extends KinematicBody2D

var velocity : Vector2 = Vector2()
var speed : int = 300
var slide_speed : int = 600
var sliding : bool = false
var jump : int = -360
var gravity : int = 1200
var double_jump : bool = false
var health : float = 10
var current_dmg : int = 1
var light_dmg : int = 1
var heavy_dmg : int = 3

func _ready() -> void:
	for ray in $WallRayCasts.get_children():
		ray.add_exception(self) 

func _physics_process(delta) -> void:
	if !sliding:
		move()
		jumping(delta)
		slide()
		attack()
	velocity = move_and_slide(velocity,Vector2.UP)

func move() -> void:
	if !$WallTimer.is_stopped():
		return
	var x : int = int(Input.get_axis("left","right"))
	velocity.x = lerp(velocity.x,x*speed,0.2)
	if x:
		$Node2D.scale.y = x
		$AttackArea.position.x = 45*x
		$CPUParticles2D.direction.x = -x

func jumping(del) -> void:
	if !is_on_floor():
		if !Rwall() && !Lwall():
			velocity.y += gravity*del
		else:
			velocity.y = 60 if velocity.y > 0 else velocity.y + gravity*del
		if Input.is_action_just_pressed("up"):
			if !$CoyteTimer.is_stopped():
				velocity.y = jump
			elif Rwall() or Lwall():
				velocity.y = jump
				velocity.x = speed if Lwall() else -speed
				$WallTimer.start()
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
		current_dmg = light_dmg
	if Input.is_action_just_pressed("heavy_attack"):
		$Node2D/AnimationPlayer.play("heavy_attack")
		current_dmg = heavy_dmg

func take_damage(amount) -> void:
	health -= amount

func _process(delta) -> void:
	if health <= 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main_menu.tscn")
	$ProgressBar.value = lerp($ProgressBar.value,health,12*delta)

func _on_Area2D_body_entered(body) -> void:
	if body.is_in_group("player2_units"):
		body.take_damage(current_dmg)
#		Engine.time_scale = 0.05
#		yield(get_tree().create_timer(0.01),"timeout")
#		Engine.time_scale = 1

func Rwall() -> bool:
	for ray in $WallRayCasts.get_children():
		if is_on_wall() && !is_on_floor() && ray.is_colliding() && ray.name.begins_with("R"):
			return true
	return false

func Lwall() -> bool:
	for ray in $WallRayCasts.get_children():
		if is_on_wall() && !is_on_floor() && ray.is_colliding() && ray.name.begins_with("L"):
			return true
	return false


