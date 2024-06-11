class_name Player
extends CharacterBody3D

static var _instance: Player
static var instance: Player:
	get:
		return _instance


signal selected_counter_changed(selected_counter: BaseCounter)


@export var _speed: float = 5.0
@export var _visual: Node3D
@export var _game_input: GameInput
@export var _kitchen_object_hold_point: Marker3D


var _kitchen_object: KitchenObject
var _direction: Vector3
var _facing_angle: float
var _selected_counter: BaseCounter


@onready var _ray_cast_3d: RayCast3D = $Visual/RayCast3D


func _enter_tree() -> void:
	if _instance:
		printerr('There is more than one Player instance')
	
	_instance = self


func _ready() -> void:	
	_game_input.interact_pressed.connect(_on_interact_pressed)
	_game_input.interact_alternate_pressed.connect(_on_interact_alternate_pressed)


func _physics_process(_delta: float) -> void:
	_handle_movement()
	_handle_interactions()


func is_walking() -> bool:
	return _direction != Vector3.ZERO


func _handle_interactions() -> void:
	if _ray_cast_3d.is_colliding():
		var base_counter = _ray_cast_3d.get_collider()
		if base_counter is BaseCounter:
			if base_counter != _selected_counter:
				_set_selected_counter(base_counter)
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
		_selected_counter.interact(self)
		

func _on_interact_alternate_pressed() -> void:
	if _selected_counter:
		_selected_counter.interact_alternate(self)
		
		
func _set_selected_counter(selected_counter: BaseCounter) -> void:
	_selected_counter = selected_counter
	selected_counter_changed.emit(_selected_counter)
	
	
func get_kitchen_object_follow_position() -> Marker3D:
	return _kitchen_object_hold_point

		
func set_kitchen_object(kitchen_object: KitchenObject) -> void:
	_kitchen_object = kitchen_object


func get_kitchen_object() -> KitchenObject:
	return _kitchen_object	


func clear_kitchen_object() -> void:
	_kitchen_object = null
	

func has_kitchen_object() -> bool:
	return _kitchen_object != null
