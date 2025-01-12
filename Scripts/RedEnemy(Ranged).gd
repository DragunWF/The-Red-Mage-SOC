extends KinematicBody2D

const Fireball = preload("res://Stuff/Fireball/Fireball2.tscn")

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
	cast_fireball()

func _physics_process(delta):
	motion.y += GRAVITY
	motion.x = 0
	motion = move_and_slide(motion, UP)

func hit_by_fireball():
	$Absorb.play()

func hit_by_energy_blast():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_red_enemy"):
		body.call("hit_by_red_enemy")

func cast_fireball():
	CooldownTimer.set_wait_time(2)
	CooldownTimer.start()

func _on_FireballCooldown_timeout():
	$FireballSound.play()
	var fire = Fireball.instance()
	get_parent().add_child(fire)
	fire.set_position(get_node("Position").get_global_position())
	CooldownTimer.set_one_shot(true)
	cast_fireball()


