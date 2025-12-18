--[[ 
    NULL-IA EXECUTOR v1.0 
    Created by: Gemini (Assistant)
    Key: nulled_1.0
]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Evitar duplicados
if game.CoreGui:FindFirstChild("NullIA_UI") then
    game.CoreGui.NullIA_UI:Destroy()
end

-- ================= CONFIGURACIÓN BÁSICA =================
local Config = {
    Key = "nulled_1.0",
    Language = "Español",
    AIModel = "Basic", -- Basic, Pro, Null-IA
    Theme = "Oscuro",
    Toggles = {} -- Almacena el estado de los toggles
}

local Themes = {
    Oscuro = {
        Main = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(50, 50, 50),
        Content = Color3.fromRGB(25, 25, 25),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(80, 80, 80),
        Button = Color3.fromRGB(60, 60, 60)
    },
    Verde = {
        Main = Color3.fromRGB(45, 75, 65),
        Sidebar = Color3.fromRGB(60, 90, 80),
        Content = Color3.fromRGB(30, 50, 45),
        Text = Color3.fromRGB(220, 255, 220),
        Accent = Color3.fromRGB(100, 180, 100),
        Button = Color3.fromRGB(80, 120, 80)
    },
    Naranja = {
        Main = Color3.fromRGB(80, 50, 30),
        Sidebar = Color3.fromRGB(100, 70, 50),
        Content = Color3.fromRGB(60, 40, 20),
        Text = Color3.fromRGB(255, 220, 200),
        Accent = Color3.fromRGB(255, 140, 50),
        Button = Color3.fromRGB(120, 80, 40)
    },
    Claro = {
        Main = Color3.fromRGB(230, 230, 230),
        Sidebar = Color3.fromRGB(200, 200, 200),
        Content = Color3.fromRGB(245, 245, 245),
        Text = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(100, 150, 255),
        Button = Color3.fromRGB(210, 210, 210)
    }
}

-- ================= SISTEMA DE UI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NullIA_UI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Función para arrastrar elementos (Draggable)
local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TweenService:Create(frame, TweenInfo.new(0.05), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }):Play()
        end
    end)
end

-- ================= KEY SYSTEM =================
local KeyFrame = Instance.new("Frame")
local KeyContent = Instance.new("Frame")
local KeyTitle = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local VerifyBtn = Instance.new("TextButton")
local KeyCodeLabel = Instance.new("TextLabel")
local KeyExitBtn = Instance.new("TextButton")

KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = ScreenGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

-- Header Key System
local KeyHeader = Instance.new("Frame")
KeyHeader.Size = UDim2.new(1, 0, 0, 35)
KeyHeader.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
KeyHeader.Parent = KeyFrame
Instance.new("UICorner", KeyHeader).CornerRadius = UDim.new(0, 10)
local KeyHeaderFix = Instance.new("Frame") -- Para tapar las esquinas de abajo
KeyHeaderFix.Size = UDim2.new(1, 0, 0, 10)
KeyHeaderFix.Position = UDim2.new(0, 0, 1, -10)
KeyHeaderFix.BackgroundColor3 = KeyHeader.BackgroundColor3
KeyHeaderFix.BorderSizePixel = 0
KeyHeaderFix.Parent = KeyHeader

KeyTitle.Text = "NULL-IA | Key System"
KeyTitle.Size = UDim2.new(1, -40, 1, 0)
KeyTitle.Position = UDim2.new(0, 10, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
KeyTitle.TextSize = 16
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyHeader

KeyExitBtn.Size = UDim2.new(0, 25, 0, 25)
KeyExitBtn.Position = UDim2.new(1, -30, 0, 5)
KeyExitBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KeyExitBtn.Text = "X"
KeyExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyExitBtn.Font = Enum.Font.GothamBold
KeyExitBtn.Parent = KeyHeader
Instance.new("UICorner", KeyExitBtn).CornerRadius = UDim.new(0, 6)
KeyExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Key Body
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderText = "Ingrese la Key..."
KeyInput.Text = ""
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6)

