#define SYNDICATE_CHALLENGE_TIMER 20 MINUTES

/obj/machinery/computer/shuttle/syndicate
	name = "syndicate shuttle terminal"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	req_access = list(ACCESS_SYNDICATE)
	bubble_icon = "syndibot"
	circuit = /obj/item/circuitboard/shuttle/syndicate
	shuttleId = "syndicate"
	possible_destinations = "syndicate_away;syndicate_z5;syndicate_z3;syndicate_ne;syndicate_nw;syndicate_n;syndicate_se;syndicate_sw;syndicate_s;syndicate_custom"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags = NODECONSTRUCT
	var/challenge = FALSE
	var/challenge_time = 0 //When was war declared?

/obj/machinery/computer/shuttle/syndicate/recall
	name = "syndicate shuttle recall terminal"
	circuit = /obj/item/circuitboard/shuttle/syndicate/recall
	possible_destinations = "syndicate_away"

/obj/machinery/computer/shuttle/syndicate/can_call_shuttle(user, action)
	var/time_to_go = max(SYNDICATE_CHALLENGE_TIMER, (challenge_time + 10 MINUTES))
	if(action == "move")
		if(challenge && world.time < time_to_go)
			to_chat(user, "<span class='warning'>You've issued a combat challenge to the station! You've got to give them at least [round(((time_to_go - world.time) / 10) / 60)] more minutes to allow them to prepare.</span>")
			return FALSE
	return TRUE

/obj/machinery/computer/shuttle/syndicate/drop_pod
	name = "syndicate assault pod control"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "syndie_assault_pod"
	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/shuttle/syndicate/drop_pod
	shuttleId = "steel_rain"
	possible_destinations = null

/obj/machinery/computer/shuttle/syndicate/drop_pod/can_call_shuttle(user, action)
	if(action == "move")
		if(z != level_name_to_num(CENTCOMM))
			to_chat(user, "<span class='warning'>Pods are one way!</span>")
			return FALSE
	return ..()

/obj/machinery/computer/shuttle/sst
	name = "Syndicate Strike Team Shuttle Console"
	desc = "Used to call and send the SST shuttle."
	icon_keyboard = "syndie_key"
	icon_screen = "syndishuttle"
	req_access = list(ACCESS_SYNDICATE)
	bubble_icon = "syndibot"
	shuttleId = "sst"
	possible_destinations = "sst_home;sst_away;sst_custom"
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/computer/shuttle/sit
	name = "Syndicate Infiltration Team Shuttle Console"
	desc = "Used to call and send the SIT shuttle."
	icon_keyboard = "syndie_key"
	icon_screen = "syndishuttle"
	req_access = list(ACCESS_SYNDICATE)
	bubble_icon = "syndibot"
	shuttleId = "sit"
	possible_destinations = "sit_arrivals;sit_engshuttle;sit_away;sit_custom"
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate
	name = "syndicate shuttle navigation computer"
	desc = "Used to designate a precise transit location for the syndicate shuttle."
	icon_screen = "syndinavigation"
	icon_keyboard = "syndie_key"
	shuttleId = "syndicate"
	shuttlePortId = "syndicate_custom"
	bubble_icon = "syndibot"
	view_range = 13
	x_offset = -5
	y_offset = -1
	see_hidden = TRUE
	resistance_flags = INDESTRUCTIBLE

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/sst
	name = "SST shuttle navigation computer"
	desc = "Used to designate a precise transit location for the SST shuttle."
	shuttleId = "sst"
	shuttlePortId = "sst_custom"
	x_offset = 0
	y_offset = 0

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/sit
	name = "SIT shuttle navigation computer"
	desc = "Used to designate a precise transit location for the SIT shuttle."
	shuttleId = "sit"
	shuttlePortId = "sit_custom"
	x_offset = 0
	y_offset = 0

#undef SYNDICATE_CHALLENGE_TIMER

// Fuck it its syndicate now
/obj/machinery/computer/camera_advanced/shuttle_docker/admin/vox
	name = "skipjack navigation computer"
	desc = "Used to designate a precise transit location for the skipjack."
	flags = NODECONSTRUCT
	access_mining = FALSE

/obj/machinery/computer/shuttle/admin/vox
	name = "vox skipjack console"
	req_access = list(ACCESS_VOX)
	possible_destinations = "admin_home;admin_custom"
