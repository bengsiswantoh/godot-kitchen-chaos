extends Node


@onready var gpu_particles_3d: GPUParticles3D = $"../GPUParticles3D"


func _ready() -> void:
	var stove_counter := owner as StoveCounter
	stove_counter.state_changed.connect(_on_stove_counter_state_changed)
	
	
func _on_stove_counter_state_changed(state: StoveCounter.STATE) -> void:
	var show_visual = state == StoveCounter.STATE.FRYING or state == StoveCounter.STATE.FRIED
	gpu_particles_3d.emitting = show_visual
