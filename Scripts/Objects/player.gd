class_name Player
extends CharacterBody3D


@export var _speed: float = 5.0
@export var _visual: Character


var _direction: Vector3
var _facing_angle: float


func _input(_event: InputEvent) -> void:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func _physics_process(_delta: float) -> void:
	if _direction:
		velocity.x = _direction.x * _speed
		velocity.z = _direction.z * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.z = move_toward(velocity.z, 0, _speed)

	move_and_slide()
	_rotate_visual()


func is_walking() -> bool:
	return _direction != Vector3.ZERO


func _rotate_visual() -> void:
	var is_moving: bool = _direction.x != 0 or _direction.z != 0
		
	if is_moving:
		_facing_angle = Vector2(_direction.z, _direction.x).angle()
		_visual.rotation.y = lerp_angle(_visual.rotation.y, _facing_angle, 0.5)
