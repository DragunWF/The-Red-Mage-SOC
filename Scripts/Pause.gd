extends Control

var active = true

onready var Menu = get_node("Menu")

func _ready():
	Menu.visible = false
	active = true

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and active == true:
		Menu.visible = true
		get_tree().paused = true

func _on_Resume_pressed():
	$Click.play()
	get_tree().paused = false
	Menu.visible = false

func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_Return_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://User Interface/Main Menu.tscn")

func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().quit()

func remove_access_to_pause_menu():
	active = false

