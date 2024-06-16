class_name ClearCounter
extends BaseCounter


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			player.get_kitchen_object().set_kitchen_object_parent(self)
	else:
		if player.has_kitchen_object():
			var plate = player.get_kitchen_object().try_get_plate()
			if plate:
				if plate.try_add_ingredient(get_kitchen_object().kitchen_object_resource):
					get_kitchen_object().destory_self()
			else:
				plate = get_kitchen_object().try_get_plate()
				if plate.try_add_ingredient(player.get_kitchen_object().kitchen_object_resource):
					player.get_kitchen_object().destory_self()
		else:
			get_kitchen_object().set_kitchen_object_parent(player)
