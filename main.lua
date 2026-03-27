local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EliteCheatGuiV2"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 520)
mainFrame.Position = UDim2.new(0.5, -150, 0, -50)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 1 
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false 
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 3 
uiStroke.Transparency = 1 
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Control Center Pro"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextTransparency = 1 
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

local fadeComponents = {mainFrame, uiStroke, titleLabel}

local function createIOSButton(name, yPos, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 260, 0, 38)
    btn.Position = UDim2.new(0.5, -130, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 1 
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextTransparency = 1 
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = mainFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    table.insert(fadeComponents, btn) 
    return btn
end

local function createInputRow(yPos, defaultVal, btnText)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 80, 0, 38)
    box.Position = UDim2.new(0.5, -130, 0, yPos)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.BackgroundTransparency = 1 
    box.Text = defaultVal 
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextTransparency = 1 
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Parent = mainFrame
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 10)
    boxCorner.Parent = box

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 175, 0, 38)
    btn.Position = UDim2.new(0.5, -45, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 1 
    btn.Text = btnText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextTransparency = 1 
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = mainFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    table.insert(fadeComponents, box); table.insert(fadeComponents, btn)
    return box, btn
end

local godBtn = createIOSButton("GodBtn", 50, "God Mode: OFF")
local noclipBtn = createIOSButton("NoclipBtn", 95, "Noclip: OFF")
local invisBtn = createIOSButton("InvisBtn", 140, "Invisibility: OFF")
local nameBtn = createIOSButton("NameBtn", 185, "Hide Name: OFF")
local vBox, vBtn = createInputRow(230, "12", "Vibrate: OFF")
local sBox, sBtn = createInputRow(275, "100", "Walk Speed: OFF")
local jBox, jBtn = createInputRow(320, "100", "Inf Jump: OFF")
local fBox, fBtn = createInputRow(365, "100", "Fly: OFF")

local cOff, cOn = Color3.fromRGB(45, 45, 45), Color3.fromRGB(48, 209, 88)

local isVOn, vConn, vOrigin = false, nil, nil
vBtn.MouseButton1Click:Connect(function()
    isVOn = not isVOn
    vBtn.Text = isVOn and "Vibrate: ON" or "Vibrate: OFF"
    vBtn.BackgroundColor3 = isVOn and cOn or cOff
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if isVOn and hrp then
        vOrigin = hrp.CFrame 
        local toggle = false
        vConn = RunService.Heartbeat:Connect(function()
            if hrp then
                toggle = not toggle
                local dist = tonumber(vBox.Text) or 12
                hrp.CFrame = vOrigin * CFrame.new(toggle and dist or -dist, 0, 0)
                hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
        end)
    else
        if vConn then vConn:Disconnect(); vConn = nil; if hrp and vOrigin then hrp.CFrame = vOrigin end; vOrigin = nil end
    end
end)

local isGOn = false
godBtn.MouseButton1Click:Connect(function()
    isGOn = not isGOn
    godBtn.Text = isGOn and "God Mode: ON" or "God Mode: OFF"
    godBtn.BackgroundColor3 = isGOn and cOn or cOff
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.MaxHealth = isGOn and math.huge or 100; hum.Health = hum.MaxHealth end
end)

local isNOn, nConn = false, nil
noclipBtn.MouseButton1Click:Connect(function()
    isNOn = not isNOn
    noclipBtn.Text = isNOn and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = isNOn and cOn or cOff
    if isNOn then
        nConn = RunService.Stepped:Connect(function()
            if player.Character then
                for _, p in pairs(player.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
            end
        end)
    else
        if nConn then nConn:Disconnect() end
    end
end)

local isIOn = false
invisBtn.MouseButton1Click:Connect(function()
    isIOn = not isIOn
    invisBtn.Text = isIOn and "Invisibility: ON" or "Invisibility: OFF"
    invisBtn.BackgroundColor3 = isIOn and cOn or cOff
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then if v.Name ~= "HumanoidRootPart" then v.Transparency = isIOn and 1 or 0 end end
        end
    end
end)

nameBtn.MouseButton1Click:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        local hide = hum.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None
        hum.DisplayDistanceType = hide and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
        nameBtn.Text = hide and "Hide Name: ON" or "Hide Name: OFF"
        nameBtn.BackgroundColor3 = hide and cOn or cOff
    end
end)

local isSOn = false
sBtn.MouseButton1Click:Connect(function()
    isSOn = not isSOn
    sBtn.Text = isSOn and "Walk Speed: ON" or "Walk Speed: OFF"
    sBtn.BackgroundColor3 = isSOn and cOn or cOff
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = isSOn and tonumber(sBox.Text) or 16
    end
end)

local isJOn, jConn = false, nil
jBtn.MouseButton1Click:Connect(function()
    isJOn = not isJOn
    jBtn.Text = isJOn and "Inf Jump: ON" or "Inf Jump: OFF"
    jBtn.BackgroundColor3 = isJOn and cOn or cOff
    if isJOn then
        jConn = UserInputService.JumpRequest:Connect(function()
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = tonumber(jBox.Text) or 50; hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if jConn then jConn:Disconnect(); jConn = nil end
    end
end)

local isFOn, fConn, bV, bG = false, nil, nil, nil
fBtn.MouseButton1Click:Connect(function()
    isFOn = not isFOn
    fBtn.Text = isFOn and "Fly: ON" or "Fly: OFF"
    fBtn.BackgroundColor3 = isFOn and cOn or cOff
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if isFOn and hrp and hum then
        hum.PlatformStand = true
        bV = Instance.new("BodyVelocity", hrp); bV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bG = Instance.new("BodyGyro", hrp); bG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); bG.P = 10000
        fConn = RunService.RenderStepped:Connect(function()
            local cam, dir = Workspace.CurrentCamera, Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            bV.Velocity = dir.Unit.Magnitude > 0 and dir.Unit * (tonumber(fBox.Text) or 100) or Vector3.new(0,0,0)
            bG.CFrame = cam.CFrame
        end)
    else
        if hum then hum.PlatformStand = false end
        if bV then bV:Destroy(); bG:Destroy() end
        if fConn then fConn:Disconnect() end
    end
end)

local isVisible = false
RunService.RenderStepped:Connect(function()
    if mainFrame.Visible then
        local hue = (tick() % 4) / 4
        uiStroke.Color = Color3.fromHSV(hue, 0.7, 0.8)
        titleLabel.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and (input.KeyCode == Enum.KeyCode.Return) then
        isVisible = not isVisible
        mainFrame.Visible = true
        local targetPos = isVisible and UDim2.new(0.5, -150, 0, 20) or UDim2.new(0.5, -150, 0, -50)
        TweenService:Create(mainFrame, TweenInfo.new(0.4), {Position = targetPos}):Play()
        for _, v in pairs(fadeComponents) do
            local goal = {}
            if v:IsA("Frame") or v:IsA("TextBox") or v:IsA("TextButton") then goal.BackgroundTransparency = isVisible and 0.4 or 1 end
            if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then goal.TextTransparency = isVisible and 0 or 1 end
            if v:IsA("UIStroke") then goal.Transparency = isVisible and 0 or 1 end
            TweenService:Create(v, TweenInfo.new(0.4), goal):Play()
        end
    end
end)
