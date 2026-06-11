source: https://forums.alliedmods.net/showthread.php?p=834731

This plugin will execute a config file based on the current game play mode. Because I like Versus tweaked for a higher difficulty than a coop game, I use this to do that, but leave coop up to the lobby settings. Also, the survivor mode, I think, shouldn't have any adjustments made to it. This plugin gives me that ability.

Notes
Left 4 Dead will change the game type automatically when someone hosts a lobby for a specific game type and then ends up connecting to your server.

The z_difficulty CVAR used to determine the difficulty for co-op uses the values Easy, Normal, Hard, Impossible. While the UI in the game uses Easy, Normal, Advanced, Expert. I set the names of the config files (default) to match the z_difficulty CVAR value, while the description of the coop - difficulty script CVARs matches the UI text.

If a game mode is selected which is not used by the hardcoded cfg files (see the cvars) it will automatically look for a .cfg file that matches the game mode text. To figure this out, configure your lobby as desired, start the game in the server then check the hidden mp_gamemode cvar for the value. Then create a .cfg file with the same file name as cvar value.

CVARs
gamemode_config_ver - Version of this plugin.

gamemode_resetconvars - Resets the console vars () before executing the config
gamemode_config_coop - CFG file to execute when game mode is coop - Default: coop.cfg
gamemode_config_versus - CFG file to execute when game mode is versus - Default: versus.cfg
gamemode_config_teamversus - CFG file to execute when game mode is teamversus. - Default teamversus.cfg
gamemode_config_survival - CFG file to execute when game mode is survival - Default survival.cfg
gamemode_config_realism - CFG file to execute when game mode is realism. - Default realism.cfg
gamemode_config_scavenge - CFG file to execute when game mode is scavenge. - Default scavenge.cfg
gamemode_config_teamscavenge - CFG file to execute when game mode is teamscavenge. - Default teamscavenge.cfg

gamemode_config_coop_easy - CFG file to execute when game mode is coop and the difficulty is Easy. - Default: coop_easy.cfg
gamemode_config_coop_normal - CFG file to execute when game mode is coop and the difficulty is Normal. - Default: coop_normal.cfg
gamemode_config_coop_hard - CFG file to execute when game mode is coop and the difficulty is Advanced. - Default: coop_hard.cfg
gamemode_config_coop_impossible - CFG file to execute when game mode is coop and the difficulty is Expert. - Default: coop_impossible.cfg

The values are used by the plugin to call the exec console command: exec [value].

Thanks to DJ Tsunami for getting me started. 