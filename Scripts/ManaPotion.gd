extends Area2D

onready var PotionSprite = get_node("AnimatedSprite")

func _ready():
	PotionSprite.play("Idle")

func _on_ManaPotion_body_entered(body):
	if body.has_method("pick_mana_potion"):
		body.call("pick_mana_potion")

func picked_mana_potion():
	queue_free()