KeyCodeLabel.Size = UDim2.new(1, 0, 0, 20)
KeyCodeLabel.Position = UDim2.new(0, 0, 0.58, 0)
KeyCodeLabel.BackgroundTransparency = 1
KeyCodeLabel.Text = "Codigo: nulled_1.0"
KeyCodeLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
KeyCodeLabel.Font = Enum.Font.Code
KeyCodeLabel.TextSize = 12
KeyCodeLabel.Parent = KeyFrame

VerifyBtn.Size = UDim2.new(0.8, 0, 0, 35)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 220)
VerifyBtn.Text = "Verificar"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 14
VerifyBtn.Parent = KeyFrame
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

MakeDraggable(KeyFrame, KeyHeader)

-- ================= INTERFAZ PRINCIPAL Y TOGGLE =================

-- Botón Flotante [NA]
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "NA_Button"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 180, 220)
ToggleButton.Text = "NA"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Visible = false -- Se activa tras verificar key
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0) -- Circular
Instance.new("UIStroke", ToggleButton).Color = Color3.fromRGB(255, 255, 255)
Instance.new("UIStroke", ToggleButton).Thickness = 2
MakeDraggable(ToggleButton)

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainInterface"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Themes.Oscuro.Main
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Lógica Botón NA
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Header Principal
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(220, 220, 220) -- Header siempre claro como imagen
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
local HeaderCover = Instance.new("Frame")
HeaderCover.Size = UDim2.new(1, 0, 0, 15)
HeaderCover.Position = UDim2.new(0, 0, 1, -10)
HeaderCover.BackgroundColor3 = Header.BackgroundColor3
HeaderCover.BorderSizePixel = 0
HeaderCover.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "NULL-IA"
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 22
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, -2)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Text = "v1.0"
VersionBadge.Size = UDim2.new(0, 30, 0, 15)
VersionBadge.Position = UDim2.new(0, 105, 0, 12)
VersionBadge.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
VersionBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
VersionBadge.Font = Enum.Font.GothamBold
VersionBadge.TextSize = 10
VersionBadge.Parent = Header
Instance.new("UICorner", VersionBadge).CornerRadius = UDim.new(0, 4)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Al cerrar principal solo oculta, no destruye
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

MakeDraggable(MainFrame, Header)

-- Panel Lateral (Menú)
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 110, 1, -50)
SidePanel.Position = UDim2.new(0, 0, 0, 50)
SidePanel.BackgroundTransparency = 1
SidePanel.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = SidePanel
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Area de Contenido
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -125, 1, -85)
ContentArea.Position = UDim2.new(0, 120, 0, 50)
ContentArea.BackgroundColor3 = Themes.Oscuro.Content
ContentArea.Parent = MainFrame
Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 8)

-- Footer
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Footer.Parent = MainFrame
Instance.new("UICorner", Footer).CornerRadius = UDim.new(0, 12)
local FooterCover = Instance.new("Frame")
FooterCover.Size = UDim2.new(1, 0, 0, 10)
FooterCover.BackgroundColor3 = Footer.BackgroundColor3
FooterCover.BorderSizePixel = 0
FooterCover.Parent = Footer

-- Botones Footer
local UpdatesBtn = Instance.new("TextButton")
UpdatesBtn.Size = UDim2.new(0, 80, 0, 20)
UpdatesBtn.Position = UDim2.new(0, 10, 0, 5)
UpdatesBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
UpdatesBtn.Text = "Updates"
UpdatesBtn.TextColor3 = Color3.BLACK
UpdatesBtn.Font = Enum.Font.GothamBold
UpdatesBtn.TextSize = 11
UpdatesBtn.Parent = Footer
Instance.new("UICorner", UpdatesBtn).CornerRadius = UDim.new(0, 5)

