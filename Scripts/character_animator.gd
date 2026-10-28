
extends Node

# --------------------------------------------------
# ANIMATION SETTINGS
# --------------------------------------------------

const WALK_CYCLE_SPEED = 7.5
const RUN_CYCLE_SPEED = 10.0
const BLEND_SPEED = 7.0

# Walking
const WALK_HIP_SWING = 0.30
const WALK_KNEE_BEND = 0.45
const WALK_ANKLE_SWING = 0.12
const WALK_ARM_SWING = 0.25

# Sprinting
const RUN_HIP_SWING = 0.38
const RUN_KNEE_BEND = 0.55
const RUN_ANKLE_SWING = 0.14
const RUN_ARM_SWING = 0.32

# Upper body
const WALK_ELBOW_BEND = 0.10
const RUN_ELBOW_BEND = 0.40
const TORSO_TWIST = 0.05
const RUN_LEAN = 0.06

# Idle breathing
const BREATH_SPEED = 2.0
const BREATH_AMOUNT = 0.015

# --------------------------------------------------
# ANIMATION STATE
# --------------------------------------------------

var animation_time: float = 0.0
var idle_time: float = 0.0

var movement_blend: float = 0.0
var run_blend: float = 0.0
var air_blend: float = 0.0

# --------------------------------------------------
# NODE REFERENCES
# --------------------------------------------------

@onready var model: Node3D = $"../PlayerMesh/CharacterModel"

# Legs
@onready var left_hip: Node3D = $"../PlayerMesh/CharacterModel/LeftHipPivot"
@onready var right_hip: Node3D = $"../PlayerMesh/CharacterModel/RightHipPivot"

@onready var left_knee: Node3D = $"../PlayerMesh/CharacterModel/LeftHipPivot/LeftKneePivot"
@onready var right_knee: Node3D = $"../PlayerMesh/CharacterModel/RightHipPivot/RightKneePivot"

@onready var left_ankle: Node3D = $"../PlayerMesh/CharacterModel/LeftHipPivot/LeftKneePivot/LeftAnklePivot"
@onready var right_ankle: Node3D = $"../PlayerMesh/CharacterModel/RightHipPivot/RightKneePivot/RightAnklePivot"

# Arms
@onready var left_shoulder: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot/LeftShoulderPivot"
@onready var right_shoulder: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot/RightShoulderPivot"

@onready var left_elbow: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot/LeftShoulderPivot/LeftElbowPivot"
@onready var right_elbow: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot/RightShoulderPivot/RightElbowPivot"

# Upper body
@onready var spine: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot"
@onready var neck: Node3D = $"../PlayerMesh/CharacterModel/SpinePivot/NeckPivot"


# --------------------------------------------------
# MAIN ANIMATION
# --------------------------------------------------

func update_animation(
	delta: float,
	movement_speed: float,
	grounded: bool
) -> void:

	idle_time += delta

	# Movement targets
	var target_movement = 0.0
	var target_run = 0.0
	var target_air = 0.0

	if grounded and movement_speed > 0.1:
		target_movement = 1.0

	if grounded and movement_speed > 6.5:
		target_run = 1.0

	if not grounded:
		target_air = 1.0

	# Smooth transitions
	movement_blend = move_toward(
		movement_blend,
		target_movement,
		BLEND_SPEED * delta
	)

	run_blend = move_toward(
		run_blend,
		target_run,
		BLEND_SPEED * delta
	)

	air_blend = move_toward(
		air_blend,
		target_air,
		BLEND_SPEED * delta
	)

	# Animation timing
	var cycle_speed = lerp(
		WALK_CYCLE_SPEED,
		RUN_CYCLE_SPEED,
		run_blend
	)

	if grounded and movement_blend > 0.01:
		animation_time += delta * cycle_speed

	var left_phase = sin(animation_time)
	var right_phase = sin(animation_time + PI)

	# Blend walk and sprint
	var hip_swing = lerp(WALK_HIP_SWING, RUN_HIP_SWING, run_blend)
	var knee_bend = lerp(WALK_KNEE_BEND, RUN_KNEE_BEND, run_blend)
	var ankle_swing = lerp(WALK_ANKLE_SWING, RUN_ANKLE_SWING, run_blend)
	var arm_swing = lerp(WALK_ARM_SWING, RUN_ARM_SWING, run_blend)
	var elbow_bend = lerp(WALK_ELBOW_BEND, RUN_ELBOW_BEND, run_blend)

	# --------------------------------------------------
	# LEGS
	# --------------------------------------------------

	var left_hip_target = left_phase * hip_swing * movement_blend
	var right_hip_target = right_phase * hip_swing * movement_blend

	var left_knee_target = -max(
		0.0,
		sin(animation_time - 0.5)
	) * knee_bend * movement_blend

	var right_knee_target = -max(
		0.0,
		sin(animation_time + PI - 0.5)
	) * knee_bend * movement_blend

	var left_ankle_target = -left_phase * ankle_swing * movement_blend
	var right_ankle_target = -right_phase * ankle_swing * movement_blend

	# --------------------------------------------------
	# ARMS
	# --------------------------------------------------

	# Opposite arm and leg movement
	var left_arm_target = -left_phase * arm_swing * movement_blend
	var right_arm_target = -right_phase * arm_swing * movement_blend

	# Positive elbow rotation bends towards the body
	var elbow_target = elbow_bend * movement_blend

	# --------------------------------------------------
	# AIRBORNE POSE
	# --------------------------------------------------

	# Slightly staggered legs instead of sitting
	left_hip.rotation.x = lerp(
		left_hip_target,
		-0.08,
		air_blend
	)

	right_hip.rotation.x = lerp(
		right_hip_target,
		0.10,
		air_blend
	)

	left_knee.rotation.x = lerp(
		left_knee_target,
		-0.15,
		air_blend
	)

	right_knee.rotation.x = lerp(
		right_knee_target,
		-0.10,
		air_blend
	)

	left_ankle.rotation.x = lerp(
		left_ankle_target,
		0.05,
		air_blend
	)

	right_ankle.rotation.x = lerp(
		right_ankle_target,
		0.05,
		air_blend
	)

	# Arms slightly raised during jumping
	left_shoulder.rotation.x = lerp(
		left_arm_target,
		0.15,
		air_blend
	)

	right_shoulder.rotation.x = lerp(
		right_arm_target,
		0.15,
		air_blend
	)

	left_elbow.rotation.x = lerp(
		elbow_target,
		0.30,
		air_blend
	)

	right_elbow.rotation.x = lerp(
		elbow_target,
		0.30,
		air_blend
	)

	# --------------------------------------------------
	# UPPER BODY
	# --------------------------------------------------

	var torso_twist = left_phase * TORSO_TWIST * movement_blend
	var torso_lean = RUN_LEAN * run_blend * movement_blend

	spine.rotation.y = torso_twist
	spine.rotation.x = lerp(
		torso_lean,
		-0.04,
		air_blend
	)

	# Head stabilisation
	neck.rotation.y = -spine.rotation.y * 0.5
	neck.rotation.x = -spine.rotation.x * 0.5

	# --------------------------------------------------
	# IDLE BREATHING
	# --------------------------------------------------

	var breathing = (
		sin(idle_time * BREATH_SPEED) + 1.0
	) * 0.5 * BREATH_AMOUNT

	model.position.y = (
		-0.9
		+ breathing * (1.0 - movement_blend) * (1.0 - air_blend)
	)
