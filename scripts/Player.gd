extends KinematicBody2D

var velocity : Vector2 = Vector2()
var speed : int = 300
var slide_speed : int = 600
var sliding : bool = false
var jump : int = -360
var gravity : int = 1200
var double_jump : bool = false

func _physics_process(delta) -> void:
	if !sliding:
		move()
		jumping(delta)
		slide()
		#attack()
	velocity = move_and_slide(velocity,Vector2.UP)

func move() -> void:
	var x : int = int(Input.get_axis("left","right"))
	velocity.x = lerp(velocity.x,x*speed,0.2)
	if x:
		$Node2D.scale.y = x
		$CPUParticles2D.direction.x = -x

func jumping(del) -> void:
	if !is_on_floor():
		velocity.y += gravity*del
		if Input.is_action_just_pressed("up"):
			if !$CoyteTimer.is_stopped():
				velocity.y = jump
			elif double_jump:
				velocity.y = jump
				double_jump = false
			else:
				$BufferTimer.start()
	else:
		$CoyteTimer.start()
		double_jump = true
		velocity.y = 1
		if Input.is_action_just_pressed("up") or !$BufferTimer.is_stopped():
			velocity.y = jump
			$CoyteTimer.stop()

func slide() -> void:
	if abs(velocity.x) > 280 && Input.is_action_just_pressed("slide") && is_on_floor() && !$CPUParticles2D.emitting:
		velocity.x = sign(velocity.x) * slide_speed
		$CPUParticles2D.emitting = true
		sliding = true
		$SlideTimer.start()

func _on_SlideTimer_timeout() -> void:
	sliding = false

func attack() -> void:
	if $Node2D/AnimationPlayer.is_playing():
		return
	if Input.is_action_just_pressed("light_attack"):
		$Node2D/AnimationPlayer.play("light_attack")
	if Input.is_action_just_pressed("heavy_attack"):
		$Node2D/AnimationPlayer.play("heavy_attack")
