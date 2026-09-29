--[[
    Steal a brainrot Jump For Egg Script
    Arcade loading screen (red + yellow) - PC, tablet and phone friendly
    - Counts 1 -> 99 in the first 10 seconds, then holds at 99%
    - Whole loading screen lasts 5 minutes
    - Auto-scales to any screen size / rotation (portrait + landscape)
    Put your main script where marked at the bottom.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local TITLE = "Steal a brainrot Jump For Egg Script"
local COUNT_TIME = 10     -- seconds to go 1 -> 99
local TOTAL_TIME = 300    -- total loading time (5 minutes)
local MAX_COUNT = 99
local SEGMENTS = 24

local CARD_W, CARD_H = 560, 380

local RED = Color3.fromRGB(226, 46, 52)
local RED_DIM = Color3.fromRGB(150, 24, 34)
local RED_DARK = Color3.fromRGB(110, 14, 24)
local RED_HEAD = Color3.fromRGB(255, 122, 112)
local YELLOW = Color3.fromRGB(255, 214, 10)
local YELLOW_TXT = Color3.fromRGB(255, 226, 40)
local NAVY = Color3.fromRGB(22, 20, 62)
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

-- ROOT (dim backdrop, fades in/out as a whole)
local Root = new("CanvasGroup", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.fromRGB(18, 8, 26),
	BackgroundTransparency = 0.2,
	BorderSizePixel = 0,
	GroupTransparency = 1,
	Active = true, -- blocks taps/clicks behind the loading screen
}, Gui)

-- Floating pixel particles
local particles = {}
local prng = Random.new(21)
for i = 1, 16 do
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

-- HOLDER: fixed 560x380 design, scaled to fit any screen (PC / tablet / phone)
local Holder = new("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.6),
	Size = UDim2.fromOffset(CARD_W, CARD_H),
	BackgroundTransparency = 1,
}, Root)

local Fit = new("UIScale", {}, Holder)
local function updateScale()
	local cam = Workspace.CurrentCamera
	if not cam then
		return
	end
	local vp = cam.ViewportSize
	Fit.Scale = math.clamp(math.min(vp.X / (CARD_W + 24), vp.Y / (CARD_H + 24)), 0.3, 2)
end
updateScale()
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

-- Drop shadow
new("Frame", {
	Position = UDim2.fromOffset(10, 10),
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(0, 0, 0),
	BackgroundTransparency = 0.5,
	BorderSizePixel = 0,
	ZIndex = 1,
}, Holder)

local Card = new("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = RED,
	BorderSizePixel = 0,
	ZIndex = 2,
}, Holder)
new("UIStroke", { Color = BROWN, Thickness = 6 }, Card)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(246, 70, 66), Color3.fromRGB(176, 28, 40)),
}, Card)

for _, pos in ipairs({ { 5, 5 }, { 549, 5 }, { 5, 369 }, { 549, 369 } }) do
	new("Frame", {
		Position = UDim2.fromOffset(pos[1], pos[2]),
		Size = UDim2.fromOffset(6, 6),
		BackgroundColor3 = YELLOW,
		BorderSizePixel = 0,
	}, Card)
end

-- HEADER
local Header = new("Frame", {
	Position = UDim2.fromOffset(16, 16),
	Size = UDim2.fromOffset(528, 54),
	BackgroundColor3 = NAVY,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Card)
new("UIStroke", { Color = RED_DARK, Thickness = 3 }, Header)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(40, 34, 104), Color3.fromRGB(14, 12, 40)),
}, Header)

local twinkles = {}
local rng = Random.new(7)
for i = 1, 26 do
	twinkles[i] = new("Frame", {
		Position = UDim2.new(rng:NextNumber(), 0, rng:NextNumber(), 0),
		Size = UDim2.fromOffset(3, 3),
		BackgroundColor3 = YELLOW,
		BackgroundTransparency = rng:NextNumber(0.3, 0.7),
		BorderSizePixel = 0,
	}, Header)
end

new("TextLabel", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "STEAL A BRAINROT",
	TextColor3 = YELLOW_TXT,
	TextSize = 32,
}, Header)

local Star = new("Frame", {
	Position = UDim2.fromOffset(470, 19),
	Size = UDim2.fromOffset(16, 16),
	BackgroundTransparency = 1,
}, Header)
new("Frame", { Position = UDim2.fromOffset(6, 0), Size = UDim2.fromOffset(4, 16), BackgroundColor3 = YELLOW, BorderSizePixel = 0 }, Star)
new("Frame", { Position = UDim2.fromOffset(0, 6), Size = UDim2.fromOffset(16, 4), BackgroundColor3 = YELLOW, BorderSizePixel = 0 }, Star)
new("Frame", { Position = UDim2.fromOffset(4, 4), Size = UDim2.fromOffset(8, 8), BackgroundColor3 = YELLOW, BorderSizePixel = 0 }, Star)

-- SUBTITLE
new("TextLabel", {
	Position = UDim2.fromOffset(0, 78),
	Size = UDim2.new(1, 0, 0, 26),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamBlack,
	RichText = true,
	Text = '<font color="#FFFFFF">Steal a brainrot</font> <font color="#FFB81C">Jump For Egg Script</font>',
	TextSize = 22,
}, Card)

