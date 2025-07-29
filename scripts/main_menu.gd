extends Control

var scene_go_to = preload("res://scenes/World.tscn")

func _on_new_pressed():
	get_tree().change_scene_to(scene_go_to)


func _on_load_pressed():
	get_tree().change_scene_to(scene_go_to)


func _on_settings_pressed():
	get_tree().change_scene("res://scenes/test_scene.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_credit_pressed():
	get_tree().change_scene("res://scenes/credit.tscn")