local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 25, 0, 25)
SettingsBtn.Position = UDim2.new(1, -35, 0, 2.5)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
SettingsBtn.Text = "⚙"
SettingsBtn.TextColor3 = Color3.BLACK
SettingsBtn.Font = Enum.Font.GothamBold
SettingsBtn.TextSize = 14
SettingsBtn.Parent = Footer
Instance.new("UICorner", SettingsBtn).CornerRadius = UDim.new(0, 5)

-- ================= FUNCIONES DE GENERACIÓN =================

local function CreateTabButton(name, text, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 90, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.LayoutOrder = layoutOrder
    btn.Parent = SidePanel
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0,0,0)
    stroke.Thickness = 1.5
    stroke.Parent = btn
    
    return btn
end

local CurrentTabFrame = nil

local function ClearContent()
    if CurrentTabFrame then CurrentTabFrame:Destroy() end
    CurrentTabFrame = Instance.new("ScrollingFrame")
    CurrentTabFrame.Size = UDim2.new(1, -10, 1, -10)
    CurrentTabFrame.Position = UDim2.new(0, 5, 0, 5)
    CurrentTabFrame.BackgroundTransparency = 1
    CurrentTabFrame.ScrollBarThickness = 4
    CurrentTabFrame.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = CurrentTabFrame
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    
    return CurrentTabFrame
end

local function CreateToggle(parent, text, id, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Themes[Config.Theme].Text
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 40, 0, 20)
    btn.Position = UDim2.new(1, -45, 0, 5)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = ""
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0, 2)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = btn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        Config.Toggles[id] = toggled
        
        if toggled then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 200, 100)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0, 2)}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
        
        if callback then callback(toggled) end
    end)
end

-- ================= PESTAÑA: MENÚ =================
local function LoadMenu()
    local scroll = ClearContent()
    CreateToggle(scroll, "Desync", "desync", function(v) print("Desync:", v) end)
    CreateToggle(scroll, "ESP Players", "esp_p", function(v) print("ESP P:", v) end)
    CreateToggle(scroll, "ESP Time", "esp_t", function(v) print("ESP T:", v) end)
    CreateToggle(scroll, "High Best", "high_b", function(v) print("High Best:", v) end)
end

-- ================= PESTAÑA: PVP =================
local function LoadPvP()
    local scroll = ClearContent()
    CreateToggle(scroll, "Aimbot", "aim", function(v) print("Aimbot:", v) end)
    CreateToggle(scroll, "Shift Lock", "shift", function(v) print("Shift:", v) end)
    CreateToggle(scroll, "Speed", "speed", function(v) print("Speed:", v) end)
    CreateToggle(scroll, "Jump Boost", "jump", function(v) print("Jump:", v) end)
    CreateToggle(scroll, "Anti-Hit", "antihit", function(v) print("Anti-Hit:", v) end)
    CreateToggle(scroll, "Auto-Hit", "autohit", function(v) print("Auto-Hit:", v) end)
end

-- ================= PESTAÑA: SCRIPTS =================
local function LoadScripts()
    local scroll = ClearContent()
    
    local editor = Instance.new("TextBox")
    editor.Size = UDim2.new(1, 0, 0, 120)
    editor.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    editor.TextColor3 = Color3.fromRGB(200, 200, 200)
    editor.TextXAlignment = Enum.TextXAlignment.Left
    editor.TextYAlignment = Enum.TextYAlignment.Top
    editor.MultiLine = true
    editor.Font = Enum.Font.Code
    editor.TextSize = 12
    editor.PlaceholderText = "-- Pega tu script Lua aquí..."
    editor.Text = ""
    editor.Parent = scroll
    Instance.new("UICorner", editor).CornerRadius = UDim.new(0, 6)
    
    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(1, 0, 0, 30)
    execBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    execBtn.Text = "Ejecutar Script"
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextColor3 = Color3.WHITE
    execBtn.Parent = scroll
    Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 6)
    
    execBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(editor.Text)()
        end)
        if not success then warn("Error:", err) end
    end)
    
    local clearBtn = Instance.new("TextButton")
    clearBtn.Size = UDim2.new(1, 0, 0, 30)
    clearBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    clearBtn.Text = "Limpiar"
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.TextColor3 = Color3.WHITE
    clearBtn.Parent = scroll
    Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)
    
    clearBtn.MouseButton1Click:Connect(function() editor.Text = "" end)
