extends KinematicBody2D

const SPEED = 125
const UP = Vector2(0, -1)
const GRAVITY = 20
const JUMP_HEIGHT = -325

var motion = Vector2()
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right

onready var MobSprite = get_node("AnimatedSprite")
onready var JumpTime = get_node("JumpCooldown")

func _ready():
	JumpTime.set_one_shot(false)
	jump_time_start()
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
	if is_on_floor():
		MobSprite.play("Walk")

func hit_by_fireball():
	queue_free()

func hit_by_energy_blast():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_purple_enemy"):
		body.call("hit_by_purple_enemy")

func jump_time_start():
	JumpTime.set_wait_time(1)
	JumpTime.start()

func _on_JumpCooldown_timeout():
	$JumpSound.play()
	MobSprite.play("Jump")
	motion.y = JUMP_HEIGHT
	JumpTime.set_one_shot(true)
	jump_time_start()
