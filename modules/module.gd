extends Node3D
@onready var level = $"../"
var speed = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z += speed*delta
	if position.z > 2:
		level.spawnModule(position.z+(level.amnt*level.offset) * -1)
		queue_free()
