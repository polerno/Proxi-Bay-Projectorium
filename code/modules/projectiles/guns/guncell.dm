#define BATTERY_PISTOL 1
#define BATTERY_RIFLE 2
#define BATTERY_VOX 3
#define BATTERY_ALIEN 4

/*
/obj/item/projectile/plasma/shrapnel
	range_step = 2 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.
	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 40
	fire_sound = null
	no_attack_log = TRUE
	muzzle_type = null
	embed = FALSE
	*/

/obj/item/cell/guncell
	w_class = ITEM_SIZE_SMALL
	name = "Small battery"
	icon = 'proxima/icons/obj/guns/guncells.dmi'
	var/battery_chamber_size = BATTERY_RIFLE
	var/overcharged = FALSE		 	//will allow cell to be used as hand grenade
	var/discharging = FALSE			//To see if it's going to boom
	var/emp_vulnerable = FALSE
	var/arm_sound = 'sound/weapons/armbomb.ogg'

	//var/list/fragment_types = list(/obj/item/projectile/plasma/shrapnel = 1)

/obj/item/cell/guncell/proc/detonate(mob/living/user)
	var/turf/T = get_turf(src)
	var/explosion_size = charge/100*1.2
	if((explosion_size>0) && (T))
		explosion(T, -1, 1, explosion_size, round(explosion_size/2), 0)
		empulse(src, 2, explosion_size)
	qdel(src)

/obj/item/cell/guncell/attack_self(mob/user)
	if(discharging==TRUE)
		to_chat(user, "<span class='warning'>\The [src] is already discharging! Dispose it!</span>")
		return
	if(overcharged==TRUE)
		discharging=TRUE
		update_icon()
		to_chat(user, "<span class='warning'>You activated guncell overcharge function. It will explode in 5 seconds.</span>")
		if (user)
			msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
		var/mob/living/carbon/C = user
		C.throw_mode_on()
		playsound(loc, arm_sound, 75, 0, -3)
		addtimer(CALLBACK(src, .proc/detonate, user), 50) // 5 senconds
	else
		to_chat(user, "<span class='notice'>\The [src] doesn't have overcharged function. Please contact your local manufacturer.</span>")

/obj/item/cell/guncell/emp_act(severity, mob/user)
	..()
	if(emp_vulnerable==TRUE)
		discharging=TRUE
		update_icon()
		to_chat(loc, "<span class='warning'>\The [src] is overloaded! It's going to explode!.</span>")
		playsound(loc, arm_sound, 75, 0, -3)
		addtimer(CALLBACK(src, .proc/detonate, user), 30) // 3 senconds

/obj/item/cell/guncell/overcharged
	name = "Hypercharged battery"
	overcharged = TRUE
	emp_vulnerable = TRUE

/obj/item/cell/guncell/pistol
	name = "Pistol battery"
	battery_chamber_size = BATTERY_PISTOL

/obj/item/cell/guncell/pistol/overcharged
	name = "Hypercharged pistol battery"
	overcharged = TRUE
	emp_vulnerable = TRUE

/* =================================================
				Ascent  battaries
================================================= */

/obj/item/cell/guncell/ascent
	name = "Ascent power core"
	desc = "A very special battery for a very comlex ascent weaponary. This one is stabilized."
	charge = 400 // base 20 shots
	maxcharge = 400
	self_recharge = TRUE
	battery_chamber_size = BATTERY_ALIEN
	icon_state = "a_0"

/obj/item/cell/guncell/ascent/overcharged
	name = "Hypercharged ascent power core"
	desc = "A very special battery for a very comlex ascent weaponary. This one can be rapidly discharged for a violent explosion. Not EMP proof."
	charge = 800 // base 40 shots
	maxcharge = 800
	overcharged = TRUE
	emp_vulnerable = TRUE

/* =================================================
				Vox  battaries
================================================= */

/obj/item/cell/guncell/vox
	name = "Vox power core"
	desc = "A very special battery for a very comlex vox weaponary. This one is stabilized."
	charge = 400 // base 20 shots
	maxcharge = 400
	battery_chamber_size = BATTERY_VOX
	self_recharge = TRUE
	icon_state = "v_0"

