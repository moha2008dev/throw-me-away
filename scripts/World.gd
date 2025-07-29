extends Node2D


func _ready():
	$wol.play("1")



func _on_area_body_entered(body):
	$wol.stop()


func _on_area_body_exited(body):
	$wol.play("1")
