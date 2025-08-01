//Cargo
/datum/job/qm
	title = "Quartermaster"
	flag = JOB_QUARTERMASTER
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SUPPLY | DEP_FLAG_COMMAND
	supervisors = "the captain"
	department_head = list("Captain")
	department_account_access = TRUE
	selection_color = "#e2c59d"
	access = list(
		ACCESS_CARGO_BAY,
		ACCESS_CARGO_BOT,
		ACCESS_CARGO,
		ACCESS_HEADS_VAULT,
		ACCESS_HEADS,
		ACCESS_KEYCARD_AUTH,
		ACCESS_MAILSORTING,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING_STATION,
		ACCESS_MINING,
		ACCESS_QM,
		ACCESS_RC_ANNOUNCE,
		ACCESS_SEC_DOORS,
		ACCESS_SUPPLY_SHUTTLE,
		ACCESS_WEAPONS,
		ACCESS_TELEPORTER,
		ACCESS_EXPEDITION,
		ACCESS_SMITH
	)
	blacklisted_disabilities = list(DISABILITY_FLAG_BLIND, DISABILITY_FLAG_DEAF, DISABILITY_FLAG_MUTE, DISABILITY_FLAG_DIZZY)
	outfit = /datum/outfit/job/qm
	important_information = "This role requires you to coordinate a department. You are required to be familiar with Standard Operating Procedure (Supply), basic job duties, and act professionally (roleplay)."
	exp_map = list(EXP_TYPE_SUPPLY = 1200)
	standard_paycheck = CREW_PAY_HIGH

/datum/outfit/job/qm
	name = "Quartermaster"
	jobtype = /datum/job/qm

	uniform = /obj/item/clothing/under/rank/cargo/qm
	shoes = /obj/item/clothing/shoes/workboots/mining
	head = /obj/item/clothing/head/qm
	l_ear = /obj/item/radio/headset/heads/qm
	glasses = /obj/item/clothing/glasses/meson/sunglasses
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	id = /obj/item/card/id/quartermaster
	l_hand = /obj/item/clipboard
	l_pocket = /obj/item/mail_scanner
	pda = /obj/item/pda/heads/qm
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1
	)

/datum/outfit/job/qm/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_PACK_RAT, JOB_TRAIT)

/datum/job/cargo_tech
	title = "Cargo Technician"
	flag = JOB_CARGOTECH
	department_flag = JOBCAT_SUPPORT
	total_positions = 2
	spawn_positions = 2
	job_department_flags = DEP_FLAG_SUPPLY
	supervisors = "the quartermaster"
	department_head = list("Quartermaster")
	selection_color = "#eeddbe"
	access = list(
		ACCESS_CARGO_BAY,
		ACCESS_CARGO,
		ACCESS_MAILSORTING,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SUPPLY_SHUTTLE,
	)
	alt_titles = list("Mail Carrier", "Courier")
	outfit = /datum/outfit/job/cargo_tech
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/cargo_tech
	name = "Cargo Technician"
	jobtype = /datum/job/cargo_tech

	uniform = /obj/item/clothing/under/rank/cargo/tech
	l_pocket = /obj/item/mail_scanner
	l_ear = /obj/item/radio/headset/headset_cargo
	id = /obj/item/card/id/supply
	pda = /obj/item/pda/cargo

/datum/outfit/job/cargo_tech/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_PACK_RAT, JOB_TRAIT)

/datum/job/smith
	title = "Smith"
	flag = JOB_SMITH
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SUPPLY
	supervisors = "the quartermaster"
	department_head = list("Quartermaster")
	selection_color = "#eeddbe"
	access = list(
		ACCESS_CARGO_BAY,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SMITH
	)
	alt_titles = list("Metalworker", "Tinkerer")
	outfit = /datum/outfit/job/smith
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/smith
	name = "Smith"
	jobtype = /datum/job/smith

	gloves = /obj/item/clothing/gloves/smithing
	uniform = /obj/item/clothing/under/rank/cargo/smith
	l_ear = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/workboots/smithing
	id = /obj/item/card/id/smith
	pda = /obj/item/pda/cargo

/datum/outfit/job/smith/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_SMITH, JOB_TRAIT)

