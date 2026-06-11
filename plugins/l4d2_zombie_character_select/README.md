source: https://forums.alliedmods.net/showthread.php?t=121461

Zombie Character Select
Version 0.9.7

Important
Only 0.9.1+ is compatible for Left 4 Dead 2 (2.0.4.2) & Left 4 Dead 1 (1.0.2.1) Sacrifice update and beyond.
Description

This is a complete bare metal rewrite of the Infected Character Select plugin originally written by Crimson_Fox but with a higher degree of flexibility in addition to added features. In a nutshell, this plugin allows any player on the infected team to choose their infected class.

Notable features
Enable/Disable valve infected bots.
Smooth infected class change in Zombie Class sequence.
Class change can be restricted by admin flags. (up to eight can be used)
Configurable cooldown timers/disable or use default for each infected class after player death.
Lock out class selection at each ghost spawn after a delay (configurable).
Restrict previous class played on next ghost spawn.
Better randomness of zombie delegation at ghost spawn. (No more 5x same infected in a row)
Plugin controlled limit handling. (manual or respect z_versus_*_limits)
Limits can be completely disabled, allowing for any infected class selection anytime.
Count fake infected bots in limits.
Configurable class selection delay.
Configurable key binding.
Configurable class selection at finale stages.
Limit HUD display.
NOTE: As this plugin is able to restrict class selection based on cooldown, limits and last class - it's most likely that not all 3 are used simultaneously because there simply isn't enough classes to accommodate (depending on limits). Many features are configurable so it's up to the server admin to find the right balance, avoiding any shortage of classes. Refer to the download link for a list of CVAR's. They should be fairly self explanatory - last class and fake bot features work best with respect limits enabled.

Sources/Installation

if you use the plugin posted here, be sure to:

L4D1

Place l4d_zcs.smx into sourcemod/plugins.
Place l4d_zcs.txt into sourcemod/gamedata.
l4d_zcs.cfg is auto generated and placed into cfg/sourcemod.

L4D2

Place l4d2_zcs.smx into sourcemod/plugins.
Place l4d2_zcs.txt into sourcemod/gamedata.
l4d2_zcs.cfg is auto generated and placed into cfg/sourcemod.

Github Sources:

master/sourcemod/l4d/zcs
master/sourcemod/l4d2/zcs

Important
If upgrading, be sure to remove the .cfg file then restart the server to ensure all cvar's are updated properly.
If compiling, version(s) 0.9.7+ contains syntax only compatible with sourcemod 1.8 or above.
Feedback/Bug reports

Of course no plugin is ever perfect, and there may be bugs (even though I've eradicated a great deal). So report them here and I will see what I can do - remember to provide as much information as possible (sourcemod version/plugin list/description of fault). I cannot guarantee perfect operation with all other plugins.