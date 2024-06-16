class_name StoveCounter
extends BaseCounter


signal state_changed(state: STATE)
signal progress_changed(current_progress: float)


enum STATE {
	IDLE,
	FRYING,
	FRIED,
	BURNED
}


@export var frying_recipe_list: Array[FryingRecipeResource]
@export var burning_recipe_list: Array[BurningRecipeResource]

var _state: STATE
var _frying_timer: float
var _frying_recipe_resource: FryingRecipeResource
var _burning_timer: float
var _burning_recipe_resource: BurningRecipeResource


func _ready() -> void:
	_state = STATE.IDLE


func _process(delta: float) -> void:
	match _state:
		STATE.IDLE:
			pass
		STATE.FRYING:
			_frying_timer += delta
			
			progress_changed.emit(_frying_timer as float / _frying_recipe_resource.frying_timer_max)
			
			if _frying_timer > _frying_recipe_resource.frying_timer_max:
				get_kitchen_object().destory_self()
				
				KitchenObject.spawn_kitchen_object(_frying_recipe_resource.output, self)
								
				_state = STATE.FRIED
				_burning_timer = 0
				_burning_recipe_resource = _get_burning_recipe_with_input(get_kitchen_object().kitchen_object_resource)
				
				state_changed.emit(_state)
		STATE.FRIED:
			_burning_timer += delta
			
			progress_changed.emit(_burning_timer as float / _burning_recipe_resource.burning_timer_max)
			
			if _burning_timer > _burning_recipe_resource.burning_timer_max:
				get_kitchen_object().destory_self()
				
				KitchenObject.spawn_kitchen_object(_burning_recipe_resource.output, self)
				
				_state = STATE.BURNED
				
				state_changed.emit(_state)
				progress_changed.emit(0)
		STATE.BURNED:
			pass


func interact(player: Player) -> void:
	if not has_kitchen_object():
		if player.has_kitchen_object():
			if _has_recipe_with_input(player.get_kitchen_object().kitchen_object_resource):
				player.get_kitchen_object().set_kitchen_object_parent(self)
				
				_frying_recipe_resource = _get_frying_recipe_with_input(get_kitchen_object().kitchen_object_resource)
				
				_state = STATE.FRYING
				_frying_timer = 0
				
				state_changed.emit(_state)
				progress_changed.emit(_frying_timer as float / _frying_recipe_resource.frying_timer_max)
	else:
		if player.has_kitchen_object():
			var plate = player.get_kitchen_object().try_get_plate()
			if plate:
				if plate.try_add_ingredient(get_kitchen_object().kitchen_object_resource):
					get_kitchen_object().destory_self()
					
					_state = STATE.IDLE
					state_changed.emit(_state)
					progress_changed.emit(0)
		else:
			get_kitchen_object().set_kitchen_object_parent(player)
			
			_state = STATE.IDLE
			state_changed.emit(_state)
			progress_changed.emit(0)


func _has_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> bool:
	var frying_recipe = _get_frying_recipe_with_input(kitchen_object_resource)
	return frying_recipe != null


func _get_output_for_input(kitchen_object_resource: KitchenObjectResource) -> KitchenObjectResource:
	var frying_recipe = _get_frying_recipe_with_input(kitchen_object_resource)
	if frying_recipe:
		return frying_recipe.output

	return null


func _get_frying_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> FryingRecipeResource:
	for frying_recipe in frying_recipe_list:
		if frying_recipe.input == kitchen_object_resource:
			return frying_recipe

	return null


func _get_burning_recipe_with_input(kitchen_object_resource: KitchenObjectResource) -> BurningRecipeResource:
	for burning_recipe in burning_recipe_list:
		if burning_recipe.input == kitchen_object_resource:
			return burning_recipe

	return null
