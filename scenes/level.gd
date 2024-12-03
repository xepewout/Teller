extends Node3D
@export var modules: Array[PackedScene] = []
@export var obstacles: Array[PackedScene] = []
var amnt = 10
var rng = RandomNumberGenerator.new()
var offset = 1
var timepassed = 0
@export var ability = false
@onready var timer = $Timer
@onready var delayTimer = $Timer2
var obstacleCount = 0
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
const LEVEL_2 = preload("res://scenes/Level2.tscn")
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"


func _ready() -> void:
	delayTimer.start(5)
	for n in amnt:
		spawnModule(n*offset)
	if Ui.deathCount < 3:
		audio_stream_player_3.playing = true
		animation_player.play("directions")
		
	else:
		timer.start(.5)

func _on_delay_Timer():
	if obstacleCount == 0:
		timer.start(.5)
	audio_stream_player_2.play()

func _on_Timer_timeout():
	if obstacleCount < 60:
		spawnObstacle(offset)
		obstacleCount+=1
		print (obstacleCount)
	else:
		if timepassed > 120:
			print(timepassed)
			levelComplete()


var initObs = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	instance.position.z = (timepassed * -1)
	add_child(instance)

func levelComplete():
	queue_free()
	var main = LEVEL_2.instantiate()
	get_tree().root.add_child(main)
	get_tree().current_scene = main
	print("done!")
	
