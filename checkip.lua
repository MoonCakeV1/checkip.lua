-- This script was made by MoonCake_Par, it's open source thus feel free to make new versions of it, enjoy!
-- If you need help please DM me on discord. 

require "moonloader"
local json = require "dkjson"
local encoding = require "encoding"
encoding.default = 'CP1251'
u8 = encoding.UTF8

local api_key = "YOUR_API_KEY_HERE" -- Please read the readme file in https://github.com/MoonCakeV1/checkip for docs.

function main()
    while not isSampAvailable() do wait(100) end
    sampRegisterChatCommand("checkip", checkip)
    wait(-1)
end

function checkip(ip)
    if not ip or ip == "" then
        sampAddChatMessage("No IP provided. Usage: /checkip <ip>", 0xFF3333)
        return
    end

    if not ip:match("^%d+%.%d+%.%d+%.%d+$") then
        sampAddChatMessage("Invalid IP format. Please enter a valid IP address. Usage: /checkip <ip>", 0xFF3333)
        return
    end

    lua_thread.create(function()
        local url = string.format("http://v2.api.iphub.info/ip/%s", ip)
        local response, status = httpRequest(url, { ["X-Key"] = api_key })
        if not response then
            sampAddChatMessage("Failed to fetch data. Status: " .. tostring(status), 0xFF0000)
            return
        end

        local data, _, err = json.decode(response)
        if not data then
            sampAddChatMessage("Error parsing response: " .. tostring(err), 0xFF0000)
            return
        end

        sampAddChatMessage("IP: {FFFF00}" .. ip, 0xFFFF00)
        if data.block == 0 then
            sampAddChatMessage("Status: {33FF33}Clean IP", 0x33FF33)
        elseif data.block == 1 then
            sampAddChatMessage("Status: {FF0000}Hosting/Proxy IP", 0xFF0000)
        elseif data.block == 2 then
            sampAddChatMessage("Status: {FF0000}VPN or Anonymous Proxy", 0xFF0000)
        else
            sampAddChatMessage("Status: {CCCC00}Unknown (" .. tostring(data.block) .. ")", 0xCCCC00)
        end

        if data.countryName then
            sampAddChatMessage("Country: {00FF00}" .. data.countryName, 0x00FF00)
        end
        if data.isp then
            sampAddChatMessage("ISP: {FFA500}" .. data.isp, 0xFFA500)
        end

        sampAddChatMessage("Made by {00FF00}MoonCake_Par{FFFFFF}", 0x00FF00)
    end)
end

function httpRequest(url, headers)
    local socket = require("socket.http")
    local ltn12 = require("ltn12")
    
    local response = {}
    local res, status, _ = socket.request({
        url = url,
        headers = headers,
        sink = ltn12.sink.table(response)
    })

    return table.concat(response), status
end
