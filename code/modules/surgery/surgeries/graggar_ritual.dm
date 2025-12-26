/datum/surgery_step/graggarritual
	name = "Graggar ritual"
	time = 45 SECONDS
	accept_hand = FALSE
	possible_locs = list(BODY_ZONE_CHEST)
	implements = list(
		TOOL_SCALPEL = 80,
		TOOL_SHARP = 60,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_BROKEN

/datum/surgery_step/graggarritual/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(target.has_status_effect(/datum/status_effect/debuff/alreadygraggared))
		display_results(user, target, span_notice("The [target]'s most delicious parts are already taken!"),
			"[user] chops [target]'s body.",
			"[user] chops [target]'s body.")
		return FALSE

	var/mob/living/carbon/H = target
	if(!H.mind || !H.mind.assigned_role)
		display_results(user, target, span_notice("[target] is NOT a worthy OPPONENT!"),
			"[user] attempts to cut [target]'s body, but finds nothing special.",
			"[user] attempts to cut [target]'s body.")
		return FALSE

	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		display_results(user, target, span_notice("You lack the devotion to perform Graggar's ritual!"),
			"[user] attempts to cut [target]'s body, but fails.",
			"[user] attempts to cut [target]'s body.")
		return FALSE

	var/chosen_meat = null
	if(H.mind.assigned_role == "Man at arms")
		chosen_meat = /obj/item/graggarflesh/maa
	else if(H.mind.assigned_role == "Templar")
		chosen_meat = /obj/item/graggarflesh/templar
	else if(HAS_TRAIT(target, TRAIT_INQUISITION))
		chosen_meat = /obj/item/graggarflesh/inquisition
	else if(H.mind.assigned_role == "Warden")
		chosen_meat = /obj/item/graggarflesh/warden
	else if(H.mind.assigned_role == "Knight" || H.mind.assigned_role == "Knight Captain")
		chosen_meat = /obj/item/graggarflesh/knight
	else if(H.mind.assigned_role == "Priest")
		chosen_meat = /obj/item/graggarflesh/priest
	else if(H.mind.assigned_role == "Grand Duke" || H.mind.assigned_role == "Consort" || H.mind.assigned_role == "Grand Duchess" || H.mind.assigned_role == "Prince" || H.mind.assigned_role == "Princess")
		chosen_meat = /obj/item/graggarflesh/royal
	else
		display_results(user, target, span_notice("[target] is NOT a worthy OPPONENT!"),
			"[user] attempts to cut [target]'s body, but finds nothing special.",
			"[user] attempts to cut [target]'s body.")
		return FALSE

	display_results(user, target, span_notice("[user] starts to cut some meat from [target]'s spine!"),
		"[user] cuts a slice from [target]'s body.",
		"[user] cuts a slice from [target]'s body.")

	new chosen_meat(target.loc)
	target.apply_status_effect(/datum/status_effect/debuff/alreadygraggared)
	return TRUE

/obj/item/graggarflesh
	name = "flesh"
	desc = "A piece of meat harvested from a fallen foe."
	icon = 'icons/roguetown/items/food.dmi'  
	icon_state = "meatcutlet"		  


// Man-at-Arms Flesh
/obj/item/graggarflesh/maa
	name = "man at arms's flesh"
	desc = "A tough, sinewy piece of meat from a Man-at-Arms."

/obj/item/graggarflesh/maa/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/maa/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/maameat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/maameat)
	to_chat(user, span_notice("[M] now tastes the flesh of a Man-at-Arms."))
	qdel(src)
	return TRUE

// Templar's Flesh
/obj/item/graggarflesh/templar
	name = "templar's flesh"
	desc = "A sanctified cut from a Templar's body, radiating faint warmth."

/obj/item/graggarflesh/templar/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/templar/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/templarmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/templarmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of a Templar."))
	qdel(src)
	return TRUE

/obj/item/graggarflesh/inquisition
	name = "inquisition's Flesh"
	desc = "Tough meat from a member of the Inquisition. When you look at him for a long time, tears slowly flow from your eyes, as if from an onion"

/obj/item/graggarflesh/inquisition/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/inquisition/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/inquisitionmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/inquisitionmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of a member of the Inquisition."))
	qdel(src)
	return TRUE

// warden's Flesh
/obj/item/graggarflesh/warden
	name = "warden's flesh"
	desc = "A sturdy chunk of flesh from a warden, brimming with resilience."

/obj/item/graggarflesh/warden/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/warden/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/wardenmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/wardenmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of a warden."))
	qdel(src)
	return TRUE

// Knight's Flesh
/obj/item/graggarflesh/knight
	name = "knight's flesh"
	desc = "A noble cut of meat, harvested from a Knight's frame."

/obj/item/graggarflesh/knight/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/knight/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/knightmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/knightmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of a Knight."))
	qdel(src)
	return TRUE

// Priest's Flesh
/obj/item/graggarflesh/priest
	name = "priest's flesh"
	desc = "A tender piece of meat, infused with a hint of divine essence."

/obj/item/graggarflesh/priest/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/priest/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/priestmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/priestmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of a Priest."))
	qdel(src)
	return TRUE

// Royal Flesh
/obj/item/graggarflesh/royal
	name = "royal flesh"
	desc = "An exquisite piece of meat from royalty, rich and succulent."

/obj/item/graggarflesh/royal/attack(mob/M, mob/user)
	if(ishuman(M))
		consume_flesh(M, user)
	return ..()

/obj/item/graggarflesh/royal/proc/consume_flesh(mob/living/carbon/human/M, mob/user)
	if(!isliving(M) || M.stat == DEAD)
		to_chat(user, span_warning("They are dead. You cannot feed them the flesh."))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_warning("Only followers of Graggar can do such things..."))
		return FALSE
	if(M.has_status_effect(/datum/status_effect/buff/royalmeat))
		to_chat(user, span_warning("[M] knows the taste of this flesh already!"))
		return FALSE
	M.apply_status_effect(/datum/status_effect/buff/royalmeat)
	to_chat(user, span_notice("[M] now tastes the flesh of royalty."))
	qdel(src)
	return TRUE
