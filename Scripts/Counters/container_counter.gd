class_name ContainerCounter
extends BaseCounter


@export var _kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not player.has_kitchen_object():
		var new_kitchen_object = _kitchen_object_resource.create_scene() as KitchenObject
		new_kitchen_object.set_kitchen_object_parent(player)
