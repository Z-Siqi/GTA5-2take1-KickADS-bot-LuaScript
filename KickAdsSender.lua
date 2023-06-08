local filter = {
	"AdsWordsA",
	"AdsWordsB",
	"AdsWordsC"
}

-- Write black list to scid.cfg --
adsbotname = " "
function DECtoHEX(scidnumstr)
    local a, b = string.match(scidnumstr, "%D*(%d+)%.?(%d*)")
    local ret1 = ""
    a = tonumber(a)
    local multiple = 0

    if a ~= 0 then
        -- print (ret1)
        while a > 0 do
            local decimal = tostring(a % 16)
            if decimal == "10" then
                decimal = "a"
            elseif decimal == "11" then
                decimal = "b"
            elseif decimal == "12" then
                decimal = "c"
            elseif decimal == "13" then
                decimal = "d"
            elseif decimal == "14" then
                deciaml = "e"
            elseif decimal == "15" then
                decimal = "f"
            end
            a = math.floor(a / 16)
            ret1 = decimal .. ret1
            multiple = multiple + 1
        end
    else
        ret1 = "0"
    end

    local ret = "."
    if tonumber(b) == 0 then
        return b
    elseif b ~= nil then
        b = "0." .. b
        b = tonumber(b)
        local decimal = 0
        local multiple = 0
        while multiple < 5 do
            b = b * 16
            decimal = string.match(b, "(%d+)%.")
            b = b - tonumber(decimal)
            if decimal == "10" then
                decimal = "a"
            elseif decimal == "11" then
                decimal = "b"
            elseif decimal == "12" then
                decimal = "c"
            elseif decimal == "13" then
                decimal = "d"
            elseif decimal == "14" then
                deciaml = "e"
            elseif decimal == "15" then
                decimal = "f"
            end
            ret = ret .. decimal
            multiple = multiple + 1
        end
        return ret1
    end
end

function WriteBlacklist(name, scid)
	scid = DECtoHEX(tostring(scid))
	block = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").. "\\cfg\\scid.cfg", "a+")
	block:write(name ..":".. tostring(scid) .. ":c\n")
	block:close()
end
--script code from a website--


-- Kick player who sent ads --
local f = function(s)
	for k,v in pairs(filter) do
		if s:find(v) then
			return true
		end
	end
	return false
end

event.add_event_listener("chat", function(e)
	if f(e.body) then
		if player.is_player_valid(e.player) then
			adsbotname = player.get_player_name(e.player)
			if e.player ~= player.player_id() and player.is_player_valid(e.player) and not player.is_player_friend(e.player) then
				adsbotscid = player.get_player_scid(e.player)
				player.unset_player_as_modder(e.player, -1)
				script.trigger_script_event(0x493FC6BB, e.player, {e.player, script.get_global_i(1893548 + (1 + (e.player * 600)) + 511)})
				network.force_remove_player(e.player)
				system.wait(10)
				menu.notify("Chat sender of ads: " ..adsbotname, "Player is kicked!")
				WriteBlacklist(adsbotname, adsbotscid)
			end
		end
	end
end)

hook.register_script_event_hook(function(source, target, params, count)
	if #params < 3 then
		return
	end
	
	if (params[1] & 0xFFFFFFFF) ~= 53975141 then
		return
	end
	
	local t = {}
	table.move(params, 3, #params, 1, t)
	local s = utils.vecu64_to_str(t)

	if f(s) then
		network.force_remove_player(source)
		menu.notify("SMS sender of ads: " ..adsbotname, "Player is kicked!")
	end
end)
--script code from AntiAdBot and a website--
