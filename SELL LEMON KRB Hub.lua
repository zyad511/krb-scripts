-- ================================================
--           KRB PREMIUM - FINAL EDITION
--        غوجو + أوتوفارم + أنتي AFK كامل
-- ================================================
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui          = game:GetService("CoreGui")
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")
local TeleportService  = game:GetService("TeleportService")
local LocalPlayer      = Players.LocalPlayer

-- تنظيف نسخ قديمة
pcall(function()
    if CoreGui:FindFirstChild("KRB_Final") then
        CoreGui["KRB_Final"]:Destroy()
    end
end)

-- ================================================
--                  Anti-AFK دائم
-- ================================================
task.spawn(function()
    while task.wait(60) do
        local VU = game:GetService("VirtualUser")
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end
end)
LocalPlayer.Idled:Connect(function()
    local VU = game:GetService("VirtualUser")
    VU:CaptureController()
    VU:ClickButton2(Vector2.new())
end)

-- ================================================
--               الـ ScreenGui الرئيسي
-- ================================================
local GUI = Instance.new("ScreenGui")
GUI.Name             = "KRB_Final"
GUI.Parent           = CoreGui
GUI.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
GUI.ResetOnSpawn     = false

-- ================================================
--               دالة السحب
-- ================================================
local function makeDraggable(frame, handle, clamp)
    local drag, dragInput, dragStart, startPos = false
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; dragStart = i.Position; startPos = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch then
            dragInput = i
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if i == dragInput and drag then
            local d  = i.Position - dragStart
            local nX = startPos.X.Offset + d.X
            local nY = startPos.Y.Offset + d.Y
            if clamp then
                local s = workspace.CurrentCamera.ViewportSize
                nX = math.clamp(nX, 0, s.X - frame.AbsoluteSize.X)
                nY = math.clamp(nY, 0, s.Y - frame.AbsoluteSize.Y)
            end
            frame.Position = UDim2.new(startPos.X.Scale, nX, startPos.Y.Scale, nY)
        end
    end)
end

-- ================================================
--               الإطار الرئيسي
-- ================================================
local W, H = 480, 360

local Main = Instance.new("Frame", GUI)
Main.Name               = "Main"
Main.Size               = UDim2.new(0, W, 0, H)
Main.Position           = UDim2.new(0.5, -W/2, 0.5, -H/2)
Main.BackgroundColor3   = Color3.fromRGB(6, 8, 14)
Main.ClipsDescendants   = true
Main.Visible            = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color       = Color3.fromRGB(0, 160, 255)
mainStroke.Thickness   = 1.8
mainStroke.Transparency = 0.5

-- خلفية غوجو
local BG = Instance.new("ImageLabel", Main)
BG.Size              = UDim2.new(1, 0, 1, 0)
BG.Image             = "rbxassetid://124561153221476"
BG.ScaleType         = Enum.ScaleType.Crop
BG.ImageTransparency = 0.68
BG.BackgroundTransparency = 1
BG.ZIndex            = 0

-- طبقة تعتيم فوق الصورة
local Overlay = Instance.new("Frame", Main)
Overlay.Size              = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3  = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.55
Overlay.ZIndex            = 1
Overlay.BorderSizePixel   = 0

-- ================================================
--               شريط العنوان
-- ================================================
local Topbar = Instance.new("Frame", Main)
Topbar.Size             = UDim2.new(1, 0, 0, 46)
Topbar.BackgroundColor3 = Color3.fromRGB(4, 6, 10)
Topbar.BackgroundTransparency = 0.2
Topbar.ZIndex           = 5
makeDraggable(Main, Topbar, false)

local TopLine = Instance.new("Frame", Topbar)
TopLine.Size            = UDim2.new(1, 0, 0, 2)
TopLine.Position        = UDim2.new(0, 0, 1, -2)
TopLine.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
TopLine.BackgroundTransparency = 0.4
TopLine.ZIndex          = 6

