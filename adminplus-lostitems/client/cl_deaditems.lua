ESX = exports["es_extended"]:getSharedObject()

-- Triggered when the player dies
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsEntityDead(PlayerPedId()) then
        TriggerServerEvent('playerDied')
        break
      end
    end
  end)

  RegisterNetEvent('inventoryDataSaved')
AddEventHandler('inventoryDataSaved', function(characterLicense)
  print('Inventory data saved for character: ' .. characterLicense)
end)

RegisterNetEvent('showLostItems')
AddEventHandler('showLostItems', function(message)
  -- Display chat message with lost items
  TriggerEvent('chat:addMessage', {
    color = { 255, 255, 255 },
    multiline = true,
    args = { message }
  })
end)