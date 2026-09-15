# Game Scripting | FiveM Lua Utilities

![Lua](https://img.shields.io/badge/Lua-5.4-blue?style=for-the-badge&logo=lua&logoColor=white)
![FiveM](https://img.shields.io/badge/Platform-Cfx.re_/_FiveM-orange?style=for-the-badge)
![ox_lib](https://img.shields.io/badge/Library-ox__lib-38B2AC?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)

A collection of performance-optimized Lua scripts for the FiveM platform, focusing on immersive gameplay mechanics and automated server security. These resources demonstrate proficiency in **Client-Server RPC**, **Entity Networking**, and **Access Control Lists (ACE)**.

---

## Included Resources

### Advanced Lockpick & Vehicle Hijacking
A comprehensive vehicle interaction script that bridges technical skill-checks with immersive animations.
*   **Skill-Based Interaction:** Features a dynamic lockpicking mini-game with model-specific difficulty scaling (e.g., higher-end vehicles require more pins/accuracy).
*   **Entity Networking:** Utilizes `NetworkRequestControlOfEntity` with timeout-logic to ensure the script maintains sync across the server when manipulating vehicle doors and ignitions.
*   **Hotwiring Logic:** Implements a secondary "Hotwire" phase post-entry, utilizing `TaskPlayAnim` and `FreezeEntityPosition` to simulate a realistic hijacking timeline.
*   **Core Dependency:** This script utilizes **`t3_lockpick`** as the primary GUI provider for the lockpicking mini-game.

### WeaponLogger: Automated Inventory Auditor
A security-focused administrative tool designed to enforce server weaponry standards and log violations in real-time.
*   **ACE Group Verification:** Dynamically audits a player's inventory against their assigned ACE permissions (e.g., LEO, EMS, Military).
*   **Discord Telemetry:** Integrated with the **`Badger_Discord_API`**, this script dispatches detailed JSON payloads to Discord webhooks whenever an unauthorized weapon is detected and removed.
*   **Performance Optimized:** Operations are performed on an asynchronous `CreateThread` loop with configurable intervals to ensure zero impact on client-side frame times.

---

## Technical Architecture

| Feature | Implementation |
| :--- | :--- |
| **API Integration** | Deep integration with `ox_lib` for notifications and advanced task handling. |
| **State Sync** | Precise handling of vehicle lock states (`SetVehicleDoorsLocked`) across the network. |
| **Security** | Server-side validation of client-triggered events to prevent executor-based exploits. |
| **Metadata** | Modular `config.lua` design allowing for hash-based difficulty overrides. |

---

## Installation

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/ChefAsmith/Fivem-Utilities.git
    ```
2.  **Verify Dependencies**
    Ensure the following resources are installed and started in your `server.cfg`:
    *   `ox_lib`
    *   `t3_lockpick` (Required for the Lockpick GUI)
    *   `Badger_Discord_API` (Required for WeaponLogger)
3.  **Deploy Resources**
    Add the folders to your `resources/` directory and ensure them:
    ```cfg
    ensure ox_lib
    ensure t3_lockpick
    ensure apex-lockpick
    ensure apex-weaponlogger
    ```

---

## Configuration

Scripts are highly configurable via `config.lua`. 

**Example WeaponLogger Entry:**
```lua
Config.AllowedWeapons = {
    ["group.leo"] = {
        "WEAPON_PISTOL",
        "WEAPON_STUNGUN",
        "WEAPON_CARBINERIFLE"
    }
}
```

---

## License
Distributed under the **MIT License**. Created as a demonstration of game engine interfacing and multiplayer synchronization logic.

**Maintainer:** *ChefAmbrosia* – Backend & Infrastructure Developer