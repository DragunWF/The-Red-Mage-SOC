extends Area2D

var rng = RandomNumberGenerator.new()
var random_number = 0

onready var PotionSprite = get_node("AnimatedSprite")

func _ready():
	rng.randomize()
	random_number = rng.randi_range(1, 3)
	PotionSprite.play("Idle")

func _on_RandomPotion_body_entered(body):
	if body.has_method("pick_health_potion") and random_number == 1:
		body.call("pick_health_potion")
		print("1")
	if body.has_method("pick_mana_potion") and random_number == 2:
		body.call("pick_mana_potion")
		print("2")
	if body.has_method("pick_random_potion_damage") and random_number == 3:
		body.call("pick_random_potion_damage")
		print("3")

func picked_random_potion():
	if random_number == 1:
		pass
	if random_number == 2:
		pass
	if random_number == 3:
		queue_free()
