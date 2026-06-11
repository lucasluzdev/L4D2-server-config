source: https://forums.alliedmods.net/showthread.php?p=2826306

Description
With this plugin you are able to ignore all damage that occurs inside a safe room that is considered TK. You can configure whether this works in the initial safe room, the final safe room or both. You can also configure the team, Survivor, Infected or Both.

(If the attacker or the victim or both are inside the safe room the damage will be ignored)

Cvars

PHP Code:
// 0 = Disabled 
// 1 = First Safe room
// 2 = Second Safe room
// 3 = Both Safe room
// -
// Default: "3"
// Minimum: "0.000000"
// Maximum: "3.000000"
l4d_ffsaferoom "3"

// 1 = Both teams
// 2 = Survivor team
// 3 = Infected team
// -
// Default: "1"
// Minimum: "1.000000"
// Maximum: "3.000000"
l4d_ffsaferoom_team "1" 
Dependencies

Left4DHooks