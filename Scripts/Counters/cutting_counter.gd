class_name CuttingCounter
extends BaseCounter


@export var cut_kitchen_object_resource: KitchenObjectResource


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			player.get_kitchen_object().set_kitchen_object_parent(self)
	else:
		if not player.has_kitchen_object():
			get_kitchen_object().set_kitchen_object_parent(player)


func interact_alternate(_player: Player) -> void:
	if has_kitchen_object():
		get_kitchen_object().destory_self()
		KitchenObject.spawn_kitchen_object(cut_kitchen_object_resource, self)
