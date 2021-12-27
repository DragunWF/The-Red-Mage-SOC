extends KinematicBody2D

const EnergyBlast = preload("res://Stuff/Energy Blast/EnergyBlast2.tscn")

const UP = Vector2(0, -1)
const GRAVITY = 20

var motion = Vector2()
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right

onready var MobSprite = get_node("AnimatedSprite")
onready var CooldownTimer = get_node("FireballCooldown")

func _ready():
	MobSprite.play("Idle")
	CooldownTimer.set_one_shot(false)
	cast_energy_blast()

func _physics_process(delta):
	motion.y += GRAVITY
	motion.x = 0
	motion = move_and_slide(motion, UP)

func hit_by_fireball():
	queue_free()

func hit_by_energy_blast():
	$Absorb.play()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_blue_enemy"):
		body.call("hit_by_blue_enemy")

func cast_energy_blast():
	CooldownTimer.set_wait_time(2)
	CooldownTimer.start()

func _on_FireballCooldown_timeout():
	$BlastSound.play()
	var blast = EnergyBlast.instance()
	get_parent().add_child(blast)
	blast.set_position(get_node("Position").get_global_position())
	CooldownTimer.set_one_shot(true)
	cast_energy_blast()
