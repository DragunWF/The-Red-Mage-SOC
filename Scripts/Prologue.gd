extends Node2D

var DialoguePlaying = false

onready var RedMage = get_node("Mages/RedMagePrologue")
onready var BlueMage = get_node("Mages/BlueMagePrologue")
onready var DialogueStartTime = get_node("DialogueStartTime")
onready var Dialogue = get_node("CanvasLayer/Dialogue")
onready var ClickSound = get_node("CanvasLayer/ClickSound")

#chat variables
onready var Chat1 = get_node("CanvasLayer/Dialogue/Chat1")
onready var Chat2 = get_node("CanvasLayer/Dialogue/Chat2")
onready var Chat3 = get_node("CanvasLayer/Dialogue/Chat3")

func _ready():
	$ChangeTime.set_one_shot(false)
	Dialogue.visible = false
	DialogueStartTime.set_one_shot(false)
	DialogueStartTime.set_wait_time(2)
	DialogueStartTime.start()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func _on_DialogueStartTime_timeout():
	if DialoguePlaying == false:
		Dialogue.visible = true
		DialoguePlaying = true
		DialogueStartTime.set_one_shot(true)

func _on_Next_pressed():
	ClickSound.play()
	Chat1.visible = false
	Chat2.visible = true

func _on_Next2_pressed():
	ClickSound.play()
	Chat2.visible = false
	Chat3.visible = true

func _on_Next3_pressed():
	ClickSound.play()

func _on_Skip_pressed():
	ClickSound.play()
	Dialogue.visible = false
	RedMage.dialogue_finished()
	BlueMage.dialogue_finished()
	BlueMage.flip_sprite()

func _on_ChangeScene_body_entered(body):
	if body.has_method("door_function"):
		$ChangeTime.set_wait_time(1)
		$ChangeTime.start()

func _on_ChangeTime_timeout():
	get_tree().change_scene("res://Levels/Level 1.tscn")
