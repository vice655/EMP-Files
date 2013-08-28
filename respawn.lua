-- The following code was created for TTT, using it in any other gamemode may have undesired consequences, although unlikely.
-- Version 0.93
local CATEGORY_NAME = "TTT Debugging" -- What you are playing

function ulx.spawn( calling_ply, target_plys )
	local affected_plys = {}

	for i=1, #target_plys do
		local v = target_plys[ i ]

		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif v:IsFrozen() then
			ULib.tsayError( calling_ply, v:Nick() .. " is apparantly frozen?", true )
		elseif v:Alive() then
			ULib.tsayError( calling_ply, v:Nick() .. " is alive? Do you think i'm an idiot -- how can I respawn him?! Even the Law cant respawn him.", true ) -- I wonder if you could use csay? :o
		else
			v:SetRole(ROLE_INNOCENT) -- They will be innocent
			v:Spawn()
			table.insert( affected_plys, v )
		end
	end

	ulx.fancyLogAdmin( calling_ply, "#A spawned the player -  #T", affected_plys )
end
local law = ulx.command( CATEGORY_NAME, "ulx spawn", ulx.spawn, "!spawn" ) -- the command name
law:addParam{ type=ULib.cmds.PlayersArg }
law:defaultAccess( ULib.ACCESS_SUPERADMIN )
law:help( "Respawns <user> and makes them innocent" )

function ulx.cc_traitor( ply, targs )

 	for _, v in ipairs( targs ) do
		 v:SetRole(ROLE_TRAITOR)
		 v:SetDefaultCredits()
 	end
 	SendFullStateUpdate()
 end
 local silent = ulx.command( CATEGORY_NAME, "ulx forcetraitor", ulx.cc_traitor, "!forcetraitor", true )
 silent:addParam{type=ULib.cmds.PlayersArg, hint = "<name(s)>"}
 silent:defaultAccess( ULib.ACCESS_SUPERADMIN )
 silent:help( "Turns desired user into a traitor" ) -- ulx help hint

function ulx.cc_detective( ply, targs )

 	for _, v in ipairs( targs ) do
		 v:SetRole(ROLE_DETECTIVE)
		 v:Give("weapon_ttt_wtester") -- give DNA scanner
		 v:SetDefaultCredits()
 	end
 	SendFullStateUpdate()
 end
 local silent = ulx.command( CATEGORY_NAME, "ulx forcedetective", ulx.cc_detective, "!forcedetective", true )
 silent:addParam{type=ULib.cmds.PlayersArg, hint = "<name(s)>"}
 silent:defaultAccess( ULib.ACCESS_SUPERADMIN ) -- Access only available to SA+
 silent:help( "Turns desired user into a detective." )


function ulx.cc_innocent( ply, targs )

 	for _, v in ipairs( targs ) do
		 v:SetRole(ROLE_INNOCENT) -- Forces innocent status
 	end
 	SendFullStateUpdate()
 end
 local silent = ulx.command( CATEGORY_NAME, "ulx forceinnocent", ulx.cc_innocent, "!forceinnocent", true )
 silent:addParam{type=ULib.cmds.PlayersArg, hint = "<name(s)>"}
 silent:defaultAccess( ULib.ACCESS_SUPERADMIN )
 silent:help( "Turns desired user into an innocent terrorist." )
