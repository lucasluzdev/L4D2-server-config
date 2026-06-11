source: https://forums.alliedmods.net/showthread.php?p=2820368

description：
Relies on Steamwork for real player time

Thanks:
Many features reference this plugin

CVars:
PHP Code:
GetPlayerGametimeEnable : 1
//Enable plugin?,0=disable

ShowGametimeMode : 2
//What type of game duration is displayed to players? 1=hour and minute  2=Hours rounded to two decimal places

CheckPlayerGameCount : 8
//If for any possible reason it fails to get the player's real gametime, how many times should it be repeated to get the player's game time? 0=Disabled

LPWRequesting : 0
//If the player's real gametime is being acquired repeatedly. Does it move the player to spec? 0=disable

LPMWFailureGet : 0
//How to deal with players if repeatedly getting player real playtime fails?0=disable, 1=kick 2=move to spec

LPLateload : 1
//If LimitPlayer=1 and the plugin is not activated properly, does it cancel the behavior of various plugins that restrict the player due to real playertime?0=disable 1=enable

LimitPlayer : 1
//Are players who meet the gametime criteria prohibited from entering the server or entering the game? 0=disable 1=enable

LimitPlayerMinGametime : 1
//How long is the minimum prohibition for gametime players to enter the server or enter the game

LimitPlayerMaxGametime : 36000
//How long is the maximum prohibition for gametime players to enter the server or enter the game

LimitPlayerMode : 2
//If LimitPlayer is not 0, how will eligible players be processed? 1=kick out, 2=move to spec

ShowPlayerLerp : 1
//Show Player Lerp with gametime? 0=disable 1=enable

SPLMode : 1
//Whether to display player real playtime and Lerp information by player team 0=Output in player order

IfNeedLogKickMsg : 1
//Need Log Kick Auto Kick Player Message? 0:disable 
Please do not click "Get Plugin" but clickclick "GetPlayerGametime.smx" to get compiled plugin.

2025-6-26 19:56:10 fix some bug by deepseek