/mob/living/simple_animal/slime
	name = "pet slime"
	desc = "A lovable, domesticated slime."
	icon = 'icons/mob/simple_animal/slimes.dmi'
	icon_state = "grey baby slime"
	icon_living = "grey baby slime"
	icon_dead = "grey baby slime dead"
	speak_emote = list("щебечет")
	health = 100
	maxHealth = 100
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	var/colour = "grey"
	pass_flags = PASS_FLAG_TABLE

	say_list_type = /datum/say_list/slime

/mob/living/simple_animal/slime/can_force_feed(var/feeder, var/food, var/feedback)
	if(feedback)
		to_chat(feeder, "Where do you intend to put \the [food]? \The [src] doesn't have a mouth!")
	return 0

/mob/living/simple_animal/adultslime
	name = "pet slime"
	desc = "A lovable, domesticated slime."
	icon = 'icons/mob/simple_animal/slimes.dmi'
	health = 200
	maxHealth = 200
	icon_state = "grey adult slime"
	icon_living = "grey adult slime"
	icon_dead = "grey baby slime dead"
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	var/colour = "grey"

/mob/living/simple_animal/adultslime/New()
	..()
	overlays += "aslime-:33"


/mob/living/simple_animal/slime/adult/death()
	var/mob/living/simple_animal/slime/S1 = new /mob/living/simple_animal/slime (src.loc)
	S1.icon_state = "[src.colour] baby slime"
	S1.icon_living = "[src.colour] baby slime"
	S1.icon_dead = "[src.colour] baby slime dead"
	S1.colour = "[src.colour]"
	var/mob/living/simple_animal/slime/S2 = new /mob/living/simple_animal/slime (src.loc)
	S2.icon_state = "[src.colour] baby slime"
	S2.icon_living = "[src.colour] baby slime"
	S2.icon_dead = "[src.colour] baby slime dead"
	S2.colour = "[src.colour]"
	qdel(src)

/datum/say_list/slime
	emote_see = list("jiggles", "bounces in place")