local TitleLbl = Instance.new("TextLabel", Topbar)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Position   = UDim2.new(0, 18, 0, 0)
TitleLbl.Size       = UDim2.new(0, 240, 1, 0)
TitleLbl.Font       = Enum.Font.GothamBold
TitleLbl.Text       = "• KRB Hub"
TitleLbl.TextColor3 = Color3.fromRGB(0, 210, 255)
TitleLbl.TextSize   = 15
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex     = 6

local VersionLbl = Instance.new("TextLabel", Topbar)
VersionLbl.BackgroundTransparency = 1
VersionLbl.Position   = UDim2.new(0, 18, 0.55, 0)
VersionLbl.Size       = UDim2.new(0, 170, 0, 12)
VersionLbl.Font       = Enum.Font.Gotham
VersionLbl.Text       = "Anti-AFK ✓"
VersionLbl.TextColor3 = Color3.fromRGB(120, 180, 220)
VersionLbl.TextSize   = 10
VersionLbl.TextXAlignment = Enum.TextXAlignment.Left
VersionLbl.ZIndex     = 6

local menuOpen = false
local CloseX = Instance.new("TextButton", Topbar)
CloseX.BackgroundTransparency = 1
CloseX.Position  = UDim2.new(1, -44, 0, 0)
CloseX.Size      = UDim2.new(0, 44, 1, 0)
CloseX.Font      = Enum.Font.GothamBold
CloseX.Text      = "x"
CloseX.TextColor3 = Color3.fromRGB(255, 70, 70)
CloseX.TextSize  = 18
CloseX.ZIndex    = 6
CloseX.MouseButton1Click:Connect(function()
    menuOpen = false
    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0, W, 0, 0)}):Play()
    task.wait(0.22)
    Main.Visible = false
end)

-- ================================================
--               الشريط الجانبي
-- ================================================
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size             = UDim2.new(0, 122, 1, -46)
Sidebar.Position         = UDim2.new(0, 0, 0, 46)
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BackgroundTransparency = 0.65
Sidebar.ZIndex           = 4

local SideStroke = Instance.new("UIStroke", Sidebar)
SideStroke.Color       = Color3.fromRGB(0, 120, 200)
SideStroke.Transparency = 0.85
SideStroke.Thickness   = 1

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding              = UDim.new(0, 6)
SideLayout.HorizontalAlignment  = Enum.HorizontalAlignment.Center
local SidePad = Instance.new("UIPadding", Sidebar)
SidePad.PaddingTop = UDim.new(0, 10)

-- حاوية الصفحات
local PageHolder = Instance.new("Frame", Main)
PageHolder.BackgroundTransparency = 1
PageHolder.Position = UDim2.new(0, 132, 0, 54)
PageHolder.Size     = UDim2.new(1, -142, 1, -62)
PageHolder.ZIndex   = 3

-- ================================================
--               إنشاء التبويبات
-- ================================================
local pages, tabBtns = {}, {}

local function newTab(id, icon, label)
    local page = Instance.new("ScrollingFrame", PageHolder)
    page.Name                = id
    page.Size                = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible             = false
    page.CanvasSize          = UDim2.new(0, 0, 0, 500)
    page.ScrollBarThickness  = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 160, 255)
    page.ZIndex              = 3
    local ll = Instance.new("UIListLayout", page)
    ll.Padding = UDim.new(0, 8)
    local pp = Instance.new("UIPadding", page)
    pp.PaddingBottom = UDim.new(0, 8)
    pages[id] = page

    local btn = Instance.new("TextButton", Sidebar)
    btn.Size             = UDim2.new(0, 108, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(15, 20, 32)
    btn.BackgroundTransparency = 0.3
    btn.Font             = Enum.Font.GothamMedium
    btn.Text             = icon .. "  " .. label
    btn.TextColor3       = Color3.fromRGB(180, 210, 240)
    btn.TextSize         = 12
    btn.TextXAlignment   = Enum.TextXAlignment.Left
    btn.ZIndex           = 5
    local bc = Instance.new("UICorner", btn); bc.CornerRadius = UDim.new(0, 8)
    local bs = Instance.new("UIStroke", btn)
    bs.Color       = Color3.fromRGB(0, 140, 255)
    bs.Transparency = 0.8
    local bp = Instance.new("UIPadding", btn); bp.PaddingLeft = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        for k, p in pairs(pages) do p.Visible = (k == id) end
        for b in pairs(tabBtns) do
            local active = (b == btn)
            TweenService:Create(b, TweenInfo.new(0.15), {
                BackgroundColor3    = active and Color3.fromRGB(0, 130, 220) or Color3.fromRGB(15, 20, 32),
                BackgroundTransparency = active and 0.1 or 0.3,
                TextColor3          = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 210, 240),
            }):Play()
        end
    end)
    tabBtns[btn] = true
    return page
