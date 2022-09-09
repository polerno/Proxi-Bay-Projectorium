/datum/mob_list
	var/list/mobs = list()
	var/sound/arrival_sound
	var/arrival_message
	var/limit ///target number of mobs to spawn
	var/length = 75 ///length of time the event should run for
	var/spawn_near_chance = 20 ///chance a mob spawns near a player
	var/delay_time = 600 ///Amount of time between the event starting and mobs beginning spawns

/datum/mob_list/major/meat
	mobs = list(
				list(/mob/living/simple_animal/hostile/meat/abomination, 10),
				list(/mob/living/simple_animal/hostile/meat/horror, 75),
				list(/mob/living/simple_animal/hostile/meat/strippedhuman, 80),
				list(/mob/living/simple_animal/hostile/meat/horrorminer, 80),
				list(/mob/living/simple_animal/hostile/meat/horrorsmall, 98),
				list(/mob/living/simple_animal/hostile/meat, 10)
			)
	arrival_message = "Леденящий кровь вой эхом разносится по воздуху, когда планета начинает сильно трястись. Что-то проснулось..."
	arrival_sound   = 'sound/ambience/meat_monster_arrival.ogg'
	limit = 30
	spawn_near_chance = 30

/datum/mob_list/major/spiders
	mobs = list(
				list(/mob/living/simple_animal/hostile/giant_spider/lurker, 40),
				list(/mob/living/simple_animal/hostile/giant_spider/tunneler, 45),
				list(/mob/living/simple_animal/hostile/giant_spider/pepper, 25),
				list(/mob/living/simple_animal/hostile/giant_spider/webslinger, 20),
				list(/mob/living/simple_animal/hostile/giant_spider/electric, 20),
				list(/mob/living/simple_animal/hostile/giant_spider/thermic, 15),
				list(/mob/living/simple_animal/hostile/giant_spider/frost, 15),
				list(/mob/living/simple_animal/hostile/giant_spider/carrier, 20),
				list(/mob/living/simple_animal/hostile/giant_spider/phorogenic, 5),
				list(/mob/living/simple_animal/hostile/giant_spider/guard, 85),
				list(/mob/living/simple_animal/hostile/giant_spider/hunter, 75),
				list(/mob/living/simple_animal/hostile/giant_spider/nurse, 60),
				list(/mob/living/simple_animal/hostile/giant_spider/spitter, 55),
				list(/mob/living/simple_animal/hostile/giant_spider, 90)
			)
	arrival_message = "Земля под вами дрожит и грохочет, и это сопровождается приближающимся шуршащим звуком..."
	arrival_sound   = 'sound/effects/wind/wind_3_1.ogg'
	limit = 15
	length = 45
	spawn_near_chance = 10

/datum/mob_list/major/machines
	mobs = list(
				list(/mob/living/simple_animal/hostile/hivebot, 80),
				list(/mob/living/simple_animal/hostile/hivebot/range, 45),
				list(/mob/living/simple_animal/hostile/hivebot/strong, 25),
				list(/mob/living/simple_animal/hostile/hivebot/mega, 2),
			)
	arrival_message = "Земля под вами грохочет, когда вы слышите звуки машин со всех сторон..."
	arrival_sound   = 'sound/effects/wind/wind_3_1.ogg'
	limit = 25
	length = 50
	spawn_near_chance = 10

/datum/mob_list/moderate/spiders
	mobs = list(
				list(/mob/living/simple_animal/hostile/giant_spider/guard, 60),
				list(/mob/living/simple_animal/hostile/giant_spider/hunter, 15),
				list(/mob/living/simple_animal/hostile/giant_spider/nurse, 30),
				list(/mob/living/simple_animal/hostile/giant_spider/spitter, 10),
				list(/mob/living/simple_animal/hostile/giant_spider, 60)
			)
	arrival_message = "Вы чувствуете себя неловко, когда слышите, как что-то шуршит вокруг..."
	arrival_sound = 'sound/effects/wind/wind_3_1.ogg'
	limit = 8
	length = 40
	spawn_near_chance = 5

/datum/mob_list/moderate/machines
	mobs = list(
				list(/mob/living/simple_animal/hostile/hivebot, 95),
				list(/mob/living/simple_animal/hostile/hivebot/range, 15)
			)
	arrival_message = "Вы слышите отдаленный скрип металлических соединений. Что это?"
	arrival_sound = 'sound/effects/wind/wind_3_1.ogg'
	limit = 10
	length = 50
	spawn_near_chance = 15
