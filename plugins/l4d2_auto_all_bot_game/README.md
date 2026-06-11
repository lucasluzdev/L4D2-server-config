source: https://forums.alliedmods.net/showthread.php?p=2812331

Description
cvar "sb_all_bot_game" lets the server keep running even everyone idled or only bots per team in game, but after the last player left, the bots keep playing, it's uncontrollable and wasteful. so this plugin auto enable "sb_all_bot_game" on the first player join the server, and disable it on the last player left.

Cvars
PHP Code:
auto_all_bot_game_enable "1" 