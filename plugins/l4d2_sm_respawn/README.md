source: https://forums.alliedmods.net/showthread.php?p=2693455

Description:
Adds ability to respawn player:
from admin menu
from console
from 3-rd party plugins using native
without losing statistics.

This is fork, improved version based on v1.9.5 from this topic. See changelog below.
Features:
Allow respawning even a spectator (with team selection)
Ability to spawn in crouch pose (like inside the transport / duct with limited height of space)
Very accurate positioning at crosshair preventing the collision
Lot of customization in respawn position (see ConVars and l4d_sm_respawn.inc)
Allow to switch the team (e.g. using sm_respawnex command)

Commands:
sm_respawn - Opens menu to select players for respawning.
sm_respawn <target> - Respawn a player at your crosshair.
sm_respawnex - Extended respawn options. Alternative to SM_Respawn() native. See the "Natives" section.
Settings (ConVars):
cfg/sourcemod/l4d_sm_respawn.cfg:
PHP Code:
// Respawn survivor players with this loadout
// For the list of valid names see here: https://github.com/raziEiL/l4d2_weapons/blob/e7d7d75518150aea155acc3c37ff79f15e994b99/scripting/include/l4d2_weapons.inc#L149
l4d_sm_respawn_loadout "smg,pistol,pain_pills"

// Notify in chat and log about the respawn action? (0 - No, 1 - Yes)
l4d_sm_respawn_showaction "1"

// Add 'Respawn player' item in admin menu under 'Player commands' category? (0 - No, 1 - Yes)
l4d_sm_respawn_adminmenu "1"

// Where to respawn? (1 - next to you or alive player, 2 - at your crosshair, 32 - TakeOver bot firstly. You can combine with SPAWN_POSITION values, see .inc file)
l4d_sm_respawn_position "34"

// What teams to display in respawn menu? (2 - Spectators, 4 - Survivors, 8 - Infected, 16 - Dead only, 32 - No surv.bots, 64 - No inf.bots. You can combine)
l4d_sm_respawn_teams "78"

// Respawn infected player as ghost? (1 - Yes, 0 - No, instant respawn)
l4d_sm_respawn_ghost "1"

// Admin flag(s) required to use the respawn command
l4d_sm_respawn_accessflag "d" // (ban) 
Natives:
Spoiler 


Installation
- Just unpack /l4d_sm_respawn/ and copy to server.
- If you update from the original 1.x version, perhaps you may want to remove "Respawn Survivor" entry from "configs/adminmenu_custom.txt" file (not required anymore, unless you are using adminmenu_sorting.txt feature).
- If you want to use custom admin. menu items sorting (like, to make "Respawn Player" item to be the first in the list), here are required correct settings:
(optionally) adminmenu_custom.txt 

PHP Code:
"Commands"
{
    "PlayerCommands"
    {
        "Respawn Player" // admin menu item name (you can use UTF8 as well)
        {
            "cmd"            "sm_respawn"
            "admin"            "sm_voteban"
        }
    }
} 

(optionally) adminmenu_sorting.txt 

PHP Code:
"Menu"
{
    "PlayerCommands"
    {
        "item"        "Respawn Player" // admin. menu item name (should match with same in adminmenu_custom.txt file)
        "item"        "sm_noclip"
        "item"        "sm_slay"
        "item"        "sm_kick"
        "item"        "sm_ban"
        "item"        "sm_slap"
        "item"        "sm_gag"
        "item"        "sm_burn"        
        "item"        "sm_beacon"
        "item"        "sm_freeze"
        "item"        "sm_timebomb"
        "item"        "sm_firebomb"
        "item"        "sm_freezebomb"
    }

... e.t.c. 
P.S. You don't need l4d_native_usage_sample.sp file. It is an example for developers, how to use natives.