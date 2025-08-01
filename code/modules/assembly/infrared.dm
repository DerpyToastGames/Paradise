/obj/item/assembly/infra
	name = "infrared emitter"
	desc = "Emits a visible or invisible beam and is triggered when the beam is interrupted."
	icon_state = "infrared"
	materials = list(MAT_METAL=1000, MAT_GLASS=500)
	origin_tech = "magnets=2;materials=2"

	bomb_name = "tripwire mine"

	secured = FALSE // toggle_secure()'ed in New() for correct adding to processing_objects, won't work otherwise
	dir = EAST
	var/on = FALSE
	var/visible = TRUE
	var/obj/effect/beam/i_beam/first = null
	var/obj/effect/beam/i_beam/last = null
	var/max_nesting_level = 10
	var/turf/fire_location
	var/emission_cycles = 0
	var/emission_cap = 20

/obj/item/assembly/infra/Destroy()
	if(first)
		QDEL_NULL(first)
		last = null
		fire_location = null
	return ..()

/obj/item/assembly/infra/examine(mob/user)
	. = ..()
	. += "The assembly is [secured ? "secure" : "not secure"]. The infrared trigger is [on ? "on" : "off"]."
	. += "<span class='notice'><b>Alt-Click</b> to rotate it.</span>"

/obj/item/assembly/infra/activate()
	if(!..())
		return FALSE//Cooldown check
	on = !on
	update_icon()
	return TRUE

/obj/item/assembly/infra/toggle_secure()
	secured = !secured
	if(secured)
		START_PROCESSING(SSobj, src)
	else
		on = FALSE
		if(first)
			qdel(first)
		STOP_PROCESSING(SSobj, src)
	update_icon()
	return secured

/obj/item/assembly/infra/New()
	..()
	if(!secured)
		toggle_secure()

/obj/item/assembly/infra/proc/arm() // Forces the device to arm no matter its current state.
	if(!secured) // Checked because arm() might be called sometime after the object is spawned.
		toggle_secure()
	on = TRUE

/obj/item/assembly/infra/update_overlays()
	. = ..()
	attached_overlays = list()
	if(on)
		. += "infrared_on"
		attached_overlays += "infrared_on"
	if(holder)
		holder.update_icon()

/obj/item/assembly/infra/process()
	var/turf/T = get_turf(src)
	if(first && (!on || !fire_location || fire_location != T || emission_cycles >= emission_cap))
		qdel(first)
		return
	if(!on)
		return
	if(!secured)
		return
	if(first && last)
		last.process()
		emission_cycles++
		return
	if(T)
		fire_location = T
		emission_cycles = 0
		var/obj/effect/beam/i_beam/I = new /obj/effect/beam/i_beam(T)
		I.master = src
		I.density = TRUE
		I.dir = dir
		I.update_icon()
		first = I
		step(I, I.dir)
		if(first)
			I.density = FALSE
			I.vis_spread(visible)
			I.limit = 8
			I.process()

/obj/item/assembly/infra/attack_hand()
	qdel(first)
	..()

/obj/item/assembly/infra/Move()
	var/t = dir
	. = ..()
	dir = t
	qdel(first)

/obj/item/assembly/infra/holder_movement()
	if(!holder)
		return FALSE
	qdel(first)
	return TRUE

/obj/item/assembly/infra/equipped(mob/user, slot)
	qdel(first)
	return ..()

/obj/item/assembly/infra/pickup(mob/user)
	qdel(first)
	return ..()

/obj/item/assembly/infra/proc/trigger_beam()
	if(!secured || !on || cooldown > 0)
		return FALSE
	cooldown = 2
	pulse(FALSE)
	audible_message("[bicon(src)] *beep* *beep* *beep*", hearing_distance = 3)
	playsound(src, 'sound/machines/triple_beep.ogg', 40, extrarange = -14)
	if(first)
		qdel(first)
	addtimer(CALLBACK(src, PROC_REF(process_cooldown)), 10)