end

local pgFarm     = newTab("Farm",     "🌾", "الزراعة")
local pgMain     = newTab("Main",     "🏠", "الرئيسية")
local pgSave     = newTab("Save",     "💾", "الحفظ")
local pgSettings = newTab("Settings", "⚙️", "الإعدادات")

-- تفعيل تبويب الزراعة أول
pages["Farm"].Visible = true
for b in pairs(tabBtns) do
    if b.Text:find("الزراعة") then
        b.BackgroundColor3 = Color3.fromRGB(0, 130, 220)
        b.BackgroundTransparency = 0.1
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- ================================================
--           دوال بناء عناصر التحكم
-- ================================================
local function makeRow(parent, txt)
    local f = Instance.new("Frame", parent)
    f.Size             = UDim2.new(1, -4, 0, 50)
    f.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
    f.BackgroundTransparency = 0.25
    f.ZIndex           = 4
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local st = Instance.new("UIStroke", f)
    st.Color       = Color3.fromRGB(0, 160, 255)
    st.Transparency = 0.85
    st.Thickness   = 1

    local lbl = Instance.new("TextLabel", f)
    lbl.BackgroundTransparency = 1
    lbl.Position   = UDim2.new(0, 14, 0, 0)
    lbl.Size       = UDim2.new(0, 180, 1, 0)
    lbl.Font       = Enum.Font.GothamMedium
    lbl.Text       = txt
    lbl.TextColor3 = Color3.fromRGB(220, 235, 255)
    lbl.TextSize   = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex     = 5
    return f
end

local function makeToggle(parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size             = UDim2.new(0, 72, 0, 30)
    btn.Position         = UDim2.new(1, -80, 0.5, -15)
    btn.BackgroundColor3 = Color3.fromRGB(55, 16, 16)
    btn.Font             = Enum.Font.GothamBold
    btn.Text             = "OFF"
    btn.TextColor3       = Color3.fromRGB(255, 90, 90)
    btn.TextSize         = 13
    btn.ZIndex           = 5
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local function setToggle(btn, state)
    TweenService:Create(btn, TweenInfo.new(0.15), {
        BackgroundColor3 = state and Color3.fromRGB(10, 50, 20) or Color3.fromRGB(55, 16, 16),
        TextColor3       = state and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 90, 90),
    }):Play()
    btn.Text = state and "ON" or "OFF"
end

-- ================================================
--          🌾 صفحة الزراعة - AutoFarm
-- ================================================
local AutoBuy, AutoUpgrade, AutoFruit = false, false, false
local Buying = false

-- إيجاد الـ Tycoon
local userTycoon = nil
task.spawn(function()
    task.wait(3)
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:match("Tycoon%d") then
            if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then
                userTycoon = v; break
            end
        end
    end
end)

