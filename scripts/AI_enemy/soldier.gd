extends KinematicBody2D


var player = null
var speed = 50
var direction = 1 
var patrol_range = 250
var start_position
var is_paused = false
var damage = 2
var health = 4
var current_target = null
var targets_in_range = []
var aleady_attacked = false
var gravity = 20
var motion = Vector2(0,0)
var go = false
var mon = Vector2()
var attack = false
var knockback_power = Vector2()
onready var p = $"../Player"

func _ready():
	start_position = global_position

func _physics_process(delta):
	if !$KnockBack.is_stopped():
		if !is_on_floor():
			knockback_power.y += gravity*60*delta
			$s.play("default")
		aleady_attacked = false
		move_and_slide(knockback_power,Vector2.UP)
		return
	if go == false:
		if is_paused:
			return
		
		var velocity = Vector2(speed * direction, 0)
		move_and_slide(velocity)
		
		var distance = global_position.x - start_position.x
		if abs(distance) > patrol_range:
			if direction == 1:
				direction = -1
			else:
				direction = 1
#			$s.scale.x = direction
		if direction >= 0:
			$s.flip_h = false
		if direction < 0:
			$s.flip_h = true
	fir()
	attack()
	if player != null:
		if player.global_position.x < global_position.x:
			$s.flip_h = true
		else:
			$s.flip_h = false
	




func fir():
	if go == true:
		motion = position.direction_to(p.position) * speed
		motion = move_and_slide(motion)
	if not is_on_floor():
		mon.y += gravity
	mon = move_and_slide(mon, Vector2.UP)







func _on_area_body_entered(body):
	if body.is_in_group("player1_units"):
		attack = true
		$s.play("run")
		speed = 80
		go = true
		player = body



func _on_area_body_exited(body):
	if body.is_in_group("player1_units"):
		attack = false
		$s.play("walk")
		speed = 50
		go = false
		player = null












func attack():
	if current_target and is_instance_valid(current_target):
		if health > 0:
			$s.animation = "fir"
			$s.play()
			
		if $s.frame == 2 and not aleady_attacked:
			current_target.take_damage(damage)
			aleady_attacked = true
		if $s.frame != 2:
			aleady_attacked = false
		if current_target.health <= 0:
			targets_in_range.erase(current_target)
			current_target = null
	else:
		if targets_in_range.size() > 0:
			current_target = targets_in_range[0]
		else:
			if health > 0:
				if attack == true:
					$s.animation = "run"
					aleady_attacked = false
					$s.play()
				else:
					$s.animation = "walk"
					$s.play()



func _process(delta):
	$ProgressBar.value = lerp($ProgressBar.value,health,12*delta)
	
	
	if health <= 0:
		$ProgressBar.visible = false
		speed = 0
		gravity = 0
		go = false;is_paused = true
		$CollisionShape2D.disabled = true
		$AttackArea/CollisionSdhape2D.disabled = true
		$s.play("dead")
		if $s.frame == 6:
			queue_free()




func take_damage(amount):
	health -= amount
	if health > 0:
		var dir = 1 if $s.flip_h else -1
		knockback_power = Vector2(200*direction *dir,-300)
		$KnockBack.start()



func _on_AttackArea_body_entered(body):
	if is_instance_valid(body):
		var is_enemy = false
		
		if is_in_group("player1_units") and body.is_in_group("player2_units"):
			is_enemy = true
		elif is_in_group("player2_units") and body.is_in_group("player1_units"):
			is_enemy = true
		if is_enemy:
			targets_in_range.append(body)
			if current_target == null:
				current_target = body


func _on_AttackArea_body_exited(body):
	if body in targets_in_range:
		targets_in_range.erase(body)
	if body == current_target:
		current_target = null