/datum/job/mining
	title = "Shaft Miner"
	flag = JOB_MINER
	department_flag = JOBCAT_SUPPORT
	total_positions = 6
	spawn_positions = 8
	job_department_flags = DEP_FLAG_SUPPLY
	supervisors = "the quartermaster"
	department_head = list("Quartermaster")
	selection_color = "#eeddbe"
	access = list(
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING_STATION,
		ACCESS_MINING,
	)
	alt_titles = list("Spelunker")
	outfit = /datum/outfit/job/mining
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/mining
	name = "Shaft Miner"
	jobtype = /datum/job/mining

	l_ear = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
	l_pocket = /obj/item/reagent_containers/hypospray/autoinjector/survival
	r_pocket = /obj/item/storage/bag/ore
	id = /obj/item/card/id/shaftminer
	pda = /obj/item/pda/shaftminer
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/mining_voucher=1,\
		/obj/item/stack/marker_beacon/ten=1
	)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	box = /obj/item/storage/box/survival_mining

/datum/outfit/job/mining/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_BUTCHER, JOB_TRAIT)

/datum/outfit/job/mining/equipped

	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_SUIT_STORE
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1
	)

/datum/outfit/job/mining/equipped/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(istype(H.wear_suit, /obj/item/clothing/suit/hooded))
		var/obj/item/clothing/suit/hooded/S = H.wear_suit
		S.ToggleHood()

/datum/outfit/job/mining/equipped/modsuit
	name = "Shaft Miner (Equipment + MODsuit)"
	back = /obj/item/mod/control/pre_equipped/mining/asteroid
	mask = /obj/item/clothing/mask/breath

/datum/job/explorer
	title = "Explorer"
	flag = JOB_EXPLORER
	department_flag = JOBCAT_SUPPORT
	job_department_flags = DEP_FLAG_SUPPLY
	total_positions = 4
	spawn_positions = 4
	supervisors = "the quartermaster"
	department_head = list("Quartermaster")
	selection_color = "#eeddbe"
	access = list(
		ACCESS_MAINT_TUNNELS,
		ACCESS_EXPEDITION,
		ACCESS_EVA,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_TELEPORTER,
		ACCESS_CARGO,
		ACCESS_CARGO_BAY,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SUPPLY_SHUTTLE,
		ACCESS_MINING_STATION
	)
	alt_titles = list("Salvage Technician", "Scavenger")
	outfit = /datum/outfit/job/explorer
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/explorer
	name = "Explorer"
	jobtype = /datum/job/explorer
	l_ear = /obj/item/radio/headset/headset_cargo/expedition
	head = /obj/item/clothing/head/soft/expedition
	uniform = /obj/item/clothing/under/rank/cargo/expedition
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/utility/expedition
	id = /obj/item/card/id/explorer
	pda = /obj/item/pda/explorer
	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	box = /obj/item/storage/box/survival_mining

/datum/outfit/job/explorer/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_BUTCHER, JOB_TRAIT)

//Food
/datum/job/bartender
	title = "Bartender"
	flag = JOB_BARTENDER
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(ACCESS_BAR, ACCESS_MAINT_TUNNELS, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM)
	outfit = /datum/outfit/job/bartender
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/bartender
	name = "Bartender"
	jobtype = /datum/job/bartender

	uniform = /obj/item/clothing/under/rank/civilian/bartender
	suit = /obj/item/clothing/suit/armor/vest
	belt = /obj/item/storage/belt/bandolier/full
	l_ear = /obj/item/radio/headset/headset_service
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	id = /obj/item/card/id/bartender
	pda = /obj/item/pda/bar
	backpack_contents = list(
		/obj/item/toy/russian_revolver = 1,
		/obj/item/eftpos = 1)

/datum/outfit/job/bartender/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return

	H.dna.SetSEState(GLOB.soberblock,1)
	singlemutcheck(H, GLOB.soberblock, MUTCHK_FORCED)
	H.dna.default_blocks.Add(GLOB.soberblock)
	H.check_mutations = 1

/datum/outfit/job/bartender/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_TABLE_LEAP, ROUNDSTART_TRAIT)
	ADD_TRAIT(H.mind, TRAIT_SLEIGHT_OF_HAND, ROUNDSTART_TRAIT)

/datum/job/chef
	title = "Chef"
	flag = JOB_CHEF
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_KITCHEN,
		ACCESS_MAINT_TUNNELS
	)
	alt_titles = list("Cook","Culinary Artist","Butcher")
	outfit = /datum/outfit/job/chef
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/chef
	name = "Chef"
	jobtype = /datum/job/chef

	uniform = /obj/item/clothing/under/rank/civilian/chef
	suit = /obj/item/clothing/suit/chef
	belt = /obj/item/storage/belt/chef
	head = /obj/item/clothing/head/chefhat
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/chef
	pda = /obj/item/pda/chef
	backpack_contents = list(
		/obj/item/eftpos = 1,
	)

