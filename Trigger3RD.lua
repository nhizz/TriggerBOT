local TriggerBotToggleKey = Enum.KeyCode.L
local AimBotToggleKey = Enum.KeyCode.C

local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Camera = game.Workspace.CurrentCamera
local Mouse = Player:GetMouse()
local PlayerTeam = Player.Team
local Neutral = Player.Neutral
local UIS = game:GetService("UserInputService")
local triggerBotToggled = false
local aimBotToggled = false
local aimbotTweenInfo = TweenInfo.new(0.2) 
local aimbotTweenStatus = nil

local function findTeams()
    local cc1 = false
    local cc2 = false

    if PlayerTeam and not Neutral then
        if #game:GetService("Teams"):GetTeams() > 0 then
            cc1 = true
            for _, team in pairs(game.Teams:GetTeams()) do
                if #team:GetPlayers() > 0 and team ~= PlayerTeam and cc1 == true then
                    cc2 = true
                elseif #team:GetPlayers() <= 0 and cc1 == true then
                    return "FFA"
                end
            end
        elseif #game.Teams:GetTeams() <= 0 then
            return "FFA"
        end
    elseif Neutral == true or not PlayerTeam then
        return "FFA"
    end

    if cc1 == true and cc2 == true then
        return "TEAMS"
    end
end

local function Click()
    local ZorskosMonkeyNuts = math.random(0.3, 0.7) / 10
    wait(ZorskosMonkeyNuts)
    mouse1click
end

local function castRay(mode)
    local raySPTR = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
    local newRay = Ray.new(raySPTR.Origin, raySPTR.Direction * 9999)
    local target, position = workspace:FindPartOnRayWithIgnoreList(newRay, {Char, Camera})

    if target and position and game.Players:GetPlayerFromCharacter(target.Parent) and target.Parent.Humanoid.Health > 0 or
        target and position and game.Players:GetPlayerFromCharacter(target.Parent.Parent) and target.Parent.Parent.Humanoid.Health > 0 then
        local tPlayer = game.Players:GetPlayerFromCharacter(target.Parent) or game.Players:GetPlayerFromCharacter(target.Parent.Parent)

        if tPlayer.Team ~= PlayerTeam and mode ~= "FFA" and tPlayer ~= Player then
            Click()
        elseif tPlayer.Team == PlayerTeam and tPlayer ~= Player then
            if mode == "FFA" then
                Click()
            end
        end
    end
end

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == TriggerBotToggleKey then
        triggerBotToggled = not triggerBotToggled
    end

    if input.KeyCode == AimBotToggleKey then
        aimBotToggled = not aimBotToggled
    end
end)

local function aimAt(targetPosition)
    local screenPosition, onScreen = Camera:WorldToScreenPoint(targetPosition)

    if onScreen then
        local cursorPosition = Vector2.new(Mouse.X, Mouse.Y)
        local cursorTargetPosition = Vector2.new(screenPosition.X, screenPosition.Y)

        if aimbotTweenStatus == nil then
            aimbotTweenStatus = true
            local cursorTween = game:GetService("TweenService"):Create(Mouse, aimbotTweenInfo, {
                X = cursorTargetPosition.X,
                Y = cursorTargetPosition.Y
            })
            cursorTween:Play()
            cursorTween.Completed:Connect(function()
                aimbotTweenStatus = nil
            end)
        end
    end
end

local preMode = findTeams()
local o = false

game:GetService("RunService").Stepped:Connect(function()
    local mode = findTeams()

    if o == false then
        o = true
        print(mode)
    end

    if mode ~= preMode then
        preMode = mode
        print(mode)
    end

    if triggerBotToggled then
        castRay(mode)
    end

    if aimBotToggled then
        local target = Char:FindFirstChild("HumanoidRootPart") or Char:FindFirstChild("Head")
        if target then
            aimAt(target.Position)
        end
    end
end)
