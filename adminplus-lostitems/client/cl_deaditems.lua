ESX = exports["es_extended"]:getSharedObject()

-- Triggered when the player dies
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsEntityDead(PlayerPedId()) then
        TriggerServerEvent('playerDied')
        break
local function libMenu(data, latest)
  -- Second Layer
  local function subMenu(items)
    local menuItems = {}
    for _, item in pairs(items) do
      table.insert(menuItems, {
        title = item.name,
        description = item.count
      })
    end
    lib.registerContext({
      id = 'lostItems-2',
      title = 'Lost Items',
      menu = 'lostItems-1',
      options = {
        table.unpack(menuItems)
      }
    })
    lib.showContext('lostItems-2')
  end

  -- First Layer
  local menuItems = {}
  -- Set latest first
  table.insert(menuItems, {
    title = (GetGameTimer() - latest.time) / 1000..' Seconds Ago',
    description = 'Latest',
    onSelect = function() pcall(subMenu, latest.items) end
  })

  -- Now do Data
  for i=1, #data do
    table.insert(menuItems, {
      title = (GetGameTimer() - data[i].time) / 1000..' Seconds Ago',
      onSelect = function() pcall(subMenu, data[i].items) end
    })
  end
  lib.registerContext({
    id = 'lostItems-1',
    title = 'Lost Items',
    options = {
      {
        title = 'When it gets saved?',
        description = 'Whenever you die in the period of the serverinstance being open. All items when dying gets saved. Even after when you disconnect yourself! :)',
        disabled = true
      },
      table.unpack(menuItems)
    }
  })
  lib.showContext('lostItems-1')
end

local function esxMenu(data, latest)
  local menuItems = {}
  -- Explain segment
  table.insert(menuItems, {
    title = 'When it gets saved?',
    description = 'Whenever you die in the period of the serverinstance being open. All items when dying gets saved. Even after when you disconnect yourself! :)',
    unselectable = true,
  })

  -- Set latest first
  table.insert(menuItems, {
    title = (GetGameTimer() - latest.time) / 1000..' Seconds Ago',
    description = 'Latest',
    items = latest.items
  })

  -- Now do Data
  for i=1, #data do
    table.insert(menuItems, {
      title = (GetGameTimer() - data[i].time) / 1000..' Seconds Ago',
      items = data[i].items
    })
  end

  ESX.OpenContext("right" , menuItems,
    function(menu,element)
      ESX.CloseContext()

      local menuItems_Sub = {}
      for _, item in pairs(element.items) do
        table.insert(menuItems_Sub, {
          title = item.name,
          description = item.count,
          unselectable = true
        })
      end

      ESX.OpenContext("right" , element.,
        function(menu,element)
          -- onSelect function
        end,
        function()
          -- onClose function
        end
      end)


    end,
    function()
      -- onClose function
    end
  end)
end

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
RegisterNetEvent('lostItems:goToClient', function(data, latest)
  if not lib then
    esxMenu(data, latest)
  else
    libMenu(data,latest)
  end
end)