-- MAIN YELLOW PANEL
local Panel = new("Frame", {
	Position = UDim2.fromOffset(16, 112),
	Size = UDim2.fromOffset(528, 176),
	BackgroundColor3 = YELLOW,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, Card)
new("UIStroke", { Color = RED_DARK, Thickness = 4 }, Panel)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new(Color3.fromRGB(255, 232, 90), Color3.fromRGB(255, 200, 10)),
}, Panel)

for i = 0, 43 do
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
	Size = UDim2.new(1, 0, 0, 60),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "1%",
	TextColor3 = RED_DARK,
	TextSize = 60,
	TextXAlignment = Enum.TextXAlignment.Center,
}, Panel)

local BarBack = new("Frame", {
	Position = UDim2.fromOffset(12, 76),
	Size = UDim2.fromOffset(504, 34),
	ClipsDescendants = true,
	BackgroundColor3 = RED_DARK,
	BorderSizePixel = 0,
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

-- Shine that sweeps across the bar
local Shine = new("Frame", {
	Size = UDim2.new(0, 36, 1, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.75,
	BorderSizePixel = 0,
	ZIndex = 3,
}, BarBack)

-- Glossy highlight on the top half of the bar
new("Frame", {
	Size = UDim2.new(1, 0, 0.4, 0),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.85,
	BorderSizePixel = 0,
	ZIndex = 4,
}, BarBack)

local Status = new("TextLabel", {
	Position = UDim2.fromOffset(0, 124),
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "> Loading assets",
	TextColor3 = BROWN,
	TextSize = 22,
	TextXAlignment = Enum.TextXAlignment.Center,
}, Panel)

-- EGG ICONS
local function makeEgg(x, y, rot)
	local egg = new("Frame", {
		Position = UDim2.fromOffset(x, y),
		Size = UDim2.fromOffset(28, 34),
		BackgroundColor3 = YELLOW,
		Rotation = rot,
		BorderSizePixel = 0,
		ZIndex = 5,
	}, Card)
	new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, egg)
	new("UIStroke", { Color = RED_DARK, Thickness = 3 }, egg)
	new("Frame", { Position = UDim2.fromOffset(7, 9), Size = UDim2.fromOffset(6, 6), BackgroundColor3 = RED, BorderSizePixel = 0, ZIndex = 6 }, egg)
	new("Frame", { Position = UDim2.fromOffset(15, 20), Size = UDim2.fromOffset(6, 6), BackgroundColor3 = RED, BorderSizePixel = 0, ZIndex = 6 }, egg)
	return egg
end
local EggL = makeEgg(20, 262, -8)
local EggR = makeEgg(514, 262, 8)

-- FOOTER
local Wait = new("TextLabel", {
	Position = UDim2.fromOffset(0, 296),
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.Arcade,
	Text = "PLEASE WAIT.",
	TextColor3 = YELLOW_TXT,
	TextSize = 26,
}, Card)

local Checker = new("Frame", {
	Position = UDim2.fromOffset(16, 334),
	Size = UDim2.fromOffset(528, 30),
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

-- White flash used on finish
local Flash = new("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 20,
}, Card)

-- INTRO
TweenService:Create(Root, TweenInfo.new(0.35), { GroupTransparency = 0 }):Play()
TweenService:Create(
	Holder,
	TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{ Position = UDim2.fromScale(0.5, 0.5) }
):Play()

-- LOGIC
-- Status text while counting 1 -> 99
local messages = {
	{ 0, "> Loading assets" },
	{ 25, "> Hatching eggs" },
	{ 50, "> Setting up Egg ESP" },
	{ 75, "> Charging jump" },
	{ 95, "> Almost there" },
}
-- Status text rotated every 8s while holding at 99% (until 5:00 is up)
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

	-- 1 -> 99 in COUNT_TIME seconds, then stays on 99
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

	-- After the count, rotate messages + animated dots
	if elapsed > COUNT_TIME then
		local idx = math.floor((elapsed - COUNT_TIME) / 8) % #holdMessages + 1
		Status.Text = holdMessages[idx] .. string.rep(".", math.floor(elapsed * 2) % 4)
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

	local shift = math.floor(elapsed * 8)
	for i, c in ipairs(checks) do
		c.BackgroundColor3 = ((i + shift) % 2 == 0) and GRAY_A or GRAY_B
	end

	Star.Rotation = math.sin(elapsed * 4) * 15
	Shine.Position = UDim2.fromOffset(((elapsed * 0.6) % 1.3 - 0.15) * 504, 0)

	for i, t in ipairs(twinkles) do
		t.BackgroundTransparency = 0.3 + 0.5 * math.abs(math.sin(elapsed * 3 + i))
	end

	for _, p in ipairs(particles) do
		p.y -= p.speed * dt
		if p.y < -0.05 then
			p.y = 1.05
		end
		p.frame.Position = UDim2.fromScale(p.x, p.y)
	end

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
