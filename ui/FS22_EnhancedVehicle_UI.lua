--
-- Mod: FS22_EnhancedVehicle_UI
--
-- Author: Majo76
-- email: ls22@dark-world.de
-- @Date: 18.02.2022
-- @Version: 1.2.1.0

local myName = "FS22_EnhancedVehicle_UI"

FS22_EnhancedVehicle_UI = {}
local FS22_EnhancedVehicle_UI_mt = Class(FS22_EnhancedVehicle_UI, ScreenElement)

-- these items are referenced in the XML
FS22_EnhancedVehicle_UI.CONTROLS = {
  "yesButton",
  "noButton",

  "guiTitle",

  "sectionGlobalFunctions",
  "sectionHUD",
  "sectionSnapSettings",
  "sectionHeadlandSettings",

  "resetConfigButton",
  "resetConfigTitle",
  "resetConfigTT",

  "reloadConfigButton",
  "reloadConfigTitle",
  "reloadConfigTT",

  "snapSettingsAngle",
  "snapSettingsAngleTitle",
  "snapSettingsAngleTT",
  "snapSettingsAngleValue",

  "visibleTracksSetting",
  "visibleTracksTitle",
  "visibleTracksTT",

  "showLinesSetting",
  "showLinesTitle",
  "showLinesTT",

  "hideLinesSetting",
  "hideLinesTitle",
  "hideLinesTT",

  "hideLinesAfterSetting",
  "hideLinesAfterTitle",
  "hideLinesAfterTT",

  "HUDdmgAmountLeftSetting",
  "HUDdmgAmountLeftTitle",
  "HUDdmgAmountLeftTT",

  "HUDdmgfuelSetting",
  "HUDdmgfuelTitle",
  "HUDdmgfuelTT",

  "headlandModeSetting",
  "headlandModeTitle",
  "headlandModeTT",
  "headlandDistanceSetting",
  "headlandDistanceTitle",
  "headlandDistanceTT",
  "headlandSoundTriggerDistanceSetting",
  "headlandSoundTriggerDistanceTitle",
  "headlandSoundTriggerDistanceTT",
  "headlandRearFrontUpSetting",
  "headlandRearFrontUpTitle",
  "headlandRearFrontUpTT",
  "headlandRearFrontOffSetting",
  "headlandRearFrontOffTitle",
  "headlandRearFrontOffTT",
}

local EV_elements_global = { 'snap', 'diff', 'hydraulic', 'parkingBrake' }
for _, v in pairs( EV_elements_global ) do
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."Setting")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."Title")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, v.."TT")
end

