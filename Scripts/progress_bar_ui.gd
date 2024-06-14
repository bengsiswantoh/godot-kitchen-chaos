extends Node3D


@export var has_progress_changed: Node


@onready var progress_bar: ProgressBar = $SubViewport/ProgressBar


func _ready() -> void:
	progress_bar.value = 0
	hide()
	
	if has_progress_changed.has_signal("progress_changed"):
		has_progress_changed.progress_changed.connect(_on_object_progress_changed)
	
	
func _on_object_progress_changed(progress: float) -> void:
	progress_bar.value = progress
	
	show()
	if progress_bar.value == 0 or progress_bar.value == 1:
		hide()
