
# Black Village — Changelog

All notable changes to Black Village will be documented in this file.

Black Village is a third-person, low-poly medieval RPG being developed in Godot 4.

The project is currently in early development.

---

## [0.8.0] - 2026-10-29
### Multiple Item Types

### Added
- Five new item resources:
  - Bread
  - Iron Sword
  - Health Potion
  - Wooden Shield
  - Iron Ore
- Support for multiple item types within inventories.
- Support for stackable and non-stackable items.
- Separate inventory entries for individual non-stackable items.
- Inventory-slot-based item selection in the chest interface.
- Multiple item types within the wooden chest.

### Changed
- Improved inventory addition logic to respect item stackability.
- Improved inventory removal logic to handle quantities across multiple entries.
- Updated the wooden chest inventory with a selection of medieval items.
- Updated chest item selection to use inventory slot indices rather than item IDs.
- Item selection now resets after transferring an item to prevent incorrect selections.

### Fixed
- Selecting one Iron Sword no longer highlights every Iron Sword in the chest.
- Non-stackable items now transfer as separate inventory entries.
- Multiple identical non-stackable items can be transferred correctly.

---

## [0.7.0] - 2026-10-29
### Player Inventory Interface

### Added
- Standalone player inventory interface.
- Dedicated inventory menu scene hierarchy.
- Inventory access using the I key.
- Inventory closing using the I key, Escape key or Close button.
- Dynamic display of items held by the player.
- Automatic display of item quantities.
- Empty inventory message.
- Dedicated InventoryUI CanvasLayer.

### Changed
- Updated player controller to support opening the inventory.
- Player movement pauses while the inventory is open.
- Mouse cursor becomes visible when accessing the inventory.
- Mouse cursor is recaptured when closing the inventory.
- Inventory contents reflect items transferred from the wooden chest.

### Fixed
- Inventory interface now correctly pauses and resumes gameplay.
- Inventory and chest interfaces cannot be opened simultaneously through normal gameplay.

---

## [0.6.0] - 2026-10-28
### Inventory System & Chest Looting

### Added
- ItemData resource class for defining game items.
- InventoryData resource class for managing item collections.
- Item properties including:
  - Unique item ID
  - Item name
  - Description
  - Icon
  - Value
  - Stackability
- Gold Coin item resource.
- Player inventory resource.
- Wooden chest inventory resource.
- Inventory item quantities.
- Inventory addition and removal functions.
- Item quantity lookup.
- Inventory empty-state detection.
- Inventory change signal.
- Functional chest loot interface.
- Chest item selection.
- Take button for transferring individual items.
- Take All button for transferring entire chest contents.
- Player inventory display within the loot interface.
- Empty chest display.

### Changed
- Wooden chest now contains a functional inventory.
- Chest interaction opens a loot menu.
- Looting transfers items between chest and player inventories.
- Inventory displays update following item transfers.
- Gameplay pauses while the loot interface is open.
- Mouse cursor becomes visible while looting.

### Fixed
- Items are correctly removed from the chest after being taken.
- Player inventory quantities update when collecting items.
- Empty chests no longer offer items to take.

---

## [0.5.0] - 2026-10-28
### Wooden Chest Interaction

### Added
- Interactable wooden chest.
- Chest opening animation.
- Animated chest lid using Tween.
- Interaction raycast detection.
- Context-sensitive interaction prompts.
- Chest opening and examination interactions.
- Chest loot menu interface.
- Chest interaction signals.

### Changed
- Player can interact with objects using the E key.
- Chest interaction text changes depending on whether the chest is open.
- Chest lid remains open after its initial interaction.

---

## [0.4.0]
### Initial Game Environment

### Added
- Initial 3D game environment.
- Basic world geometry.
- Environment objects for testing player movement and interactions.
- Initial foundation for future world development.

---

## [0.3.0]
### Character Model & Animation

### Added
- Third-person character model.
- Character model node hierarchy.
- Procedural character animations.
- Movement-based animation updates.
- Character rotation based on movement direction.

### Changed
- Improved visual feedback during player movement.
- Character orientation now follows the player's movement direction.

---

## [0.2.0]
### Player Movement

### Added
- Third-person player movement.
- Sprinting.
- Jumping.
- Gravity and ground detection.
- Movement acceleration and deceleration.
- Camera-relative movement.

### Changed
- Improved player movement responsiveness.
- Added smooth character turning.

---

## [0.1.0]
### Initial Project Setup

### Added
- Initial Godot 4 project structure.
- Player scene.
- Basic third-person player controller.
- Third-person camera setup.
- Initial world scene.
- Foundation for future gameplay systems.

---

## Planned Features

### v0.9.0 — Item Information & Icons
- Inventory item icons.
- Item descriptions.
- Item value display.
- Item information panel.
- Improved inventory presentation.

### v0.10.0 — Inventory Management
- Improved item selection.
- Inventory organisation.
- Additional inventory interactions.

### v0.11.0+ — Save System
- Persistent player inventory.
- Persistent chest inventories.
- Save and load functionality.
- Multiple save slots.

### Future Development
- Equipment and weapons.
- Health and consumables.
- Combat.
- NPCs and dialogue.
- Trading and economy.
- Quests.
- Expanded medieval environments.
- Character progression.
- Larger interconnected game world.