local function getButtons()
    if not userTycoon then return {} end
    local list = {}
    for _, obj in ipairs(userTycoon.Purchases:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("Shown") == true and obj:GetAttribute("Purchased") ~= true then
            local bp = obj:FindFirstChild("Button")
            if bp and bp:IsA("BasePart") then table.insert(list, {Name=obj.Name, Button=bp}) end
        end
    end
    return list
end

local function buyButton(bd)
    if Buying then return end
    Buying = true
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        pcall(function()
            firetouchinterest(hrp, bd.Button, 0)
            firetouchinterest(hrp, bd.Button, 1)
        end)
    end
    Buying = false
end

task.spawn(function()
    while true do
        task.wait(0.05)
        if AutoBuy then
            for _, bd in ipairs(getButtons()) do pcall(buyButton, bd) end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoUpgrade and userTycoon then
            for _, obj in ipairs(userTycoon.Purchases:GetDescendants()) do
                if obj:IsA("RemoteFunction") and obj.Name == "Upgrade" then
                    pcall(function()
                        for l = 1, 100 do obj:InvokeServer(l) end
                    end)
                end
            end
        end
    end
end)

local Trees = {}
workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Model") and obj.Name == "LemonTree" and not table.find(Trees, obj) then
        table.insert(Trees, obj)
    end
end)
workspace.DescendantRemoving:Connect(function(obj)
    local i = table.find(Trees, obj)
    if i then table.remove(Trees, i) end
end)
for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("Model") and v.Name == "LemonTree" then table.insert(Trees, v) end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoFruit then
            for _, tree in ipairs(Trees) do
                if not AutoFruit then break end
                if tree and tree.Parent then
                    pcall(function()
                        for _, p in ipairs(tree:GetDescendants()) do
                            if p:IsA("BasePart") then p.CanCollide = false end
                        end
                        local char = LocalPlayer.Character
                        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                        if hrp then hrp.CFrame = tree:GetPivot() + Vector3.new(0, 5, 0) end
                        for _, obj in ipairs(tree:GetDescendants()) do
                            if obj:IsA("BasePart") and obj.Name == "Fruit" then
                                local cp  = obj:FindFirstChild("ClickPart")
                                local det = cp and cp:FindFirstChildOfClass("ClickDetector")
                                if det then task.wait(0.4); pcall(fireclickdetector, det) end
                            end
                        end
                    end)
                end
            end
        end
    end
end)

-- عناصر صفحة الزراعة
local rBuy  = makeRow(pgFarm, "🛒  شراء تلقائي")
local tBuy  = makeToggle(rBuy)
tBuy.MouseButton1Click:Connect(function()
    AutoBuy = not AutoBuy; setToggle(tBuy, AutoBuy)
end)

local rUpg  = makeRow(pgFarm, "⬆️  ترقية تلقائية")
local tUpg  = makeToggle(rUpg)
tUpg.MouseButton1Click:Connect(function()
    AutoUpgrade = not AutoUpgrade; setToggle(tUpg, AutoUpgrade)
end)

local rFruit = makeRow(pgFarm, "🍋  جمع فاكهة تلقائي")
local tFruit = makeToggle(rFruit)
tFruit.MouseButton1Click:Connect(function()
    AutoFruit = not AutoFruit; setToggle(tFruit, AutoFruit)
end)

-- فاصل
local farmInfo = Instance.new("TextLabel", pgFarm)
farmInfo.BackgroundTransparency = 1
farmInfo.Size = UDim2.new(1, -4, 0, 28)
farmInfo.Font = Enum.Font.Gotham
farmInfo.Text = "Anti-AFK مفعّل دائماً تلقائياً ✓"
farmInfo.TextColor3 = Color3.fromRGB(80, 200, 120)
farmInfo.TextSize = 12
farmInfo.TextXAlignment = Enum.TextXAlignment.Center
farmInfo.ZIndex = 3

-- ================================================
--          🏠 صفحة الرئيسية
-- ================================================
local targetSpeed   = 16
local noclipActive  = false

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = targetSpeed end
        if noclipActive then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)

