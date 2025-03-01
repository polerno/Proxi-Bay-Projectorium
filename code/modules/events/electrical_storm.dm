/datum/event/electrical_storm
	announceWhen = 0		// Warn them shortly before it begins.
	startWhen = 30
	endWhen = 60			// Set in start()
	has_skybox_image = TRUE
	var/list/valid_apcs		// Shuffled list of valid APCs.
	var/static/lightning_color

/datum/event/electrical_storm/get_skybox_image()
	if(!lightning_color)
		lightning_color = pick("#ffd98c", "#ebc7ff", "#bdfcff", "#bdd2ff", "#b0ffca", "#ff8178", "#ad74cc")
	var/image/res = overlay_image('icons/skybox/electrobox.dmi', "lightning", lightning_color, RESET_COLOR)
	res.blend_mode = BLEND_ADD
	return res

/datum/event/electrical_storm/announce()
	..()
	switch(severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Небольшая электрическая буря была обнаружена вблизи [location_name()]. Пожалуйста, следите за возможными электрическими разрядами.", "[station_name()] Sensor Array", zlevels = affecting_z)
		if(EVENT_LEVEL_MODERATE)
			command_announcement.Announce("Вблизи [location_name()] обнаружена сильная электрическая буря. Рекомендуется немедленно обезопасить чувствительное электрооборудование с целью сохранения его работоспособности.", "[station_name()] Sensor Array", new_sound = GLOB.using_map.electrical_storm_moderate_sound, zlevels = affecting_z)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Аномальная электрическая буря неизвестной силы была обнаружена в непосредственной близости от [location_name()]. Требуется немедленно обезопасить чувствительное электрооборудование с целью сохранения его работоспособности.", "[station_name()] Sensor Array", new_sound = GLOB.using_map.electrical_storm_major_sound, zlevels = affecting_z)

/datum/event/electrical_storm/start()
	..()
	valid_apcs = list()
	for(var/obj/machinery/power/apc/A in SSmachines.machinery)
		if(A.z in affecting_z)
			valid_apcs.Add(A)
	endWhen = (severity * 60) + startWhen

/datum/event/electrical_storm/tick()
	..()
	//See if shields can stop it first
	var/list/shields = list()
	for(var/obj/machinery/power/shield_generator/G in SSmachines.machinery)
		if((G.z in affecting_z) && G.running && G.check_flag(MODEFLAG_EM))
			shields += G
	if(shields.len)
		var/obj/machinery/power/shield_generator/shield_gen = pick(shields)
		//Minor breaches aren't enough to let through frying amounts of power
		if(shield_gen.take_damage(30 * severity, SHIELD_DAMTYPE_EM) <= SHIELD_BREACHED_MINOR)
			return
	if(!length(valid_apcs))
		CRASH("No valid APCs found for electrical storm event! This is likely a bug. Location: [location_name()] - Z Level: [affecting_z]")
	var/list/picked_apcs = list()
	for(var/i=0, i< severity*2, i++) // up to 2/4/6 APCs per tick depending on severity
		picked_apcs |= pick(valid_apcs)

	for(var/obj/machinery/power/apc/T in picked_apcs)
		// Main breaker is turned off. Consider this APC protected.
		if(!T.operating)
			continue

		// Decent chance to overload lighting circuit.
		if(prob(3 * severity))
			T.overload_lighting()

		// Relatively small chance to emag the apc as apc_damage event does.
		if(prob(0.2 * severity))
			T.emagged = TRUE
			T.update_icon()

		if(T.is_critical)
			T.energy_fail(10 * severity)
			continue
		else
			T.energy_fail(10 * severity * rand(severity * 2, severity * 4))

		// Very tiny chance to completely break the APC. Has a check to ensure we don't break critical APCs such as the Engine room, or AI core. Does not occur on Mundane severity.
		if(prob((0.2 * severity) - 0.2))
			T.set_broken()



/datum/event/electrical_storm/end()
	..()
	command_announcement.Announce("[location_name()] вышел из электрической бури. Пожалуйста, устраните любые электрические перегрузки.", "Electrical Storm Alert", zlevels = affecting_z)
