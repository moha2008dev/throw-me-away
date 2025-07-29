extends KinematicBody2D


var speed = 50
var direction = 1 
var patrol_range = 220
var start_position
var is_paused = false
var damage = 2
var health = 4
var current_target = null
var targets_in_range = []
var aleady_attacked = false
var gravity = 15
var motion = Vector2(0,0)
var go = false
var mon = Vector2()

onready var p = $"../Player"

func _ready():
	start_position = global_position
	$s.play("walk")

func _physics_process(delta):
	if go == false:
		if is_paused:
			return
		
		var velocity = Vector2(speed * direction, 0)
		move_and_slide(velocity)
		
		var distance = global_position.x - start_position.x
		if abs(distance) > patrol_range:
			direction *= -1
			$s.scale.x = direction
	fir()
	attack()





func fir():
	if go == true:
		motion = position.direction_to(p.position) * speed
		motion = move_and_slide(motion)
	if not is_on_floor():
		mon.y += gravity
	mon = move_and_slide(mon, Vector2.UP)







func _on_area_body_entered(body):
	if body.is_in_group("player1_units"):
		$s.play("run")
		speed = 80
		$s.flip_h = true
		go = true


func _on_area_body_exited(body):
	if body.is_in_group("player1_units"):
		$s.play("walk")
		speed = 50
		$s.flip_h = false
		go = false










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
#	else:
#
#		if targets_in_range.size() > 0:
#			current_target = targets_in_range[0]
#		else:
#			if health > 0:
#				$s.animation = "default"
#				$s.play()
#			var direction = Vector2.RIGHT
#			if is_in_group("player2_units"):
#				direction = Vector2.LEFT
#			move_and_slide(direction * speed)
#
	$ProgressBar.value = health
	
	
	if health <= 0:
		$ProgressBar.visible = false
		speed = 0
		$CollisionShape2D.disabled = true
		$AttackArea/CollisionShape2D.disabled = true
		$s.play("dead")
		if $s.frame == 7:
			queue_free()




func take_damage(amount):
	health -= amount



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




