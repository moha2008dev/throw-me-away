extends Control

func _ready():
	yield(get_tree().create_timer(3.5),"timeout")
	Global.change_scene("res://scenes/main_menu.tscn")