local rSpeed = makeRow(pgMain, "🏃  سرعة المشي")
local sBox   = Instance.new("TextBox", rSpeed)
sBox.Size             = UDim2.new(0, 72, 0, 30)
sBox.Position         = UDim2.new(1, -80, 0.5, -15)
sBox.BackgroundColor3 = Color3.fromRGB(14, 22, 36)
sBox.Font             = Enum.Font.GothamBold
sBox.Text             = "16"
sBox.TextColor3       = Color3.fromRGB(0, 200, 255)
sBox.TextSize         = 14
sBox.ZIndex           = 5
Instance.new("UICorner", sBox).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", sBox).Color = Color3.fromRGB(0, 140, 200)
sBox.FocusLost:Connect(function()
    local v = tonumber(sBox.Text)
    if v and v >= 1 and v <= 500 then targetSpeed = v
    else sBox.Text = tostring(targetSpeed) end
end)

local rNoclip = makeRow(pgMain, "👻  اختراق جدران")
local tNoclip = makeToggle(rNoclip)
tNoclip.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive; setToggle(tNoclip, noclipActive)
end)

-- ================================================
--          💾 صفحة الحفظ
-- ================================================
local autoFile          = "KrbAuto.txt"
local currentCfg        = "KrbConfig1"
local autoLoadActive    = false

local cfgInput = Instance.new("TextBox", pgSave)
cfgInput.Size             = UDim2.new(1, -4, 0, 36)
cfgInput.BackgroundColor3 = Color3.fromRGB(10, 15, 25)
cfgInput.Font             = Enum.Font.GothamMedium
cfgInput.Text             = "KrbConfig1"
cfgInput.TextColor3       = Color3.fromRGB(200, 220, 255)
cfgInput.TextSize         = 13
cfgInput.ZIndex           = 4
Instance.new("UICorner", cfgInput).CornerRadius = UDim.new(0, 7)
local cfgStroke = Instance.new("UIStroke", cfgInput)
cfgStroke.Color = Color3.fromRGB(0, 140, 255); cfgStroke.Transparency = 0.5

local actFrame = Instance.new("Frame", pgSave)
actFrame.BackgroundTransparency = 1
actFrame.Size = UDim2.new(1, -4, 0, 38)
local actLayout = Instance.new("UIListLayout", actFrame)
actLayout.FillDirection = Enum.FillDirection.Horizontal
actLayout.Padding = UDim.new(0, 8)

local function makeActionBtn(parent, txt, bg, tc)
    local b = Instance.new("TextButton", parent)
    b.Size             = UDim2.new(0, 150, 1, 0)
    b.BackgroundColor3 = bg
    b.Font             = Enum.Font.GothamBold
    b.Text             = txt
    b.TextColor3       = tc
    b.TextSize         = 12
    b.ZIndex           = 4
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    return b
end

local saveBtn = makeActionBtn(actFrame, "💾  حفظ الحالي",
    Color3.fromRGB(10, 46, 20), Color3.fromRGB(80, 255, 120))
local delBtn  = makeActionBtn(actFrame, "🗑️  حذف الحفظ",
    Color3.fromRGB(46, 10, 10), Color3.fromRGB(255, 80, 80))

local fileList = Instance.new("ScrollingFrame", pgSave)
fileList.Size               = UDim2.new(1, -4, 0, 130)
fileList.BackgroundColor3   = Color3.fromRGB(4, 7, 12)
fileList.BackgroundTransparency = 0.4
fileList.ScrollBarThickness = 3
fileList.ScrollBarImageColor3 = Color3.fromRGB(0, 160, 255)
fileList.CanvasSize         = UDim2.new(0, 0, 0, 200)
fileList.ZIndex             = 4
Instance.new("UICorner", fileList).CornerRadius = UDim.new(0, 7)
local fileLayout = Instance.new("UIListLayout", fileList)
fileLayout.Padding = UDim.new(0, 4)
local filePad = Instance.new("UIPadding", fileList)
filePad.PaddingLeft = UDim.new(0, 4); filePad.PaddingTop = UDim.new(0, 4)

local function buildCurrentConfig()
    return {
        Speed       = targetSpeed,
        NoClip      = noclipActive,
        AutoBuy     = AutoBuy,
        AutoUpgrade = AutoUpgrade,
        AutoFruit   = AutoFruit,
    }
end

