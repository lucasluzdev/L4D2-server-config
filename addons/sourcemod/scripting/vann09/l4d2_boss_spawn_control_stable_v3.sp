#include <sourcemod>
#include <sdktools>
#include <left4dhooks>
#include <colors>

char mapName[64];

bool tankIsAlive = false;
bool witchIsAlive = false;

Handle g_hVsBossBuffer;

// =====================================================
// MAPS SEM TANK
// =====================================================

char restrictedTankMaps[][32] =
{
	"c5m5_bridge",
	"c7m1_docks",
	"c7m3_port",
	"c6m3_port",
	"c4m5_milltown_escape",
	"c13m2_southpinestream",
	"c8m5_rooftop",
	"c11m5_runway",
	"c8m1_apartment"
};

// =====================================================
// MAPS SEM WITCH
// =====================================================

char restrictedWitchMaps[][32] =
{
	"c6m1_riverbank",
	"c6m3_port",
	"c7m3_port",
	"c11m5_runway",
	"c8m5_rooftop",
	"c5m5_bridge"
};

// =====================================================
// MULTI BLOCK RULES
// =====================================================

enum struct BossBlockRule
{
	char map[32];
	int minPercent;
	int maxPercent;
}

// =====================================================
// TANK BLOCKS
// =====================================================

BossBlockRule g_TankBlockRules[] =
{
	// c1m1_hotel
	{ "c1m1_hotel", 0, 70 },

	// c1m3_mall
	{ "c1m3_mall", 60, 100 },

	{ "c2m2_fairgrounds", 70, 100 },

	{ "c2m3_coaster", 48, 75 },

	{ "c2m4_barns", 80, 100 },

	{ "c4m2_sugarmill_a", 70, 100 },

	{ "c4m3_sugarmill_b", 0, 30 },

	{ "c4m3_sugarmill_b", 75, 100 },

	{ "c5m1_waterfront", 70, 100 },

	{ "c5m2_park", 75, 100 },

	{ "c5m3_cemetery", 50, 70 },

	{ "c5m4_quarter", 70, 100 },

	{ "c6m2_bedlam", 60, 100 },

	{ "c7m2_barge", 80, 100 },

	{ "c8m1_apartment", 0, 70 },

	{ "c8m2_subway", 65, 100 },

	{ "c8m3_sewers", 0, 40 },

	{ "c8m3_sewers", 80, 100 },

	{ "c8m4_interior", 0, 30 },

	{ "c8m4_interior", 43, 70 },

	{ "c8m4_interior", 80, 100 },

	{ "c10m1_caves", 0, 30 },

	{ "c10m1_caves", 60, 100 },

	{ "c10m2_drainage", 65, 100 },

	{ "c10m3_ranchhouse", 75, 100},

	{ "c10m4_mainstreet", 70, 100 },

	{ "c11m1_greenhouse", 0, 30 },

	{ "c11m1_greenhouse", 50, 100 },

	{ "c11m2_offices", 0, 30 },

	{ "c11m2_offices", 75, 100 },

	{ "c11m3_garage", 75, 100 },

	{ "c11m4_terminal",  30, 50},

	{ "c11m4_terminal",  60, 100}
};

// =====================================================
// WITCH BLOCKS
// =====================================================

BossBlockRule g_WitchBlockRules[] =
{
	// c1m1_hotel
	{ "c1m1_hotel", 0, 60 },
};

public Plugin myinfo =
{
	name = "Boss Spawn Control",
	author = "pa4H, Vann09, ChatGPT",
	description = "Boss spawn controller with reroll and flow restrictions",
	version = "2.0",
	url = "https://t.me/pa4H232"
};

public void OnPluginStart()
{
	// =====================================================
	// PLAYER COMMANDS
	// =====================================================

	RegConsoleCmd("sm_boss", Command_BossFlow);
	RegConsoleCmd("sm_tank", Command_TankFlow);

	// =====================================================
	// ADMIN COMMANDS
	// =====================================================

	RegAdminCmd("sm_reroll", Command_Reroll, ADMFLAG_GENERIC);

	// =====================================================
	// EVENTS
	// =====================================================

	HookEvent("round_start", RoundStartEvent, EventHookMode_PostNoCopy);

	HookEvent("tank_spawn", TankNotify, EventHookMode_PostNoCopy);
	HookEvent("witch_spawn", WitchNotify, EventHookMode_PostNoCopy);

	HookEvent("player_death", TankDead, EventHookMode_Pre);

	g_hVsBossBuffer = FindConVar("versus_boss_buffer");

	LoadTranslations("boss_spawn_control.phrases");
}

