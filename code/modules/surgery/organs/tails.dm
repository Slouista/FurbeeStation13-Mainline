// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/tail_type = "None"
	var/spines = "None"

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	tail_type = "Cat"

/obj/item/organ/tail/lizard
	name = "lizard tail"
	desc = "A severed lizard tail. Somewhere, no doubt, a lizard hater is very pleased with themselves."
	color = "#116611"
	tail_type = "Smooth"

// 		if(tail_type in GLOB.tails_list_lizard)
//     This will not be a useful format once I try to run this check against mam_tails
// What if I check for mamtails when adding a tail like outside character cration the distinction is moot
//	if(istype(H) && !(H.logging.len <= 1))//is a humanoid character who is not in the lobby

/obj/item/organ/tail/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(H.logging.len != 0)//is a humanoid character who is not in the lobby
		if(tail_type in GLOB.tails_list_human)
			if(!(("tail_human" || "mam_tail") in H.dna.species.mutant_bodyparts))
				H.dna.species.mutant_bodyparts |= "tail_human"
				H.dna.features["tail_human"] = tail_type
				H.update_body()
				return
		if(tail_type in GLOB.tails_list_lizard)
			if(!("tail_lizard" in H.dna.species.mutant_bodyparts))
				H.dna.features["tail_lizard"] = tail_type
				H.dna.species.mutant_bodyparts |= "tail_lizard"
			if(!("spines" in H.dna.species.mutant_bodyparts))
				H.dna.features["spines"] = spines
				H.dna.species.mutant_bodyparts |= "spines"
			H.update_body()

/obj/item/organ/tail/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(H?.dna?.species)
		H.dna.species.stop_wagging_tail(H)
	if(H.logging.len != 0)//is a humanoid character who is not in the lobby
		if(!(H.dna.features["tail_human"] == "None" || null) || (H.dna.features["tail_lizard"] == "None" || null))
			if("tail_human" in H.dna.species.mutant_bodyparts)
				tail_type = H.dna.features["tail_human"]
				H.dna.features["tail_human"] = "None"
				H.dna.species.mutant_bodyparts -= "tail_human"
				color = H.hair_color
				H.update_body()
				return
			if("mam_tail" in H.dna.species.mutant_bodyparts)
				tail_type = H.dna.features["mam_tail"]
				H.dna.features["mam_tail"] = "None"
				H.dna.species.mutant_bodyparts -= "mam_tail"
				color = "#" + H.dna.features["mcolor"]
				H.update_body()
				return
			if("tail_lizard" in H.dna.species.mutant_bodyparts)
				tail_type = H.dna.features["tail_lizard"]
				H.dna.species.mutant_bodyparts -= "tail_lizard"
				H.dna.species.mutant_bodyparts -= "spines"
				color = "#" + H.dna.features["mcolor"]
				tail_type = H.dna.features["tail_lizard"]
				spines = H.dna.features["spines"]
				H.update_body()
