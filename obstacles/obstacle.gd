extends Node3D
@onready var level = $"../"
var speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z += speed*delta
	if position.z > 2:
		level.spawnObstacle(3 + (level.amnt*(level.offset)) * -1)
		free()

func free():
	queue_free()