public void RoundStartEvent(Event event, const char[] name, bool dontBroadcast)
{
	tankIsAlive = false;
	witchIsAlive = false;

	if (GameRules_GetProp("m_bInSecondHalfOfRound") == 0)
	{
		CreateTimer(0.4, AdjustBossFlow);
	}
}

public Action AdjustBossFlow(Handle timer)
{
	// =====================================================
	// ENABLE BOSSES
	// =====================================================

	L4D2Direct_SetVSTankToSpawnThisRound(0, true);
	L4D2Direct_SetVSTankToSpawnThisRound(1, true);

	L4D2Direct_SetVSWitchToSpawnThisRound(0, true);
	L4D2Direct_SetVSWitchToSpawnThisRound(1, true);

	GetCurrentMap(mapName, sizeof(mapName));

	// =====================================================
	// RESTRICTED TANK MAPS
	// =====================================================

	for (int i = 0; i < sizeof(restrictedTankMaps); i++)
	{
		if (StrEqual(restrictedTankMaps[i], mapName))
		{
			L4D2Direct_SetVSTankToSpawnThisRound(0, false);
			L4D2Direct_SetVSTankToSpawnThisRound(1, false);
			break;
		}
	}

	// =====================================================
	// RESTRICTED WITCH MAPS
	// =====================================================

	for (int i = 0; i < sizeof(restrictedWitchMaps); i++)
	{
		if (StrEqual(restrictedWitchMaps[i], mapName))
		{
			L4D2Direct_SetVSWitchToSpawnThisRound(0, false);
			L4D2Direct_SetVSWitchToSpawnThisRound(1, false);
			break;
		}
	}

	// =====================================================
	// RANDOMIZE
	// =====================================================

	if (L4D_IsMissionFinalMap())
	{
		randomSpawn(false);
	}
	else
	{
		if (GameRules_GetProp("m_bInSecondHalfOfRound") == 0)
		{
			randomSpawn(true);
		}
	}

	return Plugin_Stop;
}

// =====================================================
// RANDOM SPAWN
// =====================================================

public void randomSpawn(bool isRandom)
{
	float rndFlowTank;
	float rndFlowWitch;

	if (isRandom)
	{
		int gapPercent = GetRandomInt(10, 50);

		bool witchFirst = GetRandomInt(0, 1) == 1;

		int witchPercent;
		int tankPercent;

		if (witchFirst)
		{
			witchPercent = GetRandomInt(18, 85);
			tankPercent = witchPercent + gapPercent;

			if (tankPercent > 85)
			{
				tankPercent = 85;
				witchPercent = tankPercent - gapPercent;
			}
		}
		else
		{
			tankPercent = GetRandomInt(30, 85);
			witchPercent = tankPercent - gapPercent;

			if (witchPercent < 18)
			{
				witchPercent = 18;
				tankPercent = witchPercent + gapPercent;
			}
		}

		// =====================================================
		// TANK BLOCK CHECK
		// =====================================================

		int tankAttempts = 0;

		while (
			IsTankFlowBlocked(mapName, tankPercent) &&
			tankAttempts < 100
		)
		{
			tankPercent = GetRandomInt(30, 85);
			tankAttempts++;
		}

		// =====================================================
		// WITCH BLOCK CHECK
		// =====================================================

		int witchAttempts = 0;

		while (
			IsWitchFlowBlocked(mapName, witchPercent) &&
			witchAttempts < 100
		)
		{
			witchPercent = GetRandomInt(18, 85);
			witchAttempts++;
		}

		rndFlowTank = CalcFlow(tankPercent);
		rndFlowWitch = CalcFlow(witchPercent);
	}
	else
	{
		rndFlowTank = CalcFlow(15);
		rndFlowWitch = CalcFlow(15);
	}

	L4D2Direct_SetVSWitchFlowPercent(0, rndFlowWitch);
	L4D2Direct_SetVSWitchFlowPercent(1, rndFlowWitch);

	L4D2Direct_SetVSTankFlowPercent(0, rndFlowTank);
	L4D2Direct_SetVSTankFlowPercent(1, rndFlowTank);
}