/obj/item/assembly/infra/interact(mob/user)//TODO: change this this to the wire control panel
	if(!secured)	return
	user.set_machine(src)
	var/dat = {"<TT><B>Infrared Laser</B>
				<B>Status</B>: [on ? "<A href='byond://?src=[UID()];state=0'>On</A>" : "<A href='byond://?src=[UID()];state=1'>Off</A>"]<BR>
				<B>Visibility</B>: [visible ? "<A href='byond://?src=[UID()];visible=0'>Visible</A>" : "<A href='byond://?src=[UID()];visible=1'>Invisible</A>"]<BR>
				<B>Current Direction</B>: <A href='byond://?src=[UID()];rotate=1'>[capitalize(dir2text(dir))]</A><BR>
				</TT>
				<BR><BR><A href='byond://?src=[UID()];refresh=1'>Refresh</A>
				<BR><BR><A href='byond://?src=[UID()];close=1'>Close</A>"}
	var/datum/browser/popup = new(user, "infra", name, 400, 400)
	popup.set_content(dat)
	popup.open(0)
	onclose(user, "infra")

/obj/item/assembly/infra/Topic(href, href_list)
	..()
	if(HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED) || usr.stat || usr.restrained() || !in_range(loc, usr))
		usr << browse(null, "window=infra")
		onclose(usr, "infra")
		return
	if(href_list["state"])
		on = !(on)
		update_icon()
	if(href_list["visible"])
		visible = !(visible)
		if(first)
			first.vis_spread(visible)
	if(href_list["rotate"])
		rotate(usr)
	if(href_list["close"])
		usr << browse(null, "window=infra")
		return
	if(usr)
		attack_self__legacy__attackchain(usr)

/obj/item/assembly/infra/AltClick(mob/user)
	rotate(user)

/obj/item/assembly/infra/proc/rotate(mob/user)
	if(user.stat || HAS_TRAIT(user, TRAIT_HANDS_BLOCKED) || !Adjacent(user))
		return

	dir = turn(dir, 90)

	if(user.machine == src)
		interact(user)

	if(first)
		qdel(first)



/obj/item/assembly/infra/armed/New()
	..()
	spawn(3)
		if(holder)
			if(holder.master)
				dir = holder.master.dir
		arm()

/obj/item/assembly/infra/armed/stealth
	visible = FALSE


/***************************IBeam*********************************/

/obj/effect/beam/i_beam
	name = "i beam"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "ibeam"
	var/obj/effect/beam/i_beam/next = null
	var/obj/effect/beam/i_beam/previous = null
	var/obj/item/assembly/infra/master = null
	var/limit = null
	var/visible = FALSE
	var/left = null
	var/life_cycles = 0
	var/life_cap = 20
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSFENCE

/obj/effect/beam/i_beam/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_atom_entered)
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/beam/i_beam/proc/hit()
	if(master)
		master.trigger_beam()
	qdel(src)

/obj/effect/beam/i_beam/proc/vis_spread(v)
	visible = v
	if(next)
		next.vis_spread(v)

/obj/effect/beam/i_beam/update_icon_state()
	transform = turn(matrix(), dir2angle(dir))

/obj/effect/beam/i_beam/Process_Spacemove(movement_dir = 0, continuous_move = FALSE)
	return TRUE

/obj/effect/beam/i_beam/process()
	life_cycles++
	if(loc.density || !master || life_cycles >= life_cap)
		qdel(src)
		return
	if(left > 0)
		left--
	if(left < 1)
		if(!(visible))
			invisibility = 101
		else
			invisibility = FALSE
	else
		invisibility = FALSE

	if(!next && (limit > 0))
		var/obj/effect/beam/i_beam/I = new /obj/effect/beam/i_beam(loc)
		I.master = master
		I.density = TRUE
		I.dir = dir
		I.update_icon()
		I.previous = src
		next = I
		step(I, I.dir)
		if(next)
			I.density = FALSE
			I.vis_spread(visible)
			I.limit = limit - 1
			master.last = I
			I.process()

/obj/effect/beam/i_beam/Bump()
	qdel(src)

/obj/effect/beam/i_beam/Bumped()
	hit()

/obj/effect/beam/i_beam/proc/on_atom_entered(datum/source, atom/movable/entered)
	if(!isobj(entered) && !isliving(entered))
		return
	if(iseffect(entered))
		return
	hit()

/obj/effect/beam/i_beam/Destroy()
	if(master.first == src)
		master.first = null
	QDEL_NULL(next)
	if(previous)
		previous.next = null
		master.last = previous
	return ..()