/datum/outfit/job/chef/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	var/datum/martial_art/cqc/under_siege/justacook = new
	justacook.teach(H) // requires mind
	ADD_TRAIT(H.mind, TRAIT_TABLE_LEAP, ROUNDSTART_TRAIT)

/datum/job/hydro
	title = "Botanist"
	flag = JOB_BOTANIST
	department_flag = JOBCAT_SUPPORT
	total_positions = 3
	spawn_positions = 2
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_HYDROPONICS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MORGUE
	)
	alt_titles = list("Hydroponicist", "Botanical Researcher")
	outfit = /datum/outfit/job/hydro
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/hydro
	name = "Botanist"
	jobtype = /datum/job/hydro

	uniform = /obj/item/clothing/under/rank/civilian/hydroponics
	suit = /obj/item/clothing/suit/apron
	belt = /obj/item/storage/belt/botany/full
	gloves = /obj/item/clothing/gloves/botanic_leather
	l_ear = /obj/item/radio/headset/headset_service
	l_pocket = /obj/item/storage/bag/plants/portaseeder
	pda = /obj/item/pda/botanist
	id = /obj/item/card/id/botanist
	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel_hyd
	dufflebag = /obj/item/storage/backpack/duffel/hydro

/datum/outfit/job/hydro/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_GREEN_THUMB, JOB_TRAIT)

//Griff //BS12 EDIT

/datum/job/clown
	title = "Clown"
	flag = JOB_CLOWN
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_CLOWN,
		ACCESS_MAINT_TUNNELS,
		ACCESS_THEATRE
	)
	outfit = /datum/outfit/job/clown
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/clown
	name = "Clown"
	jobtype = /datum/job/clown

	uniform = /obj/item/clothing/under/rank/civilian/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	mask = /obj/item/clothing/mask/gas/clown_hat
	l_pocket = /obj/item/bikehorn
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/clown
	pda = /obj/item/pda/clown
	backpack_contents = list(
		/obj/item/food/grown/banana = 1,
		/obj/item/stamp/clown = 1,
		/obj/item/toy/crayon/rainbow = 1,
		/obj/item/storage/fancy/crayons = 1,
		/obj/item/reagent_containers/spray/waterflower = 1,
		/obj/item/reagent_containers/drinks/bottle/bottleofbanana = 1,
		/obj/item/instrument/bikehorn = 1
	)

	bio_chips = list(/obj/item/bio_chip/sad_trombone)

	backpack = /obj/item/storage/backpack/clown
	satchel = /obj/item/storage/backpack/satchel/clown
	dufflebag = /obj/item/storage/backpack/duffel/clown

/datum/outfit/job/clown/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BANANIUM_SHIPMENTS))
		backpack_contents += /obj/item/stack/sheet/mineral/bananium/fifty
	if(H.gender == FEMALE)
		mask = /obj/item/clothing/mask/gas/clown_hat/sexy
		uniform = /obj/item/clothing/under/rank/civilian/clown/sexy

/datum/outfit/job/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return

	if(ismachineperson(H))
		var/obj/item/organ/internal/cyberimp/brain/clown_voice/implant = new
		implant.insert(H)

	H.dna.SetSEState(GLOB.clumsyblock, TRUE)
	singlemutcheck(H, GLOB.clumsyblock, MUTCHK_FORCED)
	H.dna.default_blocks.Add(GLOB.clumsyblock)
	if(!ismachineperson(H))
		H.dna.SetSEState(GLOB.comicblock, TRUE)
		singlemutcheck(H, GLOB.comicblock, MUTCHK_FORCED)
		H.dna.default_blocks.Add(GLOB.comicblock)
	H.check_mutations = TRUE
	H.add_language("Clownish")
	H.AddComponent(/datum/component/slippery, H, 8 SECONDS, 100, 0, FALSE, TRUE, "slip", TRUE)

//action given to antag clowns
/datum/action/innate/toggle_clumsy
	name = "Toggle Clown Clumsy"
	button_icon_state = "clown"

/datum/action/innate/toggle_clumsy/Activate()
	var/mob/living/carbon/human/H = owner
	H.dna.SetSEState(GLOB.clumsyblock, TRUE)
	singlemutcheck(H, GLOB.clumsyblock, MUTCHK_FORCED)
	active = TRUE
	background_icon_state = "bg_spell"
	build_all_button_icons()
	to_chat(H, "<span class='notice'>You start acting clumsy to throw suspicions off. Focus again before using weapons.</span>")

