
extends Node3D

signal loot_requested

@onready var lid_pivot: Node3D = $LidPivot

const OPEN_ANGLE: float = 110.0
const OPEN_DURATION: float = 0.6

var is_open: bool = false
var is_animating: bool = false


func get_interaction_text() -> String:
	if is_animating:
		return ""

	if is_open:
		return "[E] Examine Wooden Chest"

	return "[E] Open Wooden Chest"


func interact() -> void:
	if is_animating:
		return

	if is_open:
		loot_requested.emit()
		return

	open_chest()


func open_chest() -> void:
	is_open = true
	is_animating = true

	print("Opening wooden chest...")

	var tween = create_tween()

	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		lid_pivot,
		"rotation:x",
		deg_to_rad(OPEN_ANGLE),
		OPEN_DURATION
	)

	await tween.finished

	is_animating = false

	print("Wooden chest opened!")

	loot_requested.emit()
