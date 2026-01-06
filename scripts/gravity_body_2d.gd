extends RigidBody2D
class_name GravityBody2D


@export var gravity_center: Node
@export var gravity_force: float = 100


func _ready()->void:
	gravity_scale = 0

func _physics_process(delta: float) -> void:
	var force_direction = get_gravity_force()
	apply_central_force(force_direction * gravity_force * delta )
	
func get_vector_between_points(v1:Vector2,v2:Vector2):
	return Vector2(v2.x-v1.x,v2.y-v1.y)

func get_gravity_force()->Vector2:
	var force_direction: Vector2 = get_vector_between_points(global_position,gravity_center.global_position)
	return force_direction
	
