extends Node2D

var pushed = false

onready var DoorCollision = get_node("Door/DoorCollision")
onready var ButtonSprite = get_node("Button/S1")

func _ready():
	DoorCollision.disabled = false
	ButtonSprite.play("unpushed")
	$Door/S1.play("closed")
	$Door/S2.play("closed")
	$Door/S3.play("closed")

func _process(delta):
	if pushed == true:
		DoorCollision.disabled = true

func button_pushed():
	pushed = true
	ButtonSprite.play("pushed")
	$Door/S1.play("opened")
	$Door/S2.play("opened")
	$Door/S3.play("opened")

func _on_Button_body_entered(body):
	if body.name == "Player" and pushed == false:
		$Button/PushSound.play()
		button_pushed()
	if body.has_method("door_function") and pushed == false:
		$Button/PushSound.play()
		button_pushed()