end

-- ================= PESTAÑA: IA (Simulación) =================
local function LoadIA()
    local scroll = ClearContent()
    
    local chatArea = Instance.new("ScrollingFrame")
    chatArea.Size = UDim2.new(1, 0, 0, 120)
    chatArea.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    chatArea.Parent = scroll
    Instance.new("UICorner", chatArea).CornerRadius = UDim.new(0, 6)
    
    local chatLayout = Instance.new("UIListLayout")
    chatLayout.Parent = chatArea
    chatLayout.Padding = UDim.new(0, 5)
    
    local function addMsg(text, isAi)
        local msg = Instance.new("TextLabel")
        msg.Text = (isAi and "[IA]: " or "[Tú]: ") .. text
        msg.Size = UDim2.new(1, -10, 0, 0)
        msg.AutomaticSize = Enum.AutomaticSize.Y
        msg.BackgroundTransparency = 1
        msg.TextColor3 = isAi and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 255, 255)
        msg.Font = Enum.Font.Code
        msg.TextSize = 12
        msg.TextXAlignment = Enum.TextXAlignment.Left
        msg.TextWrapped = true
        msg.Parent = chatArea
        chatArea.CanvasPosition = Vector2.new(0, 9999)
    end
    
    addMsg("Bienvenido a " .. Config.AIModel .. ". ¿Qué necesitas?", true)
    
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.75, 0, 0, 30)
    input.Position = UDim2.new(0, 0, 0, 130) -- Posición manual relativa
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    input.TextColor3 = Color3.WHITE
    input.PlaceholderText = "Escribe una instrucción..."
    input.Parent = scroll
    Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
    
    local sendBtn = Instance.new("TextButton")
    sendBtn.Size = UDim2.new(0.2, 0, 0, 30)
    sendBtn.Position = UDim2.new(0.8, 0, 0, 130)
    sendBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 220)
    sendBtn.Text = "Enviar"
    sendBtn.TextColor3 = Color3.WHITE
    sendBtn.Parent = scroll
    Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0, 6)
    
    sendBtn.MouseButton1Click:Connect(function()
        if input.Text == "" then return end
        addMsg(input.Text, false)
        local query = input.Text
        input.Text = ""
        
        wait(0.5) -- Simulación de pensamiento
        
        -- Respuestas simuladas de la IA
        local lowerQuery = query:lower()
        
        if lowerQuery:find("script") then
            addMsg("Generando script solicitado...", true)
            wait(1)
            addMsg("-- Script generado por Null-IA (".. Config.AIModel ..")\nprint('Script ejecutado correctamente')", true)
        elseif lowerQuery:find("optimizar") or lowerQuery:find("mejorar") then
             addMsg("Analizando entorno...", true)
             wait(1)
             addMsg("Optimización completada. FPS potenciales +15%.", true)
        elseif lowerQuery:find("hola") or lowerQuery:find("saludo") then
             addMsg("Hola. Soy tu asistente Null-IA. ¿En qué puedo ayudarte hoy?", true)
        else
            addMsg("Procesando solicitud con el modelo " .. Config.AIModel .. "...", true)
            wait(1)
            addMsg("Entendido. Sin embargo, esta función requiere permisos de ejecución de nivel superior.", true)
        end
    end)
end

