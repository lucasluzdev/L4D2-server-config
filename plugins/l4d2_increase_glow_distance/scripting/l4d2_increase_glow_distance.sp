#include <sourcemod>
#include <sdktools>
#include <left4downtown>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "1.0"

// Default values - change these cvars after plugin loads
#define DEFAULT_GLOW_RANGE 4000      // Maximum distance to see survivor glow
#define DEFAULT_GLOW_MIN_RANGE 0     // Minimum distance (glow always visible if closer than this)

int g_iGlowRange = DEFAULT_GLOW_RANGE;
int g_iGlowRangeMin = DEFAULT_GLOW_MIN_RANGE;

public Plugin myinfo = 
{
    name = "Survivor Glow Distance Enhancer",
    author = "Vann09",
    description = "Increases survivor glow visibility distance while preserving Versus stealth mechanics",
    version = PLUGIN_VERSION,
    url = ""
};

public void OnPluginStart()
{
    // Create console variables for server admins
    g_iGlowRange = CreateConVar("survivor_glow_range", "2500", "Maximum distance to see survivor glow (0 = infinite)", 0, true, 0.0);
    g_iGlowRangeMin = CreateConVar("survivor_glow_min_range", "0", "Minimum distance before glow starts fading", 0, true, 0.0);
    
    AutoExecConfig(true, "survivor_glow_distance");
    
    HookEvent("player_spawn", Event_PlayerSpawn);
    HookEvent("player_bot_replace", Event_PlayerReplace);
    HookEvent("bot_player_replace", Event_PlayerReplace);
}

public void OnMapStart()
{
    // Refresh all survivors on map start
    for (int i = 1; i <= MaxClients; i++)
    {
        if (IsClientInGame(i) && GetClientTeam(i) == TEAM_SURVIVOR)
        {
            SetSurvivorGlowRange(i);
        }
    }
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    if (client && GetClientTeam(client) == TEAM_SURVIVOR)
    {
        SetSurvivorGlowRange(client);
    }
}

public void Event_PlayerReplace(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("player"));
    if (client && IsClientInGame(client) && GetClientTeam(client) == TEAM_SURVIVOR)
    {
        CreateTimer(0.1, Timer_RefreshGlow, GetClientUserId(client));
    }
}

public Action Timer_RefreshGlow(Handle timer, int userid)
{
    int client = GetClientOfUserId(userid);
    if (client && IsClientInGame(client) && GetClientTeam(client) == TEAM_SURVIVOR)
    {
        SetSurvivorGlowRange(client);
    }
    return Plugin_Stop;
}

void SetSurvivorGlowRange(int client)
{
    if (!IsValidEntity(client)) return;
    
    int range = GetConVarInt(g_iGlowRange);
    int minRange = GetConVarInt(g_iGlowRangeMin);
    
    // Set the glow range properties on the survivor entity
    // m_nGlowRange = maximum distance to see the glow (0 = infinite)
    // m_nGlowRangeMin = distance where glow starts (glow is fully visible within this range)
    SetEntProp(client, Prop_Send, "m_nGlowRange", range);
    SetEntProp(client, Prop_Send, "m_nGlowRangeMin", minRange);
    
    // Ensure the survivor has a glow type set (3 = full body outline)
    // If the game hasn't set one yet, this enables it
    int currentGlowType = GetEntProp(client, Prop_Send, "m_iGlowType");
    if (currentGlowType == 0)
    {
        SetEntProp(client, Prop_Send, "m_iGlowType", 3);
    }
}