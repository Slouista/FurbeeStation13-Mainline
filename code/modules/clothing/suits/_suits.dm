#define FOOTSTEP_COOLDOWN 3	//3 deci-seconds

/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "stamina" = 0)
	slot_flags = ITEM_SLOT_OCLOTHING
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	var/move_sound = null
	var/footstep = 0
	var/mob/listeningTo
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo

	var/adjusted = NORMAL_STYLE
	mutantrace_variation = MUTANTRACE_VARIATION
	var/tauric = FALSE		//Citadel Add for tauric hardsuits
	var/taurmode = NOT_TAURIC
	var/dimension_x = 32
	var/dimension_y = 32
	var/center = FALSE	//Should we center the sprite?

/obj/item/clothing/suit/worn_overlays(isinhands = FALSE)
	. = list()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]")
		if(HAS_BLOOD_DNA(src))
			if(taurmode >= SNEK_TAURIC)
				. += mutable_appearance('modular_citadel/icons/mob/64x32_effects.dmi', "[blood_overlay_type]blood")
			else
				. += mutable_appearance('icons/effects/blood.dmi', "[blood_overlay_type]blood")
		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()

/obj/item/clothing/suit/proc/on_mob_move()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.wear_suit != src)
		return
	if(world.time > footstep)
		playsound(src, pick(move_sound), 65, 1)
		footstep = world.time + FOOTSTEP_COOLDOWN

/obj/item/clothing/suit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_OCLOTHING)
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
			listeningTo = null
		return
	if(listeningTo == user)
		return
	//Remove old listener
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	//Add new listener
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)
	listeningTo = user
	//Handle suit variations
	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		if(mutantrace_variation)
			if(DIGITIGRADE in H.dna.species.species_traits)
				adjusted = DIGITIGRADE_STYLE
				H.update_inv_wear_suit()
			else if(adjusted == DIGITIGRADE_STYLE)
				adjusted = NORMAL_STYLE

		if(("taur" in H.dna.species.mutant_bodyparts) && (H.dna.features["taur"] != "None"))
			if(H.dna.features["taur"] in list("Naga", "Tentacle"))
				taurmode = SNEK_TAURIC
				if(tauric == TRUE)
					center = TRUE
					dimension_x = 64
			else if(H.dna.features["taur"] in list("Fox","Wolf","Otie","Drake","Lab","Shepherd","Husky","Eevee","Panther","Horse","Cow","Tiger","Deer"))
				taurmode = PAW_TAURIC
				if(tauric == TRUE)
					center = TRUE
					dimension_x = 64
		else
			taurmode = NOT_TAURIC
			if(tauric == TRUE)
				center = FALSE
				dimension_x = 32
		H.update_inv_wear_suit()

/obj/item/clothing/suit/dropped(mob/user)
	. = ..()
	//Remove our listener
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
		listeningTo = null

/obj/item/clothing/suit/Destroy()
	listeningTo = null
	. = ..()

#undef FOOTSTEP_COOLDOWN
