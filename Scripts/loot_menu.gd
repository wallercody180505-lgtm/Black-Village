
extends Control

signal menu_closed

@export var player_inventory: InventoryData
@export var chest_inventory: InventoryData

@onready var close_button: Button = $LootPanel/MainLayout/ButtonBox/CloseButton
@onready var take_button: Button = $LootPanel/MainLayout/ButtonBox/TakeButton
@onready var take_all_button: Button = $LootPanel/MainLayout/ButtonBox/TakeAllButton

@onready var chest_item_list: VBoxContainer = $LootPanel/MainLayout/InventoryColumns/ChestInventory/ChestItemList
@onready var player_item_list: VBoxContainer = $LootPanel/MainLayout/InventoryColumns/PlayerInventory/PlayerItemList

var selected_item: ItemData = null


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	close_button.pressed.connect(close_menu)
	take_button.pressed.connect(take_selected_item)
	take_all_button.pressed.connect(take_all_items)

	refresh_inventory_display()


func open_menu() -> void:
	selected_item = null

	refresh_inventory_display()

	show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func close_menu() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	menu_closed.emit()


func _unhandled_key_input(event: InputEvent) -> void:
	if visible and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			close_menu()
			get_viewport().set_input_as_handled()


func refresh_inventory_display() -> void:
	clear_item_list(chest_item_list)
	clear_item_list(player_item_list)

	if chest_inventory != null:
		populate_chest_items()

	if player_inventory != null:
		populate_player_items()

	take_button.disabled = selected_item == null
	take_all_button.disabled = (
		chest_inventory == null or chest_inventory.is_empty()
	)


func clear_item_list(item_list: VBoxContainer) -> void:
	for child in item_list.get_children():
		item_list.remove_child(child)
		child.queue_free()


func populate_chest_items() -> void:
	if chest_inventory.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Empty"
		empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		chest_item_list.add_child(empty_label)
		return

	for i in range(chest_inventory.items.size()):
		if i >= chest_inventory.quantities.size():
			continue

		var item: ItemData = chest_inventory.items[i]

		if item == null:
			continue

		var quantity: int = chest_inventory.quantities[i]

		var item_button := Button.new()
		item_button.text = item.item_name + " x" + str(quantity)
		item_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		item_button.custom_minimum_size.y = 35
		item_button.add_theme_font_size_override("font_size", 18)

		if selected_item != null and selected_item.item_id == item.item_id:
			item_button.text = "> " + item_button.text + " <"

		item_button.pressed.connect(select_item.bind(item))

		chest_item_list.add_child(item_button)


func populate_player_items() -> void:
	if player_inventory.is_empty():
		var empty_label := Label.new()
		empty_label.text = "Empty"
		empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		player_item_list.add_child(empty_label)
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

		player_item_list.add_child(item_label)


func select_item(item: ItemData) -> void:
	selected_item = item
	refresh_inventory_display()


func take_selected_item() -> void:
	if selected_item == null:
		return

	if chest_inventory == null or player_inventory == null:
		return

	if chest_inventory.remove_item(selected_item, 1):
		player_inventory.add_item(selected_item, 1)

		print("Taken: ", selected_item.item_name)

		if chest_inventory.get_item_quantity(selected_item) <= 0:
			selected_item = null

		refresh_inventory_display()


func take_all_items() -> void:
	if chest_inventory == null or player_inventory == null:
		return

	# Copy the arrays so removing items doesn't affect our loop.
	var items_to_transfer: Array[ItemData] = chest_inventory.items.duplicate()
	var quantities_to_transfer: Array[int] = chest_inventory.quantities.duplicate()

	for i in range(items_to_transfer.size()):
		if i >= quantities_to_transfer.size():
			continue

		var item: ItemData = items_to_transfer[i]
		var amount: int = quantities_to_transfer[i]

		if item == null or amount <= 0:
			continue

		if chest_inventory.remove_item(item, amount):
			player_inventory.add_item(item, amount)

	selected_item = null

	refresh_inventory_display()

	print("All items taken from chest!")
