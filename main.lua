--[[
    Steal a brainrot Jump For Egg Script - Loading Screen
    - Logo + arcade machine artwork, red/yellow arcade card, black backdrop
    - Counts 1 -> 99 over the first 10 seconds, holds at 99%, total 5 minutes
    - Scales to any screen (PC / tablet / phone, portrait + landscape)

    IMAGES: Roblox can only show images that have an asset id.
    1) Upload both pictures at create.roblox.com (Creator Hub > Decals/Images)
    2) Paste the ids below, e.g. "rbxassetid://1234567890"
    Executor alternative: writefile("logo.png", data) then
    LOGO_IMAGE = getcustomasset("logo.png")
    Leave a slot empty ("") and the script falls back gracefully.
]]

local LOGO_IMAGE = ""   -- "STEAL A BRAINROT" logo
local ARCADE_IMAGE = "" -- red arcade machine

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local TITLE = "Steal a brainrot Jump For Egg Script"
local COUNT_TIME = 10 -- 1 -> 99 over 10 seconds
local TOTAL_TIME = 300 -- 5 minutes total
local MAX_COUNT = 99
local SEGMENTS = 18
local CARD_W, DESIGN_H = 560, 504
local IS_TOUCH = UserInputService.TouchEnabled -- phones / tablets

local RED = Color3.fromRGB(226, 46, 52)
local RED_DIM = Color3.fromRGB(150, 24, 34)
local RED_DARK = Color3.fromRGB(110, 14, 24)
local RED_HEAD = Color3.fromRGB(255, 122, 112)
local YELLOW = Color3.fromRGB(255, 214, 10)
local YELLOW_TXT = Color3.fromRGB(255, 226, 40)
local BROWN = Color3.fromRGB(86, 40, 20)
local GRAY_A = Color3.fromRGB(150, 150, 155)
local GRAY_B = Color3.fromRGB(104, 104, 110)

local function new(class, props, parent)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	obj.Parent = parent
	return obj
end

local function getParent()
	local ok, ui = pcall(function()
		return (gethui and gethui()) or game:GetService("CoreGui")
	end)
	if ok and ui then
		return ui
	end
	return Players.LocalPlayer:WaitForChild("PlayerGui")
end

local parent = getParent()
local old = parent:FindFirstChild(TITLE)
if old then
	old:Destroy()
end

local Gui = new("ScreenGui", {
	Name = TITLE,
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	DisplayOrder = 999,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, parent)
pcall(function()
	Gui.ScreenInsets = Enum.ScreenInsets.None
end)

-- Solid black backdrop
local Root = new("CanvasGroup", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0,
	BorderSizePixel = 0,
	GroupTransparency = 1,
	Active = true,
}, Gui)

-- Retro grid lines drifting upward behind everything
local gridLines = {}
for i = 1, 8 do
	gridLines[i] = new("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = RED,
		BackgroundTransparency = 0.86,
		BorderSizePixel = 0,
	}, Root)
end

local particles = {}
local prng = Random.new(21)
for i = 1, (IS_TOUCH and 8 or 16) do -- fewer particles on phones
	local size = prng:NextInteger(4, 9)
	particles[i] = {
		frame = new("Frame", {
			Size = UDim2.fromOffset(size, size),
			BackgroundColor3 = (i % 2 == 0) and YELLOW or RED,
			BackgroundTransparency = prng:NextNumber(0.45, 0.8),
			BorderSizePixel = 0,
		}, Root),
		x = prng:NextNumber(),
		y = prng:NextNumber(),
		speed = prng:NextNumber(0.05, 0.16),
	}
end

-- Holder: fixed design size, scaled to fit any screen
local Holder = new("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.6),
	Size = UDim2.fromOffset(CARD_W, DESIGN_H),
	BackgroundTransparency = 1,
}, Root)

local Fit = new("UIScale", {}, Holder)
local function updateScale()
	local vp = Root.AbsoluteSize
	local cam = Workspace.CurrentCamera
	if (vp.X < 1 or vp.Y < 1) and cam then
		vp = cam.ViewportSize
	end
	local margin = IS_TOUCH and 40 or 24 -- keeps clear of notches / rounded corners
	Fit.Scale = math.clamp(math.min(vp.X / (CARD_W + margin), vp.Y / (DESIGN_H + margin)), 0.3, 2)
