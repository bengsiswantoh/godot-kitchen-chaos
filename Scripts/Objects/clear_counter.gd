class_name ClearCounter
extends StaticBody3D


@export var _kitchen_object_resource: KitchenObjectResource
@export var _counter_top_point: Marker3D

var _kitchen_object: KitchenObject


func interact() -> void:
	if not _kitchen_object:
		var kitchen_object = _kitchen_object_resource.create_scene() as KitchenObject
		kitchen_object.set_clear_counter(self)
		
		#add_child(_kitchen_object)
		#_kitchen_object.position = _counter_top_point.position
		#_kitchen_object.set_clear_counter(self)


func get_kitchen_object_follow_position() -> Vector3:
	return _counter_top_point.position

		
func set_kitchen_object(kitchen_object: KitchenObject) -> void:
	_kitchen_object = kitchen_object


func get_kitchen_object() -> KitchenObject:
	return _kitchen_object	


func clear_kitchen_object() -> void:
	_kitchen_object = null
	

func has_kitchen_object() -> bool:
	return _kitchen_object != null