local EV_elements_HUD = { 'fuel', 'dmg', 'misc', 'rpm', 'temp', 'diff', 'track', 'park' }
  for _, v in pairs( EV_elements_HUD ) do
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."Setting")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."Title")
  table.insert(FS22_EnhancedVehicle_UI.CONTROLS, "HUD"..v.."TT")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI.new(target, custom_mt)
  if debug > 1 then print("-> " .. myName .. ": new ") end

  local self = DialogElement.new(target, custom_mt or FS22_EnhancedVehicle_UI_mt)

  self:registerControls(FS22_EnhancedVehicle_UI.CONTROLS)

  self.vehicle = nil

  return self
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:delete()
  if debug > 1 then print("-> " .. myName .. ": delete ") end
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:setVehicle(vehicle)
  if debug > 1 then print("-> " .. myName .. ": setVehicle ") end

  self.vehicle = vehicle
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onOpen()
  if debug > 1 then print("-> " .. myName .. ": onOpen ") end

  FS22_EnhancedVehicle_UI:superClass().onOpen(self)

  local modName = "FS22_EnhancedVehicle"

  -- reset & reload config buttons
  self.resetConfigButton:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigButton"))
  self.resetConfigTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigTitle"))
  self.resetConfigTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_resetConfigTT"))
  self.reloadConfigButton:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigButton"))
  self.reloadConfigTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigTitle"))
  self.reloadConfigTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_reloadConfigTT"))

  -- title
  self.guiTitle:setText("Enhanced Vehicle ".. g_EnhancedVehicle.version .. " by Majo76")

  -- section headers
  self.sectionGlobalFunctions:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionGlobalFunctions"))
  self.sectionHUD:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionHUD"))
  self.sectionSnapSettings:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionSnapSettings"))
  self.sectionHeadlandSettings:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_sectionHeadlandSettings").." "..self.vehicle:getFullName())

  -- global elements
  for _, v in pairs(EV_elements_global) do
    v1 = v.."Title"
    v2 = v.."TT"
    v3 = v.."Setting"
    self[v1]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v1))
    self[v2]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v2))
    self[v3]:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_on"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_off")
    })
  end

  -- snap to angle
  self.snapSettingsAngleTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_snapSettingsAngleTitle"))
  self.snapSettingsAngleTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_snapSettingsAngleTT"))

  -- visible tracks
  self.visibleTracksTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_visibleTracksTitle"))
  self.visibleTracksTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_visibleTracksTT"))
  self.visibleTracksSetting:setTexts({ "1", "3", "5", "7", "9" })

  -- show lines
  self.showLinesTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesTitle"))
  self.showLinesTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesTT"))
  self.showLinesSetting:setTexts({
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesOption1"),
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesOption2"),
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesOption3"),
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_showLinesOption4")
  })

  -- hide lines
  self.hideLinesTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_hideLinesTitle"))
  self.hideLinesTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_hideLinesTT"))
  self.hideLinesSetting:setTexts({
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_on"),
    g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_off")
  })

  -- hide lines after
  self.hideLinesAfterTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_hideLinesAfterTitle"))
  self.hideLinesAfterTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_hideLinesAfterTT"))
  self.hideLinesAfterSetting:setTexts({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" })

  -- headland mode
  self.headlandModeTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandModeTitle"))
  self.headlandModeTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandModeTT"))
  self.headlandModeSetting:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandModeOption1"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandModeOption2"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandModeOption3"),
      "Only attachments"
    })

  -- headland distance
  self.headlandDistanceTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandDistanceTitle"))
  self.headlandDistanceTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandDistanceTT"))
  local _dists = {}
  local _addtxt = ""
  if self.vehicle.vData.track.workWidth ~= nil then
    _addtxt = " ("..tostring(Round(self.vehicle.vData.track.workWidth, 1)).."m)"
  end
  table.insert(_dists, g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandDistanceOption1").._addtxt)
  for _, d in pairs(FS22_EnhancedVehicle.hl_distances) do
    if d >= 0 then
      table.insert(_dists, tostring(d).."m "..g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandDistanceOptionBefore"))
    else
      table.insert(_dists, tostring(math.abs(d)).."m "..g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandDistanceOptionAfter"))
    end
  end
  self.headlandDistanceSetting:setTexts(_dists)

  -- headland sound trigger distance
  self.headlandSoundTriggerDistanceTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandSoundTriggerDistanceTitle"))
  self.headlandSoundTriggerDistanceTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_headlandSoundTriggerDistanceTT"))

  self.headlandSoundTriggerDistanceSetting:setTexts({ "5", "10", "15", "20" })
  --headland rear/front up
  self.headlandRearFrontUpTitle:setText("Rear/Front attachemnt up at headland")
  self.headlandRearFrontUpTT:setText("Only applicable when headland mode is active")
  self.headlandRearFrontUpSetting:setTexts({ "none", "rear", "front", "rear+front" })

  --headland rear/front off
  self.headlandRearFrontOffTitle:setText("Rear/Front attachemnt off at headland")
  self.headlandRearFrontOffTT:setText("Only applicable when headland mode is active")
  self.headlandRearFrontOffSetting:setTexts({ "none", "rear", "front", "rear+front" })

  -- HUD elements
  for _, v in pairs(EV_elements_HUD) do
    v1 = "HUD"..v.."Title"
    v2 = "HUD"..v.."TT"
    v3 = "HUD"..v.."Setting"
    self[v1]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v1))
    self[v2]:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_"..v2))
    self[v3]:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_on"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_off")
    })
  end

  -- HUD dmgfuel position
  self.HUDdmgfuelTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgfuelTitle"))
  self.HUDdmgfuelTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgfuelTT"))
  self.HUDdmgfuelSetting:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgfuelOption1"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgfuelOption2"),
    })

  -- HUD dmg display mode
  self.HUDdmgAmountLeftTitle:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftTitle"))
  self.HUDdmgAmountLeftTT:setText(g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftTT"))
  self.HUDdmgAmountLeftSetting:setTexts({
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftO1"),
      g_i18n.modEnvironments[modName]:getText("ui_FS22_EnhancedVehicle_HUDdmgAmountLeftO2")
    })

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:updateValues()
  -- global elements
  for _, v in pairs(EV_elements_global) do
    v3 = v.."Setting"
    self[v3]:setState(lC:getConfigValue("global.functions", v.."IsEnabled") and 1 or 2)
  end

  -- HUD elements
  for _, v in pairs(EV_elements_HUD) do
    v3 = "HUD"..v.."Setting"
    self[v3]:setState(lC:getConfigValue("hud."..v, "enabled") and 1 or 2)
  end

  -- snap to angle
  self.snapSettingsAngleValue:setText(tostring(lC:getConfigValue("snap", "snapToAngle")))

  -- visible tracks
  local _state = (lC:getConfigValue("track", "numberOfTracks") + 1) / 2
  self.visibleTracksSetting:setState(_state)

  -- show lines
  self.showLinesSetting:setState(lC:getConfigValue("track", "showLines"))

  -- hide lines
  self.hideLinesSetting:setState(lC:getConfigValue("track", "hideLines") and 1 or 2)

  -- hide lines after
  self.hideLinesAfterSetting:setState(lC:getConfigValue("track", "hideLinesAfter"))

  -- dmgfuel position
  self.HUDdmgfuelSetting:setState(lC:getConfigValue("hud", "dmgfuelPosition"))

  -- headland mode
  self.headlandModeSetting:setState(self.vehicle.vData.track.headlandMode)

  -- headland rear/front up
  self.headlandRearFrontUpSetting:setState(self.vehicle.vData.track.headlandRearFrontUp)

  -- headland rear/front off
  self.headlandRearFrontOffSetting:setState(self.vehicle.vData.track.headlandRearFrontOff)

  -- headland distance
  local _state = 0
  if self.vehicle.vData.track.headlandDistance == 9999 then --self.vehicle.vData.track.workWidth then
    _state = 1
  end
  local _i = 2
  for _, d in pairs(FS22_EnhancedVehicle.hl_distances) do
    if self.vehicle.vData.track.headlandDistance == d then
      _state = _i
    end
    _i = _i + 1
  end
  self.headlandDistanceSetting:setState(_state)

  -- headland sound trigger distance
  self.headlandSoundTriggerDistanceSetting:setState(Between(Round(lC:getConfigValue("track", "headlandSoundTriggerDistance") / 5, 0), 1, 4))

  -- HUD dmg display mode
  self.HUDdmgAmountLeftSetting:setState(lC:getConfigValue("hud.dmg", "showAmountLeft") and 1 or 2)
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickOk()
  if debug > 1 then print("-> " .. myName .. ": onClickOk ") end

  -- jump out if no vehicle is present
  if self.vehicle == nil then return end

  local state

  -- global functions
  for _, v in pairs(EV_elements_global) do
    v1 = v.."Setting"
    state = self[v1]:getState() == 1
    lC:setConfigValue("global.functions", v.."IsEnabled", state)
  end

  -- HUD
  for _, v in pairs(EV_elements_HUD) do
    v1 = "HUD"..v.."Setting"
    state = self[v1]:getState() == 1
    lC:setConfigValue("hud."..v, "enabled", state)
  end

  -- HUD dmg display
  state = self.HUDdmgAmountLeftSetting:getState() == 1
  lC:setConfigValue("hud.dmg", "showAmountLeft", state)

  -- HUD dmgfuel Position
  state = self.HUDdmgfuelSetting:getState()
  lC:setConfigValue("hud", "dmgfuelPosition", state)

  -- snapto angle
  local n = tonumber(self.snapSettingsAngleValue:getText())
  if n ~= nil then
    if n <= 0 then n = 1 end
    if n > 90 then n = 90 end
  else
    n = 10
  end
  lC:setConfigValue("snap", "snapToAngle", n)

  -- visible tracks
  local _state = self.visibleTracksSetting:getState() * 2 - 1
  lC:setConfigValue("track", "numberOfTracks", _state)

  -- show lines
  state = Between(self.showLinesSetting:getState(), 1, 4)
  lC:setConfigValue("track", "showLines", state)

  -- hide lines
  state = self.hideLinesSetting:getState() == 1
  lC:setConfigValue("track", "hideLines", state)

  -- hide lines after
  state = self.hideLinesAfterSetting:getState()
  lC:setConfigValue("track", "hideLinesAfter", state)

  -- headland mode
  self.vehicle.vData.track.headlandMode = self.headlandModeSetting:getState()

  -- headland rear/front up
  self.vehicle.vData.track.headlandRearFrontUp = self.headlandRearFrontUpSetting:getState()

  -- headland rear/front off
  self.vehicle.vData.track.headlandRearFrontOff = self.headlandRearFrontOffSetting:getState()

  -- headland distance
  local _state = self.headlandDistanceSetting:getState()
  self.vehicle.vData.track.headlandDistance = 0
  if _state == 1 then
    self.vehicle.vData.track.headlandDistance = 9999
  end
  local _i = 2
  for _, d in pairs(FS22_EnhancedVehicle.hl_distances) do
    if _state == _i then
      self.vehicle.vData.track.headlandDistance = d
    end
    _i = _i + 1
  end

  -- headland sound trigger distance
  state = self.headlandSoundTriggerDistanceSetting:getState()
  lC:setConfigValue("track", "headlandSoundTriggerDistance", state * 5)

  -- write and update our config
  lC:writeConfig()
  FS22_EnhancedVehicle:activateConfig()

  -- update HUD
  FS22_EnhancedVehicle.ui_hud:storeScaledValues(true)

  -- close screen
  g_gui:closeDialogByName("FS22_EnhancedVehicle_UI")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickBack()
  if debug > 1 then print("-> " .. myName .. ": onClickBack ") end

  -- close screen
  g_gui:closeDialogByName("FS22_EnhancedVehicle_UI")
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickResetConfig()
  if debug > 1 then print("-> " .. myName .. ": onClickResetConfig ") end

  FS22_EnhancedVehicle:resetConfig()
  lC:writeConfig()
  FS22_EnhancedVehicle:activateConfig()

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onClickReloadConfig(p1)
  if debug > 1 then print("-> " .. myName .. ": onClickReloadConfig ") end

  lC:readConfig()
  FS22_EnhancedVehicle:activateConfig()

  self:updateValues()
end

-- #############################################################################

function FS22_EnhancedVehicle_UI:onTextChanged_SnapAngle(_, text)
  local n = tonumber(text)
  if n ~= nil then
    if n < 0 then n = 10 end
    if n > 90 then n = 90 end
  else
    n = ""
  end

  self.snapSettingsAngleValue:setText(tostring(n))
end