/datum/action/innate/toggle_clumsy/Deactivate()
	var/mob/living/carbon/human/H = owner
	H.dna.SetSEState(GLOB.clumsyblock, FALSE)
	singlemutcheck(H, GLOB.clumsyblock, MUTCHK_FORCED)
	active = FALSE
	background_icon_state = "bg_default"
	build_all_button_icons()
	to_chat(H, "<span class='notice'>You focus and can now use weapons regularly.</span>")

/datum/job/mime
	title = "Mime"
	flag = JOB_MIME
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_MAINT_TUNNELS,
		ACCESS_MIME,
		ACCESS_THEATRE
	)
	outfit = /datum/outfit/job/mime
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/mime
	name = "Mime"
	jobtype = /datum/job/mime

	uniform = /obj/item/clothing/under/rank/civilian/mime
	suit = /obj/item/clothing/suit/suspenders
	back = /obj/item/storage/backpack/mime
	gloves = /obj/item/clothing/gloves/color/white
	head = /obj/item/clothing/head/beret
	mask = /obj/item/clothing/mask/gas/mime
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/mime
	pda = /obj/item/pda/mime
	backpack_contents = list(
		/obj/item/toy/crayon/mime = 1,
		/obj/item/reagent_containers/drinks/bottle/bottleofnothing = 1,
		/obj/item/cane = 1
	)

	backpack = /obj/item/storage/backpack/mime
	satchel = /obj/item/storage/backpack/mime

/datum/outfit/job/mime/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_TRANQUILITE_SHIPMENTS))
		backpack_contents += /obj/item/stack/sheet/mineral/tranquillite/fifty
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/rank/civilian/mime/sexy
		suit = /obj/item/clothing/mask/gas/sexymime

	if(visualsOnly)
		return

	H.DeleteComponent(/datum/component/footstep)

/datum/outfit/job/mime/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	H.mind.AddSpell(new /datum/spell/aoe/conjure/build/mime_wall(null))
	H.mind.AddSpell(new /datum/spell/mime/speak(null))
	H.mind.miming = TRUE

/datum/job/janitor
	title = "Janitor"
	flag = JOB_JANITOR
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_JANITOR,
		ACCESS_MAINT_TUNNELS
	)
	alt_titles = list("Custodial Technician")
	outfit = /datum/outfit/job/janitor
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/janitor
	name = "Janitor"
	jobtype = /datum/job/janitor

	uniform = /obj/item/clothing/under/rank/civilian/janitor
	l_ear = /obj/item/radio/headset/headset_service
	id = /obj/item/card/id/janitor
	pda = /obj/item/pda/janitor
	r_pocket = /obj/item/door_remote/janikeyring

/datum/outfit/job/janitor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_NEVER_MISSES_DISPOSALS, ROUNDSTART_TRAIT)

/datum/outfit/job/janitor/on_mind_initialize(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H.mind, TRAIT_JANITOR, JOB_TRAIT)

//More or less assistants
/datum/job/librarian
	title = "Librarian"
	flag = JOB_LIBRARIAN
	department_flag = JOBCAT_SUPPORT
	total_positions = 1
	spawn_positions = 1
	job_department_flags = DEP_FLAG_SERVICE
	supervisors = "the head of personnel"
	department_head = list("Head of Personnel")
	selection_color = "#dddddd"
	access = list(
		ACCESS_LIBRARY,
		ACCESS_MAINT_TUNNELS
	)
	alt_titles = list("Journalist")
	outfit = /datum/outfit/job/librarian
	standard_paycheck = CREW_PAY_LOW

/datum/outfit/job/librarian
	name = "Librarian"
	jobtype = /datum/job/librarian

	uniform = /obj/item/clothing/under/rank/civilian/librarian
	l_ear = /obj/item/radio/headset/headset_service
	l_pocket = /obj/item/laser_pointer
	r_pocket = /obj/item/barcodescanner
	l_hand = /obj/item/storage/bag/books
	id = /obj/item/card/id/librarian
	pda = /obj/item/pda/librarian
	backpack_contents = list(
		/obj/item/videocam/advanced = 1,
		/obj/item/clothing/suit/armor/vest/press = 1
)

/datum/outfit/job/librarian/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	for(var/la in GLOB.all_languages)
		var/datum/language/new_language = GLOB.all_languages[la]
		if(new_language.flags & (HIVEMIND|NOLIBRARIAN))
			continue
		H.add_language(la)
