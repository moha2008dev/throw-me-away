extends CanvasLayer

var cam : Camera2D
var duration : float
var timer_intial : float
var timer_on : bool = false

signal timeout

func change_scene(scene_path:String,color:String = "#131313") -> void:
	$ColorRect.show()
#	var anim = $ColorRect/AnimationPlayer.get_animation("fade_out")
#	anim.track_set_key_value(0,0,Color(color))
	$ColorRect/AnimationPlayer.play_backwards("fade_out")
	yield($ColorRect/AnimationPlayer,"animation_finished")
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene(scene_path)
	$ColorRect/AnimationPlayer.play("fade_out")
	yield($ColorRect/AnimationPlayer,"animation_finished")
	$ColorRect.hide()

func change_scene_to(packed_scene:PackedScene,color:String = "#131313") -> void:
	$ColorRect.show()
#	var anim = $ColorRect/AnimationPlayer.get_animation("fade_out")
#	anim.track_set_key_value(0,0,Color(color))
	$ColorRect/AnimationPlayer.play_backwards("fade_out")
	yield($ColorRect/AnimationPlayer,"animation_finished")
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene_to(packed_scene)
	$ColorRect/AnimationPlayer.play("fade_out")
	yield($ColorRect/AnimationPlayer,"animation_finished")
	$ColorRect.hide()

func reload_scene() -> void:
	$ColorRect.show()
	get_tree().paused = true
	$ColorRect/AnimationPlayer.play_backwards("fade_out")
	yield($ColorRect/AnimationPlayer,"animation_finished")
	get_tree().reload_current_scene()
	yield(get_tree().create_timer(0.4),"timeout")
	$ColorRect/AnimationPlayer.play("fade_out")
	get_tree().paused = false
	yield($ColorRect/AnimationPlayer,"animation_finished")
	$ColorRect.hide()

func create_timer(time : float) -> void:
	duration = time
	timer_intial = OS.get_ticks_msec()
	timer_on = true

func _process(delta):
	if timer_on:
		var elapsed = (OS.get_ticks_msec() - timer_intial) / 1000.0
		if elapsed >= duration:
			timer_on = false
			emit_signal("timeout")
