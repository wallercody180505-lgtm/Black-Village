
extends Resource
class_name InventoryData

signal inventory_changed

@export var inventory_name: String = "New Inventory"
@export var items: Array[ItemData] = []
@export var quantities: Array[int] = []


func add_item(item: ItemData, amount: int = 1) -> void:
	if item == null or amount <= 0:
		return

	if item.stackable:
		for i in range(items.size()):
			if items[i] != null and items[i].item_id == item.item_id:
				quantities[i] += amount
				inventory_changed.emit()
				return

		items.append(item)
		quantities.append(amount)

	else:
		for i in range(amount):
			items.append(item)
			quantities.append(1)

	inventory_changed.emit()


func remove_item(item: ItemData, amount: int = 1) -> bool:
	if item == null or amount <= 0:
		return false

	if get_item_quantity(item) < amount:
		return false

	var remaining: int = amount

	for i in range(items.size() - 1, -1, -1):
		if items[i] == null:
			continue

		if items[i].item_id != item.item_id:
			continue

		var amount_to_remove: int = min(quantities[i], remaining)

		quantities[i] -= amount_to_remove
		remaining -= amount_to_remove

		if quantities[i] <= 0:
			items.remove_at(i)
			quantities.remove_at(i)

		if remaining <= 0:
			break

	inventory_changed.emit()
	return true


func get_item_quantity(item: ItemData) -> int:
	if item == null:
		return 0

	var total: int = 0

	for i in range(items.size()):
		if items[i] != null and items[i].item_id == item.item_id:
			total += quantities[i]

	return total


func is_empty() -> bool:
	return items.is_empty()
