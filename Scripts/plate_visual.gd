extends Node3D


@export var plate_visual_object_list: Array[PlateVisualObject]


var _plate = PlateKitchenObject


func _ready() -> void:
	for plate_visual_object in plate_visual_object_list:
		plate_visual_object.visible = false
	
	_plate = owner as PlateKitchenObject
	_plate.ingredient_added.connect(_on_ingredient_added)
	
	
func _on_ingredient_added(ingredient: KitchenObjectResource) -> void:
	for plate_visual_object in plate_visual_object_list:
		if plate_visual_object.kitchen_object_resource == ingredient:
			plate_visual_object.visible = true
			break