// =====================================================
// !REROLL
// =====================================================

public Action Command_Reroll(int client, int args)
{
	if (L4D_HasAnySurvivorLeftSafeArea())
	{
		PrintToChat(
			client,
			"\x04[Boss]\x01 Survivors already left saferoom."
		);

		return Plugin_Handled;
	}

	randomSpawn(true);

	int round = GameRules_GetProp("m_bInSecondHalfOfRound");

	PrintToChatAll(
		"\x04[Boss]\x01 Boss spawns rerolled -> Tank: \x03%.0f%%\x01 | Witch: \x03%.0f%%",
		GetTankFlow(round) * 100.0,
		GetWitchFlow(round) * 100.0
	);

	return Plugin_Handled;
}

// =====================================================
// !BOSS
// =====================================================

public Action Command_BossFlow(int client, int args)
{
	ShowBossPercents(client);
	return Plugin_Handled;
}

// =====================================================
// !TANK
// =====================================================

public Action Command_TankFlow(int client, int args)
{
	ShowBossPercents(client);
	return Plugin_Handled;
}

// =====================================================
// DISPLAY BOSS INFO
// =====================================================

void ShowBossPercents(int client)
{
	if (client <= 0 || !IsClientInGame(client))
	{
		return;
	}

	int round = GameRules_GetProp("m_bInSecondHalfOfRound");

	bool tankEnabled =
		L4D2Direct_GetVSTankToSpawnThisRound(0) ||
		L4D2Direct_GetVSTankToSpawnThisRound(1);

	bool witchEnabled =
		L4D2Direct_GetVSWitchToSpawnThisRound(0) ||
		L4D2Direct_GetVSWitchToSpawnThisRound(1);

	// =====================================================
	// SURVIVOR FLOW
	// =====================================================

	float survivorFlow = GetSurvivorMaxFlowPercent();

	PrintToChat(
		client,
		"\x04[Boss]\x01 Survivors advanced: \x03%.0f%%",
		survivorFlow
	);

	// =====================================================
	// TANK
	// =====================================================

	if (tankEnabled)
	{
		PrintToChat(
			client,
			"\x04[Boss]\x01 Tank spawn: \x03%.0f%%",
			GetTankFlow(round) * 100.0
		);
	}
	else
	{
		PrintToChat(
			client,
			"\x04[Boss]\x01 Tank spawn: \x03None"
		);
	}

	// =====================================================
	// WITCH
	// =====================================================

	if (witchEnabled)
	{
		PrintToChat(
			client,
			"\x04[Boss]\x01 Witch spawn: \x03%.0f%%",
			GetWitchFlow(round) * 100.0
		);
	}
	else
	{
		PrintToChat(
			client,
			"\x04[Boss]\x01 Witch spawn: \x03None"
		);
	}
}

// =====================================================
// GET SURVIVOR MAX FLOW
// =====================================================

float GetSurvivorMaxFlowPercent()
{
	float bestFlow = 0.0;

	for (int i = 1; i <= MaxClients; i++)
	{
		if (
			IsClientInGame(i) &&
			GetClientTeam(i) == 2 &&
			IsPlayerAlive(i)
		)
		{
			float flow = L4D2Direct_GetFlowDistance(i);

			if (flow > bestFlow)
			{
				bestFlow = flow;
			}
		}
	}

	return (
		bestFlow /
		L4D2Direct_GetMapMaxFlowDistance()
	) * 100.0;
}

// =====================================================
// TANK BLOCK CHECK
// =====================================================

bool IsTankFlowBlocked(const char[] currentMap, int percent)
{
	for (int i = 0; i < sizeof(g_TankBlockRules); i++)
	{
		if (StrEqual(g_TankBlockRules[i].map, currentMap))
		{
			if (
				percent >= g_TankBlockRules[i].minPercent &&
				percent <= g_TankBlockRules[i].maxPercent
			)
			{
				return true;
			}
		}
	}

	return false;
}

