class_name BaseCounter
extends StaticBody3D


@export var counter_top_point: Marker3D


var _kitchen_object: KitchenObject


func interact(_player: Player) -> void:
	pass
	
	
func interact_alternate(_player: Player) -> void:
	pass


func get_kitchen_object_follow_position() -> Marker3D:
	return counter_top_point

		
func set_kitchen_object(kitchen_object: KitchenObject) -> void:
	_kitchen_object = kitchen_object


func get_kitchen_object() -> KitchenObject:
	return _kitchen_object	


func clear_kitchen_object() -> void:
	_kitchen_object = null
	

func has_kitchen_object() -> bool:
	return _kitchen_object != null
