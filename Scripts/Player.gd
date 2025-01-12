extends KinematicBody2D

const FireballRight = preload("res://Stuff/Fireball/Fireball.tscn")
const FireballLeft = preload("res://Stuff/Fireball/Fireball2.tscn")
const EnergyBlastRight = preload("res://Stuff/Energy Blast/EnergyBlast.tscn")
const EnergyBlastLeft = preload("res://Stuff/Energy Blast/EnergyBlast2.tscn")

const MAX_HEALTH = 5
const MAX_MANA = 5
const GRAVITY = 20
const UP = Vector2(0, -1)

var motion = Vector2()
var Health = MAX_HEALTH
var Mana = MAX_MANA
var Speed = 175
var Jump_Height = -350
var DialoguePlaying = false
var airborne = false
var invincible = false
var active = true

#Modes
var RedMode = false
var BlueMode = false

#Casting Cost
var FireballCastingCost = 1
var EnergyBlastCastingCost = 1

#Right and Left
var Right = false
var Left = false

onready var PlayerSprite = get_node("AnimatedSprite")
onready var BlueMageSprite = get_node("AnimatedSpriteBlue")
onready var PositionRight = get_node("PositionRight")
onready var PositionLeft = get_node("PositionLeft")
onready var FireballCastTime = get_node("FireballCastTime")
onready var EnergyCastTime = get_node("EnergyBlastCastTime")
onready var InvincibleTime = get_node("InvincibleTime")
onready var ManaRegenTime = get_node("ManaRegenTime")
onready var GameOverMenu = get_node("UI/GameOver")

func _ready():
	FireballCastTime.set_one_shot(false)
	EnergyCastTime.set_one_shot(false)
	InvincibleTime.set_one_shot(false)
	ManaRegenTime.set_one_shot(false)
	GameOverMenu.visible = false
	RedMode = true
	BlueMode = false
	Right = true
	Left = false
	mana_regen_start()

func _physics_process(delta):
	motion.y += GRAVITY
	if Health <= 0:
		motion.x = 0
		active = false
	if RedMode == true:
		PlayerSprite.visible = true
		BlueMageSprite.visible = false
	if BlueMode == true:
		PlayerSprite.visible = false
		BlueMageSprite.visible = true
	if invincible == true and airborne == false and active == true:
		PlayerSprite.play("Damage")
		BlueMageSprite.play("Damage")
	if invincible == true and airborne == true and active == true:
		PlayerSprite.play("JumpDamage")
		BlueMageSprite.play("JumpDamage")
	if RedMode == false:
		PlayerSprite.visible = false
	if BlueMode == false:
		BlueMageSprite.visible = false
	if DialoguePlaying == false and active == true:
		if Input.is_action_pressed("ui_right"):
			if airborne == false and invincible == false:
				PlayerSprite.play("Walk")
				BlueMageSprite.play("Walk")
			PlayerSprite.flip_h = false
			BlueMageSprite.flip_h = false
			Left = false
			Right = true
			motion.x = Speed
		elif Input.is_action_pressed("ui_left"):
			if airborne == false and invincible == false:
				PlayerSprite.play("Walk")
				BlueMageSprite.play("Walk")
			PlayerSprite.flip_h = true
			BlueMageSprite.flip_h = true
			Right = false
			Left = true
			motion.x = -Speed
		else:
			if motion.y == 20 and invincible == false:
				PlayerSprite.play("Idle")
				BlueMageSprite.play("Idle")
			motion.x = 0
		if Input.is_action_just_pressed("ui_accept"):
			if FireballCastTime.is_stopped() and Mana >= 1:
				if RedMode == true and BlueMode == false:
					Mana -= 1
					update_mana_bar()
					cast_fireball()
					fireball_time_cooldown()
			if EnergyCastTime.is_stopped() and Mana >= 1:
				if RedMode == false and BlueMode == true:
					Mana -= 1
					update_mana_bar()
					cast_energy_blast()
					energy_blast_cooldown()
	if is_on_floor() and active == true:
		airborne = false
		if Input.is_action_just_pressed("ui_up"):
			$JumpSound.play()
			airborne = true
			motion.y = Jump_Height
			if airborne == true and invincible == false:
				PlayerSprite.play("Jump")
				BlueMageSprite.play("Jump")
			if airborne == true and invincible == true:
				PlayerSprite.play("JumpDamage")
				BlueMageSprite.play("JumpDamage")
	motion = move_and_slide(motion, UP)

