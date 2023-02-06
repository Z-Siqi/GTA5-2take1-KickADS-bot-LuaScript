ui.notify_above_map("广告机拦截已开启", "", 12)
adsbotname = " "

function tentosixteennnn(scidnumstr)
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
	scid = tentosixteennnn(tostring(scid))
	block = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").. "\\cfg\\scid.cfg", "a+")
	block:write(name ..":".. tostring(scid) .. ":c\n")
	block:close()
end


GUANGGAOJILANJIEZIDONGAA = menu.add_feature("广告机拦截", "toggle", 0, function(f)
	if f.on then
		chatlistener = event.add_event_listener("chat", function(m)
			if string.match(m.body,"广告词A")
			or string.match(m.body,"广告词B")
			or string.match(m.body,"广告词C...")
			then
				if player.is_player_valid(m.player) then
					adsbotname = player.get_player_name(m.player)
					if m.player ~= player.player_id() and player.is_player_valid(m.player) and not player.is_player_friend(m.player) then
						adsbotscid = player.get_player_scid(m.player)
						player.unset_player_as_modder(m.player, -1)
						script.trigger_script_event(0x493FC6BB, m.player, {m.player, script.get_global_i(1893548 + (1 + (m.player * 600)) + 511)})
						network.force_remove_player(m.player)
						system.wait(10)
						ui.notify_above_map("已踢出广告机".. adsbotname, "", 12)
						WriteBlacklist(adsbotname, adsbotscid)
					end
				end
            end
            return HANDLER_CONTINUE
		end)
	else
		event.remove_event_listener("chat", chatlistener)
		chatlistener  = nil
	end
end)
GUANGGAOJILANJIEZIDONGAA.on = true
GUANGGAOJILANJIEZIDONGAA.hidden = true
