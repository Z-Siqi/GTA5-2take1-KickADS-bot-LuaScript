--[[
Script describe:
Kick GTA online player who sent ads message
Merged two Lua scripts: one is from web (forgot web URL) and another one is AntiAdBot.

Feature on this merged lua script:
Kick and save player to blacklist who sent ads Chat or SMS.
--]]


--[[ Personal Configs ]]--

-- set work as true will default try to kick ads bot. [true/false]
-- Default: true
local work = true

-- set workInHost to true will kick ads sender only when you are session host. [true/false]
-- Default: false
local workInHost = false

--[[ Configs End ]]--

-- Ads words filter --
local filter = {
	"包不封号",
	"老店",
	"安全稳定",
	"国产",
	"辅助",
	"萌新一起玩",
	"块一亿",
	"元一亿",
	"刷金",
	"搜索店",
	"千人售后",
	"最强辅助",
	"封号包赔",
	"唰金",
	"挂壁别进",
	"自拍分享",
	"在线观看",
	"处女",
	"女优",
	"解所",
	"代练",
	"包安装",
	"任务组队",
	"金币",
	"微信GTA",
	"淘宝搜",
	"淘bao",
	"乱伦",
	"免费科技",
	"辅竹",
	"加微信就送",
	"做任务 有妹子",
	"加微信送",
	"进网站送",
	"幼女学生",
	"破处",
	"淘宝店铺",
	"没人开黑",
	"加QQ群",
	"手工美金",
	"送1亿",
	"薇信",
	"支持淘宝搜索",
	"吃瓜分享",
	"请色",
	"请涩",
	"情涩",
	"无优媒体",
	"--->",
	"\xE6\x89\xA3\xE6\x89\xA3", 
	"\xE5\xBE\xAE\xE4\xBF\xA1",
	"<font s",
	"\xD0\xBC\xD0\xB5",
	"<b>",
	"20R$",
	"/Menu",
	"gtacash",
	"L55.",
	"gta5studio",
	"gtavhack",
	"byruoying",
	"gta11",
	"GTA6611",
	"gta5on-",
	"gta5sx",
	"gta5-",
	"gta5.vip",
	"gta5.",
	"gtakj",
	"gta5kj",
	"gta44",
	"GTASX",
	"GTA5D",
	"gtagta",
	"GTAV0",
	"GTA26",
	"GTA58",
	"GTA23",
	"GTA88",
	"G666",
	"2649114",
	"gta62",
	"6300700",
	"P860",
	"94818",
	"621992",
	"c654",
	"92333",
	"gta99",
    "GTAA5",
    "54.c",
    "GTASOS",
	"P699"
}
--added by this Script--

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
	local doIt = true
	scid = DECtoHEX(tostring(scid))
	block = io.open(utils.get_appdata_path("PopstarDevs", "2Take1Menu").. "\\cfg\\scid.cfg", "a+")
	for line in block:lines() do
		if string.find(line, scid) then
			menu.notify("Failed: " ..adsbotname, "Has already marked before!")
			doIt = false
		end
	end

	if doIt == true then
		block:write(name ..":".. tostring(scid) .. ":c\n")
	    block:close()
	end
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

local note = false
local disable = false

event.add_event_listener("chat", function(e)
    if workInHost == true then
        if player.get_host() ~= player.player_id() then
            work = false
        end
    end
	if work == true then
		if f(e.body) then
			if player.is_player_valid(e.player) then
				adsbotname = player.get_player_name(e.player)
				if e.player ~= player.player_id() and player.is_player_valid(e.player) and not player.is_player_friend(e.player) then
					adsbotscid = player.get_player_scid(e.player)
					player.unset_player_as_modder(e.player, -1)
					script.trigger_script_event(0x493FC6BB, e.player, {e.player, script.get_global_i(1893548 + (1 + (e.player * 600)) + 511)})
					network.force_remove_player(e.player, false)
					network.network_session_kick_player(e.player)
					system.wait(10)
					if (player.get_host() ~= player.player_id()) then
						menu.notify("Chat sender of ads: " ..adsbotname, "Player is try to kick!")
						if note == false then
							menu.notify("You may kick by fucking ads bot or failed to kick if you are not session host!", "You are NOT host!!")
							note = true
						end
					else
						menu.notify("Chat sender of ads: " ..adsbotname, "Player is kicked!")
					end
					WriteBlacklist(adsbotname, adsbotscid)
				end
			end
		end
	end
	if (player.get_host() == player.player_id()) then
        if (work == false) then
            if disable == false then
                work = true
                menu.notify("The script will kick ads sender!", "You are session host now!")
            end
        end
    end
end)

hook.register_script_event_hook(function(source, target, params, count)
    if work == true then
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
			network.force_remove_player(source, true)
			network.force_remove_player(source, false)
			network.network_session_kick_player(source)
			if (player.get_host() ~= player.player_id()) then
				menu.notify("SMS sender of ads: " ..adsbotname, "Player is try to kick!")
				menu.notify("You may kick by fucking ads bot if you are not session host!", "You are NOT host!!")
			else
				menu.notify("SMS sender of ads: " ..adsbotname, "Player is kicked!")
			end
		end
	end
end)
--script code from AntiAdBot and a website--

-- become session host --
menuRoot = menu.add_feature("KickAdsSender", "parent", 0)
menu.add_feature("Become Session Host (kick current host player)", "action", menuRoot.id, function() 
    for pid=0, 31 do 
        if player.is_player_valid(pid) then
            while player.get_host() ~= player.player_id() do 
                local sessionHost = player.get_host()
                network.force_remove_player(sessionHost, false)
                system.yield()
            end
            menu.notify("Successfully became session host!")
        end
    end
end)
--script code from GameCrunchScript--

menu.add_feature("Check the running state", "action", menuRoot.id, function()
    if work == true then
        menu.notify("The script will kick ads sender")
    else
        menu.notify("The kick function is disable now")
    end
    if workInHost == true then
        menu.notify("Kick ads bot will only work when you are host")
    end
end)

menu.add_feature("Disable kick ads bot", "action", menuRoot.id, function()
    work = false
    workInHost = false
    disable = true
    menu.notify("Now the script won't kick ads sender anymore!")
end)

menu.add_feature("Enable kick ads bot (auto on when u are host)", "action", menuRoot.id, function()
    workInHost = false
    disable = false
    work = true
    menu.notify("The script will start kick ads sender!")
end)

menu.add_feature("Enable kick ads bot when host only", "action", menuRoot.id, function()
    workInHost = true
    disable = false
    menu.notify("The script will only work when you are host!")
end)
