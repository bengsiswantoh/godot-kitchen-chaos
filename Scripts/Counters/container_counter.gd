class_name ContainerCounter
extends BaseCounter


@export var _kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not player.has_kitchen_object():
		KitchenObject.spawn_kitchen_object(_kitchen_object_resource, player)
