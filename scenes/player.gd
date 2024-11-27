extends CharacterBody3D

var speed = .000005
var movementSpeed = .2
var target_velocity = Vector3.ZERO
var spacetime = 0
@onready var death_sensor: RayCast3D = $DeathSensor
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
var invisible = false

# Variables for mode switching and circular movement
var free_mode = true # True for free flight, False for circular movement
var circular_radius = .1
var circular_angle = 0.0
var angular_speed = 4.0 # Speed of angular movement along the circle

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_just_pressed("left_click"):
		free_mode = !free_mode # Toggle movement mode

	if free_mode:
		# Free flying movement
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_up"):
			direction.y += 1
		if Input.is_action_pressed("move_down"):
			direction.y -= 1
		if Input.is_action_pressed("space"):
			spacetime += delta
			print(spacetime)
			if spacetime > 3:
				death()
			collision_shape_3d.disabled = true
			invisible = true
			animated_sprite_3d.visible = false
			
		
		if Input.is_action_just_released("space"):
			spacetime = 0
			collision_shape_3d.disabled = false
			invisible = false 
			animated_sprite_3d.visible = true
		
		# Ground Velocity
		target_velocity.x = direction.x * movementSpeed
		target_velocity.y = direction.y * movementSpeed

		# Moving the Character
		velocity = target_velocity
		move_and_slide()
		position.z -= speed * delta
	else:
		# Circular movement logic
		if Input.is_action_pressed("move_right"):
			circular_angle += angular_speed * delta
		if Input.is_action_pressed("move_left"):
			circular_angle -= angular_speed * delta
		var x = circular_radius * cos(circular_angle)
		var y = circular_radius * sin(circular_angle)
		print(x," ", y)
		# Update position to follow the circle path
		position.x = x
		position.y = y
		position.z -= speed * delta


	if (death_sensor.is_colliding() and not invisible):
		death()

func death():
	get_tree().reload_current_scene()
