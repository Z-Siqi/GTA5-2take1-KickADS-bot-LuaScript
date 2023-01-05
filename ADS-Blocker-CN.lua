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

function xieruheimmd(namee, sciddd)
	sciddd = tentosixteennnn(tostring(sciddd))
	block = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").. "\\cfg\\scid.cfg", "a+")
	block:write(namee ..":".. tostring(sciddd) .. ":c\n")
	block:close()
end


GUANGGAOJILANJIEZIDONGAA = menu.add_feature("广告机拦截", "toggle", 0, function(f)
	if f.on then
		chatlistener = event.add_event_listener("chat", function(m)
			if string.match(m.body,"包不封号")
			or string.match(m.body,"老店")
			or string.match(m.body,"安全稳定")
			or string.match(m.body,"国产")
			or string.match(m.body,"辅助")
			or string.match(m.body,"萌新一起玩")
			or string.match(m.body,"块一亿")
			or string.match(m.body,"元一亿")
			or string.match(m.body,"刷金")
			or string.match(m.body,"搜索店")
			or string.match(m.body,"千人售后")
			or string.match(m.body,"最强辅助")
			or string.match(m.body,"封号包赔")
			or string.match(m.body,"唰金")
			or string.match(m.body,"在线观看")
			or string.match(m.body,"处女")
			or string.match(m.body,"女优")
			or string.match(m.body,"解所")
			or string.match(m.body,"代练")
			or string.match(m.body,"包安装")
			or string.match(m.body,"任务组队")
			or string.match(m.body,"金币")
			or string.match(m.body,"微信GTA")
			or string.match(m.body,"淘宝搜")
			or string.match(m.body,"淘bao")
			or string.match(m.body,"乱伦")
			or string.match(m.body,"免费科技")
			or string.match(m.body,"辅竹")
			or string.match(m.body,"加微信就送")
			or string.match(m.body,"加微信送")
			or string.match(m.body,"进网站送")
			or string.match(m.body,"L55.")
			or string.match(m.body,"gta5studio")
			or string.match(m.body,"gtavhack")
			or string.match(m.body,"byruoying")
			or string.match(m.body,"gta11")
			or string.match(m.body,"GTA6611")
			or string.match(m.body,"gta5on-")
			or string.match(m.body,"gta5sx")
			or string.match(m.body,"gta5-")
			or string.match(m.body,"gta5.vip")
			or string.match(m.body,"gta5.")
			or string.match(m.body,"gtakj")
			or string.match(m.body,"gta5kj")
			or string.match(m.body,"gta44")
			or string.match(m.body,"GTASX")
			or string.match(m.body,"GTA5D")
			or string.match(m.body,"gtagta")
			or string.match(m.body,"GTAV0")
			or string.match(m.body,"GTA26")
			or string.match(m.body,"GTA23")
			or string.match(m.body,"GTA88")
			or string.match(m.body,"2649114")
			or string.match(m.body,"6300700")
			then
				if player.is_player_valid(m.player) then
					adsbotname = player.get_player_name(m.player)
					if m.player ~= player.player_id() and player.is_player_valid(m.player) and not player.is_player_friend(m.player) then
						adsbotscid = player.get_player_scid(m.player)
						player.unset_player_as_modder(m.player, -1)
						script.trigger_script_event(0x493FC6BB, m.player, {m.player, script.get_global_i(1893548 + (1 + (m.player * 600)) + 511)})
						network.force_remove_player(m.player)
						system.wait(10)
						network.send_chat_message(" \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n",false)
						ui.notify_above_map("已踢出广告机".. adsbotname, "", 12)
						xieruheimmd(adsbotname, adsbotscid)
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
