extends CharacterBody3D

var speed = .000005
var movementSpeed = .2
var target_velocity = Vector3.ZERO
var spacetime = 0
@onready var death_sensor: RayCast3D = $DeathSensor
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var collision_shape_3d_2: CollisionShape3D = $CollisionShape3D2
@onready var level: Node3D = $"../LevelOne"
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

# Variables for mode switching and circular movement
var free_mode = true # True for free flight, False for circular movement
var circular_radius = .1
var circular_angle = 0.0
var angular_speed = 4.0 # Speed of angular movement along the circle

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_just_pressed("left_click"):
		free_mode = !free_mode # Toggle movement mode
		collision_shape_3d.disabled = !collision_shape_3d.disabled
		collision_shape_3d_2.disabled = !collision_shape_3d_2.disabled
		if collision_shape_3d.disabled == true:
			mesh_instance_3d.scale = Vector3(.01,.01,.01)
		else:
			mesh_instance_3d.scale = Vector3(.03,.03,.03)
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
			level.ability = true
			mesh_instance_3d.scale = Vector3(.05,.05,.05)
		
		if Input.is_action_just_released("space"):
			spacetime = 0
			level.ability = false
			mesh_instance_3d.scale = Vector3(.03,.03,.03)
		
		# Ground Velocity
		target_velocity.x = direction.x * movementSpeed
		target_velocity.y = direction.y * movementSpeed

		# Moving the Character
		velocity = target_velocity
		move_and_slide()
		position.z -= speed * delta
	else:
		# Circular movement logic
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"):
			circular_angle += angular_speed * delta
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_down"):
			circular_angle -= angular_speed * delta
		var x = circular_radius * cos(circular_angle)
		var y = circular_radius * sin(circular_angle)
		print(x," ", y)
		# Update position to follow the circle path
		position.x = x
		position.y = y
		position.z -= speed * delta


	if (death_sensor.is_colliding()):
		if(death_sensor.get_collider().name == "wall" and level.ability==true):
			death_sensor.get_collider().free()
		else:
			death()

func death():
	print(get_tree().reload_current_scene())
	Ui.deathCount+=1
