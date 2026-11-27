extends Node3D

@onready var raycast: RayCast3D = $RayCast3D

var carried_object: RigidBody3D = null

func _physics_process(_delta: float) -> void:
	# Pick up
	if carried_object == null and Input.is_action_just_pressed("interact"):
		if raycast.is_colliding():
			var obj = raycast.get_collider()
			if obj is RigidBody3D and obj.is_in_group("pickable"):
				carried_object = obj
				carried_object.freeze = true
				carried_object.collision_layer = 2

	# Drop
	elif carried_object != null and Input.is_action_just_released("interact"):
		_drop()

	# Follow the hold point
	if is_instance_valid(carried_object):
		carried_object.global_transform = global_transform
	elif carried_object != null:
		carried_object = null  # item was freed (e.g. binned) while held

func _drop() -> void:
	if is_instance_valid(carried_object):
		carried_object.collision_layer = 1
		carried_object.freeze = false
	carried_object = null
