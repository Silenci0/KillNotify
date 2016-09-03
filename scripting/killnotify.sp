/************************************************************************
*************************************************************************
[ZPS] Kill Notifications
Description:
	Displays a message to all players with information on who was
    killed by a player, the team they were on represented by color 
    (Green = Zombies, Blue = Survivors), and which weapon was used 
    to kill that player.
    
Original author:
    Kana
    
Updated by:
    Mr. Silence
    
*************************************************************************
*************************************************************************
This plugin is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the License, or
later version. 

This plugin is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this plugin.  If not, see <http://www.gnu.org/licenses/>.
*************************************************************************
*************************************************************************/
#pragma semicolon 1

#include <sourcemod>
#include <colors>

#define PLUGIN_VERSION "1.1"

#define SURVIVORTEAM    2
#define ZOMBIETEAM		3

public Plugin:myinfo = {
    name = "[ZPS] Kill Notifications",
    author = "Original: Kana, Updated by: Mr. Silence",
    description = "Displays who killed a player and with what weapon.",
    version = PLUGIN_VERSION,
    url = "http://forums.alliedmods.net"
};

public OnPluginStart()
{
    CreateConVar("sm_zpskillnotify_version", PLUGIN_VERSION, "[ZPS] Kill Notifications Version", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
    HookEvent("player_death", event_PlayerDeath);
}

public Action:event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
    new victim = GetClientOfUserId(GetEventInt(event, "userid"));
    new attacker = GetClientOfUserId(GetEventInt(event, "attacker"));

    // Don't display messages based on suicides and such.
    if (victim == attacker)
    {
        return Plugin_Handled;
    }
    
    // If the userid is invalid, we can't continue.
    if (attacker == 0)
    {
        return Plugin_Handled;
    }
        
    // Get the attacker's team.
    new atkteam = GetClientTeam(attacker);
    
    // Get the weapon used to kill the poor victim.
    decl String:sWpnName[32];
    GetEventString(event, "weapon", sWpnName, sizeof(sWpnName));
    
    // For weapons that are known to the community by other names, 
    // find their strings then set them accordingly.
    if (StrEqual(sWpnName,"grenade_frag"))
    {
        sWpnName = "grenade";
    }
    if (StrEqual(sWpnName,"slam"))
    {
        sWpnName = "IED";
    }
    if (StrEqual(sWpnName,"870"))
    {
        sWpnName = "remington";
    }
    if (StrEqual(sWpnName,"spanner"))
    {
        sWpnName = "wrench";
    }
    if (StrEqual(sWpnName,"golf"))
    {
        sWpnName = "golf club";
    }

    // Display messages with colors based on team involved.
    if (atkteam == ZOMBIETEAM)
    {
        CPrintToChatAllEx(victim, "{green}%N {default}killed {teamcolor}%N {default}", attacker, victim);
        return Plugin_Handled;
    }
    else if (atkteam == SURVIVORTEAM)
    {
        CPrintToChatAllEx(attacker, "{teamcolor}%N {default}killed {green}%N {default}with a %s", attacker, victim, sWpnName);
        return Plugin_Handled;
    }
    else
    {
        // Do Nothing.
    }

    return Plugin_Handled;
}