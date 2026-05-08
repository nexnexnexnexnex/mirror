--[[
MirrorLibrary
Credit required!!

Enjoy
]]

if not game:IsLoaded() then
  repeat task.wait() until game:IsLoaded()
end

if not getgenv() then
  repeat task.wait() until getgenv()
end

local g = getgenv()
local Mirror = {}
g.MirrorLibrary = Mirror

g.MirrorLibrary.ShowNotifications = true -- change to false to disable notifications from startup

local libversion = "1.0.0"

-- yes this is vibecoded i'm terrible at ui design and tweenservice
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function Notify(title, text)
  if title and text and g.MirrorLibrary.ShowNotifications then
    local TweenService = game:GetService("TweenService")
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local gui = playerGui:FindFirstChild("NotificationSystem")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "NotificationSystem"
        gui.ResetOnSpawn = false
        gui.Parent = playerGui
    end

    local holder = gui:FindFirstChild("Holder")
    if not holder then
        holder = Instance.new("Frame")
        holder.Name = "Holder"
        holder.BackgroundTransparency = 1
        holder.Size = UDim2.new(0, 280, 1, -20)
        holder.Position = UDim2.new(1, -300, 0, 10)
        holder.Parent = gui

        local layout = Instance.new("UIListLayout")
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = holder
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 80)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = tick()
    frame.Parent = holder

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 12, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -24, 0, 40)
    descLabel.Position = UDim2.new(0, 12, 0, 32)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = text
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.TextTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 12
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextYAlignment = Enum.TextYAlignment.Top
    descLabel.Parent = frame

    local tInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(frame, tInfo, {BackgroundTransparency = 0}):Play()
    TweenService:Create(titleLabel, tInfo, {TextTransparency = 0}):Play()
    TweenService:Create(descLabel, tInfo, {TextTransparency = 0}):Play()

    task.delay(5, function()
        local fade = TweenService:Create(frame, tInfo, {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
        TweenService:Create(titleLabel, tInfo, {TextTransparency = 1}):Play()
        TweenService:Create(descLabel, tInfo, {TextTransparency = 1}):Play()
        
        fade:Play()
        fade.Completed:Wait()
        frame:Destroy()
    end)
  else
    return
  end
end

Notify("Mirror", "Library loaded!") -- can delete if you want


function g.MirrorLibrary:ToggleNotifs()
  self.ShowNotifications = not self.ShowNotifications
  print("[MirrorInternal] Notifications: "..tostring(self.ShowNotifications))
end

-- Checks existence of all MirrorLibrary functions
function g.MirrorLibrary:CheckCustomFunctions()
    -- List the specific functions you want to verify
    local functionsToVerify = {
        "debUNCTest",
        "CheckCustomFunctions",
        "GetLibVersion",
        "GetAllPlayerInfo",
        "ListAll",
        "DestroyAll",
        "GetPlayerHealth",
        "PlaySound",
        "SpamNotifications",
        "KillSelf",
        "SetFullBright",
        "GetStats",
        "PullPassword"
    }

    print("--- CheckCustomFunctions ---")

    for _, name in ipairs(functionsToVerify) do
        -- We check 'self' because this function is inside MirrorLibrary
        if self[name] and type(self[name]) == "function" then
            -- Success (Using warn for orange or your green trick)
            print("✅ MirrorLib:" .. name)
        else
            -- Failure (The Red X you are seeing)
            warn("❌ MirrorLib:" .. name .. " NOT FOUND")
        end
    end
end

-- Runs a debUNC test on the current executor. Credits to alyssagithub on GitHub
function g.MirrorLibrary:debUNCTest()
  local s, e = pcall(function()
    loadstring(game:HttpGet("https://github.com/alyssagithub/debUNC/raw/main/debUNC.luau"))()
  end)

  if s then
    Notify("Mirror", "debUNC test started\nOpen Console")
  else
    Notify("Mirror", "Error: debUNCTest pcall returned error\nOpen Console")
    warn("[MirrorLibrary] debUNCTest error: ", e)
  end
end


-- Returns the current version of the library
function g.MirrorLibrary:GetLibVersion()
  return Notify("Mirror", string.format("The current MirrorLibrary version is %s", libversion))
end

-- Prints some useless information about all players in the server
function g.MirrorLibrary:GetAllPlayerInfo()
  Notify("Mirror", "GetAllPlayerInfo started\nOpen Console")
  for _, plr in ipairs(Players:GetPlayers()) do
    local wPlayer = workspace:FindFirstChild(plr.Name)
    print("- - - - - - - - - - -")
    print("Username: ", plr.Name)
    print("Display Name: ", plr.DisplayName)
    print("UserID: ", plr.UserId)
    print("Health: ", wPlayer.Humanoid.Health)
    print("- - - - - - - - - - -")
  end
end

-- Lists (prints) all names and parents of a given Class
function g.MirrorLibrary:ListAll(type: string)
  Notify("Mirror", "ListAll started (may give you lag spikes)\nOpen Console")
  task.wait(1.5)
  for _, v in ipairs(game:GetDescendants()) do
    if v:IsA(type) then
      print("- - - - - -")
      print(string.format("Name: %s\nParent: %s", v.Name, tostring(v.Parent)))
      print("- - - - - -")
    end
  end
end


-- Returns the specified player's health at time of execution
function g.MirrorLibrary:GetPlayerHealth(name)
  for _, plr in ipairs(Players:GetPlayers()) do
    if plr.Name == name then
      local wPlayer = workspace:FindFirstChild(name)
      local health = tostring(wPlayer.Humanoid.Health)
      Notify("Mirror", string.format("%s's current health is %s", name, health))
    end
  end
end


function g.MirrorLibrary:PlaySound(ID: number)
  local sound = Instance.new("Sound")
  sound.Parent = CoreGui or Players.LocalPlayer.Backpack
  sound.SoundId = ID

  local s, e = pcall(function()
    sound:Play()
    sound:Destroy()
  end)

  if s then
    Notify("Mirror", string.format("Sound played: %s", tostring(ID)))
  else
    Notify("Mirror", "PlaySound pcall returned an error\nOpen Console")
    warn("[PlaySound] Error: ", e)
  end
end


function g.MirrorLibrary:DestroyAll(type: string)
  Notify("Mirror", "DestroyAll started (may cause lag spikes)\nOpen Console")
  for _, v in ipairs(game:GetDescendants()) do
    if v:IsA(type) then
      local s, e = pcall(function()
        v:Destroy()    
      end)

      if s then
        print("[DestroyAll] Destroyed ", v.Name, " ✅ ")
      else
        warn("[DestroyAll] Failed to destroy ", v.Name, " ❌\nError: ", e)
      end
    end
  end
end


function g.MirrorLibrary:KillSelf()
  local selfbody = workspace:FindFirstChild(Players.LocalPlayer.Name)
  local hum = selfbody:WaitForChild("Humanoid")
  hum.Health = 0
end


local Lighting = game:GetService("Lighting")
local OldLightingSettings = nil

function g.MirrorLibrary:SetFullBright(toggle: boolean)
    if toggle then
        OldLightingSettings = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows,
            OutdoorAmbient = Lighting.OutdoorAmbient
        }

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        
        Notify("Mirror", "FullBright activated")
    else

        if OldLightingSettings then
            Lighting.Brightness = OldLightingSettings.Brightness
            Lighting.ClockTime = OldLightingSettings.ClockTime
            Lighting.FogEnd = OldLightingSettings.FogEnd
            Lighting.GlobalShadows = OldLightingSettings.GlobalShadows
            Lighting.OutdoorAmbient = OldLightingSettings.OutdoorAmbient
            
            Notify("Mirror", "FullBright deactivated")
        else
            warn("[SetFullBright]: No fallback Lighting settings were found")
        end
    end
end

function g.MirrorLibrary:GetStats()
    local stats = game:GetService("Stats")
    local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
    local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    
    print("--- GetStats ---")
    print("FPS: " .. fps)
    print("Ping: " .. ping .. "ms")
    print("--- GetStats ---")
    Notify("Mirror", "Stats printed\nOpen Console")
end


function g.MirrorLibrary:Kiciahook()
  local s, e = pcall(function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.luau'))()
  end)

  if s then
    Notify("Mirror", "Kiciahook injected")
  else
    Notify("Mirror", "Error: loadstring returned error\nOpen Console")
    warn("[MirrorLibrary/Kiciahook()] Error: ", e)
  end
end

function g.MirrorLibrary:InfiniteYield()
  local s, e = pcall(function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source'))()
  end)

  if s then
    Notify("Mirror", "IY injected")
  else
    Notify("Mirror", "Error: loadstring returned error\nOpen Console")
    warn("[MirrorLibrary/InfiniteYield()] Error: ", e)
  end
end

function g.MirrorLibrary:UnnamedEnhancements()
  local s, e = pcall(function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/smi9/UnnamedCheats/refs/heads/main/loader.lua'))()
  end)

  if s then
    Notify("Mirror", "UE injected")
  else
    Notify("Mirror", "Error: loadstring returned error\nOpen Console")
    warn("[MirrorLibrary/UnnamedEnhancements()] Error: ", e)
  end
end

function g.MirrorLibrary:Novoline()
  local s, e = pcall(function()
      loadstring(game:HttpGet('https://novoline.pro'))()
  end)

  if s then
    Notify("Mirror", "Novoline injected")
  else
    Notify("Mirror", "Error: loadstring returned error\nOpen Console")
    warn("[MirrorLibrary/Novoline()] Error: ", e)
  end
end

function g.MirrorLibrary:SaveInstance(options)
local Params = {
  RepoURL = "https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/",
  SSI = "saveinstance",
}
  local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
  synsaveinstance(options)
end

local SavedCameraState = nil
local SpectateConnection = nil
local SpectateTarget = nil

local function StopSpectating()
  local camera = workspace.CurrentCamera
  if SpectateConnection then
    SpectateConnection:Disconnect()
    SpectateConnection = nil
  end

  if camera and SavedCameraState then
    camera.CameraType = SavedCameraState.CameraType
    camera.CameraSubject = SavedCameraState.CameraSubject
    camera.CFrame = SavedCameraState.CFrame
    camera.Focus = SavedCameraState.Focus
  end

  SavedCameraState = nil
  SpectateTarget = nil
end

function g.MirrorLibrary:Spectate(username)
  local camera = workspace.CurrentCamera
  if not camera then
    Notify("Mirror", "Unable to access current camera")
    return
  end

  local player = Players:FindFirstChild(username)
  if not (player and player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
    Notify("Mirror", "Player not found")
    return
  end

  if camera and not SavedCameraState then
    SavedCameraState = {
      CameraType = camera.CameraType,
      CameraSubject = camera.CameraSubject,
      CFrame = camera.CFrame,
      Focus = camera.Focus,
    }
  end

  StopSpectating()
  SpectateTarget = player
  camera.CameraType = Enum.CameraType.Scriptable

  SpectateConnection = game:GetService("RunService").RenderStepped:Connect(function()
    if not SpectateTarget or not SpectateTarget.Character or not SpectateTarget.Character:FindFirstChild("HumanoidRootPart") then
      StopSpectating()
      Notify("Mirror", "Stopped spectating: target unavailable")
      return
    end

    local hrp = SpectateTarget.Character.HumanoidRootPart
    camera.CFrame = hrp.CFrame
    camera.Focus = hrp.CFrame
  end)

  Notify("Mirror", "Spectating " .. username)
end

function g.MirrorLibrary:Unspectate()
  if not SavedCameraState and not SpectateConnection then
    Notify("Mirror", "You aren't spectating anyone")
    return
  end

  StopSpectating()
  Notify("Mirror", "Stopped spectating")
end