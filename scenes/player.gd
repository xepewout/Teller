extends CharacterBody3D

var speed = .000005
var movementSpeed = .2
var target_velocity = Vector3.ZERO
@export var fall_acceleration = 75
@onready var death_sensor: RayCast3D = $DeathSensor

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
		print("right")
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y += 1
	if Input.is_action_pressed("move_down"):
		direction.y -= 1

	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#$Pivot.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * movementSpeed
	target_velocity.y = direction.y * movementSpeed

	# Vertical Velocity
	#if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		#target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	position.z -= speed*delta

	if death_sensor.is_colliding():
		death()
	

func death():
	get_tree().reload_current_scene()
