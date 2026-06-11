source: https://forums.alliedmods.net/showthread.php?p=2700212

About:
Thanks to "SilentBr" for testing.
Thanks to "KasperH" for Hungarian translations.
Thanks to "Kleiner" for Russian translations.
Thanks to "Toranks" for testing and Spanish translations.
Thanks to "Voevoda" for testing and updated Russian translation.
Thanks to "in2002" for Traditional Chinese translations.
Thanks to "CIKK for Simplified Chinese translations.
Various optional features:
Lock the first saferoom door for X seconds (1st and 2nd round with different time cvars).
Prevent closing the first saferoom door once opened.
Prevent players opening or closing the last saferoom door after being used for X seconds. Use the l4d_safe_spam_time_close and l4d_safe_spam_time_open cvars.
Make the first saferoom door automatically fall, use the l4d_safe_spam_fall_time cvar.
Can set the door model for all maps, use the l4d_safe_spam_skin cvar.




Admin Commands:
Requires "z" - ADMFLAG_ROOT flag
PHP Code:
sm_door_drop    // Test command to make a targeted door fall over (will likely only work correctly on Saferoom doors).
sm_door_fall    // Test command to make the first locked saferoom door fall over (will likely only work correctly on Saferoom doors). 


CVars:

Saved to l4d_safe_spam.cfg in your servers \cfg\sourcemod\ folder.

PHP Code:
l4d_safe_spam_allow          "1"       // 0=Plugin off, 1=Plugin on.
l4d_safe_spam_modes          ""        // Turn on the plugin in these game modes, separate by commas (no spaces). (Empty = all).
l4d_safe_spam_modes_off      ""        // Turn off the plugin in these game modes, separate by commas (no spaces). (Empty = none).
l4d_safe_spam_modes_tog      "0"       // Turn on the plugin in these game modes. 0=All, 1=Coop, 2=Survival, 4=Versus, 8=Scavenge. Add numbers together.
l4d_safe_spam_fall_time      "10.0"    // 0.0=Off. How many seconds after round start (or after unlocking by l4d_safe_spam_lock* and l4d_safe_spam_lock* cvars) until the locked saferoom door will automatically fall.
l4d_safe_spam_freeze         "0"       // 0=Off. Any other value is the number of seconds to freeze Survivors on maps that begin without a saferoom. Also prevents players taking damage during this time.
l4d_safe_spam_freeze2        "1"       // 0=Off. 1=Display a message showing the timer until movement is allowed.
l4d_safe_spam_glow           "255 0 0" // 0=Off. Three values between 0-255 separated by spaces. RGB Color255 - Red Green Blue.
l4d_safe_spam_hint           "3"       // 0=Off. 1=Display a message showing who opened or closed the saferoom door. 2=Display a message when saferoom door is auto unlocked (_touch and _lock cvars). 3=Both.
l4d_safe_spam_hints          "1"       // Where should the countdown notifications display when attempting to open a locked door. 1=Chat. 2=Hint box.
l4d_safe_spam_last           "0"       // Final door state on round start: 0=Use map default. 1=Close last door. 2=Open last door.
l4d_safe_spam_lock           "30.0"    // 0.0=Off. How many seconds after round start will the saferoom door remain locked.
l4d_safe_spam_lock_2         "10.0"    // 0.0=Off. How many seconds after round start will the saferoom door remain locked. For the second+ round of a map.
l4d_safe_spam_open           "2"       // 0=Off, 1=Keep the first saferoom door open and prevent closing, 2=Make the first saferoom door fall once opened, 3=Automatically open without falling after l4d_safe_spam_fall_time seconds, 4=Auto open and prevent closing again.
l4d_safe_spam_physics        "3.0"     // 0.0=Always has physics. How many seconds until the fallen doors physics are disabled.
l4d_safe_spam_skin           "0"       // 0=Map default. 1=Classic. 2=Last Stand. Which door model to use on the first and last saferooms.
l4d_safe_spam_time_close     "1.0"     // How many seconds to block after closing the last saferoom door.
l4d_safe_spam_time_open      "3.0"     // How many seconds to block after opening the last saferoom door.
l4d_safe_spam_touch          "0.0"     // 0.0=Off. How many seconds after attempting to open the locked saferoom door until it will fall (overrides the l4d_safe_spam_fall_time cvar).
l4d_safe_spam_touch_2        "0.0"     // 0.0=Off. How many seconds after attempting to open the locked saferoom door until it will fall (overrides the l4d_safe_spam_fall_time cvar). For the second+ round of a map.
l4d_safe_spam_type           "3"       // 0=Off. When the last saferoom door is used enable the timeout on: 1=Open, 2=Close, 3=Both.
l4d_safe_spam_version        // Saferoom Door Spam Protection plugin version 


