extends Node3D
@export var modules: Array[PackedScene] = []
var amnt = 5
var rng = RandomNumberGenerator.new()
var offset = 1.5

var initObs = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in amnt:
		spawnModule(n*offset)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnModule(n):
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
