extends Control

func _ready():
	$AnimationPlayer.play("fade in_out")
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/main_menu.tscn")
