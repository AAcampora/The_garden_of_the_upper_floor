extends CharacterBody3D

@export var speed := 5.0
@onready var visual: Node3D = $mesh

func get_input() -> void:
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.y * speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	look_at_mouse(delta)


func look_at_mouse(delta: float) -> void:
	var camera := get_viewport().get_camera_3d()
	var mousePos := get_viewport().get_mouse_position()
	
	var rayOrig := camera.project_ray_origin(mousePos)
	var rayDir := camera.project_ray_normal(mousePos)
	
	
# Horizontal plane at the character's height
	var plane := Plane(Vector3.UP, global_position.y)
	var hit = plane.intersects_ray(rayOrig, rayDir)
	if hit == null:
		return
		
	var target: Vector3 = hit
	if target.distance_squared_to(global_position) < 0.01:
		return

	visual.look_at(target, Vector3.UP)
	
