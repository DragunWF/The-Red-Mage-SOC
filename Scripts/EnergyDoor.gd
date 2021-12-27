extends StaticBody2D

var opened = false

onready var DoorCollision = get_node("Collision")

func _ready():
	DoorCollision.disabled = false

func _process(delta):
	if opened == true:
		DoorCollision.disabled = true
		$S1.play("opened")
		$S2.play("opened")
		$S3.play("opened")
	if opened == false:
		$S1.play("closed")
		$S2.play("closed")
		$S3.play("closed")

func hit_by_fireball():
	$AbsorbSound.play()

func hit_by_energy_blast():
	$HitSound.play()
	opened = true
