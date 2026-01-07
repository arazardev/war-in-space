extends Area2D
class_name Warp

@export var dest_warp: Warp

#func _ready() -> void:
	#var collision_shape = CollisionShape2D.new()
	#collision_shape.shape = shape
	#add_child(collision_shape)



#func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	#print("Warp")
	#pass # Replace with function body.


func warp_to_dest(obj:CollisionObject2D):
	obj.position = Vector2(obj.position.x,dest_warp.get_child(0).position.y)
	print("teleported. Position ",obj.position)


func _on_area_entered(area: Area2D) -> void:
	warp_to_dest(area)


func _on_body_entered(body: Node2D) -> void:
	warp_to_dest(body)
