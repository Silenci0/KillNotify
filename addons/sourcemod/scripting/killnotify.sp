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
#include <morecolors>

#pragma newdecls required

#define PLUGIN_VERSION "1.6.0"
#define SURVIVORTEAM    2
#define ZOMBIETEAM      3

public Plugin myinfo = {
    name = "[ZPS] Kill Notifications",
    author = "Original: Kana, Updated by: Mr. Silence",
    description = "Displays who killed a player and with what weapon.",
    version = PLUGIN_VERSION,
    url = "https://github.com/Silenci0/KillNotify"
};

public void OnPluginStart()
{
    CreateConVar("sm_zpskillnotify_version", PLUGIN_VERSION, "[ZPS] Kill Notifications Version", FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);
    HookEvent("player_death", event_PlayerDeath);
}

public Action event_PlayerDeath(Handle event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(GetEventInt(event, "userid"));
    int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));

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
    int atkteam = GetClientTeam(attacker);
    
    // Get the weapon used to kill the poor victim.
    char sWpnName[32];
    GetEventString(event, "weapon", sWpnName, sizeof(sWpnName));
    
    // A large list of weapons to rename here! 
    // If a weapon shows up that isn't listed to be changed, the actual weapon name will show up in the player's chat.
    if (StrEqual(sWpnName,"frag"))
    {
        sWpnName = "a {green}Grenade";
    }
    else if (StrEqual(sWpnName,"ied"))
    {
        sWpnName = "an {green}IED";
    }
    else if (StrEqual(sWpnName,"870"))
    {
        sWpnName = "a {green}Remington 870";
    }
    else if (StrEqual(sWpnName,"spanner"))
    {
        sWpnName = "a {green}Wrench";
    }
    else if (StrEqual(sWpnName,"golf"))
    {
        sWpnName = "a {green}Golf Club";
    }
    else if (StrEqual(sWpnName,"bat_wood"))
    {
        sWpnName = "a {green}Wooden Bat";
    }
    else if (StrEqual(sWpnName,"bat_aluminum"))
    {
        sWpnName = "an {green}Aluminum Bat";
    }
    else if (StrEqual(sWpnName,"ak47"))
    {
        sWpnName = "an {green}AK-47";
    }
    else if (StrEqual(sWpnName,"axe"))
    {
        sWpnName = "an {green}Axe";
    }
    else if (StrEqual(sWpnName,"chair"))
    {
        sWpnName = "a {green}Chair";
    }
    else if (StrEqual(sWpnName,"crowbar"))
    {
        sWpnName = "a {green}Crowbar";
    }
    else if (StrEqual(sWpnName,"fryingpan"))
    {
        sWpnName = "a {green}Frying Pan";
    }
    else if (StrEqual(sWpnName,"glock"))
    {
        sWpnName = "a {green}Glock 17";
    }
    else if (StrEqual(sWpnName,"glock18c"))
    {
        sWpnName = "a {green}Glock 18c";
    }
    else if (StrEqual(sWpnName,"keyboard"))
    {
        sWpnName = "a {green}Keyboard";
    }
    else if (StrEqual(sWpnName,"m4"))
    {
        sWpnName = "an {green}M4";
    }
    else if (StrEqual(sWpnName,"mp5"))
    {
        sWpnName = "an {green}MP5";
    }
    else if (StrEqual(sWpnName,"pipe"))
    {
        sWpnName = "a {green}Pipe";
    }
    else if (StrEqual(sWpnName,"plank"))
    {
        sWpnName = "a {green}Wooden Plank";
    }
    else if (StrEqual(sWpnName,"pot"))
    {
        sWpnName = "a {green}Pot";
    }
    else if (StrEqual(sWpnName,"ppk"))
    {
        sWpnName = "a {green}PPK";
    }
    else if (StrEqual(sWpnName,"revolver"))
    {
        sWpnName = "a {green}Revolver";
    }
    else if (StrEqual(sWpnName,"shovel"))
    {
        sWpnName = "a {green}Shovel";
    }
    else if (StrEqual(sWpnName,"machete"))
    {
        sWpnName = "a {green}Machete";
    }
    else if (StrEqual(sWpnName,"sledgehammer"))
    {
        sWpnName = "a {green}Sledgehammer";
    }
    else if (StrEqual(sWpnName,"supershorty"))
    {
        sWpnName = "a {green}Super Shorty";
    }
    else if (StrEqual(sWpnName,"tireiron"))
    {
        sWpnName = "a {green}Tire Iron";
    }
    else if (StrEqual(sWpnName,"usp"))
    {
        sWpnName = "a {green}USP";
    }
    else if (StrEqual(sWpnName,"winchester"))
    {
        sWpnName = "a {green}Winchester";
    }
    else if (StrEqual(sWpnName,"racket"))
    {
        sWpnName = "a {green}Tennis Racket";
    }
    else if (StrEqual(sWpnName,"wrench"))
    {
        sWpnName = "a {green}Wrencher";
    }
    else if (StrEqual(sWpnName,"molotov"))
    {
        sWpnName = "a {green}Molotov";
    }
    else if (StrEqual(sWpnName,"pipebomb"))
    {
        sWpnName = "a {green}Pipebomb";
    }
    else if (StrEqual(sWpnName,"baguette"))
    {
        sWpnName = "a {green}Large Breadstick";
    }
    else if (StrEqual(sWpnName,"barricade_hammer"))
    {
        sWpnName = "a {green}Barricade Hammer";
    }
    else if (StrEqual(sWpnName,"inoculator"))
    {
        sWpnName = "an {green}Inoculator";
    }
    else
    {
        // Do nothing! The whole name of the weapon will be used as the output.
    }

    // Display message for zombies
    if (atkteam == ZOMBIETEAM)
    {
        // If the carrier is the killer, display the carrier's name in white.
        if (IsCarrierZombie(attacker))
        {
            CPrintToChatAllEx(victim, "{ghostwhite}%N {default}killed {blue}%N {default}", attacker, victim);
        }
        // Otherwise, its a normal zombie, display killer in red.
        else
        {
            CPrintToChatAllEx(victim, "{red}%N {default}killed {blue}%N {default}", attacker, victim);
        }
        return Plugin_Handled;
    }
    // Display message for survivors who kill the carrier (aka whitey)
    else if (atkteam == SURVIVORTEAM)
    {
        // If the survivor kills the carrier, display victim name in white.
        if (IsCarrierZombie(victim))
        {
            CPrintToChatAllEx(attacker, "{blue}%N {default}killed {ghostwhite}%N {default}with %s {default}", attacker, victim, sWpnName);
        }
        // Otherwise, its a normal zombie, display victim in red.
        else
        {
            CPrintToChatAllEx(attacker, "{blue}%N {default}killed {red}%N {default}with %s {default}", attacker, victim, sWpnName);
        }
        return Plugin_Handled;
    }
    else
    {
        // Do Nothing.
    }

    return Plugin_Handled;
}

// Determines if player is carrier or not
public bool IsCarrierZombie(int client) 
{
    char zombieWeapon[32];
    GetClientWeapon(client, zombieWeapon, sizeof(zombieWeapon));
    return 0 == strcmp(zombieWeapon, "weapon_carrierarms");
}