-- ================= PESTAÑA: CONFIGURACIÓN =================
local function LoadSettings()
    local scroll = ClearContent()
    scroll.CanvasSize = UDim2.new(0, 0, 0, 250)
    
    local layout = scroll:FindFirstChild("UIListLayout")
    layout.Padding = UDim.new(0, 8)

    -- === SECCIÓN IDIOMA ===
    local langBtn = Instance.new("TextButton")
    langBtn.Size = UDim2.new(1, -10, 0, 35)
    langBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    langBtn.Text = "Idioma: " .. Config.Language
    langBtn.TextColor3 = Color3.WHITE
    langBtn.Font = Enum.Font.GothamBold
    langBtn.TextSize = 14
    langBtn.Parent = scroll
    Instance.new("UICorner", langBtn).CornerRadius = UDim.new(0, 6)
    
    langBtn.MouseButton1Click:Connect(function()
        if Config.Language == "Español" then Config.Language = "English"
        elseif Config.Language == "English" then Config.Language = "Chino"
        else Config.Language = "Español" end
        langBtn.Text = "Idioma: " .. Config.Language
    end)

    -- === SECCIÓN MODELO IA ===
    local aiBtn = Instance.new("TextButton")
    aiBtn.Size = UDim2.new(1, -10, 0, 35)
    aiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    aiBtn.Text = "Modelo IA: " .. Config.AIModel
    aiBtn.TextColor3 = Color3.WHITE
    aiBtn.Font = Enum.Font.GothamBold
    aiBtn.TextSize = 14
    aiBtn.Parent = scroll
    Instance.new("UICorner", aiBtn).CornerRadius = UDim.new(0, 6)
    
    aiBtn.MouseButton1Click:Connect(function()
        if Config.AIModel == "Basic" then Config.AIModel = "Pro"
        elseif Config.AIModel == "Pro" then Config.AIModel = "Null-IA"
        else Config.AIModel = "Basic" end
        aiBtn.Text = "Modelo IA: " .. Config.AIModel
    end)

    -- === SECCIÓN TEMAS ===
    local themeLabel = Instance.new("TextLabel")
    themeLabel.Text = "Seleccionar Tema"
    themeLabel.Size = UDim2.new(1, -10, 0, 20)
    themeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    themeLabel.BackgroundTransparency = 1
    themeLabel.Font = Enum.Font.Gotham
    themeLabel.TextXAlignment = Enum.TextXAlignment.Left
    themeLabel.Parent = scroll

    local themeContainer = Instance.new("Frame")
    themeContainer.Size = UDim2.new(1, -10, 0, 40)
    themeContainer.BackgroundTransparency = 1
    themeContainer.Parent = scroll
    
    local grid = Instance.new("UIGridLayout")
    grid.Parent = themeContainer
    grid.CellSize = UDim2.new(0, 30, 0, 30)
    grid.CellPadding = UDim2.new(0, 10, 0, 0)
    
    -- Función para aplicar tema en tiempo real
    local function ApplyThemeColor(themeName)
        Config.Theme = themeName
        local t = Themes[themeName]
        
        -- Aplicar colores a la UI principal
        MainFrame.BackgroundColor3 = t.Main
        ContentArea.BackgroundColor3 = t.Content
        SidePanel.Parent.BackgroundColor3 = t.Main -- Refrescar main
        
        -- Actualizar botones laterales (si existen)
        for _, obj in pairs(SidePanel:GetChildren()) do
            if obj:IsA("TextButton") then
                obj.BackgroundColor3 = Color3.fromRGB(200, 200, 200) -- Base estandar
            end
        end
    end

    -- Generar botones de colores
    for name, colors in pairs(Themes) do
        local b = Instance.new("TextButton")
        b.Name = name
        b.Text = ""
        b.BackgroundColor3 = colors.Main
        b.Parent = themeContainer
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0) -- Redondo
        
        -- Borde para identificar
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Thickness = 1
        stroke.Parent = b
        
        b.MouseButton1Click:Connect(function() ApplyThemeColor(name) end)
    end
    
    -- === SECCIÓN SOFTWARE (Save/Load) ===
    local actionContainer = Instance.new("Frame")
    actionContainer.Size = UDim2.new(1, -10, 0, 35)
    actionContainer.BackgroundTransparency = 1
    actionContainer.LayoutOrder = 5
    actionContainer.Parent = scroll
    
    local actionGrid = Instance.new("UIGridLayout")
    actionGrid.Parent = actionContainer
    actionGrid.CellSize = UDim2.new(0, 85, 0, 30)
    actionGrid.CellPadding = UDim2.new(0, 5, 0, 0)

    local function createActionBtn(text, color)
        local btn = Instance.new("TextButton")
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = Color3.WHITE
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = actionContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end

    local saveBtn = createActionBtn("Save", Color3.fromRGB(46, 139, 87))
    saveBtn.MouseButton1Click:Connect(function() 
        print("Configuración Guardada: ", Config)
        saveBtn.Text = "Guardado!"
        wait(1)
        saveBtn.Text = "Save"
    end)

    local loadBtn = createActionBtn("Load", Color3.fromRGB(70, 130, 180))
    loadBtn.MouseButton1Click:Connect(function() 
        print("Cargando configuración...") 
        loadBtn.Text = "Cargado!"
        wait(1)
        loadBtn.Text = "Load"
    end)

    local resetBtn = createActionBtn("Reset", Color3.fromRGB(178, 34, 34))
    resetBtn.MouseButton1Click:Connect(function() 
        Config.Theme = "Oscuro"
        Config.AIModel = "Basic"
        Config.Language = "Español"
        ApplyThemeColor("Oscuro")
        LoadSettings() -- Recargar pestaña
    end)
