class_name ClearCounter
extends StaticBody3D


@export var _kitchen_object_resource: KitchenObjectResource
@export var _counter_top_point: Marker3D


func interact() -> void:
	var kitchen_object = _kitchen_object_resource.scene.instantiate()
	add_child(kitchen_object)
	kitchen_object.position = _counter_top_point.position
