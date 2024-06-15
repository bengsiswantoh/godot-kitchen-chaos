extends Node


@export var counter_top_point: Marker3D
@export var plate_scene: PackedScene
@export var plate_counter: PlateCounter


var plate_list: Array[Node3D] = []


func _ready() -> void:
	plate_counter.plate_spawned.connect(_on_plate_spawned)
	plate_counter.plate_removed.connect(_on_plate_removed)


func _on_plate_spawned() -> void:
	var plate = plate_scene.instantiate() as Node3D
	counter_top_point.add_child(plate)
	
	var offset_y : float = 0.1
	plate.position = Vector3(0, offset_y * plate_list.size(), 0)
	plate_list.append(plate)


func _on_plate_removed() -> void:
	var plate = plate_list.pop_back() as Node3D
	plate.queue_free()
	
