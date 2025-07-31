extends Control

var previos_scene = "res://scenes/main_menu.tscn"

func _ready():
	yield(get_tree().create_timer(0.6),"timeout")
	$AnimationPlayer.play("up")

func _on_TextureButton_pressed():
	Global.change_scene(previos_scene,"#05301a")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "up":
		Global.change_scene(previos_scene,"#05301a")
