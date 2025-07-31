extends Control

var next_scene_to_load = "res://scenes/World.tscn"

func _ready():
	$AnimationPlayer2.play("loading")
	yield(get_tree(), "idle_frame")
	load_scene_async()
func load_scene_async():
	var loader = ResourceLoader.load_interactive(next_scene_to_load)
	if loader == null :
		print("loading failed")
		return
	while loader.poll() == OK :
		yield(get_tree(), "idle_frame")
	yield(get_tree().create_timer(2.5),"timeout")
	var packed_scene = loader.get_resource()
	if packed_scene :
		Global.change_scene_to(packed_scene)
