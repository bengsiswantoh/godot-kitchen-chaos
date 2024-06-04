class_name Character
extends Node3D


@onready var _animation_tree: AnimationTree = $AnimationTree
@onready var _player: Player = owner


func _process(_delta: float) -> void:
	_animation_tree.set("parameters/conditions/idle", not _player.is_walking())
	_animation_tree.set("parameters/conditions/is_walking", _player.is_walking())
