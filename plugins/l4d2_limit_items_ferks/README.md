source: https://forums.alliedmods.net/showthread.php?p=2844121

About:
I've always thought it was really unfair how many items the maps spawn for survivors.
It's not at all uncommon for survivors to face a tank or a horde of some kind, with every single one of them armed with pipes, molotovs, bile jar's, extra piils / kits etc...
With that in mind, here’s where the plugin comes in:
Limit the number of items across the entire map however you like.

Cvars:

PHP Code:
l4d2_limit_items_enable "1" // Enable plugin
l4d2_limit_items_debug "0" // Enable debug mode

l4d2_limit_items_menu "1" // 0=Disable item limits menu and sm_itemlimits command, 1=Enable.
l4d2_limit_items_menu_show "31" // Bitmask of items to show in the menu. 1=Molotov, 2=PipeBomb, 4=Pills, 8=Adrenaline, 16=BileJar, 32=Medkit, 64=Defibrillator, 128=GrenadeLauncher, 256=Chainsaw, 512=LaserSight, 1024=ExplosiveAmmo, 2048=IncendiaryAmmo. 4095=All.

l4d2_limit_items_molotov "2" // Max molotov spawns (-1 = unlimited)
l4d2_limit_items_pipebomb "2" // Max pipe bomb spawns (-1 = unlimited)
l4d2_limit_items_pills "2" // Max pain pills spawns (-1 = unlimited)
l4d2_limit_items_adrenaline "-1" // Max adrenaline spawns (-1 = unlimited)
l4d2_limit_items_bilejar "-1" // Max bile jar spawns (-1 = unlimited)
l4d2_limit_items_defibrillator "-1" // Max defibrillator spawns (-1 = unlimited)
l4d2_limit_items_upgrade_explosive "-1" // Max explosive ammo upgrade spawns (-1 = unlimited)
l4d2_limit_items_upgrade_incendiary "-1" // Max incendiary ammo upgrade spawns (-1 = unlimited)

// Please note that setting “l4d2_limit_items_medkit_inside” or “l4d2_limit_items_medkit_outside” to 4 or higher will not spawn new medkits on the map.
l4d2_limit_items_medkit_inside "-1" // Max medkits inside the starting saferoom (-1 = unlimited)
l4d2_limit_items_medkit_outside "0" // Max medkits outside the starting saferoom (-1 = unlimited)

l4d2_limit_items_gascan "1" // Max gascans on the map (-1 = unlimited)
l4d2_limit_items_propane "1" // Max propane tanks on the map (-1 = unlimited)
l4d2_limit_items_oxygen "1" // Max oxygen tanks on the map (-1 = unlimited)
l4d2_limit_items_fireworks "-1" // Max fireworks on the map (-1 = unlimited)

l4d2_limit_items_grenade_launcher "-1" // Max grenade launcher spawns (-1 = unlimited)
l4d2_limit_items_chainsaw "-1" // Max chainsaw spawns (-1 = unlimited)
l4d2_limit_items_laser_sight "-1" // Max laser sight spawns (-1 = unlimited) 


Admin Commands:

PHP Code:
sm_listitems // Lists all items spawned on the map in the console, including their exact location (required z flag). 

Client Commands:

PHP Code:
sm_itemsmenu // Show the item limits menu. 

Changes:

Code:
2.2 (24-May-2026)
    - Added a check for the “fallen survivor” items that appear on the c6m2_bedlam map.
    - Added a new menu that always opens for survivors, showing the items on the map.

Credits:
This plugin uses code and ideas from other authors and plugins to perform certain functions.
Credits are listed in the source code.

Known issues:

The removed items won't always be the same. For example, the laser sight for weapons in the gun shop at c1m2_streets when “l4d2_limit_items_laser_sight 1”.



I haven't been able to test this on all official maps, so if you run into any issues, let me know 