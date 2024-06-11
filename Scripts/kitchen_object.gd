class_name KitchenObject
extends Node3D


var kitchen_object_resource: KitchenObjectResource


var _kitchen_object_parent: Node3D


static func spawn_kitchen_object(kitchen_object_resource: KitchenObjectResource, kitchen_object_parent: Node3D) -> void:
	var new_kitchen_object = kitchen_object_resource.create_scene() as KitchenObject
	new_kitchen_object.set_kitchen_object_parent(kitchen_object_parent)


func set_kitchen_object_parent(parent: Node3D) -> void:
	if (_kitchen_object_parent):
		_kitchen_object_parent.clear_kitchen_object()
	
	if not parent.has_method("has_kitchen_object"):
		return
	
	_kitchen_object_parent = parent
	
	if parent.has_kitchen_object():
		printerr("Counter already has a KitchenObject!")
	
	parent.set_kitchen_object(self)
	
	
	if get_parent() != null:
		reparent(parent.get_kitchen_object_follow_position())
	else:
		parent.get_kitchen_object_follow_position().add_child(self)
		
	position = Vector3.ZERO
	
	
func get_kitchen_object_parent() -> Node3D:
	return _kitchen_object_parent


func destory_self() -> void:
	_kitchen_object_parent.clear_kitchen_object()
	queue_free()
