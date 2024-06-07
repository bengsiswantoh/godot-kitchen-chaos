class_name SelectedCounterVisual
extends MeshInstance3D


@export var _base_counter: BaseCounter


func _ready() -> void:
	Player.instance.selected_counter_changed.connect(_on_player_selected_counter_changed)


func _on_player_selected_counter_changed(selected_counter: BaseCounter) -> void:
	if selected_counter == _base_counter:
		visible = true
	else:
		visible = false
