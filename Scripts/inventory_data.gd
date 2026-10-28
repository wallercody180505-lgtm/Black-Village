
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

	inventory_changed.emit()


func remove_item(item: ItemData, amount: int = 1) -> bool:
	if item == null or amount <= 0:
		return false

	for i in range(items.size()):
		if items[i] != null and items[i].item_id == item.item_id:
			if quantities[i] < amount:
				return false

			quantities[i] -= amount

			if quantities[i] <= 0:
				items.remove_at(i)
				quantities.remove_at(i)

			inventory_changed.emit()
			return true

	return false


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
