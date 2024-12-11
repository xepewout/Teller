extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const MAIN = preload("res://scenes/main.tscn")

func _ready() -> void:
	animation_player.play("start")
	
func _process(delta: float) -> void:
	if !(animation_player.is_playing()):
		queue_free()
		var main = MAIN.instantiate()
		get_tree().root.add_child(main)
		get_tree().current_scene = main
