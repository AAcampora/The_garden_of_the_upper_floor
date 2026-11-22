extends Node

static var NUMBER_OF_ENTITIES = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scene: PackedScene = preload("res://entities/test_entity.tscn")
	for i in NUMBER_OF_ENTITIES:
		var instance := scene.instantiate()
		instance.position = Vector3(
			randf_range(-1, 1),
			randf_range(-1, 1),
			randf_range(-1, 1)
		)
		add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
