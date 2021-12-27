extends Control

func _ready():
	$Music.play()

func _on_Start_pressed():
	get_tree().change_scene("res://Levels/Prologue.tscn")

func _on_Select_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