func _input(event):
	if Input.is_key_pressed(KEY_Z) and BlueMode == false and active == true:
		$SwitchMageSound.play()
		RedMode = false
		BlueMode = true
	if Input.is_key_pressed(KEY_X) and RedMode == false and active == true:
		$SwitchMageSound.play()
		BlueMode = false
		RedMode = true

func cast_fireball():
	$FireballSound.play()
	if Right == true:
		var fire = FireballRight.instance()
		get_parent().add_child(fire)
		fire.set_position(PositionRight.get_global_position())
	if Left == true:
		var fire = FireballLeft.instance()
		get_parent().add_child(fire)
		fire.set_position(PositionLeft.get_global_position())

func fireball_time_cooldown():
	FireballCastTime.set_wait_time(1)
	FireballCastTime.start()

func _on_FireballCastTime_timeout():
	FireballCastTime.set_one_shot(true)

func cast_energy_blast():
	$EnergyBlastSound.play()
	if Right == true:
		var blast = EnergyBlastRight.instance()
		get_parent().add_child(blast)
		blast.set_position(PositionRight.get_global_position())
	if Left == true:
		var blast = EnergyBlastLeft.instance()
		get_parent().add_child(blast)
		blast.set_position(PositionLeft.get_global_position())

func energy_blast_cooldown():
	EnergyCastTime.set_wait_time(1)
	EnergyCastTime.start()

func _on_EnergyBlastCastTime_timeout():
	EnergyCastTime.set_one_shot(true)

func invincible_time_start():
	InvincibleTime.set_wait_time(2)
	InvincibleTime.start()

func _on_InvincibleTime_timeout():
	invincible = false
	InvincibleTime.set_one_shot(true)

func mana_regen_start():
	ManaRegenTime.set_wait_time(10)
	ManaRegenTime.start()

func _on_ManaRegenTime_timeout():
	if Mana <= 4:
		$GainSound.play()
		Mana += 1
		update_mana_bar()
	mana_regen_start()
	ManaRegenTime.set_one_shot(true)

func update_health_bar():
	get_node("UI/Interface/BarHealth/Health").set_value(Health)
	if Health <= 0:
		PlayerSprite.play("Death")
		BlueMageSprite.play("Death")

func update_mana_bar():
	get_node("UI/Interface/BarMana/Mana").set_value(Mana)

#Damage Codes
func hit_by_green_enemy():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_red_enemy():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 2
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_blue_enemy():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		Mana -= 1
		invincible = true
		update_health_bar()
		update_mana_bar()
		invincible_time_start()

func hit_by_purple_enemy():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_tank_enemy():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_fireball():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_energy_blast():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func hit_by_spike():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func pick_health_potion():
	if Health <= 4:
		$GainSound.play()
		Health += 1
		update_health_bar()

func pick_mana_potion():
	if Mana <= 4:
		$GainSound.play()
		Mana += 1
		update_mana_bar()

func pick_random_potion_damage():
	if invincible == false and Health >= 1:
		$DamageSound.play()
		Health -= 1
		invincible = true
		update_health_bar()
		invincible_time_start()

func _on_Hitbox_area_entered(area):
	if area.has_method("picked_health_potion") and Health <= 4:
		area.call("picked_health_potion")
		pick_health_potion()
	if area.has_method("picked_mana_potion") and Mana <= 4:
		area.call("picked_mana_potion")
		pick_mana_potion()
	if area.has_method("picked_random_potion"):
		area.call("picked_random_potion")

func _on_AnimatedSprite_animation_finished():
	if Health <= 0 and RedMode == true:
		$GameOverSound.play()
		get_node("UI/Pause").remove_access_to_pause_menu()
		GameOverMenu.visible = true

func _on_AnimatedSpriteBlue_animation_finished():
	if Health <= 0 and BlueMode == true:
		$GameOverSound.play()
		get_node("UI/Pause").remove_access_to_pause_menu()
		GameOverMenu.visible = true

#Game Over Menu
func _on_Restart_pressed():
	get_tree().reload_current_scene()

func _on_Return_pressed():
	get_tree().change_scene("res://User Interface/Main Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
