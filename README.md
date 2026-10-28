# Black Village

**A third-person, low-poly medieval RPG built with Godot 4.**

Black Village is an early-stage indie game project focused on building an explorable medieval world with interactive environments, looting, inventory management, and eventually deeper RPG systems.

> **Development status:** Pre-alpha — current development milestone: **v0.6.0**.
>
> The game is actively being developed. Features, controls, and visuals may change.

## Overview

Black Village is being developed incrementally, starting with core character movement and world interaction before expanding into a larger medieval RPG experience.

The current playable prototype allows you to explore a 3D environment, interact with a wooden chest, inspect its contents, and transfer loot into your inventory.

## Features implemented

- **Third-person character controller** with walking, sprinting, jumping, and camera controls.
- **Animated low-poly character** with movement and idle animation.
- **Object interaction system** with contextual prompts.
- **Animated wooden chest** that opens when interacted with.
- **Loot interface** showing separate chest and player inventories.
- **Data-driven items** using Godot custom resources.
- **Inventory quantities and stacking** for stackable items.
- **Selectable chest items** and functional **Take** / **Take All** actions.
- **Live inventory updates** and empty-chest detection.

## Controls

| Action | Control |
| --- | --- |
| Move | W / A / S / D |
| Look around | Mouse |
| Sprint | Configured sprint input |
| Jump | Space |
| Interact | E |
| Close loot menu | Esc or Close button |

> Controls reflect the current prototype and may be revised.

## Getting started

### Requirements

- **Godot 4.x** (a compatible Godot 4 release)
- A computer capable of running Godot's 3D renderer

### Run locally

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Open **Godot 4**.
3. Choose **Import** and select the project's `project.godot` file.
4. Open the project and press **F5** to run it.

Replace `<repository-url>` with this repository's clone URL.

## Development roadmap

The following features are planned or under consideration, not yet implemented:

- [x] Third-person movement and camera
- [x] Basic character animation
- [x] Object interaction and chest opening
- [x] Inventory data and chest looting
- [ ] Additional items, such as food, weapons, and potions
- [ ] Item descriptions and inspection
- [ ] Standalone player inventory screen
- [ ] Equipment and gear management
- [ ] Save/load persistence
- [ ] Expanded world and gameplay systems

## Milestones

| Version | Focus |
| --- | --- |
| **v0.5.0** | Chest interaction and initial loot interface |
| **v0.6.0** | Functional inventories and item transfers |

*These are development milestones; they do not necessarily correspond to separate Git commits or published releases.*

## Known limitations

- Inventory changes currently last only for the running game session; save/load persistence has not yet been implemented.
- The prototype uses a limited set of items and a single demonstration chest.
- Equipment, combat, quests, and broader RPG mechanics are not yet implemented.
- Non-stackable item handling will need refinement as equipment is introduced.

## Built with

- [Godot Engine](https://godotengine.org/) — game engine
- **GDScript** — gameplay scripting

## Project status

Black Village is a learning-driven passion project in active development. This README will evolve as new systems are added.
