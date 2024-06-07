class_name KitchenObject
extends Node3D


var kitchen_object_resource: KitchenObjectResource


var _clear_counter: ClearCounter


func set_clear_counter(clear_counter: ClearCounter) -> void:
	if (_clear_counter):
		_clear_counter.clear_kitchen_object()
		
	_clear_counter = clear_counter
	
	if clear_counter.has_kitchen_object():
		printerr("Counter already has a KitchenObject!")
	
	clear_counter.set_kitchen_object(self)
	
	clear_counter.add_child(self)
	position = clear_counter.get_kitchen_object_follow_position()
	
	
func get_clear_counter() -> ClearCounter:
	return _clear_counter
