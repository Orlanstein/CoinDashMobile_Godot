extends Area2D

signal pickup
signal hurt

@export var speed = 350
@export var velocity = Vector2.ZERO
var screensize = Vector2(480, 720)

func _process(delta):
	
	#Debug added by ChatGPT
	#print("Velocity:", velocity)
	
	position += velocity * speed * delta
	
	# Get input for 8-directional movement
	
	#Removed by ChatGPT
	#velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	"""  
	if($"../HUD"._on_b_down_pressed()):
		velocity.y = 1
	elif($"../HUD"._on_b_up_pressed()):
		velocity.y = -1 
	else:
		velocity.y = 0
	
	if($"../HUD"._on_b_right_pressed()):
		velocity.x = 1
	elif ($"../HUD"._on_b_left_pressed()):
		velocity.x = -1
	else:
		velocity.x = 0
	"""
	#velocity = change_velocity($"../HUD"._on_b_down_pressed(), $"../HUD"._on_b_up_pressed())
	#print(velocity)
	
	# Move the player's position
	position += velocity * speed * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	# Choose which animation to play
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	# Flip the sprite based on movement direction
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0


func start():
	set_process(true)
	position = screensize / 2
	$AnimatedSprite2D.animation = "idle"

func die():
	$AnimatedSprite2D.animation = "hurt"
	set_process(false)

func _on_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")
	if area.is_in_group("powerups"):
		area.pickup()
		pickup.emit("powerup")
	if area.is_in_group("obstacles"):
		hurt.emit()
		die()

func change_velocity(x, y) -> Vector2:
	var changeVel = Vector2.ZERO
	changeVel.x = x
	changeVel.y = y
	return changeVel

func _on_move_up():
	print("Player received _on_move_up signal")
	velocity.y = -1

func _on_move_down():
	print("Player received _on_move_down signal")
	velocity.y = 1

func _on_move_left():
	print("Player received _on_move_left signal")
	velocity.x = -1

func _on_move_right():
	print("Player received _on_move_right signal")
	velocity.x = 1

func _on_stop_vertical():
	print("Player received _on_stop_vertical signal")
	velocity.y = 0

func _on_stop_horizontal():
	print("Player received _on_stop_horizontal signal")
	velocity.x = 0
