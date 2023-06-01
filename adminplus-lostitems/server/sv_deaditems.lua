ESX = exports["es_extended"]:getSharedObject()

local playerInventory = {}
_LostItems = {}

RegisterNetEvent('playerDied')
AddEventHandler('playerDied', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then
    return
  end

  local characterLicense = xPlayer.identifier
  local inventory = xPlayer.getInventory()

  -- Store inventory data in a Lua table
  playerInventory[characterLicense] = inventory
AddEventHandler('baseevents:onPlayerDied', function()
  local playerId = source
  local xPlayer = ESX?.GetPlayerFromId(playerId) -- set nil if ESX is not set, to avoid script error
  if not playerId or xPlayer then return end
  local temptable = _LostItems[xPlayer.identifier] or {}
  table.insert(temptable, {char = xPlayer.identifier, items = xPlayer.getInventory(), time = GetGameTimer()})

  print('Inventory data saved')

  -- Trigger client event to notify the player
  TriggerClientEvent('inventoryDataSaved', source, characterLicense)
  if not _LostItems[xPlayer.identifier] then _LostItems[xPlayer.identifier] = {} end
  _LostItems[xPlayer.identifier] = temptable
end)

RegisterCommand('lostitems', function(source, args)
  local targetId = tonumber(args[1])
  local xPlayer = ESX.GetPlayerFromId(source)
  
  if targetId then
    -- Admin is trying to view someone else's lost items
    if xPlayer.getGroup() == 'admin' then
      local xTarget = ESX.GetPlayerFromId(targetId)
      if not xTarget then
        print('Player not found.')
        return
      end

      local characterLicense = xTarget.identifier

      if playerInventory[characterLicense] then
        local inventory = playerInventory[characterLicense]

        local itemList = ''
        for _, item in ipairs(inventory) do
          itemList = itemList .. item.name .. ': ' .. item.count .. ', '
        end

        local characterName = xTarget.getName() -- Get the character name
        local message = 'Lost Items for ' .. characterName .. ': ' .. string.sub(itemList, 1, -3) -- Remove the last comma and space

        -- Trigger client event to display the chat message
        TriggerClientEvent('showLostItems', source, message)

      else
        print('No lost items found.')
      end
    else
      print('Insufficient permission to view other player\'s lost items.')
    end
  else
    -- User is trying to view their own lost items
    local characterLicense = xPlayer.identifier

    if playerInventory[characterLicense] then
      local inventory = playerInventory[characterLicense]

      local itemList = ''
      for _, item in ipairs(inventory) do
        itemList = itemList .. item.name .. ': ' .. item.count .. ', '
      end

      local characterName = xPlayer.getName() -- Get the character name
      local message = 'Lost Items for ' .. characterName .. ': ' .. string.sub(itemList, 1, -3) -- Remove the last comma and space

      -- Trigger client event to display the chat message
      TriggerClientEvent('showLostItems', source, message)
    else
      print('No lost items found.')
    end
  end
end, true)