end

-- ================= PESTAÑA: UPDATES =================
local function LoadUpdates()
    local scroll = ClearContent()
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -10, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Themes[Config.Theme].Text or Color3.WHITE
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.Font = Enum.Font.Gotham
    text.TextSize = 13
    text.TextWrapped = true
    text.Text = [[
[v1.0 Release]
- Lanzamiento oficial de NULL-IA.
- Sistema de Key integrado (nulled_1.0).
- Soporte para temas (4 colores).
- Chat IA simulado con respuestas.
- Ejecutor de scripts Lua básico integrado.

[Próximamente v1.1]
- Cloud Scripts.
- IA conectada a API real.
- Bypass de seguridad mejorado.
    ]]
    text.Parent = scroll
end

-- ================= CREACIÓN Y CONEXIÓN DE BOTONES LATERALES =================

-- Creamos los botones llamando a la función CreateTabButton definida en la parte 1
local btnMenu = CreateTabButton("MenuBtn", "Menú", 1)
local btnPvP = CreateTabButton("PvPBtn", "PvP", 2)
local btnScripts = CreateTabButton("ScriptsBtn", "Scripts", 3)
local btnIA = CreateTabButton("IABtn", "IA", 4)

-- Conectar eventos de clic a las funciones
btnMenu.MouseButton1Click:Connect(LoadMenu)
btnPvP.MouseButton1Click:Connect(LoadPvP)
btnScripts.MouseButton1Click:Connect(LoadScripts)
btnIA.MouseButton1Click:Connect(LoadIA)

-- Conectar botones del Footer
SettingsBtn.MouseButton1Click:Connect(LoadSettings)
UpdatesBtn.MouseButton1Click:Connect(LoadUpdates)

-- ================= LÓGICA DE VERIFICACIÓN DE KEY =================

VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == Config.Key then
        -- Animación de éxito
        VerifyBtn.Text = "Verificado!"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        wait(0.5)
        
        -- Destruir Key System y mostrar UI
        KeyFrame:Destroy()
        
        -- Mostrar botón flotante
        ToggleButton.Visible = true
        
        -- Mostrar Main Frame
        MainFrame.Visible = true
        
        -- Cargar menú por defecto
        LoadMenu()
        
        -- Notificación (Usando StarterGui estándar)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "NULL-IA";
            Text = "Acceso concedido. Bienvenido.";
            Duration = 5;
        })
    else
        -- Feedback de error
        local originalColor = VerifyBtn.BackgroundColor3
        VerifyBtn.Text = "Key Incorrecta"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        wait(1)
        VerifyBtn.Text = "Verificar"
        VerifyBtn.BackgroundColor3 = originalColor
        KeyInput.Text = ""
    end
end)

-- Inicialización final
print("NULL-IA Executor Cargado Correctamente")
