/*
 * Defines the helmets, gloves and shoes for rigs.
 */

/obj/item/clothing/head/helmet/space/rig
	name = "helmet"
	item_flags = ITEM_FLAG_THICKMATERIAL
	flags_inv = 		 HIDEEARS|HIDEEYES|HIDEFACE|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	heat_protection =    HEAD|FACE|EYES
	cold_protection =    HEAD|FACE|EYES
	brightness_on = 0.5
	sprite_sheets = list(
		SPECIES_SKRELL = 'icons/mob/species/skrell/onmob_head_skrell.dmi',
		SPECIES_UNATHI = 'icons/mob/species/unathi/onmob_head_unathi.dmi',
		)
	species_restricted = null

/obj/item/clothing/gloves/rig
	name = "gauntlets"
	item_flags = ITEM_FLAG_THICKMATERIAL | ITEM_FLAG_AIRTIGHT
	body_parts_covered = HANDS
	heat_protection =    HANDS
	cold_protection =    HANDS
	species_restricted = null
	gender = PLURAL

/obj/item/clothing/shoes/magboots/rig
	name = "boots"
	item_flags = ITEM_FLAG_THICKMATERIAL | ITEM_FLAG_AIRTIGHT
	body_parts_covered = FEET
	cold_protection = FEET
	heat_protection = FEET
	species_restricted = null
	gender = PLURAL
	icon_base = null

/obj/item/clothing/suit/space/rig
	name = "chestpiece"
	allowed = list(/obj/item/device/flashlight,/obj/item/tank,/obj/item/device/suit_cooling_unit)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	// HIDEJUMPSUIT no longer needed, see "hides_uniform" and "update_component_sealed()" in rig.dm
	flags_inv =          HIDETAIL | CLOTHING_BULKY
	item_flags =         ITEM_FLAG_THICKMATERIAL | ITEM_FLAG_AIRTIGHT
	//will reach 10 breach damage after 25 laser carbine blasts, 3 revolver hits, or ~1 PTR hit. Completely immune to smg or sts hits.
	breach_threshold = 38
	resilience = 0.2
	can_breach = 1
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/species/unathi/onmob_suit_unathi.dmi',
		)
	var/list/supporting_limbs = list() //If not-null, automatically splints breaks. Checked when removing the suit.
	equip_delay = null


/obj/item/clothing/suit/space/rig/equipped(mob/M)
	check_limb_support(M)
	..()

/obj/item/clothing/suit/space/rig/dropped(var/mob/user)
	check_limb_support(user)
	..()

// Some space suits are equipped with reactive membranes that support broken limbs
/obj/item/clothing/suit/space/rig/proc/can_support(var/mob/living/carbon/human/user)
	if(user.wear_suit != src)
		return 0 //not wearing the suit
	var/obj/item/rig/rig = user.back
	if(!istype(rig) || rig.offline || rig.canremove)
		return 0 //not wearing a rig control unit or it's offline or unsealed
	return 1

/obj/item/clothing/suit/space/rig/proc/check_limb_support(var/mob/living/carbon/human/user)

	// If this isn't set, then we don't need to care.
	if(!istype(user) || isnull(supporting_limbs))
		return

	if(can_support(user))
		for(var/obj/item/organ/external/E in user.bad_external_organs)
			if((E.body_part & body_parts_covered) && E.is_broken() && E.apply_splint(src))
				to_chat(user, "<span class='notice'>You feel [src] constrict about your [E.name], supporting it.</span>")
				supporting_limbs |= E
	else
		// Otherwise, remove the splints.
		for(var/obj/item/organ/external/E in supporting_limbs)
			if(E.splinted == src && E.remove_splint(src))
				to_chat(user, "<span class='notice'>\The [src] stops supporting your [E.name].</span>")
		supporting_limbs.Cut()

/obj/item/clothing/suit/space/rig/proc/handle_fracture(var/mob/living/carbon/human/user, var/obj/item/organ/external/E)
	if(!istype(user) || isnull(supporting_limbs) || !can_support(user))
		return
	if((E.body_part & body_parts_covered) && E.is_broken() && E.apply_splint(src))
		to_chat(user, "<span class='notice'>You feel [src] constrict about your [E.name], supporting it.</span>")
		supporting_limbs |= E


/obj/item/clothing/gloves/rig/Touch(var/atom/A, var/proximity)

	if(!A || !proximity)
		return 0

	var/mob/living/carbon/human/H = loc
	if(!istype(H) || !H.back)
		return 0

	var/obj/item/rig/suit = H.back
	if(!suit || !istype(suit) || !suit.installed_modules.len)
		return 0

	for(var/obj/item/rig_module/module in suit.installed_modules)
		if(module.active && module.activates_on_touch)
			if(module.engage(A))
				return 1
	return 0

//Rig pieces for non-spacesuit based rigs

/obj/item/clothing/head/lightrig
	name = "mask"
	body_parts_covered = HEAD|FACE|EYES
	heat_protection =    HEAD|FACE|EYES
	cold_protection =    HEAD|FACE|EYES
	item_flags =         ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_AIRTIGHT

/obj/item/clothing/suit/lightrig
	name = "suit"
	allowed = list(/obj/item/device/flashlight)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	cold_protection =    UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv =          HIDEJUMPSUIT
	item_flags =         ITEM_FLAG_THICKMATERIAL

/obj/item/clothing/shoes/lightrig
	name = "boots"
	body_parts_covered = FEET
	cold_protection = FEET
	heat_protection = FEET
	species_restricted = null
	gender = PLURAL

/obj/item/clothing/gloves/lightrig
	name = "gloves"
	item_flags = ITEM_FLAG_THICKMATERIAL
	body_parts_covered = HANDS
	heat_protection =    HANDS
	cold_protection =    HANDS
	species_restricted = null
	gender = PLURAL
