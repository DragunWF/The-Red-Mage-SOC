extends KinematicBody2D

const SPEED = 175
const UP = Vector2(0, -1)
const GRAVITY = 20

var motion = Vector2()
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right

onready var MobSprite = get_node("AnimatedSprite")

func _ready():
	MobSprite.play("Walk")

func _physics_process(delta):
	motion.y += GRAVITY
	motion.x = direction.x * SPEED
	motion = move_and_slide(motion, UP)
	if is_on_wall():
		if direction == left:
			MobSprite.flip_h = false
			direction = right
		elif direction == right:
			MobSprite.flip_h = true
			direction = left

func hit_by_fireball():
	$Absorb.play()

func hit_by_energy_blast():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_red_enemy"):
		body.call("hit_by_red_enemy")
