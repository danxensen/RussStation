/obj/item/gun/chem/alcohol_gun
	name = "SHOTgun"
	desc = "a chem gun designed to shoot ethanol based beverages into bar patrons."
	inhand_icon_state = "shotgun"
	time_per_syringe = 200
	fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'

/obj/item/gun/chem/alcohol_gun/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignal(reagents, list(COMSIG_REAGENTS_ADD_REAGENT), .proc/on_reagent_change)

/obj/item/gun/chem/alcohol_gun/proc/on_reagent_change(datum/reagents/holder, ...)
	if(!(obj_flags & EMAGGED))
		for(var/datum/reagent/contents in reagents.reagent_list)
			if(!istype(contents, /datum/reagent/consumable/ethanol))
				reagents.clear_reagents()
				playsound(src,'sound/weapons/sear.ogg',50)
				loc.visible_message("<span class='warning'>The [name] purges the contents of its chamber!</span>", null, "<span class='hear'>You hear a sizzling sound!</span>")
				//to_chat(loc.visible_message,"The [name] purges the contents of its chamber!")
				return

/obj/item/gun/chem/alcohol_gun/emag_act()
	if(obj_flags & EMAGGED)
		return
	Emag()

/obj/item/gun/chem/alcohol_gun/proc/Emag()
	obj_flags ^= EMAGGED
	playsound(src.loc,"sparks",100,TRUE)
	loc.visible_message("You hear a sparking sound","<span class='warning'>You scramble the [name]'s purge sensor</span>")
