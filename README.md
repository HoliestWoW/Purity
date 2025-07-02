# Purity Hardcore AddOn for World of Warcraft: Classic Era

Purity is a hardcore challenge addon for World of Warcraft: Classic Era that allows players to opt into strict, class-specific challenges. These challenges are designed to be completed from level 1 to 60, testing your knowledge of the game and forcing you to play your class in new and interesting ways.

The addon is lightweight, modular, and designed to provide a verifiable path for proving your accomplishment.

---

## Links

* **[Download on CurseForge](https://www.curseforge.com/wow/addons/purity)**
* **[Join our Discord Community](https://discord.gg/5m74Kw27AE)**

---

## Features

* **Class-Specific Challenges**: Unique, thematic challenges for Mage, Paladin, Priest, Shaman, Warlock, and Warrior. 
* **Specialization Choices**: Some classes, like the Mage, must choose a sub-path within their challenge, further restricting their gameplay.
* **Real-Time Violation Monitoring**: The addon actively monitors your actions, talents, and spells to ensure the rules are being followed. A single violation fails the challenge permanently for that character.
* **In-Game Status UI**: Use `/purity status` to view your current standing, uptime, and other important information.
* **Verification System**: Upon challenge completion, a unique verification code is generated. **Post this code in the `#verification-submissions` channel on our Discord to have your run officially verified.** 
* **Extensible Design**: The addon is built to be expanded with new class modules.

## How to Use

The addon will automatically present the challenge to you at level 1. If you decline, you can use the `/purity` slash commands to interact with the UI.

* `/purity`: Shows a summary of your current challenge status in the chat window.
* `/purity status`: Opens the main interface to the Status tab.
* `/purity rules`: Opens the main interface to the Rules tab.

## The Class Challenges

### Warrior - Brand of Purity
* **Description**: The Berserker. No shields or defensive stance. All combat must be initiated with Charge, forsaking all caution. 
* **Key Prohibitions**:
    * You may NOT use shields at any time. 
    * You may NOT use Defensive Stance. 
    * After level 4, you may NOT initiate combat without using Charge. 
    * After level 20, equipping two-handed weapons is forbidden (with a grace period for the weapon you have when you ding 20).

### Shaman - Communion of Purity
* **Description**: The Spirit Walker. Your power flows purely from your spells and maintaining active totems in combat. No weapons of any kind.
* **Key Prohibitions**:
    * You may NOT equip any weapons of any kind.
    * You must always maintain at least one active totem on the ground while in combat (after totems are unlocked).
    * You must learn your first totem spell before level 6.

### Warlock - Grimoire of Purity
* **Description**: A crazed demonologist focused on fire, brimstone, and demons. Souls are fuel for summoning and nothing else.
* **Key Prohibitions**:
    * No learning or using forbidden spells (Shadow, most Curses, etc.).
    * No spending points in the Affliction talent tree.
    * Soul Shards may ONLY be used to summon or subjugate demons.
    * Healthstones and Soulstones are forbidden.
    * Only wands that deal Fire damage are permitted.

### Paladin - The Oath of Purity
* **Description**: The ultimate guardian, the Paladin's Oath is to be a selfless shield. They have forsaken retribution and personal glory, vowing to never be the aggressor.
* **Key Prohibitions**:
    * Do not initiate combat; enemies must strike first.
    * No learning or using Retribution spells or talents.
    * No learning or using Hammer of Wrath.

### Priest - The Testament of Purity
* **Description**: A true vessel of the Light, this Priest has sworn off the corrupting and seductive whispers of the Shadow.
* **Key Prohibitions**:
    * No weapons or physical attacks (including wands).
    * No learning or using Shadow magic spells or talents.
    * No killing Humanoid creatures.

### Mage - The Tome of Purity
* **Description**: Choose a tome to dedicate yourself to a single school of magic, forsaking all others. This decision is permanent.
* **Key Prohibitions**:
    * You may ONLY use spells and talents from your chosen school of magic.
    * You may NOT use your starting spells if they do not match your chosen school.

## Installation

1.  Download the latest version from CurseForge.
2.  Unzip the package.
3.  Copy the `Purity` folder into your `World of Warcraft/_classic_era_/Interface/AddOns/` directory. The final structure should look like this:
    ```
    .../Interface/AddOns/
        |-- Purity/
            |-- Purity.lua
            |-- Purity_Mage.lua
            |-- Purity_Paladin.lua
            |-- Purity_Priest.lua
            |-- Purity_Shaman.lua
            |-- Purity_Warlock.lua
            |-- Purity_Warrior.lua
            |-- README.md
            |-- LICENSE
    ```

## License

This addon is licensed under the MIT License. See the `LICENSE` file for more details.
