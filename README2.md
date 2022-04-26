**Ruby Game** 

*Console Based Text RPG Game*

> **Ruby Gems**
Ruby gems used for this project

https://ttytoolkit.org/

tty-prompt - interactive command line prompt

tty-reader - provides independent reader component for TTY toolkit

tty-spinner - Optional

colorize - Extends String class or add a ColorizedString with methods to set text color, background color and text effects.

> **File Structure**
 - root - root directory of project
    - lib - here goes all files which will be included in project
    - modules - here goes our state action files
    - spec - here goes our specs for testing

Create file named core.rb in root directory, and this file will be our starting point

<br>
<pre>/</pre>

> **Core.rb**

Will have class named Game in which everything needs to be initialized before game starts.

Will have loop method which runs our game logic



<br>
<pre>/lib</pre>

Here will be our resources for the game

Each file created here inside has a module named same as file name, with class of Base, excepts for states

Example - Player.rb
```
module Player 
  class Base
     def initialize
     ...
```


<br>
<pre>/modules</pre>

Here goes our State action files, which will be used in 
> States.rb

<br>
<pre>/spec</pre>

Here will be located or spec files for each .rb included in this project


<br>

> **Intro**

While working on this, you will learn how to use Ruby Gems, Classes, Modules, includes and many other useful things.

tty-prompt will be used for designing user input, you can make text input, selection, multiple selections and other..

You will start making project in Core.rb, where you will initialize everything what will be used in game

<br>

> **To Do**

<br>

> Player

This game needs Player, so you will have to make module for Player, which will have next attributes:
id, name, level, xp, health, damage, armor, pos_x, pos_y, dead, quests, inventory, equiped_weapon, abilities, interacting_with, map_marker( character for 2d map), image(ASCII image of player)

Player should have next actions: equip_weapon, use_item, sell_item, buy_item, drop_item, respawn, accept_quest, move_to, is_dead, interact

Player inventory should be instance of Inventory.

Player abilites is collection with instances of Abilities

<br>

> Item

This game will have items, which have multiple types.

For now, we want items with type of Weapon and Consumable

Base class has next attributes: id, name, description, gold, usable, stackable, count, item_type(?), rarity, equiped

Weapon items have next attributes: damage, description, req_lvl, item_type(?), equiped

Consumable items have next attributes: description, item_type(?), on_use

<br>

> Inventory

This game will have inventory module for Player and NPC-s.

Base attributes: id, max_slots, slots(collection), gold

Inventory should have next actions: item_remove, item_add, upgrade_slots

<br>

> Map

This game will have map module which will be used for rendering our map view

Base attributes: id, name, width, height, objects, out

Actions: render, add_object, display , remove_object, check_collision

We will use 2D array for the map rendering.

<br>

> NPC

This game will have NPC module which will be used for interaction with player

There will be next types of NPC: Enemy, EnemyBoss, Shop, QuestGiver

Base class attribues: id, name, pos_x, pos_y

Enemy attributes: damage, armor, health, inventory, dead, map_marker, image

Enemy methods: is_dead, deal_damage

EnemyBoss: same as Enemy but increased damage and loot

Shop attributes: inventory

Shop methods: set_items

QuestGiver attributes: quests

QuestGiver methods: display_quests

<br>

> Quest

This game will have Quest module which will be used by Quest givers and player

Quest module has listener or counter depending on quest description (ex. specific Enemy kill counter)

Player can accept quests and receive them

<br>

> States

This game will have States file which is used for I/O

States controlls whats currently displayed in console window.

You will implement TTY reader and prompt

You will design main menu inside.

Main menu contains next selections: Map, Character, Inventory, Quests, Quit

   >> Map

   You will design map legend which defines characters used on map and display it.

   Then you will display map

   Then you will prompt player to Walk or to go Back

    Walk
    
      Here is handled player movement and map display

      You can define here your movement keys and make movement logic


   >> Character

   You will display character stats and equiped weapon

   You can uneqip weapon if player has already equiped one.

   You can implement upgrade stats option, which can be boosted by gold or exp, you choice

   
   >> Inventory

   You will display here player items from player inventory

   Depending on item type, you can Use or Equip item, or you can Drop it

   There is also option to Upgrade inventory, which costs 100 gold and increases Inventory slots by 5

   
   >> Quests

   You will display current active Player quests and finished quests

   You will have to implement option to remove active quest

   Alo design display for this state

 <br>

Also, we have state_interraction method which is triggered when Player collides with NPC.

Depending on NPC type, specific state action is triggered (ones in /module directory), so each NPC has its own state.

States have their own I/O loop.

<br>

> **Objects**

Objects used in game

```
Item::Weapon.new("Sword", "Basic sword", 100, 10, 1))
Item::Weapon.new("Dagger", "Basic dagger", 150, 12, 1))
Item::Weapon.new("Mace", "Basic mace", 250, 25, 1))

Item::Consumable.new("Health potion", "Restore health for 20 points", 25, "hp_regen", 20)
Item::Consumable.new("Damage boost potion", "Boosts damage for *2", 40, "damage_boost", 2)

@damage = Player damage attribute
Ability.new("Basic attack", @damage, "Basic attack - #{@damage}dmg"),
Ability.new("Strong attack", @damage, "Strong attack - #{@damage}dmg + 50% critical chance"),
Ability.new("Heal", @damage, "Heal for 45% of #{@damage} dmg")

NPC::Enemy.new("Enemy", 6, 6)
enemy.health = 50
enemy.damage = 5..10
enemy.reward_gold = 100
enemy.reward_items = [ 'put one or multiple items here' ]

NPC::EnemyBoss.new("Boss Enemy", 6, 8)
boss.health = 100
boss.damage = 10..20
boss.reward_gold = 250
boss.reward_items = [ 'put one or multiple items here' ]

NPC::Shop.new("Vendor", 6, 5)
vendor.set_items(['put here items that will be for sale])

NPC::QuestGiver.new("Quester", 6, 9)
quester.quests = [
      Quest::Base.new("Tutorial", "Opis Questa", ['put here reward items'], 200, 50, ['put here items that are required to finish quest, if needed']),
    ]

Module_Map::Map.new("Map_default", 40, 50)
```




