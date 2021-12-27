extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 125

var motion = Vector2()
var DialoguePlaying = true

onready var MageSprite = get_node("AnimatedSprite")

func _ready():
	MageSprite.play("Idle")

func _physics_process(delta):
	motion.y = GRAVITY
	if DialoguePlaying == true:
		motion.x = 0
	if DialoguePlaying == false:
		motion.x = SPEED
	motion = move_and_slide(motion, UP)

func dialogue_finished():
	MageSprite.play("Walk")
	DialoguePlaying = false

func flip_sprite():
	MageSprite.flip_h = false

func door_function():
	pass
