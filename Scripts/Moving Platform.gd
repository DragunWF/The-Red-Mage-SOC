extends KinematicBody2D

const SPEED = 75
const UP = Vector2(0, -1)

var motion = Vector2()
var right = Vector2(1, 0)
var left = Vector2(-1, 0)
var direction = right

func _physics_process(delta):
	motion.x = direction.x * SPEED
	motion = move_and_slide(motion, UP)
	if is_on_wall():
		if direction == left:
			direction = right
		elif direction == right:
			direction = left
