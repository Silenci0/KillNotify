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

#define PLUGIN_VERSION "1.2"

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
    // If the userid is invalid, it must mean the player does not exist we can't continue.
    if (attacker == 0)
    {
        return Plugin_Handled;
    }
        
    // Get the attacker's team.
    new atkteam = GetClientTeam(attacker);
    
    // Get the weapon used to kill the poor victim.
    decl String:sWpnName[32];
    GetEventString(event, "weapon", sWpnName, sizeof(sWpnName));
    
    // A large list of weapons to rename here! 
    // If a weapon shows up that isn't listed to be changed, the actual
    // weapon name will show up in the player's chat.
    if (StrEqual(sWpnName,"grenade_frag"))
    {
        sWpnName = "Grenade";
    }
    else if (StrEqual(sWpnName,"slam"))
    {
        sWpnName = "IED";
    }
    else if (StrEqual(sWpnName,"870"))
    {
        sWpnName = "Remington 870";
    }
    else if (StrEqual(sWpnName,"spanner"))
    {
        sWpnName = "Wrench";
    }
    else if (StrEqual(sWpnName,"golf"))
    {
        sWpnName = "Golf Club";
    }
    else if (StrEqual(sWpnName,"bat_wood"))
    {
        sWpnName = "Bat (Wood)";
    }
    else if (StrEqual(sWpnName,"bat_aluminum"))
    {
        sWpnName = "Bat (Aluminum)";
    }
    else if (StrEqual(sWpnName,"ak47"))
    {
        sWpnName = "AK-47";
    }
    else if (StrEqual(sWpnName,"axe"))
    {
        sWpnName = "Axe";
    }
    else if (StrEqual(sWpnName,"chair"))
    {
        sWpnName = "Chair";
    }
    else if (StrEqual(sWpnName,"crowbar"))
    {
        sWpnName = "Crowbar";
    }
    else if (StrEqual(sWpnName,"fryingpan"))
    {
        sWpnName = "Frying Pan";
    }
    else if (StrEqual(sWpnName,"glock"))
    {
        sWpnName = "Glock 17";
    }
    else if (StrEqual(sWpnName,"glock18c"))
    {
        sWpnName = "Glock 18c";
    }
    else if (StrEqual(sWpnName,"keyboard"))
    {
        sWpnName = "Keyboard";
    }
    else if (StrEqual(sWpnName,"m4"))
    {
        sWpnName = "M4";
    }
    else if (StrEqual(sWpnName,"machete"))
    {
        sWpnName = "Machete";
    }
    else if (StrEqual(sWpnName,"mp5"))
    {
        sWpnName = "MP5";
    }
    else if (StrEqual(sWpnName,"pipe"))
    {
        sWpnName = "Pipe";
    }
    else if (StrEqual(sWpnName,"plank"))
    {
        sWpnName = "Wooden Plank";
    }
    else if (StrEqual(sWpnName,"pot"))
    {
        sWpnName = "Pot";
    }
    else if (StrEqual(sWpnName,"ppk"))
    {
        sWpnName = "PPK";
    }
    else if (StrEqual(sWpnName,"revolver"))
    {
        sWpnName = "Revolver";
    }
    else if (StrEqual(sWpnName,"shovel"))
    {
        sWpnName = "Shovel";
    }
    else if (StrEqual(sWpnName,"machete"))
    {
        sWpnName = "Machete";
    }
    else if (StrEqual(sWpnName,"sledgehammer"))
    {
        sWpnName = "Sledgehammer";
    }
    else if (StrEqual(sWpnName,"supershorty"))
    {
        sWpnName = "Super Shorty";
    }
    else if (StrEqual(sWpnName,"tireiron"))
    {
        sWpnName = "Tire Iron";
    }
    else if (StrEqual(sWpnName,"torque"))
    {
        sWpnName = "Torque";
    }
    else if (StrEqual(sWpnName,"usp"))
    {
        sWpnName = "USP";
    }
    else if (StrEqual(sWpnName,"winchester"))
    {
        sWpnName = "Winchester";
    }
    else
    {
        // Do nothing!
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