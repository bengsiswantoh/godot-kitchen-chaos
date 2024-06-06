class_name SelectedCounterVisual
extends MeshInstance3D


@export var _clear_counter: ClearCounter


func _ready() -> void:
	Player.instance.selected_counter_changed.connect(_on_player_selected_counter_changed)


func _on_player_selected_counter_changed(selected_counter: ClearCounter) -> void:
	if selected_counter == _clear_counter:
		visible = true
	else:
		visible = false
