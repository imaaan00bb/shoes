local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local extraStuds = 2
local stepInterval = 0.1

-- Set the JumpPower to 60
humanoid.JumpPower = 60

local movingKeys = {
    [Enum.KeyCode.W] = false,
    [Enum.KeyCode.A] = false,
    [Enum.KeyCode.S] = false,
    [Enum.KeyCode.D] = false
}

local function isMoving()
    for _, moving in pairs(movingKeys) do
        if moving then
            return true
        end
    end
    return false
end

local function onMove()
    if character and hrp then
        local forward = hrp.CFrame.lookVector
        hrp.CFrame = hrp.CFrame + forward * extraStuds
    end
end

local function onInputBegan(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard and not gameProcessed then
        local key = input.KeyCode
        if movingKeys[key] ~= nil then
            movingKeys[key] = true
        end
    end
end

local function onInputEnded(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard and not gameProcessed then
        local key = input.KeyCode
        if movingKeys[key] ~= nil then
            movingKeys[key] = false
        end
    end
end

local lastMoveTime = 0
RunService.RenderStepped:Connect(function(deltaTime)
    if isMoving() then
        local currentTime = tick()
        if currentTime - lastMoveTime >= stepInterval then
            onMove()
            lastMoveTime = currentTime
        end
    end
end)

UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)