/obj/item/cell/guncell/vox/overcharged
	name = "Hypercharged vox power core"
	desc = "A very special battery for a very comlex vox weaponary. This one can be rapidly discharged for a violent explosion. Not EMP proof."
	charge = 600 // base 30 shots
	maxcharge = 600
	overcharged = TRUE
	emp_vulnerable = TRUE

/* =================================================
				Rifle  battaries
================================================= */

/obj/item/cell/guncell/verysmall
	name = "Very-Small weapon battery"
	desc = "A small battery for energy guns."
	charge = 100 // base 5 shots
	maxcharge = 100
	icon_state = "b_0"

/obj/item/cell/guncell/small
	name = "Small weapon battery"
	desc = "A small battery for energy guns."
	charge = 200 // base 10 shots
	maxcharge = 200
	icon_state = "b_1"

/obj/item/cell/guncell/medium
	name = "Medium weapon battery"
	desc = "A medium battery for energy guns."
	charge = 300 // base 15 shots
	maxcharge = 300
	icon_state = "b_2"

/obj/item/cell/guncell/large
	name = "Large weapon battery"
	desc = "A large battery for energy gun."
	charge = 400 // base 20 shots
	maxcharge = 400
	icon_state = "b_3"

/obj/item/cell/guncell/megalarge
	name = "Very-Large weapon battery"
	desc = "A very large battery for energy guns. Do not expose to EMP."
	charge = 500 // base 25 shots
	maxcharge = 500
	icon_state = "b_4"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/huge
	name = "Huge weapon battery"
	desc = "A very large battery for energy guns. Do not expose to EMP."
	charge = 600 // base 25 shots
	maxcharge = 600
	icon_state = "b_5"
	emp_vulnerable = TRUE

/* =================================================
				Overcharged  battaries
================================================= */

/obj/item/cell/guncell/overcharged/verysmall
	name = "Hypercharged Very-Small weapon battery"
	desc = "A small battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 200 // base 10 shots
	maxcharge = 200
	icon_state = "b_0"

/obj/item/cell/guncell/overcharged/small
	name = "Hypercharged Small weapon battery"
	desc = "A small battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 300 // base 15 shots
	maxcharge = 300
	icon_state = "b_1"

/obj/item/cell/guncell/overcharged/medium
	name = "Hypercharged Medium weapon battery"
	desc = "A medium battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 400 // base 20 shots
	maxcharge = 400
	icon_state = "b_2"

/obj/item/cell/guncell/overcharged/large
	name = "Hypercharged Large weapon battery"
	desc = "A large battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 500 // base 25 shots
	maxcharge = 500
	icon_state = "b_3"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/overcharged/megalarge
	name = "Hypercharged Very-Large weapon battery"
	desc = "A very large battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 700 // base 35 shots
	maxcharge = 700
	icon_state = "b_4"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/overcharged/huge
	name = "Hypercharged Huge weapon battery"
	desc = "A huge battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 800 // base 40 shots
	maxcharge = 800
	icon_state = "b_5"
	emp_vulnerable = TRUE

/* =================================================
				Pistol battaries
================================================= */

/obj/item/cell/guncell/pistol/verysmall
	name = "Very-Small pistol weapon battery"
	desc = "A small battery for energy guns."
	charge = 100 // base 5 shots
	maxcharge = 100
	icon_state = "p_0"

/obj/item/cell/guncell/pistol/small
	name = "Small pistol weapon battery"
	desc = "A small battery for energy guns."
	charge = 200 // base 10 shots
	maxcharge = 200
	icon_state = "p_1"

/obj/item/cell/guncell/pistol/medium
	name = "Medium pistol weapon battery"
	desc = "A medium battery for energy guns."
	charge = 300 // base 15 shots
	maxcharge = 300
	icon_state = "p_2"

/obj/item/cell/guncell/pistol/large
	name = "Large pistol weapon battery"
	desc = "A large battery for energy guns."
	charge = 400 // base 20 shots
	maxcharge = 400
	icon_state = "p_3"

/obj/item/cell/guncell/pistol/megalarge
	name = "Very-Large pistol weapon battery"
	desc = "A very large battery for energy guns. Do not expose to EMP"
	charge = 500 // base 25 shots
	maxcharge = 500
	icon_state = "p_4"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/pistol/huge
	name = "Huge pistol weapon battery"
	desc = "A huge battery for energy guns. Do not expose to EMP."
	charge = 600 // base 30 shots
	maxcharge = 600
	icon_state = "p_5"
	emp_vulnerable = TRUE

