extends StaticBody3D
@onready var wall: StaticBody3D = $"."
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	wall.rotate_z(deg_to_rad(rng.randi_range(0, 90)))
	pass
	
