extends Node


const CUT = "Cut"


var _cutting_counter: CuttingCounter


func _ready() -> void:
	_cutting_counter = owner
	_cutting_counter.cut_executed.connect(_on_cut_executed)


func _on_cut_executed() -> void:
	pass
