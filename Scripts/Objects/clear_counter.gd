class_name ClearCounter
extends StaticBody3D


@export var _kitchen_object_resource: KitchenObjectResource
@export var _counter_top_point: Marker3D


var _kitchen_object: KitchenObject


func interact(player: Player) -> void:
	if not _kitchen_object:
		var kitchen_object = _kitchen_object_resource.create_scene() as KitchenObject
		kitchen_object.set_kitchen_object_parent(self)
	else:
		_kitchen_object.set_kitchen_object_parent(player)


func get_kitchen_object_follow_position() -> Marker3D:
	return _counter_top_point

		
func set_kitchen_object(kitchen_object: KitchenObject) -> void:
	_kitchen_object = kitchen_object


func get_kitchen_object() -> KitchenObject:
	return _kitchen_object	


func clear_kitchen_object() -> void:
	_kitchen_object = null
	

func has_kitchen_object() -> bool:
	return _kitchen_object != null