Changes:
Code:
1.32 (05-Nov-2024)
    - Changed cvar "l4d_safe_spam_open" to allow automatic first saferoom door opening without falling. Requested by "Slaven555".

1.31 (21-Apr-2024)
    - Fixed the saferoom door locking after opening due to player spam.
    - Fixed rare bug where the saferoom door would not fall.
    - Thanks to "Picola" for reporting and testing.

1.30 (10-Jan-2024)
    - Fixed the "l4d_safe_spam_modes_tog" cvar detecting Versus and Survival modes incorrectly.
    - Added Simplified Chinese (chi) translations. Thanks to "CIKK" for providing.

1.29 (20-Dec-2023)
    - Delays showing the movement blocked message during campaign intros. Thanks to "Hawkins" for adding.

1.28 (27-Jul-2023)
    - Added cvar "l4d_safe_spam_freeze" to freeze players on maps which have no starting saferoom. Requested by "etozhesandy".
    - Translation file for English has been updated.

1.27 (07-Dec-2022)
    - L4D1: Plugin no longer teleports the door. This is to prevent breaking the "player_entered_checkpoint" event.

1.26 (28-Oct-2022)
    - L4D1: Locked saferoom doors color are now set by the "l4d_safe_spam_glow" cvar.

1.25a (27-Aug-2022)
    - Added Traditional Chinese (zho) translations. Thanks to "in2002" for providing.

1.25 (12-Aug-2022)
    - Added cvar "l4d_safe_spam_hints" to control where to print the door locked countdown. Requested by "Erika Santos".

1.24 (20-Jun-2022)
    - Changed the "modes" cvars gamemode detection method to use "Left4DHooks" forwards and natives instead of creating an entity.

1.23 (25-May-2022)
    - Fixed not removing the glow when the door is auto unlocked and ready to be opened.

1.22 (20-May-2022)
    - L4D2: Added cvar "l4d_safe_spam_glow" to make the first saferoom door glow when locked.
    - Fixed not removing the auto unlock timer on round end.

1.21 (10-May-2022)
    - Now requires "Left4DHooks" plugin version 1.101 or newer to accurately get the first and last saferoom doors.

    - Added Spanish translations. Thanks to "Toranks" for providing.
    - Changed cvar "l4d_safe_spam_fall_time" to make the saferoom door fall after "l4d_safe_spam_fall_touch*" and "l4d_safe_spam_lock*" cvars unlock the door.
    - Fixed the plugin not locking the first saferoom door when the "l4d_safe_spam_open" cvar was set to "0".
    - Fixed not always preventing doors from being locked on certain levels.
    - Fixed some conflicts when the last saferoom door was locked by other plugins. Thanks to "Voevoda" for reporting.

    - Thanks to "Voevoda" and "Toranks" for testing.

1.20 (09-May-2022)
    - Fixed the saferoom door not unlocking when the "l4d_safe_spam_fall_touch" cvars are 0.0.
    - Fixed the saferoom door auto falling before the timer expires when only using the "l4d_safe_spam_lock" cvars.
    - Time hint until unlocked is now only displayed once per second. These hints are only shown to the user attempting to open the saferoom door.

1.19 (08-May-2022)
    - Added cvars "l4d_safe_spam_fall_touch" and "l4d_safe_spam_fall_touch_2" to determine how long after someone tries to open the first saferoom door before it falls.
    - Added cvars "l4d_safe_spam_lock" and "l4d_safe_spam_lock_2" to determine how long the first saferoom door should remain locked after round start.
    - Both cvars allow for setting the time on the second round of versus and for round restarts in coop.
    - Changed cvar "l4d_safe_spam_hint" to allow showing hints when the saferoom door is automatically opened.
    - Thanks to "Voevoda" for the feature requests and lots of help testing.

    - Translation files updated. Thanks to "KasperH" and "Voevoda" for updating the Hungarian and Russian translations respectively.


1.18 (01-Sep-2021)
    - Fixed a 2nd door dropping when used enough Thanks to "Primeas" for reporting.
    - Fixed "in solid list (not solid)" server console spam. Thanks to Tonblader for reporting.