local function applyConfig(d)
    if not d then return end
    targetSpeed  = d.Speed or 16;      sBox.Text = tostring(targetSpeed)
    noclipActive = d.NoClip or false;  setToggle(tNoclip, noclipActive)
    AutoBuy      = d.AutoBuy     or false; setToggle(tBuy,   AutoBuy)
    AutoUpgrade  = d.AutoUpgrade or false; setToggle(tUpg,   AutoUpgrade)
    AutoFruit    = d.AutoFruit   or false; setToggle(tFruit, AutoFruit)
end

local function refreshList()
    for _, c in pairs(fileList:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    if not listfiles then return end
    local count = 0
    for _, f in pairs(listfiles("")) do
        if f:sub(-9) == "_krb.json" then
            count = count + 1
            local pure = f:gsub("_krb.json","")
            local ib = Instance.new("TextButton", fileList)
            ib.Size             = UDim2.new(1, -8, 0, 28)
            ib.BackgroundColor3 = Color3.fromRGB(14, 20, 32)
            ib.BackgroundTransparency = 0.2
            ib.Font             = Enum.Font.GothamMedium
            ib.Text             = "  📁  " .. pure
            ib.TextColor3       = Color3.fromRGB(200, 225, 255)
            ib.TextSize         = 12
            ib.TextXAlignment   = Enum.TextXAlignment.Left
            ib.ZIndex           = 5
            Instance.new("UICorner", ib).CornerRadius = UDim.new(0, 5)
            ib.MouseButton1Click:Connect(function()
                currentCfg = pure; cfgInput.Text = pure
                if isfile(pure .. "_krb.json") then
                    applyConfig(HttpService:JSONDecode(readfile(pure .. "_krb.json")))
                end
                TweenService:Create(ib, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 80, 160)}):Play()
                task.wait(0.15)
                TweenService:Create(ib, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(14, 20, 32)}):Play()
            end)
        end
    end
    fileList.CanvasSize = UDim2.new(0, 0, 0, count * 32 + 8)
end

saveBtn.MouseButton1Click:Connect(function()
    local name = cfgInput.Text ~= "" and cfgInput.Text or "KrbConfig1"
    currentCfg = name
    if writefile then
        writefile(name .. "_krb.json", HttpService:JSONEncode(buildCurrentConfig()))
        writefile(autoFile, HttpService:JSONEncode({AutoLoad = autoLoadActive, ActiveFile = currentCfg}))
        local orig = saveBtn.Text; saveBtn.Text = "تم الحفظ ✓"
        task.wait(1); saveBtn.Text = orig
        refreshList()
    end
end)

delBtn.MouseButton1Click:Connect(function()
    local name = cfgInput.Text
    if delfile and isfile and isfile(name .. "_krb.json") then
        delfile(name .. "_krb.json")
        local orig = delBtn.Text; delBtn.Text = "تم الحذف ✕"
        task.wait(1); delBtn.Text = orig
        refreshList()
    end
end)

-- ================================================
--          ⚙️ صفحة الإعدادات
-- ================================================
local autoToggle = Instance.new("TextButton", pgSettings)
autoToggle.Size             = UDim2.new(1, -4, 0, 50)
autoToggle.BackgroundColor3 = Color3.fromRGB(32, 22, 10)
autoToggle.Font             = Enum.Font.GothamBold
autoToggle.Text             = "🔄  تشغيل تلقائي عند Rejoin  :  OFF"
autoToggle.TextColor3       = Color3.fromRGB(240, 170, 80)
autoToggle.TextSize         = 13
autoToggle.ZIndex           = 4
Instance.new("UICorner", autoToggle).CornerRadius = UDim.new(0, 8)
local atStroke = Instance.new("UIStroke", autoToggle)
atStroke.Color = Color3.fromRGB(240, 170, 80); atStroke.Transparency = 0.7

