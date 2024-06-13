class_name TrashCounter
extends BaseCounter


func interact(player: Player) -> void:
	if player.has_kitchen_object():
		player.get_kitchen_object().destory_self()
