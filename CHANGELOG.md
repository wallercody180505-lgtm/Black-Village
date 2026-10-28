# Changelog

All notable changes to **Black Village** are documented here.

Black Village is a third-person, low-poly medieval RPG prototype built in Godot 4. The project is in **pre-alpha**, and versions below describe development milestones rather than necessarily representing separate Git commits or published releases.

This changelog follows the spirit of [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Planned
- Additional item types, including food, weapons, and potions.
- Item descriptions and inspection UI.
- Standalone player inventory screen.
- Equipment and gear systems.
- Save/load persistence.

## [0.6.0] - 2026-10-28

### Added
- Reusable `ItemData` resources with item IDs, names, descriptions, icons, values, and stackability settings.
- Reusable `InventoryData` resources with item quantities and inventory-change signals.
- Separate player and wooden-chest inventories.
- Gold Coin item resource and sample inventory contents.
- Dynamic display of chest and player inventory contents in the loot menu.
- Selectable chest items with a visible selection indicator.
- **Take** action to transfer one selected item to the player.
- **Take All** action to transfer all chest contents to the player.
- Empty-inventory messaging and disabled loot actions where appropriate.

### Improved
- Inventory columns and item entries aligned within the loot interface.
- Loot menu refreshes immediately after transferring items.
- Open chests can be examined again without replaying the opening animation.

### Known limitations
- Inventory changes are not yet saved between game sessions.
- The prototype currently demonstrates looting with Gold Coins and one chest.
- Non-stackable item behaviour needs further development.

## [0.5.0] - Development milestone (not separately released)

### Added
- Context-sensitive interaction prompts for interactable objects.
- Raycast-based object interaction using the **E** key.
- Wooden chest with animated lid opening.
- Loot menu with separate chest and player inventory sections.
- Close button and Escape-key handling for the loot menu.
- Mouse release and game pause while the loot menu is open, restoring normal play on close.

### Notes
- The v0.5.0 features were completed before a separate version-control checkpoint was created. This entry documents the development milestone; it does **not** imply that a v0.5.0 Git tag or release exists.

## Earlier prototype work - Versions not reconstructed

### Added
- Third-person character movement, sprinting, and jumping.
- Mouse-controlled third-person camera.
- Low-poly player character with movement and idle animation.
- Initial 3D playable environment.

### Notes
- Exact version numbers and dates for these early features have not been verified, so they are grouped here rather than assigned invented releases.
