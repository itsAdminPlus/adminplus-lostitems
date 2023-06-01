ESX = exports["es_extended"]:getSharedObject()

_LostItems = {}

AddEventHandler('baseevents:onPlayerDied', function()
  local playerId = source
  local xPlayer = ESX?.GetPlayerFromId(playerId) -- set nil if ESX is not set, to avoid script error
  if not playerId or xPlayer then return end
  local temptable = _LostItems[xPlayer.identifier] or {}
  table.insert(temptable, {char = xPlayer.identifier, items = xPlayer.getInventory(), time = GetGameTimer()})

  if not _LostItems[xPlayer.identifier] then _LostItems[xPlayer.identifier] = {} end
  _LostItems[xPlayer.identifier] = temptable
end)

local function getCharItems(playerId)
  if playerId < 1 then print('Cannot check console') end
-- Checks the chars
  local xPlayer = ESX?.GetPlayerFromId(playerId) -- set nil if ESX is not set, to avoid script error
  if not xPlayer then print('Player not available') end
  local lostItems = _LostItems[xPlayer.identifier]
  local temptable = {}
  for i=1, #lostItems do
    if lostItems[i].char == xPlayer.identifier then
      table.insert(temptable, lostItems[i])
    end
  end
end

RegisterCommand('lostitems', function(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  if source > 0 then
    if not args or type(args) ~= "number" then
      lItems = getCharItems(source)
    else
      if not xPlayer.getGroup() == 'admin' then return
      lItems = getCharItems(args[1])
    end
  else return end
  local latest, data = nil, {}
  latest = lItems[#lItems]
  for i=1, #lItems do
    if i == #lItems then break end
    table.insert(data, lItems[i])
  end
  TriggerClientEvent('lostItems:goToClient', source, data, latest)
end, false)