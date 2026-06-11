source: https://forums.alliedmods.net/showthread.php?p=2836341


Code:
1. Requirements:
   - SourceMod 1.12

2. Files to download:
   Required:
   - kick.smx
   - kick.sp

3. Installation:
   - Place kick.smx in: addons/sourcemod/plugins/
   - Place kick.sp in: addons/sourcemod/scripting/

4. Admin Commands:
   - !k - Opens kick menu to remove players from the server
   - !b - Opens ban menu to ban players until server restart

5. Features:
   - Simple menu-based player management
   - Temporary bans that persist until server restart
   - Automatic rejection of banned players attempting to reconnect

6. Admin Access Required:
   - ADMFLAG_KICK for kick menu access
   - ADMFLAG_BAN for ban menu access

7. Notes:
   - Bans are temporary and will be cleared when the server restarts
   - Banned players receive "Banned by admin" message when attempting to connect