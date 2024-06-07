class_name ClearCounter
extends BaseCounter


@export var _kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			player.get_kitchen_object().set_kitchen_object_parent(self)
	else:
		if not player.has_kitchen_object():
			get_kitchen_object().set_kitchen_object_parent(player)
