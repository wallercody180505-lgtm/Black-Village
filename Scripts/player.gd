extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002
const TURN_SPEED = 7.0
const SPRINT_SPEED = 9.0
const ACCELERATION = 12.0
const DECELERATION = 16.0

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera_arm: SpringArm3D = $CameraPivot/CameraArm
@onready var player_mesh: MeshInstance3D = $PlayerMesh

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_pivot.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera_arm.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera_arm.rotation.x = clamp(
			camera_arm.rotation.x,
			deg_to_rad(-60),
			deg_to_rad(45)
		)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction.y = 0
	direction = direction.normalized()
	var current_speed = SPEED
	
	if Input.is_action_pressed("sprint"):
		current_speed = SPRINT_SPEED
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * current_speed, ACCELERATION * delta)
		velocity.z = move_toward(velocity.z, direction.z * current_speed, ACCELERATION * delta)
		var target_angle = atan2(-direction.x, -direction.z)
		player_mesh.rotation.y = lerp_angle(
			player_mesh.rotation.y,
			target_angle,
			TURN_SPEED * delta
		)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		velocity.z = move_toward(velocity.z, 0, DECELERATION * delta)
		
	move_and_slide()