1.17 (26-Aug-2021)
    - Fixed the door sometimes interfering instead of being non-solid. Thanks to "Ja-Forces" for reporting.

1.16 (26-Aug-2021)
    - Fixed crashing in L4D1. Thanks to "Ja-Forces" for reporting.
    - Restricted the "l4d_safe_spam_skin" cvar to L4D2 only.

1.15 (26-Aug-2021)
    - Fixed playing the incorrect unlock sound when the "l4d_safe_spam_open" cvar was set to "0". Thanks to "TBK Duy" for reporting.

1.14 (24-Aug-2021)
    - Fixed using the wrong falling sounds when changing door skins. Thanks to "Tonblader" for reporting.

1.13 (21-Aug-2021)
    - Fixed using the wrong door sounds when changing door skins. Thanks to "Tonblader" for reporting.
    - Fixed some doors falling the wrong way when changing door skins. Thanks to "Tonblader" for reporting.
    - Fixed some doors using the wrong angle when changing door skins.
    - Fixed the saferoom door auto falling if the "l4d_safe_spam_open" cvar was set to 1.

1.12a (17-Aug-2021)
    - Added Hungarian translations. Thanks to "KasperH" for providing.

1.12 (13-Aug-2021)
    - Added cvar "l4d_safe_spam_skin" to control the skin of Saferoom Doors. Requested by "Tonblader".

1.11 (05-Jul-2021)
    - L4D2: plugin compatibility update with "[L4D2] Saferoom Lock: Scavenge" plugin by "Eärendil" version 1.2+ only.
    - Thanks to "GL_INS" for reporting and testing.
    - Thanks to "Eärendil" for supporting the compatibility.

    - Changed method of locking doors after opening/closing. No more hackish workarounds.
    - Fixed some saferoom doors falling the wrong way when "l4d_safe_spam_physics" cvar was enabled.
    - Should now correctly detect the starting saferoom door for auto falling. Thanks to "Krevik" for reporting.

1.10 (30-Jun-2021)
    - Fixed the saferoom door not auto falling on some maps.
    - Now displays the handle falling.
    - Now swaps attachments from the old door to the new door.
    - Now supports multiple ending saferoom doors.

1.9 (26-Jun-2021)
    - Fixed cvar "l4d_safe_spam_fall_time" value "0.0" from making the door auto fall. Thanks to "Primeas" for reporting.

1.8 (21-Jun-2021)
    - Fixed not using an entity reference which could rarely throw errors otherwise.

    - Modified update from "pan0s" adding auto falling saferoom door feature.
    - Added cvar "l4d_safe_spam_fall_time" to control if the first saferoom door auto falls.
    - Added command "sm_door_last" to make a locked saferoom door fall over. Should mostly be the first saferoom door.

1.7 (15-Feb-2021)
    - Added cvar "l4d_safe_spam_physics" to allow the doors physics to persist or freeze after a specified amount of time. Requested by "yzybb".
    - Added Russian translations. Thanks to "Kleiner" for providing.

1.6 (05-Oct-2020)
    - Added cvar "l4d_safe_spam_last" to control the last saferoom door state on round start: opened, closed or map default. Thanks to "Tonblader" for requesting.

1.5 (20-Sep-2020)
    - Blocked door falling on L4D2 "Questionable Ethics" 2nd map (qe2_ep2) to prevent breaking gameplay. Thanks to "Alex101192" for reporting.
    - Fixed the door not always falling in the right direction on some maps.

1.4 (20-Sep-2020)
    - Added a sound effect for when the door breaks and falls.
    - Fixed the door not always falling on some maps.

1.3 (18-Sep-2020)
    - Changed cvar "l4d_safe_spam_open" adding option "2" to make the door fall. Thanks to "yzybb" for requesting.

1.2 (05-Jun-2020)
    - Added cvar "l4d_safe_spam_hint" to control displaying messages when saferoom doors are opened/closed.
    - Added translations support. Thanks to "Tonblader" for requesting.

1.1 (15-May-2020)
    - Initial release.

1.0 (30-Aug-2013)
    - Initial creation.


Updating from 1.27 or older:
New cvars have been added: use the Cvar Configs Updater, or delete the old cvars config or manually add them.

Requirements:
Uses Left 4 DHooks Direct plugin. Won't work without.