autoToggle.MouseButton1Click:Connect(function()
    autoLoadActive = not autoLoadActive
    autoToggle.Text = "🔄  تشغيل تلقائي عند Rejoin  :  " ..
        (autoLoadActive and "AUTO ✓" or "OFF")
    TweenService:Create(autoToggle, TweenInfo.new(0.15), {
        BackgroundColor3 = autoLoadActive and Color3.fromRGB(10, 46, 20) or Color3.fromRGB(32, 22, 10),
        TextColor3       = autoLoadActive and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(240, 170, 80),
    }):Play()
    atStroke.Color = autoLoadActive and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(240, 170, 80)
    if writefile then
        writefile(autoFile, HttpService:JSONEncode({AutoLoad = autoLoadActive, ActiveFile = currentCfg}))
    end
end)

local rejoinBtn = Instance.new("TextButton", pgSettings)
rejoinBtn.Size             = UDim2.new(1, -4, 0, 50)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(10, 28, 58)
rejoinBtn.Font             = Enum.Font.GothamBold
rejoinBtn.Text             = "🔗  إعادة دخول السيرفر (Rejoin)"
rejoinBtn.TextColor3       = Color3.fromRGB(120, 200, 255)
rejoinBtn.TextSize         = 13
rejoinBtn.ZIndex           = 4
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 8)
local rjStroke = Instance.new("UIStroke", rejoinBtn)
rjStroke.Color = Color3.fromRGB(0, 140, 255); rjStroke.Transparency = 0.6

rejoinBtn.MouseButton1Click:Connect(function()
    rejoinBtn.Text = "جاري إعادة الاتصال..."
    if writefile then
        writefile(autoFile, HttpService:JSONEncode({AutoLoad = autoLoadActive, ActiveFile = currentCfg}))
    end
    task.wait(0.4)
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end)

-- ================================================
--         التحميل التلقائي بعد Rejoin
-- ================================================
local function onSpawned()
    task.wait(0.6)
    pcall(function()
        if isfile and isfile(autoFile) then
            local ad = HttpService:JSONDecode(readfile(autoFile))
            if ad and ad.AutoLoad then
                autoLoadActive = true
                autoToggle.Text = "🔄  تشغيل تلقائي عند Rejoin  :  AUTO ✓"
                TweenService:Create(autoToggle, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(10, 46, 20),
                    TextColor3       = Color3.fromRGB(80, 255, 120),
                }):Play()
                atStroke.Color = Color3.fromRGB(80, 255, 120)
                local fn = ad.ActiveFile
                if fn and isfile(fn .. "_krb.json") then
                    currentCfg = fn; cfgInput.Text = fn
                    applyConfig(HttpService:JSONDecode(readfile(fn .. "_krb.json")))
                end
            end
        end
    end)
    refreshList()
end

LocalPlayer.CharacterAdded:Connect(onSpawned)
if LocalPlayer.Character then task.spawn(onSpawned) end

-- ================================================
--         زر التبديل الدائري (شعار KRB)
-- ================================================
local Toggle = Instance.new("ImageButton", GUI)
Toggle.Name             = "KRB_Toggle"
Toggle.Size             = UDim2.new(0, 52, 0, 52)
Toggle.Position         = UDim2.new(0, 22, 0, 110)
Toggle.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
Toggle.Image            = "rbxassetid://119587751719395"
Toggle.ScaleType        = Enum.ScaleType.Fit
Toggle.ZIndex           = 10
makeDraggable(Toggle, Toggle, true)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
local tgStroke = Instance.new("UIStroke", Toggle)
tgStroke.Color       = Color3.fromRGB(0, 180, 255)
tgStroke.Thickness   = 2
tgStroke.Transparency = 0.35

-- وميض الزر
task.spawn(function()
    while true do
        TweenService:Create(tgStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.7}):Play()
        task.wait(1.2)
        TweenService:Create(tgStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.1}):Play()
        task.wait(1.2)
    end
end)

Toggle.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        Main.Visible = true
        Main.Size    = UDim2.new(0, W, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, W, 0, H)}):Play()
    else
        local t = TweenService:Create(Main, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, W, 0, 0)})
        t:Play()
        t.Completed:Connect(function() if not menuOpen then Main.Visible = false end end)
    end
end)
