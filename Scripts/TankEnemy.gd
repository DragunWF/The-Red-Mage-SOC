extends KinematicBody2D

const SPEED = 130
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_HEALTH = 2

var motion = Vector2()
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var Health = MAX_HEALTH
var direction = right
var invincible = false

onready var MobSprite = get_node("AnimatedSprite")
onready var InvincibleTime = get_node("InvincibleCooldown")

func _ready():
	InvincibleTime.set_one_shot(false)
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
	if Health <= 0:
		enemy_defeated()

func hit_by_fireball():
	if invincible == false:
		$DamageSound.play()
		Health -= 1
		invincible_time_start()

func hit_by_energy_blast():
	if invincible == false:
		$DamageSound.play()
		Health -= 1
		invincible_time_start()

func enemy_defeated():
	queue_free()

func _on_Hitbox_body_entered(body):
	if body.has_method("hit_by_tank_enemy"):
		body.call("hit_by_tank_enemy")

func invincible_time_start():
	invincible = true
	InvincibleTime.set_wait_time(.3)
	InvincibleTime.start()

func _on_InvincibleCooldown_timeout():
	invincible = false
	InvincibleTime.set_one_shot(true)
