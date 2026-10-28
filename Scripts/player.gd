
extends CharacterBody3D

const SPEED = 5.0
const SPRINT_SPEED = 9.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = 12.0
const DECELERATION = 16.0
const TURN_SPEED = 7.0
const MOUSE_SENSITIVITY = 0.002

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera_arm: SpringArm3D = $CameraPivot/CameraArm
@onready var character_model: Node3D = $PlayerMesh/CharacterModel
@onready var character_animator: Node = $CharacterAnimator
@onready var interaction_ray: RayCast3D = $PlayerMesh/CharacterModel/InteractionRay
@onready var interaction_prompt: Label = $InteractionUI/InteractionPrompt
@onready var loot_menu: Control = $LootUI/LootMenu

var current_interactable: Node = null
var connected_chests: Array[Node] = []


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	interaction_ray.add_exception(self)
	interaction_prompt.hide()
	loot_menu.hide()


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
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_backward"
	)

	var direction = camera_pivot.global_transform.basis * Vector3(
		input_dir.x, 0, input_dir.y
	)

	direction.y = 0
	direction = direction.normalized()

	var current_speed = SPEED

	if Input.is_action_pressed("sprint"):
		current_speed = SPRINT_SPEED

	if direction.length() > 0.1:
		velocity.x = move_toward(
			velocity.x,
			direction.x * current_speed,
			ACCELERATION * delta
		)

		velocity.z = move_toward(
			velocity.z,
			direction.z * current_speed,
			ACCELERATION * delta
		)

		var target_angle = atan2(-direction.x, -direction.z)

		character_model.rotation.y = lerp_angle(
			character_model.rotation.y,
			target_angle,
			TURN_SPEED * delta
		)
	else:
		velocity.x = move_toward(
			velocity.x,
			0,
			DECELERATION * delta
		)

		velocity.z = move_toward(
			velocity.z,
			0,
			DECELERATION * delta
		)

	move_and_slide()

	var horizontal_speed = Vector2(
		velocity.x,
		velocity.z
	).length()

	character_animator.update_animation(
		delta,
		horizontal_speed,
		is_on_floor()
	)

	update_interaction()


func update_interaction() -> void:
	interaction_ray.force_raycast_update()
	current_interactable = null

	if interaction_ray.is_colliding():
		var collider = interaction_ray.get_collider()

		if collider is Node and collider.is_in_group("interactable"):
			var interactable_parent = collider.get_parent()

			if interactable_parent.has_method("interact"):
				current_interactable = interactable_parent

	if current_interactable != null:
		if current_interactable.has_method("get_interaction_text"):
			interaction_prompt.text = current_interactable.get_interaction_text()
		else:
			interaction_prompt.text = "[E] Interact"

		if interaction_prompt.text.is_empty():
			interaction_prompt.hide()
		else:
			interaction_prompt.show()

		if Input.is_action_just_pressed("interact"):
			connect_interactable(current_interactable)
			current_interactable.interact()
	else:
		interaction_prompt.hide()


func connect_interactable(interactable: Node) -> void:
	if interactable in connected_chests:
		return

	if interactable.has_signal("loot_requested"):
		interactable.loot_requested.connect(open_loot_menu)
		connected_chests.append(interactable)


func open_loot_menu() -> void:
	interaction_prompt.hide()
	velocity = Vector3.ZERO
	loot_menu.open_menu()