/* =================================================
				Pistol overcharged battaries
================================================= */

/obj/item/cell/guncell/pistol/overcharged/verysmall
	name = "Hypercharged Very-Small weapon battery"
	desc = "A small battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 200 // base 10 shots
	maxcharge = 200
	icon_state = "p_0"

/obj/item/cell/guncell/pistol/overcharged/small
	name = "Hypercharged Small weapon battery"
	desc = "A small battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 300 // base 15 shots
	maxcharge = 300
	icon_state = "p_1"

/obj/item/cell/guncell/pistol/overcharged/medium
	name = "Hypercharged Medium weapon battery"
	desc = "A medium battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 400 // base 20 shots
	maxcharge = 400
	icon_state = "p_2"

/obj/item/cell/guncell/pistol/overcharged/large
	name = "Hypercharged Large weapon battery"
	desc = "A large battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP."
	charge = 500 // base 25 shots
	maxcharge = 500
	icon_state = "p_3"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/pistol/overcharged/megalarge
	name = "Hypercharged Very-Large weapon battery"
	desc = "A very large battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP"
	charge = 700 // base 35 shots
	maxcharge = 700
	icon_state = "p_4"
	emp_vulnerable = TRUE

/obj/item/cell/guncell/pistol/overcharged/huge
	name = "Hypercharged Huge weapon battery"
	desc = "A huge battery for energy guns. This one can be rapidly discharged for a violent explosion. Do not expose to EMP"
	charge = 800 // base 40 shots
	maxcharge = 800
	icon_state = "p_5"
	emp_vulnerable = TRUE

//pasta time
/obj/item/cell/guncell/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "b_70+"
		if(35 to 69)
			new_overlay_state = "b_35+"
		if(0.05 to 34)
			new_overlay_state = "b_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_b"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/overcharged/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "bo_70+"
		if(35 to 69)
			new_overlay_state = "bo_35+"
		if(0.05 to 34)
			new_overlay_state = "bo_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_b"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/pistol/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "p_70+"
		if(35 to 69)
			new_overlay_state = "p_35+"
		if(0.05 to 34)
			new_overlay_state = "p_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_p"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/pistol/overcharged/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "po_70+"
		if(35 to 69)
			new_overlay_state = "po_35+"
		if(0.05 to 34)
			new_overlay_state = "po_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_p"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/ascent/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "a_70+"
		if(35 to 69)
			new_overlay_state = "a_35+"
		if(0.05 to 34)
			new_overlay_state = "a_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_a"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/ascent/overcharged/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "ao_70+"
		if(35 to 69)
			new_overlay_state = "ao_35+"
		if(0.05 to 34)
			new_overlay_state = "ao_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_a"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/vox/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "v_70+"
		if(35 to 69)
			new_overlay_state = "v_35+"
		if(0.05 to 34)
			new_overlay_state = "v_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_a"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/guncell/vox/overcharged/on_update_icon()

	var/new_overlay_state = null
	switch(percent())
		if(70 to 100)
			new_overlay_state = "vo_70+"
		if(35 to 69)
			new_overlay_state = "vo_35+"
		if(0.05 to 34)
			new_overlay_state = "vo_0+"
	if(discharging==TRUE)
		new_overlay_state = "overloaded_a"

	if(new_overlay_state != overlay_state)
		overlay_state = new_overlay_state
		overlays.Cut()
		if(overlay_state)
			overlays += image(icon, overlay_state)

/obj/item/cell/Initialize()
	. = ..()
	if(self_recharge)
		START_PROCESSING(SSobj, src)
	update_icon()

/obj/item/cell/Destroy()
	if(self_recharge)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/cell/Process()
	if(self_recharge) //Every [recharge_time] ticks, recharge a shot for the cyborg
		var/charge_tick
		var/recharge_time = 20
		charge_tick++
		if(charge_tick < recharge_time) return 0
		charge_tick = 0

		if(charge >= maxcharge)
			return 0 // check if we actually need to recharge

		charge+=10 //... to recharge the shot
		update_icon()
	return 1
