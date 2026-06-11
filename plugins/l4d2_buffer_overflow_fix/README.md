source: https://forums.alliedmods.net/showthread.php?t=309656

About:
This plugin fixes servers with too many ConVars, which causes a buffer overflow error in server console and the overflowed ConVars to use their default value instead of the one specified.
This should also fix commands which failed to be executed caused by the same buffer overflow.
Note: If your server is hibernating the fix will happen on the next frame when it wakes.
Initial thread and plugin version here.
This fixes "Cbuf_AddText: buffer overflow" error messages.



Related Plugins:
Cvar Configs Updater - Good for updating convar configs to add new convars, and remove unused ones
ConVars Anomaly Fixer - Good for checking and testing convars and configs for errors.



Supported Games:
CS:S
CSGO
L4D1
L4D2
OrangeBox [GoldenEye etc]
Team Fortress 2
Request support if your game suffers from this bug.



Thanks:
Peace-Maker (for DHooks Dev Preview and helping script this plugin).
Dr!fter (for initially creating DHooks extension).
Dragokas (optimizations , helping me understand the .cpp files and functions).
Lux (various scripting advice and helping figure out stuff).
Timocop (L4D1 Linux binary and testing).



ConVar Testing:
Spoiler 
To create 5000 cvars for testing if your server requires fixing, or to check the fix has worked:
Change DEBUGGING 0 to DEBUGGING 1 in this plugins source.
Recompile and install.
Change map or restart the server so the cvar config is auto-generated.
Edit \cfg\sourcemod\sm_cvar_test.cfg and replace all "0" with "1".
Change map so the server can attempt to read the changed cvar values.
Run the "sm_cvar_test" command to test.




ConVars:

PHP Code:
// Command and ConVar - Buffer Overflow Fixer plugin version.
command_buffer_version 