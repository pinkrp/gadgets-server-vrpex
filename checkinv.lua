-- O Código está adaptado para o meu NOTIFY, que é um pouco diferente dos NOTIFY padrões da VRPEX
-- Por isso você terá que modificar o NOTIFY para o seu modelo.
-- A parte comentada nada mais é do que o código mostrando a informação em uma DIV ao invés de uma NOTIFY
-- Caso queira trocar do notify para a DIV, apague o notify da linha 33 e descomente a linha 34, 36 e 37
-- Isso é apenas um código para ajudar no controle da administração, não chega nem a ser um script.
-- Não venda por favor


RegisterCommand('inv',function(source,args)
	local user_id = vRP.getUserId(source)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	local nuser_id = vRP.getUserId(nplayer)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if nuser_id then
            local identity = vRP.getUserIdentity(nuser_id)
            local weapons = vRPclient.getWeapons(nplayer)
            local money = vRP.getMoney(nuser_id)
            local data = vRP.getUserDataTable(nuser_id)
            local bag = ""
            local guns = ""
            local money = vRP.format(parseInt(money)).." $"
            local bag_size = string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg  /  "..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg"					
                if data and data.inventory then
                    for k,v in pairs(data.inventory) do			
                        bag = bag.." "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."<br>"
                    end
                end							
                for k,v in pairs(weapons) do
                    if v.ammo < 1 then
                            guns = guns.." "..vRP.itemNameList("wbody|"..k).."<br>"
                    else
                            guns = guns.."1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições<br>"
                    end
                end
                TriggerClientEvent('Notify',source,"<bold><b>Mochila</b> - "..bag_size.."<br><br><b>Itens:</b> <br>"..bag.."<br><br><b>Equipáveis:</b><br>"..guns.."<br><br>Dinheiro:<br>"..money.."</bold>",identity.name..' '..identity.firstname..' - '..nuser_id,"Rosa")
            --	vRPclient.setDiv(source,"revistar",".div_revistar { background: rgba(0,0,0,0.6); border font-size: 11px; border: 2px solid #1071e0; font-family: arial; color: #fff; padding: 20px; bottom:60%; right: 30%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 13px; }","<bold><b>"..identity.name..' '..identity.firstname..' - '..nuser_id.."<br>Mochila</b> - "..bag_size.."<br><br><b>Itens:</b> <br>"..bag.."<br><br><b>Equipáveis:</b><br>"..guns.."<br><br>Dinheiro:<br>"..money.."</bold>" )
    
            --	vRP.request(source,"Você deseja parar de olhar o inventário",1000)
            --	vRPclient.removeDiv(source,"revistar")
        else
            TriggerClientEvent("Notify",source,"Precisa digitar um ID para olhar o inventário.","Falha","Vermelho") 
        end
    end		
end)