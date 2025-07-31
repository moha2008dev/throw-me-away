extends Camera2D

var shake_amount = 1
onready var enemy = $"../../soldier"

func _ready() -> void:
	set_physics_process(false)
	Global.cam = self

func _physics_process(delta) -> void:
	offset = Vector2(rand_range(-3,3)*shake_amount,rand_range(-3,3)*shake_amount)

func shake(time:float,amount:float) -> void:
	$Timer.wait_time = time
	shake_amount = amount
	set_physics_process(true)
	$Timer.start()

func _on_Timer_timeout() -> void:
	set_physics_process(false)
	offset = Vector2()

func _process(delta):
	if Input.is_action_pressed("inspect"):
		position = get_parent().get_local_mouse_position().normalized() * 200
	else:
		position = Vector2()
