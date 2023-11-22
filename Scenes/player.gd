extends CharacterBody3D

@export_subgroup("Properties")
# How fast the player moves
@export var speed = 150
# The downward acceleration when in the air
@export var fall_acceleration = 150

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var input = Vector3.ZERO

	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")

	if input != Vector3.ZERO:
		input = input.normalized()
		$Pivot.look_at(position + input, Vector3.UP)

	# Ground Velocity
	target_velocity = input * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - fall_acceleration
	
	target_velocity *= delta

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
