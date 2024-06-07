class_name Player
extends CharacterBody3D

static var _instance: Player
static var instance: Player:
	get:
		return _instance


signal selected_counter_changed(selected_counter: ClearCounter)


@export var _speed: float = 5.0
@export var _visual: Node3D
@export var _game_input: GameInput


var _direction: Vector3
var _facing_angle: float
var _selected_counter: ClearCounter


@onready var _ray_cast_3d: RayCast3D = $Visual/RayCast3D


func _enter_tree() -> void:
	if _instance:
		printerr('There is more than one Player instance')
	
	_instance = self


func _ready() -> void:	
	_game_input.interact_pressed.connect(_on_interact_pressed)


func _physics_process(_delta: float) -> void:
	_handle_movement()
	_handle_interactions()


func is_walking() -> bool:
	return _direction != Vector3.ZERO


func _handle_interactions() -> void:
	if _ray_cast_3d.is_colliding():
		var clear_counter = _ray_cast_3d.get_collider()
		if clear_counter is ClearCounter:
			if clear_counter != _selected_counter:
				_set_selected_counter(clear_counter)
		else:
			_set_selected_counter(null)
	else:
		_set_selected_counter(null)
		
func _handle_movement() -> void:
	_direction = _game_input.get_movement_direction()
	if _direction:
		velocity.x = _direction.x * _speed
		velocity.z = _direction.z * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.z = move_toward(velocity.z, 0, _speed)

	move_and_slide()
	_rotate_visual()


func _rotate_visual() -> void:
	var is_moving: bool = _direction.x != 0 or _direction.z != 0
		
	if is_moving:
		_facing_angle = Vector2(_direction.z, _direction.x).angle()
		_visual.rotation.y = lerp_angle(_visual.rotation.y, _facing_angle, 0.5)


func _on_interact_pressed() -> void:
	if _selected_counter:
		_selected_counter.interact()
		
func _set_selected_counter(selected_counter: ClearCounter) -> void:
	_selected_counter = selected_counter
	selected_counter_changed.emit(_selected_counter)
	
