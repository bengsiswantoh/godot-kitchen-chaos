class_name GameInput
extends Node3D


signal interact_pressed


var _direction: Vector3


func _input(_event: InputEvent) -> void:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("interact"):
		interact_pressed.emit()
	
	
func get_movement_direction() -> Vector3:
	return _direction
