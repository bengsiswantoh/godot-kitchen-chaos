class_name CuttingCounter
extends BaseCounter


@export var cutting_recipe_list: Array[CuttingRecipeResource]


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			if _has_recipe_with_input(player.get_kitchen_object().kitchen_object_resource):
				player.get_kitchen_object().set_kitchen_object_parent(self)
	else:
		if not player.has_kitchen_object():
			get_kitchen_object().set_kitchen_object_parent(player)


func interact_alternate(_player: Player) -> void:
	if has_kitchen_object() and _has_recipe_with_input(get_kitchen_object().kitchen_object_resource):
		var output = _get_output_for_input(get_kitchen_object().kitchen_object_resource)
		get_kitchen_object().destory_self()
		KitchenObject.spawn_kitchen_object(output, self)


func _has_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> bool:
	for cutting_recipe in cutting_recipe_list:
		if cutting_recipe.input == kitchen_object_resource:
			return true
			
	return false


func _get_output_for_input(kitchen_object_resource: KitchenObjectResource) -> KitchenObjectResource:
	for cutting_recipe in cutting_recipe_list:
		if cutting_recipe.input == kitchen_object_resource:
			return cutting_recipe.output

	return null
