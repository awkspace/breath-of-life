#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "1.0.0"

public Plugin myinfo = {

  name        = "Breath of Life",
  author      = "awk",
  description = "Healbeams now grant you air",
  version     = PLUGIN_VERSION,
  url         = "https://github.com/awkspace/breath-of-life"

}

public void OnGameFrame() {

  for (int client = 1; client <= MaxClients; client++) {
    if (IsValidClient(client) && IsPlayerAlive(client)) {

      if (GetEntProp(client, Prop_Send, "m_nNumHealers") > 0) {

        // Reset our air timer.
        SetEntPropFloat(client, Prop_Data, "m_AirFinished", GetGameTime() + 7.0);

        // Disable health recovery. We're already being healed
        // and it may be a long time before we resurface.
        SetEntProp(client, Prop_Data, "m_idrownrestored",
          GetEntProp(client, Prop_Data, "m_idrowndmg"));
          
      }

    }
  }

}

bool IsValidClient(int client) {

  return (IsClientConnected(client) && IsClientInGame(client) &&
    !IsClientReplay(client) && !IsClientSourceTV(client));

}
