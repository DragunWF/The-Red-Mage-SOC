extends Area2D

onready var PotionSprite = get_node("AnimatedSprite")

func _ready():
	PotionSprite.play("Idle")

func _on_HealthPotion_body_entered(body):
	if body.has_method("pick_health_potion"):
		body.call("pick_health_potion")

func picked_health_potion():
	queue_free()