end
updateScale()
Root:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScale)
local camConn
local function hookCamera()
	if camConn then
		camConn:Disconnect()
	end
	local cam = Workspace.CurrentCamera
	if cam then
		camConn = cam:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
	end
end
hookCamera()
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	hookCamera()
	updateScale()
end)

-- Card (drop shadow + body)
new("Frame", {
	Position = UDim2.fromOffset(10, 154),
	Size = UDim2.fromOffset(CARD_W, 330),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
	ZIndex = 1,
}, Holder)

local Card = new("Frame", {
	Position = UDim2.fromOffset(0, 144),
	Size = UDim2.fromOffset(CARD_W, 330),
	BackgroundColor3 = RED,
	BorderSizePixel = 0,
	ZIndex = 2,
}, Holder)
local CardStroke = new("UIStroke", { Color = BROWN, Thickness = 6 }, Card)
for _, pos in ipairs({ { 6, 6 }, { 548, 6 }, { 6, 318 }, { 548, 318 } }) do
	new("Frame", {
		Position = UDim2.fromOffset(pos[1], pos[2]),
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = YELLOW,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, Card)
end
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(246, 70, 66), Color3.fromRGB(176, 28, 40)),
}, Card)

-- Logo (overlaps the top of the card). Falls back to text if no image id.
if LOGO_IMAGE ~= "" then
	new("ImageLabel", {
		Position = UDim2.fromOffset(130, 0),
		Size = UDim2.fromOffset(300, 171),
		BackgroundTransparency = 1,
		Image = LOGO_IMAGE,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 6,
	}, Holder)
else
	new("TextLabel", {
		Position = UDim2.fromOffset(0, 60),
		Size = UDim2.fromOffset(CARD_W, 60),
		BackgroundTransparency = 1,
		Font = Enum.Font.Arcade,
		Text = "STEAL A BRAINROT",
		TextColor3 = YELLOW_TXT,
		TextSize = 38,
		ZIndex = 6,
	}, Holder)
end

-- Arcade art on the left; if missing the panel uses the full width
local hasArt = ARCADE_IMAGE ~= ""
local panelX = hasArt and 176 or 16
local panelW = hasArt and 368 or 528
if hasArt then
	-- soft yellow glow behind the machine
	local glow = new("Frame", {
		Position = UDim2.fromOffset(-6, 14),
		Size = UDim2.fromOffset(172, 187),
		BackgroundColor3 = YELLOW,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		ZIndex = 4,
	}, Card)
	new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, glow)
	new("ImageLabel", {
		Position = UDim2.fromOffset(10, 24),
		Size = UDim2.fromOffset(150, 167),
		BackgroundTransparency = 1,
		Image = ARCADE_IMAGE,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 5,
	}, Card)
end

-- Main yellow panel
local Panel = new("Frame", {
	Position = UDim2.fromOffset(panelX, 34),
	Size = UDim2.fromOffset(panelW, 150),
	BackgroundColor3 = YELLOW,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Card)
new("UIStroke", { Color = RED_DARK, Thickness = 4 }, Panel)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(255, 232, 90), Color3.fromRGB(255, 200, 10)),
}, Panel)

for i = 0, 37 do -- scanlines
	new("Frame", {
		Position = UDim2.fromOffset(0, i * 4),
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = Color3.fromRGB(255, 240, 120),
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
	}, Panel)
end

local Percent = new("TextLabel", {
	Position = UDim2.fromOffset(0, 8),
	Size = UDim2.new(1, 0, 0, 56),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "1%",
	TextColor3 = RED_DARK,
	TextSize = 54,
}, Panel)
new("UIStroke", { Color = Color3.fromRGB(255, 246, 170), Thickness = 2 }, Percent)

