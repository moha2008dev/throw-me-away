extends KinematicBody2D

var mon = Vector2()
var speed = 300


func _physics_process(delta):
	mon = move_and_slide(mon, Vector2.UP)
	if Input.is_action_pressed("right"):
		mon.x = speed
	elif Input.is_action_pressed("left"):
		mon.x = -speed
	else:
		mon.x = 0

