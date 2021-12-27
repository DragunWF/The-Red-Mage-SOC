extends Area2D

const SPEED = 225

var motion = Vector2()
var moving = true

onready var EnergySprite = get_node("AnimatedSprite")

func _ready():
	EnergySprite.play("Energy")

func _physics_process(delta):
	if moving == true:
		motion.x += SPEED
	motion = motion.normalized() * SPEED
	position += motion * delta
	if moving == false:
		motion.x = 0

func _on_EnergyBlast_body_entered(body):
	if body.has_method("hit_by_energy_blast"):
		body.call("hit_by_energy_blast")
	queue_free()



