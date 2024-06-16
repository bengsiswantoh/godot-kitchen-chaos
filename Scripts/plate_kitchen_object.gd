class_name PlateKitchenObject
extends KitchenObject


@export var valid_kitchen_object_resource_list: Array[KitchenObjectResource]


var _kitchen_object_resourse_list: Array[KitchenObjectResource]


func try_add_ingredient(new_kitchen_object_resource: KitchenObjectResource) -> bool:
	if not valid_kitchen_object_resource_list.has(new_kitchen_object_resource):
		return false
	
	if _kitchen_object_resourse_list.has(new_kitchen_object_resource):
		return false
	
	_kitchen_object_resourse_list.append(new_kitchen_object_resource)
	return true
