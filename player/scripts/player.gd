extends CharacterBody2D


# Movement variables
@export var walking_speed = 200
@export var running_speed = 400

@onready var active_speed = walking_speed

@export var jump_velocity = -400.0


# Runs every frame
func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()

func movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = -200


	# Sprinting system
	if Input.is_action_pressed("sprint"):
		active_speed = running_speed
	else:
		active_speed = walking_speed
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * active_speed
	else:
		velocity.x = move_toward(velocity.x, 0, active_speed)
