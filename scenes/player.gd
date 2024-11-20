extends CharacterBody3D

var speed = .000005
var movementSpeed = .2
var target_velocity = Vector3.ZERO
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

	# Ground Velocity
	target_velocity.x = direction.x * movementSpeed
	target_velocity.y = direction.y * movementSpeed

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	position.z -= speed*delta

	if death_sensor.is_colliding():
		death()
	

func death():
	get_tree().reload_current_scene()
