extends Node3D

#spawning scenes
@export var modules: Array[PackedScene] = []
@export var obstacles: Array[PackedScene] = []

#vars
var amnt = 10
var rng = RandomNumberGenerator.new()
var offset = 1.5
var timepassed = 0
var obstacleCount = 0

#objects
@export var ability = false
@onready var timer = $Timer
@onready var delayTimer = $Timer2
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#other scenes
const LEVEL_2 = preload("res://scenes/Level2.tscn")

func _ready() -> void:
	delayTimer.start(3)
	for n in amnt:
		spawnModule(n)
	if Ui.deathCount < 3:
		audio_stream_player_3.playing = true
		animation_player.play("directions")

func _on_delay_Timer():
	if obstacleCount == 0:
		timer.start(.5)
	audio_stream_player_2.play()

#spawns obstacles at offset value until obstacle count hits 60
#once timepassed is over 2 minutes run level complete function
func _on_Timer_timeout():
	if obstacleCount < 60:
		spawnObstacle(offset)
		obstacleCount+=1
		print (obstacleCount)
	else:
		if timepassed > 120:
			print(timepassed)
			levelComplete()

func _process(delta: float) -> void:
	timepassed+=delta

func spawnModule(n):
	var instance = modules[0].instantiate()
	instance.position.z = n
	add_child(instance)	

func spawnObstacle(n):
	rng.randomize()
	var num = rng.randi_range(0,obstacles.size()-1)
	var instance = obstacles[num].instantiate()
	instance.position.z = (-timepassed * offset)
	add_child(instance)

func levelComplete():
	queue_free()
	var main = LEVEL_2.instantiate()
	get_tree().root.add_child(main)
	get_tree().current_scene = main
	print("done!")
	
