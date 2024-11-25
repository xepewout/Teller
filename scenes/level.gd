extends Node3D
@export var modules: Array[PackedScene] = []
@export var obstacles: Array[PackedScene] = []
var amnt = 10
var rng = RandomNumberGenerator.new()
var offset = 1
var timepassed = 0

var initObs = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in amnt:
		spawnModule(n*offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timepassed+=delta
	if timepassed > 10:
		spawnObstacle(timepassed - 5)
	if timepassed > 20:
		timepassed = 0
	
func spawnModule(n):
	print(n)
	if initObs > 5:
		rng.randomize()
		var num = rng.randi_range(0,modules.size()-1)
		var instance = modules[num].instantiate()
		instance.position.z = n
		add_child(instance)	
	else:
		var instance = modules[4].instantiate()
		instance.position.z = n
		add_child(instance)	
		initObs+= 1

func spawnObstacle(n):
	#var instance = obstacles[0].instantiate()
	#instance.position.z = n
	#add_child(instance)
	#print (n)
	pass
