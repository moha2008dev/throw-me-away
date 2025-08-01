extends Control

var scene_go_to = preload("res://scenes/World.tscn")

func _on_new_pressed():
	var loading_scene = preload("res://scenes/loading scenes/loading.tscn")
	Global.change_scene_to(loading_scene)


func _on_load_pressed():
	var loading_scene = preload("res://scenes/loading scenes/loading.tscn")
	Global.change_scene_to(loading_scene)


func _on_settings_pressed():
	$Options.play("press")


func _on_exit_pressed():
	$exit2.play("press")


func _on_credit_pressed():
	$credit2.play("press")




func _on_Options_frame_changed():
	Global.change_scene("res://scenes/options.tscn")


func _on_credit2_frame_changed():
	Global.change_scene("res://scenes/credit.tscn","#05301a")


func _on_exit2_frame_changed():
	get_tree().quit()
