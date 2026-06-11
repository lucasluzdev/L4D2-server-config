source: https://forums.alliedmods.net/showthread.php?p=2674048

Description

This plugin was made only to display multiple publicity/announces on chat-only, with game available chat colors

ConVar

"l4d2_publicity_time", "120", "How long must wait to display each publicity (default 2 min = 120 seconds)"


To compile you will need colors.inc Attached.


Quick installation guide:

Place l4d2_publicity.smx into /left4dead2/addons/sourcemod/plugins/
edit and place l4d2_publicity.txt into /left4dead2/addons/sourcemod/data/

load plugin. : )

example:

"publicity" {

    "1" {
          
           "msg"            "{orange}Welcome {olive}to {default}Alliedmodders" 
 
         }

    "2" {
          
           "msg"            "{red}Server Network: {default}https://forums.alliedmods.net" 
 
         }

    "3" {
          
           "msg"            "{blue}Tip{default}: {orange}Enjoy" 
 
         }



} 