----------- CREDIT SCRIPT -----------
---------- DICLOPARTZ#1028 ----------
-------------------------------------


local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_spalageamuri")

------------------------------------------------------------------------------------

RegisterServerEvent("DICLO:SPALAGEAMURI")
AddEventHandler("DICLO:SPALAGEAMURI", function()
    local user_id = vRP.getUserId({source})
    local jucator = vRP.getUserSource({user_id})
    local recompensa = math.random(25, 50) -- SUMA DE BANI PE CARE O OFERA ESTE RANDOM, INTRE 100 SI 350
    vRP.giveMoney({jucator, recompensa}) -- ITI DA BANII IN JOC
    vRPclient.notify(jucator,{"~h~~w~Ai primit ~b~"..recompensa.." ~w~pentru ca ai ~b~spalat geamurile !"}) -- ITI DA O NOTIFICARE DEASUPRA HARTII
end)
