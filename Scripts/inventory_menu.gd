
extends Control

@export var player_inventory: InventoryData

@onready var item_list: VBoxContainer = $InventoryPanel/MainLayout/ItemList
@onready var close_button: Button = $InventoryPanel/MainLayout/CloseButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	close_button.pressed.connect(close_menu)

	hide()


func open_menu() -> void:
	refresh_inventory()

	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func close_menu() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_key_input(event: InputEvent) -> void:
	if not visible:
		return

	if event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE or event.keycode == KEY_I:
			close_menu()
			get_viewport().set_input_as_handled()


func refresh_inventory() -> void:
	clear_item_list()

	if player_inventory == null:
		return

	if player_inventory.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Inventory Empty"
		empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		item_list.add_child(empty_label)
		return

	for i in range(player_inventory.items.size()):
		if i >= player_inventory.quantities.size():
			continue

		var item: ItemData = player_inventory.items[i]

		if item == null:
			continue

		var quantity: int = player_inventory.quantities[i]

		var item_label := Label.new()
		item_label.text = item.item_name + " x" + str(quantity)
		item_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		item_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		item_label.add_theme_font_size_override("font_size", 18)

		item_list.add_child(item_label)


func clear_item_list() -> void:
	for child in item_list.get_children():
		item_list.remove_child(child)
		child.queue_free()
