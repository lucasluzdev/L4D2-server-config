#include <sourcemod>
#include <sdktools>
#include <left4dhooks>
#include <colors>

char mapName[64];

bool tankIsAlive = false;
bool witchIsAlive = false;

Handle g_hVsBossBuffer;

char restrictedMaps[][32] =
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

public Plugin myinfo =
{
	name = "Boss Spawn Control",
	author = "pa4H, Vann09",
	description = "Boss (Tank, Witch) spawn control with announcements and spawn gap",
	version = "1.3",
	url = "https://t.me/pa4H232"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_boss", getBossFlowsm, "");
	RegConsoleCmd("sm_tank", getBossFlowsm, "");
	RegConsoleCmd("sm_witch", getBossFlowsm, "");

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
	L4D2Direct_SetVSTankToSpawnThisRound(0, true);
	L4D2Direct_SetVSTankToSpawnThisRound(1, true);

	L4D2Direct_SetVSWitchToSpawnThisRound(0, true);
	L4D2Direct_SetVSWitchToSpawnThisRound(1, true);

	GetCurrentMap(mapName, sizeof(mapName));

	for (int i = 0; i < sizeof(restrictedMaps); i++)
	{
		if (StrEqual(restrictedMaps[i], mapName))
		{
			L4D2Direct_SetVSTankToSpawnThisRound(0, false);
			L4D2Direct_SetVSTankToSpawnThisRound(1, false);
			break;
		}
	}

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

public void randomSpawn(bool isRandom)
{
	float rndFlowTank;
	float rndFlowWitch;

	if (isRandom)
	{
		// Gap entre Tank e Witch
		int gapPercent = GetRandomInt(10, 50);

		// Ordem aleatória
		bool witchFirst = GetRandomInt(0, 1) == 1;

		int witchPercent;
		int tankPercent;

		if (witchFirst)
		{
			// Witch primeiro
			witchPercent = GetRandomInt(18,85);
			tankPercent = witchPercent + gapPercent;

			if (tankPercent > 85)
			{
				tankPercent = 85;
				witchPercent = tankPercent - gapPercent;
			}
		}
		else
		{
			// Tank primeiro
			tankPercent = GetRandomInt(30, 85);
			witchPercent = tankPercent - gapPercent;

			if (witchPercent < 18)
			{
				witchPercent = 18;
				tankPercent = witchPercent + gapPercent;
			}
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

public Action getBossFlowsm(int client, int args)
{
	int round = GameRules_GetProp("m_bInSecondHalfOfRound");

	if (L4D2Direct_GetVSTankToSpawnThisRound(0) || L4D2Direct_GetVSTankToSpawnThisRound(1))
	{
		PrintToChat(client, "\x01Tank spawn: [\x04%.0f%%\x01]", GetTankFlow(round) * 100);
	}
	else
	{
		PrintToChat(client, "\x01Tank spawn: [\x04None\x01]");
	}

	PrintToChat(client, "\x01Witch spawn: [\x04%.0f%%\x01]", GetWitchFlow(round) * 100);

	return Plugin_Handled;
}

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