extends Node2D

onready var Sign1 = get_node("Signs/Sign/Label")
onready var Sign2 = get_node("Signs/Sign2/Label")
onready var Sign3 = get_node("Signs/Sign3/Label")
onready var Sign4 = get_node("Signs/Sign4/Label")
onready var Sign5 = get_node("Signs/Sign5/Label")
onready var Sign6 = get_node("Signs/Sign6/Label")
onready var Sign7 = get_node("Signs/Sign7/Label")

func _ready():
	Sign1.visible = false
	Sign2.visible = false
	Sign3.visible = false
	Sign4.visible = false
	Sign5.visible = false
	Sign6.visible = false
	Sign7.visible = false

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

#Sign 3
func _on_Sign3_body_entered(body):
	if body.name == "Player":
		Sign3.visible = true

func _on_Sign3_body_exited(body):
	if body.name == "Player":
		Sign3.visible = false

#Sign 4
func _on_Sign4_body_entered(body):
	if body.name == "Player":
		Sign4.visible = true

func _on_Sign4_body_exited(body):
	if body.name == "Player":
		Sign4.visible = false

#Sign 5
func _on_Sign5_body_entered(body):
	if body.name == "Player":
		Sign5.visible = true

func _on_Sign5_body_exited(body):
	if body.name == "Player":
		Sign5.visible = false

#Sign 6
func _on_Sign6_body_entered(body):
	if body.name == "Player":
		Sign6.visible = true

func _on_Sign6_body_exited(body):
	if body.name == "Player":
		Sign6.visible = false

#Sign 7
func _on_Sign7_body_entered(body):
	if body.name == "Player":
		Sign7.visible = true

func _on_Sign7_body_exited(body):
	if body.name == "Player":
		Sign7.visible = false

#Flag
func _on_Flag_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/Level 2.tscn")
