extends GravityBody2D

@export var propulsion_force: int = 100
@export var rotation_speed: int = 5
@export var projectile_resource: Resource

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if Input.is_action_pressed("turn_left"):
		rotate(-rotation_speed * delta)
	if Input.is_action_pressed("turn_right"):
		rotate(rotation_speed *delta)
	if Input.is_action_just_pressed("shoot"):
		shoot()

func get_gravity_force()->Vector2:
	var spaceship_front = Vector2.UP.rotated(rotation)* propulsion_force
	var force_direction = super.get_gravity_force()
	if Input.is_action_pressed("propulsion"):
		force_direction = force_direction + spaceship_front
		$AnimatedSprite2D.play("propulsion")
	if Input.is_action_just_released("propulsion"):
		$AnimatedSprite2D.play("default")
	return force_direction

func shoot():
	var proyectile_instance = projectile_resource.instantiate()
	proyectile_instance.position = global_position
	proyectile_instance.rotate(global_rotation)
	get_parent().add_child(proyectile_instance)
