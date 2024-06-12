class_name CuttingCounter
extends BaseCounter


signal progress_changed(current_progress: float)
signal cut_executed


@export var cutting_recipe_list: Array[CuttingRecipeResource]


var _cutting_progress: int


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			if _has_recipe_with_input(player.get_kitchen_object().kitchen_object_resource):
				player.get_kitchen_object().set_kitchen_object_parent(self)
				_cutting_progress = 0
				
				var cutting_recipe = _get_cutting_recipe_with_input(get_kitchen_object().kitchen_object_resource)
				
				progress_changed.emit(_cutting_progress as float / cutting_recipe.cutting_progress_max)
	else:
		if not player.has_kitchen_object():
			get_kitchen_object().set_kitchen_object_parent(player)


func interact_alternate(_player: Player) -> void:
	if has_kitchen_object() and _has_recipe_with_input(get_kitchen_object().kitchen_object_resource):
		_cutting_progress += 1
		
		cut_executed.emit()
		
		var cutting_recipe = _get_cutting_recipe_with_input(get_kitchen_object().kitchen_object_resource)
		
		progress_changed.emit(_cutting_progress as float / cutting_recipe.cutting_progress_max)
		
		if _cutting_progress >= cutting_recipe.cutting_progress_max:
			var output = _get_output_for_input(get_kitchen_object().kitchen_object_resource)
			get_kitchen_object().destory_self()
			KitchenObject.spawn_kitchen_object(output, self)


func _has_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> bool:
	var cutting_recipe = _get_cutting_recipe_with_input(kitchen_object_resource)
	return cutting_recipe != null


func _get_output_for_input(kitchen_object_resource: KitchenObjectResource) -> KitchenObjectResource:
	var cutting_recipe = _get_cutting_recipe_with_input(kitchen_object_resource)
	if cutting_recipe:
		return cutting_recipe.output

	return null


func _get_cutting_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> CuttingRecipeResource:
	for cutting_recipe in cutting_recipe_list:
		if cutting_recipe.input == kitchen_object_resource:
			return cutting_recipe

	return null
