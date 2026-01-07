extends GravityBody2D

@export var propulsion_force: int = 100
@export var rotation_speed: int = 5
@export var projectile_resource: Resource

var can_warp = true
var warp_coldown = 1
var warp_timer = 0

var viewport_width:int = 0
var viewport_height:int = 0

func _ready()->void:
	viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if Input.is_action_pressed("turn_left"):
		rotate(-rotation_speed * delta)
	if Input.is_action_pressed("turn_right"):
		rotate(rotation_speed *delta)
	if Input.is_action_just_pressed("shoot"):
		shoot()
	check_warp_status(delta)
	check_warp()
	
	
func check_warp_status(delta:float):
	if !can_warp:
		warp_timer += delta
	if warp_timer >= warp_coldown :
		can_warp = true
		warp_timer = 0
		

func check_warp():
	if position.x > viewport_width:
		position.x = 0
	if position.y > viewport_height:
		position.y = 0
	if position.x < 0:
		position.x = viewport_width
	if position.y < 0:
		position.y = viewport_height
	can_warp = false
	

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
