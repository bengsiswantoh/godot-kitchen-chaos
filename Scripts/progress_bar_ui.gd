extends ProgressBar


var _cutting_counter: CuttingCounter


@onready var background: Polygon2D = $"../Background"


func _ready() -> void:
	value = 0
	hide()
	background.hide()
	
	_cutting_counter = owner
	
	_cutting_counter.progress_changed.connect(_on_progress_changed)
	
	
func _on_progress_changed(progress: float) -> void:
	value = progress
	
	show()
	background.show()
	if value == 0 or value == 1:
		hide()
		background.hide()