local BarBack = new("Frame", {
	Position = UDim2.fromOffset(12, 72),
	Size = UDim2.fromOffset(panelW - 24, 34),
	BackgroundColor3 = RED_DARK,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Panel)
new("UIStroke", { Color = Color3.fromRGB(70, 8, 16), Thickness = 3 }, BarBack)
new("UIPadding", {
	PaddingLeft = UDim.new(0, 4),
	PaddingRight = UDim.new(0, 1),
	PaddingTop = UDim.new(0, 4),
	PaddingBottom = UDim.new(0, 4),
}, BarBack)

local segs = {}
for i = 1, SEGMENTS do
	segs[i] = new("Frame", {
		Position = UDim2.new((i - 1) / SEGMENTS, 0, 0, 0),
		Size = UDim2.new(1 / SEGMENTS, -3, 1, 0),
		BackgroundColor3 = RED_DIM,
		BorderSizePixel = 0,
	}, BarBack)
end

local Shine = new("Frame", {
	Size = UDim2.new(0, 36, 1, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.75,
	BorderSizePixel = 0,
	ZIndex = 3,
}, BarBack)
new("Frame", {
	Size = UDim2.new(1, 0, 0.4, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
	ZIndex = 4,
}, BarBack)

for _, f in ipairs({ 0.25, 0.5, 0.75 }) do -- 25/50/75% ticks
	new("Frame", {
		Position = UDim2.fromOffset(12 + (panelW - 24) * f, 108),
		Size = UDim2.fromOffset(3, 6),
		BackgroundColor3 = RED_DARK,
		BorderSizePixel = 0,
	}, Panel)
end

local Status = new("TextLabel", {
	Position = UDim2.fromOffset(0, 116),
	Size = UDim2.new(1, 0, 0, 26),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "> Loading assets",
	TextColor3 = BROWN,
	TextSize = 20,
}, Panel)

-- Footer
local Wait = new("TextLabel", {
	Position = UDim2.fromOffset(0, 202),
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "PLEASE WAIT.",
	TextColor3 = YELLOW_TXT,
	TextSize = 26,
}, Card)

local Checker = new("Frame", {
	Position = UDim2.fromOffset(16, 240),
	Size = UDim2.fromOffset(528, 28),
	BackgroundColor3 = GRAY_B,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Card)
new("UIStroke", { Color = BROWN, Thickness = 3 }, Checker)

local CHECKS = 14
local checks = {}
for i = 1, CHECKS do
	checks[i] = new("Frame", {
		Position = UDim2.new((i - 1) / CHECKS, 0, 0, 0),
		Size = UDim2.new(1 / CHECKS, 0, 1, 0),
		BackgroundColor3 = GRAY_A,
		BorderSizePixel = 0,
	}, Checker)
end

-- Script name ribbon
local Ribbon = new("Frame", {
	Position = UDim2.fromOffset(16, 284),
	Size = UDim2.fromOffset(528, 32),
	BackgroundColor3 = Color3.fromRGB(22, 20, 62),
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Card)
new("UIStroke", { Color = RED_DARK, Thickness = 3 }, Ribbon)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(40, 34, 104), Color3.fromRGB(14, 12, 40)),
}, Ribbon)
new("TextLabel", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "Jump For Eggs LTM Auto Get Egg Script",
	TextColor3 = YELLOW_TXT,
	TextSize = 18,
}, Ribbon)
local RibbonShine = new("Frame", {
	Size = UDim2.new(0, 40, 1, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
}, Ribbon)

local Flash = new("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 20,
}, Card)

-- Rotating tips under the card
local tips = {
	"TIP: Stay in the game while it loads",
	"TIP: Auto Get Egg starts when loading ends",
	"TIP: Made for PC and mobile players",
	"TIP: Almost there, hang tight",
}
local Tip = new("TextLabel", {
	Position = UDim2.fromOffset(0, 480),
	Size = UDim2.fromOffset(CARD_W, 22),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = tips[1],
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 16,
}, Holder)
local lastTip, lastStatus = 0, ""

-- Sparkles around the logo
local sparkles = {}
for i, pos in ipairs({ { 116, 34 }, { 436, 22 }, { 138, 138 }, { 424, 150 } }) do
	sparkles[i] = new("Frame", {
		Position = UDim2.fromOffset(pos[1], pos[2]),
		Size = UDim2.fromOffset(9, 9),
		Rotation = 45,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
		ZIndex = 7,
	}, Holder)
end

-- Intro
TweenService:Create(Root, TweenInfo.new(0.35), { GroupTransparency = 0 }):Play()
TweenService:Create(
	Holder,
	TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{ Position = UDim2.fromScale(0.5, 0.5) }
):Play()

-- Logic
local messages = {
	{ 1, "> Loading assets" },
	{ 25, "> Hatching eggs" },
	{ 50, "> Setting up Egg ESP" },
	{ 75, "> Charging jump" },
	{ 95, "> Almost there" },
}
local holdMessages = {
	"> Finalizing scripts",
	"> Warming up eggs",
	"> Syncing jump power",
	"> Polishing brainrots",
	"> Almost ready to steal",
}

local elapsed, lastShown, finished = 0, -1, false
local conn

conn = RunService.Heartbeat:Connect(function(dt)
	elapsed += dt

	local n = math.clamp(math.floor(1 + (elapsed / COUNT_TIME) * (MAX_COUNT - 1) + 0.5), 1, MAX_COUNT)
	if n ~= lastShown then
		lastShown = n
		Percent.Text = n .. "%"
		if n < MAX_COUNT then
			for _, m in ipairs(messages) do
				if n >= m[1] then
					Status.Text = m[2]
				end
			end
		end
	end

	if elapsed > COUNT_TIME then
		local idx = math.floor((elapsed - COUNT_TIME) / 8) % #holdMessages + 1
		local st = holdMessages[idx] .. string.rep(".", math.floor(elapsed * 2) % 4)
		if st ~= lastStatus then -- only touch the label when the text changes
			lastStatus = st
			Status.Text = st
		end
	end

	local lit = math.max(1, math.min(SEGMENTS, math.ceil(n / MAX_COUNT * SEGMENTS)))
	local headFlash = (math.floor(elapsed * 10) % 2 == 0) and RED_HEAD or YELLOW
	for i, s in ipairs(segs) do
		if i < lit then
			s.BackgroundColor3 = RED
		elseif i == lit then
			s.BackgroundColor3 = headFlash
		else
			s.BackgroundColor3 = RED_DIM
		end
	end

	Shine.Position = UDim2.fromOffset(((elapsed * 0.6) % 1.3 - 0.15) * (panelW - 24), 0)

	CardStroke.Color = BROWN:Lerp(YELLOW, (math.sin(elapsed * 2) + 1) / 2 * 0.35) -- border glow

	local shift = math.floor(elapsed * 8)
	for i, c in ipairs(checks) do
		c.BackgroundColor3 = ((i + shift) % 2 == 0) and GRAY_A or GRAY_B
	end

	for _, p in ipairs(particles) do
		p.y -= p.speed * dt
		if p.y < -0.05 then
			p.y = 1.05
		end
		p.frame.Position = UDim2.fromScale(p.x, p.y)
	end

	for i, g in ipairs(gridLines) do
		g.Position = UDim2.fromScale(0, ((i / 8) + elapsed * 0.03) % 1)
	end
	local ti = math.floor(elapsed / 5) % #tips + 1
	if ti ~= lastTip then
		lastTip = ti
		Tip.Text = tips[ti]
	end
	local ph = elapsed % 5 -- fade in / out at the edges of each tip
	local fade = ph < 0.4 and (1 - ph / 0.4) or (ph > 4.6 and (ph - 4.6) / 0.4 or 0)
	Tip.TextTransparency = 0.15 + fade * 0.85
	for i, sp in ipairs(sparkles) do
		sp.BackgroundTransparency = 1 - math.abs(math.sin(elapsed * 3 + i * 1.7)) * 0.8
	end
	RibbonShine.Position = UDim2.fromOffset(((elapsed * 0.35) % 1.4 - 0.2) * 528, 0)

	Wait.TextTransparency = (math.floor(elapsed * 3) % 2 == 0) and 0 or 0.35

	if elapsed >= TOTAL_TIME and not finished then
		finished = true
		conn:Disconnect()
		Percent.Text = "100%"
		for _, s in ipairs(segs) do
			s.BackgroundColor3 = RED
		end
		Status.Text = "> Ready to steal"
		Wait.Text = "GAME START!"
		Wait.TextTransparency = 0

		Flash.BackgroundTransparency = 0.3
		TweenService:Create(Flash, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()

		task.delay(0.6, function()
			local tween = TweenService:Create(Root, TweenInfo.new(0.5), { GroupTransparency = 1 })
			tween:Play()
			tween.Completed:Wait()
			Gui:Destroy()

			-- ===== PUT YOUR MAIN SCRIPT BELOW THIS LINE =====

		end)
	end
end)
