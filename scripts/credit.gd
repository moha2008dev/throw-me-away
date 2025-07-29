extends Control

var previos_scene = "res://scenes/main_menu.tscn"

func _ready():
	$AnimationPlayer.play("up")
	

func _on_TextureButton_pressed():
	get_tree().change_scene(previos_scene)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "up":
		get_tree().change_scene("res://scenes/main_menu.tscn")
