class_name KitchenObjectResource
extends Resource


@export var scene: PackedScene
@export var texture: Texture2D
@export var object_name: String


func create_scene() -> Node:
	var kitchen_object = scene.instantiate()
	kitchen_object.kitchen_object_resource = self
	
	return kitchen_object
