class_name PlateCounter
extends BaseCounter


signal plate_spawned
signal plate_removed


@export var plate_resource: KitchenObjectResource


var _spawn_plate_timer: float
var _spawn_plate_timer_max: float = 4
var _spawn_amount: int
var _spawn_amount_max: int = 4

func _process(delta: float) -> void:
	_spawn_plate_timer += delta
	if _spawn_plate_timer > _spawn_plate_timer_max:
		_spawn_plate_timer = 0
		
		if _spawn_amount < _spawn_amount_max:
			_spawn_amount += 1
			plate_spawned.emit()


func interact(player: Player) -> void:
	if not player.has_kitchen_object():
		if _spawn_amount > 0:
			_spawn_amount -= 1
			
			KitchenObject.spawn_kitchen_object(plate_resource, player)
			
			plate_removed.emit()