// =====================================================
// WITCH BLOCK CHECK
// =====================================================

bool IsWitchFlowBlocked(const char[] currentMap, int percent)
{
	for (int i = 0; i < sizeof(g_WitchBlockRules); i++)
	{
		if (StrEqual(g_WitchBlockRules[i].map, currentMap))
		{
			if (
				percent >= g_WitchBlockRules[i].minPercent &&
				percent <= g_WitchBlockRules[i].maxPercent
			)
			{
				return true;
			}
		}
	}

	return false;
}

// =====================================================
// TANK ANNOUNCE
// =====================================================

public void TankNotify(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));

	if (!tankIsAlive)
	{
		tankIsAlive = true;

		PrecacheSound("ui/pickup_secret01.wav");
		EmitSoundToAll("ui/pickup_secret01.wav");

		if (IsFakeClient(client))
		{
			CPrintToChatAll("%t", "TankIsHereBOT");
		}
		else
		{
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsValidClient(i))
				{
					if (i == client)
					{
						CPrintToChat(i, "%t", "PassTankNotify");
					}
					else
					{
						CPrintToChat(i, "%t", "TankIsHere", client);
					}
				}
			}
		}
	}
}

// =====================================================
// WITCH ANNOUNCE
// =====================================================

public void WitchNotify(Event event, const char[] name, bool dontBroadcast)
{
	if (!witchIsAlive)
	{
		witchIsAlive = true;

		PrecacheSound("ui/beepclear.wav");
		EmitSoundToAll("ui/beepclear.wav");

		int round = GameRules_GetProp("m_bInSecondHalfOfRound");
		float witchFlow = GetWitchFlow(round) * 100.0;

		CPrintToChatAll("%t", "WitchIsHere", RoundToNearest(witchFlow));
	}
}

// =====================================================
// RESET FLAGS
// =====================================================

public void TankDead(Event event, const char[] name, bool dontBroadcast)
{
	int victim = GetClientOfUserId(event.GetInt("userid"));

	if (victim != 0 && GetClientTeam(victim) == L4D_TEAM_INFECTED)
	{
		int zClass = GetEntProp(victim, Prop_Send, "m_zombieClass");

		if (zClass == 8)
		{
			tankIsAlive = false;
		}

		if (zClass == 7)
		{
			witchIsAlive = false;
		}
	}
}

// =====================================================
// FLOW HELPERS
// =====================================================

float CalcFlow(int per)
{
	return ((float(per) + 0.01) / 100.0)
		+ GetConVarFloat(g_hVsBossBuffer) / L4D2Direct_GetMapMaxFlowDistance();
}

float GetTankFlow(int round)
{
	return L4D2Direct_GetVSTankFlowPercent(round)
		- GetConVarFloat(g_hVsBossBuffer) / L4D2Direct_GetMapMaxFlowDistance();
}

float GetWitchFlow(int round)
{
	return L4D2Direct_GetVSWitchFlowPercent(round)
		- GetConVarFloat(g_hVsBossBuffer) / L4D2Direct_GetMapMaxFlowDistance();
}

// =====================================================
// CLIENT CHECK
// =====================================================

stock bool IsValidClient(int client)
{
	if (
		client > 0 &&
		client <= MaxClients &&
		IsClientInGame(client) &&
		IsClientConnected(client) &&
		!IsFakeClient(client)
	)
	{
		return true;
	}

	return false;
}

// =====================================================
// MAP SCRIPT OVERRIDES
// =====================================================

public Action L4D_OnGetScriptValueInt(const char[] key, int &retVal)
{
	int val = retVal;

	if (StrEqual(key, "ProhibitBosses"))
	{
		val = 0;
	}

	if (StrEqual(key, "DisallowThreatType"))
	{
		val = 0;
	}

	if (StrEqual(key, "TankLimit"))
	{
		val = 1;
	}

	if (StrEqual(key, "WitchLimit"))
	{
		val = 1;
	}

	if (val != retVal)
	{
		retVal = val;
		return Plugin_Handled;
	}

	return Plugin_Continue;
}