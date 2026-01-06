extends Area2D


@export var shoot_force: int = 300

func _process(delta: float) -> void:
	move_local_y(-delta * shoot_force)
	
