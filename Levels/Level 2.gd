extends Node2D

onready var Sign1 = get_node("Signs/Sign/Label")
onready var Sign2 = get_node("Signs/Sign2/Label")

func _ready():
	Sign1.visible = false
	Sign2.visible = false

#Sign 1
func _on_Sign_body_entered(body):
	if body.name == "Player":
		Sign1.visible = true

func _on_Sign_body_exited(body):
	if body.name == "Player":
		Sign1.visible = false

#Sign 2
func _on_Sign2_body_entered(body):
	if body.name == "Player":
		Sign2.visible = true

func _on_Sign2_body_exited(body):
	if body.name == "Player":
		Sign2.visible = false

#Flag
func _on_Flag_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://User Interface/Main Menu.tscn")
