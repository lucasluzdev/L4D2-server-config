source: https://forums.alliedmods.net/showthread.php?p=2681728

Info:
This plugin provides a menu panel for display server information to players.
It may useful for custom servers with lots of modifications.

When joined to custom server, it seems that there are some people get confuse for lots of changes.
Then sadly, a few people leave the game because of that.
And also I'm one of them.
On part of servers, they wrote what they customized,
but even I felt hassle to read them all.
Then I thought that it's okay if information are easy to read and
players could get information they wanted.
So I made this to solve these problems.
Features:
A menu that able to customize, translate, and categorize information to 7.
Text color supported.
Helps players understand changes smoothly.

Usage:
All examples and tutorials are written on menu.
Install the plugin, start game, and try say "!helpmenu" in chat.

If you want to reload translation file quickly, use "sm_reload_translations"
Commands:
PHP Code:
//Show sip help menu.
sm_helpmenu

//Reset note count for all players.
//Require "c" or higher flag.
sm_sip_note_resetCount 
Cvars:
PHP Code:
// [1:Enable], [0:Disable]
// Default: "1"
sm_sip_enable "1"

// Whether to force player to open menu when player joined. [0:Don't Open] [1:Open]
// Default: "1"
sm_sip_forceOpen "1"

// How many times show note message.
// Default: "3"
sm_sip_noteMax "3"

// When show note message to player.
//[(Empty):Disable], [1:on joined], [2:on opened menu], [3:on closed menu], [4:on map start]
// Default: "1234"
sm_sip_noteTiming "1234"

// Way of showing note message.Input numbers you want to use.
//[(Empty):Disable], [1:Chat], [2:Hint Message], [3:Instructer Hint]
// Default: "123"
sm_sip_noteType "123"

// Whether to reset note count on map chenged [0:Don't Reset] [1:Reset]
// Default: "1"
sm_sip_note_resetPerRound "1"

// Color of instructer hint that shown by note message.
//[R G B](0-255)
// Default: "255 255 0"
sm_sip_note_instructorColor "255 255 0"

// Whether to draw partition line of message. [(Empty:Disable)] [1:Draw Before] [2:Draw After]
// Default: "12"
sm_sip_partition "12"

// Whether to show top message(Tag + Item Name). [0:Disable] [1:Enable]
// Default: "1"
sm_sip_top "1" 