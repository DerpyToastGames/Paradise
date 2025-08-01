#define SMELT_AMOUNT 10

/**********************Mineral processing unit console**************************/

/obj/machinery/mineral
	var/input_dir = NORTH
	var/output_dir = SOUTH

/obj/machinery/mineral/proc/unload_mineral(atom/movable/S)
	S.forceMove(drop_location())
	var/turf/T = get_step(src,output_dir)
	if(T)
		S.forceMove(T)

/obj/machinery/mineral/processing_unit_console
	name = "production machine console"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	anchored = TRUE
	var/obj/machinery/mineral/processing_unit/machine = null
	speed_process = TRUE

/obj/machinery/mineral/processing_unit_console/Initialize(mapload)
	. = ..()
	for(var/obj/machinery/mineral/processing_unit/found_machine in range(1, src))
		machine = found_machine
		machine.console = src
		return //needed to break for loop

	CRASH("[src] failed to link to a mineral processing unit!")

/obj/machinery/mineral/processing_unit_console/attack_ghost(mob/user)
	return open_ui(user)

/obj/machinery/mineral/processing_unit_console/attack_hand(mob/user)
	if(..())
		return TRUE

	return open_ui(user)

/obj/machinery/mineral/processing_unit_console/proc/open_ui(mob/user)
	if(!machine)
		return

	var/dat = machine.get_machine_data()

	var/datum/browser/popup = new(user, "processing", "Smelting Console", 300, 500)
	popup.set_content(dat)
	popup.open()

/obj/machinery/mineral/processing_unit_console/Topic(href, href_list)
	if(..())
		return TRUE

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["material"])
		machine.selected_material = href_list["material"]
		machine.selected_alloy = null

	if(href_list["alloy"])
		machine.selected_material = null
		machine.selected_alloy = href_list["alloy"]

	if(href_list["set_on"])
		machine.on = (href_list["set_on"] == "on")

	updateUsrDialog()
	return TRUE

/obj/machinery/mineral/processing_unit_console/Destroy()
	machine = null
	return ..()

/**********************Mineral processing unit**************************/

/obj/machinery/mineral/processing_unit
	name = "furnace"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "furnace"
	density = TRUE
	anchored = TRUE
	var/obj/machinery/mineral/console = null
	var/on = FALSE
	var/selected_material = MAT_METAL
	var/selected_alloy = null
	var/datum/research/files
	speed_process = TRUE

/obj/machinery/mineral/processing_unit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/material_container, list(MAT_METAL, MAT_GLASS, MAT_SILVER, MAT_GOLD, MAT_DIAMOND, MAT_PLASMA, MAT_URANIUM, MAT_BANANIUM, MAT_TRANQUILLITE, MAT_TITANIUM, MAT_BLUESPACE), INFINITY, TRUE, /obj/item/stack)
	files = new /datum/research/smelter(src)

/obj/machinery/mineral/processing_unit/Destroy()
	console = null
	QDEL_NULL(files)
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.retrieve_all()
	return ..()

/obj/machinery/mineral/processing_unit/process()
	var/turf/T = get_step(src, input_dir)
	if(T)
		for(var/obj/item/stack/ore/O in T)
			process_ore(O)
			CHECK_TICK

	if(on)
		if(selected_material)
			smelt_ore()

		else if(selected_alloy)
			smelt_alloy()

		if(console)
			console.updateUsrDialog()

/obj/machinery/mineral/processing_unit/proc/process_ore(obj/item/stack/ore/O)
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/material_amount = materials.get_item_material_amount(O)
	if(!materials.has_space(material_amount))
		unload_mineral(O)
	else
		materials.insert_item(O)
		qdel(O)
		if(console)
			console.updateUsrDialog()

/obj/machinery/mineral/processing_unit/proc/get_machine_data()
	var/dat = "<b>Smelter control console</b><br><br>"
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	for(var/mat_id in materials.materials)
		var/datum/material/M = materials.materials[mat_id]
		dat += "<span class=\"res_name\">[M.name]: </span>[M.amount] cm&sup3;"
		if(selected_material == mat_id)
			dat += " <i>Smelting</i>"
		else
			dat += " <A href='byond://?src=[console.UID()];material=[mat_id]'><b>Not Smelting</b></A> "
		dat += "<br>"

	dat += "<br><br>"
	dat += "<b>Smelt Alloys</b><br>"

	for(var/v in files.known_designs)
		var/datum/design/D = files.known_designs[v]
		dat += "<span class=\"res_name\">[D.name] "
		if(selected_alloy == D.id)
			dat += " <i>Smelting</i>"
		else
			dat += " <A href='byond://?src=[console.UID()];alloy=[D.id]'><b>Not Smelting</b></A> "
		dat += "<br>"

	dat += "<br><br>"
	//On or off
	dat += "Machine is currently "
	if(on)
		dat += "<A href='byond://?src=[console.UID()];set_on=off'>On</A> "
	else
		dat += "<A href='byond://?src=[console.UID()];set_on=on'>Off</A> "

	return dat

/obj/machinery/mineral/processing_unit/proc/smelt_ore()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/datum/material/mat = materials.materials[selected_material]
	if(mat)
		var/sheets_to_remove = (mat.amount >= (MINERAL_MATERIAL_AMOUNT * SMELT_AMOUNT) ) ? SMELT_AMOUNT : round(mat.amount /  MINERAL_MATERIAL_AMOUNT)
		if(!sheets_to_remove)
			on = FALSE
		else
			var/out = get_step(src, output_dir)
			materials.retrieve_sheets(sheets_to_remove, selected_material, out)

/obj/machinery/mineral/processing_unit/proc/smelt_alloy()
	var/datum/design/alloy = files.FindDesignByID(selected_alloy) //check if it's a valid design
	if(!alloy)
		on = FALSE
		return

	var/amount = can_smelt(alloy)

	if(!amount)
		on = FALSE
		return

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.use_amount(alloy.materials, amount)

	generate_mineral(alloy.build_path)

/obj/machinery/mineral/processing_unit/proc/can_smelt(datum/design/D)
	if(length(D.make_reagents))
		return FALSE

	var/build_amount = SMELT_AMOUNT

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	for(var/mat_id in D.materials)
		var/M = D.materials[mat_id]
		var/datum/material/smelter_mat  = materials.materials[mat_id]

		if(!M || !smelter_mat)
			return FALSE

		build_amount = min(build_amount, round(smelter_mat.amount / M))

	return build_amount

/obj/machinery/mineral/processing_unit/proc/generate_mineral(P)
	var/O = new P(src)
	unload_mineral(O)

#undef SMELT_AMOUNT
