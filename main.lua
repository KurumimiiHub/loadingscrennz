-- LUCKY BLOCK LUCKER v3 | Loading screen only | Solara version (paste into Solara and press Execute)
-- Optional skull picture (pick ONE, or leave both empty for the "? ?" fallback):
local SKULL_URL = ""      -- direct link to skull.png (e.g. a raw.githubusercontent.com link)
local SKULL_IMAGE_ID = 0  -- or a Roblox image Asset ID you uploaded
-- (if both are empty, the built-in skull picture below is used automatically)
local SKULL_B64 = [==[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]==]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- remove old copy if you execute twice
for _, parent in ipairs({playerGui, game:GetService("CoreGui"), gethui and gethui() or nil}) do
	pcall(function() local old = parent:FindFirstChild("LuckyBlockLucker"); if old then old:Destroy() end end)
end

local function parentGui(g)
	pcall(function() if syn and syn.protect_gui then syn.protect_gui(g) end end)
	pcall(function() g.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
	if not g.Parent then g.Parent = playerGui end
end

local function loadSkullFromUrl()
	local ok, asset = pcall(function()
		writefile("lbl_skull.png", game:HttpGet(SKULL_URL))
		return (getcustomasset or getsynasset)("lbl_skull.png")
	end)
	return ok and asset or nil
end
local function b64decode(data)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local lookup = {}
	for i = 1, 64 do lookup[chars:byte(i)] = i - 1 end
	local out, n, buffer, bits = {}, 0, 0, 0
	for i = 1, #data do
		local v = lookup[data:byte(i)]
		if v then
			buffer = buffer * 64 + v
			bits = bits + 6
			if bits >= 8 then
				bits = bits - 8
				n = n + 1
				out[n] = string.char(math.floor(buffer / 2 ^ bits))
				buffer = buffer % 2 ^ bits
			end
		end
	end
	return table.concat(out)
end

local function loadEmbeddedSkull()
	local ok, asset = pcall(function()
		writefile("lbl_skull.png", b64decode(SKULL_B64))
		return (getcustomasset or getsynasset)("lbl_skull.png")
	end)
	return ok and asset or nil
end

local skullAsset = (SKULL_IMAGE_ID ~= 0 and ("rbxassetid://" .. SKULL_IMAGE_ID))
	or (SKULL_URL ~= "" and loadSkullFromUrl()) or loadEmbeddedSkull()

-- ============ LOADING SCREEN (full screen, phone + PC) ============
local LOAD_SECONDS = 135 -- 2 min 15 s (change to make it shorter/longer)
do
	local StarterGui = game:GetService("StarterGui")
	local C = {pink = Color3.fromRGB(240,226,226), pink2 = Color3.fromRGB(214,196,198), gray = Color3.fromRGB(150,132,136),
		dark = Color3.fromRGB(24,22,26), white = Color3.fromRGB(255,255,255), green = Color3.fromRGB(120,200,120)}
	local FT, FB = Enum.Font.FredokaOne, Enum.Font.GothamBold
	local function mk(class, props, parent)
		local o = Instance.new(class)
		for k, v in pairs(props) do o[k] = v end
		o.Parent = parent
		return o
	end
	local function label(parent, order, size, text, font, color, maxText, align)
		local l = mk("TextLabel", {LayoutOrder = order, Size = size, BackgroundTransparency = 1, Text = text, Font = font,
			TextColor3 = color, TextScaled = true, TextWrapped = true, TextXAlignment = align or Enum.TextXAlignment.Center}, parent)
		mk("UITextSizeConstraint", {MaxTextSize = maxText}, l)
		return l
	end
	for _, p in ipairs({playerGui, game:GetService("CoreGui"), gethui and gethui() or nil}) do
		pcall(function() local o = p:FindFirstChild("LuckyBlockLuckerLoading"); if o then o:Destroy() end end)
	end

	local lg = mk("ScreenGui", {Name = "LuckyBlockLuckerLoading", ResetOnSpawn = false, IgnoreGuiInset = true,
		DisplayOrder = 999999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, nil)
	pcall(function() lg.ScreenInsets = Enum.ScreenInsets.None end)
	local root = mk("Frame", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0}, lg) -- plain Frame (no CanvasGroup = no dimming)
	-- gradient lives on its own frame (a gradient on the CanvasGroup itself would darken everything inside it)
	local bg = mk("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = C.white, BorderSizePixel = 0}, root)
	mk("UIGradient", {Color = ColorSequence.new(Color3.fromRGB(34,27,36), Color3.fromRGB(10,9,12)), Rotation = 90}, bg)
	mk("TextButton", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", AutoButtonColor = false}, root) -- blocks clicks

	for _ = 1, 14 do -- floating voxel squares
		local s = math.random(14, 34)
		local sq = mk("Frame", {Size = UDim2.fromOffset(s, s), Position = UDim2.fromScale(math.random(), 1.1),
			BackgroundColor3 = C.pink, BackgroundTransparency = 0.88, BorderSizePixel = 0}, root)
		task.spawn(function()
			task.wait(math.random() * 6)
			while lg.Parent do
				local x, t = math.random(), math.random(10, 20)
				sq.Position = UDim2.fromScale(x, 1.1)
				TweenService:Create(sq, TweenInfo.new(t, Enum.EasingStyle.Linear), {Position = UDim2.fromScale(x, -0.2), Rotation = math.random(-90, 90)}):Play()
				task.wait(t)
			end
		end)
	end

	local card = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.86, 0.86), BackgroundTransparency = 1}, root)
	mk("UISizeConstraint", {MaxSize = Vector2.new(480, 420)}, card)
	mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.025, 0)}, card)

	local holder = mk("Frame", {LayoutOrder = 1, Size = UDim2.fromScale(1, 0.3), BackgroundTransparency = 1}, card)
	local glow = mk("Frame", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = C.pink, BackgroundTransparency = 0.9, BorderSizePixel = 0}, holder)
	mk("UICorner", {CornerRadius = UDim.new(1, 0)}, glow)
	mk("UIAspectRatioConstraint", {AspectRatio = 1}, glow)
	TweenService:Create(glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.78}):Play()
	local skull
	if skullAsset then
		skull = mk("ImageLabel", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1, Image = skullAsset}, holder)
		mk("UIAspectRatioConstraint", {AspectRatio = 1.678}, skull)
	else
		skull = label(holder, 1, UDim2.fromScale(1, 1), "? ?", FT, C.pink, 60)
		skull.AnchorPoint = Vector2.new(0.5, 0.5); skull.Position = UDim2.fromScale(0.5, 0.5)
	end
	skull.Rotation = -3
	TweenService:Create(skull, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{Position = UDim2.fromScale(0.5, 0.44), Rotation = 3}):Play()

	label(card, 2, UDim2.fromScale(1, 0.12), "LUCKY BLOCK LUCKER", FT, C.pink, 36)
	local stageLbl = label(card, 3, UDim2.fromScale(1, 0.07), "Starting up", FB, C.pink2, 18)

	local bar = mk("Frame", {LayoutOrder = 4, Size = UDim2.fromScale(0.9, 0.07), BackgroundColor3 = C.dark, ClipsDescendants = true}, card)
	mk("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)
	mk("UIStroke", {Color = C.gray, Thickness = 2}, bar)
	local fill = mk("Frame", {Size = UDim2.fromScale(0, 1), BackgroundColor3 = C.pink, BorderSizePixel = 0, ClipsDescendants = true}, bar)
	mk("UICorner", {CornerRadius = UDim.new(1, 0)}, fill)
	local shine = mk("Frame", {Size = UDim2.fromScale(0.25, 1), Position = UDim2.fromScale(-0.3, 0), BackgroundColor3 = C.white,
		BackgroundTransparency = 0.6, BorderSizePixel = 0}, fill)
	TweenService:Create(shine, TweenInfo.new(1.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Position = UDim2.fromScale(1.1, 0)}):Play()

	local row = mk("Frame", {LayoutOrder = 5, Size = UDim2.fromScale(0.9, 0.06), BackgroundTransparency = 1}, card)
	local pct = label(row, 1, UDim2.fromScale(1, 1), "0%", FB, C.white, 16)

	local TIPS = {"Tip: good things come to those who wait.", "Tip: lucky blocks can drop rare items.", "Tip: stay close, the loading will finish soon.",
		"Tip: rare drops are worth the wait."}
	local stepRow = mk("Frame", {LayoutOrder = 6, Size = UDim2.new(0.9, 0, 0, 16), BackgroundTransparency = 1}, card)
	mk("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, stepRow)
	local steps = {}
	for i = 1, 5 do
		steps[i] = mk("Frame", {LayoutOrder = i, Size = UDim2.fromOffset(14, 14), BackgroundColor3 = C.dark, BorderSizePixel = 0}, stepRow)
		mk("UIStroke", {Color = C.gray, Thickness = 1}, steps[i])
	end
	local tipLbl = label(card, 7, UDim2.fromScale(0.9, 0.09), TIPS[1], FB, C.gray, 14)


	local WP = {{0,0},{.05,.10},{.15,.28},{.25,.34},{.45,.62},{.55,.65},{.75,.86},{.88,.93},{.95,.98},{1,1}}
	local function prog(f)
		for i = 2, #WP do
			local a, b = WP[i-1], WP[i]
			if f <= b[1] then return a[2] + (b[2] - a[2]) * ((f - a[1]) / (b[1] - a[1])) end
		end
		return 1
	end
	local STAGES = {{0,"Starting up"},{.10,"Checking environment"},{.25,"Loading modules"},{.45,"Preparing interface"},
		{.65,"Optimizing"},{.85,"Almost there"},{.97,"Finalizing"}}

	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false) end)
	parentGui(lg)

	local function fadeAll(dur)
		for _, d in ipairs(root:GetDescendants()) do
			local goal
			if d:IsA("TextButton") or d:IsA("TextLabel") then goal = {TextTransparency = 1, BackgroundTransparency = 1}
			elseif d:IsA("ImageLabel") then goal = {ImageTransparency = 1, BackgroundTransparency = 1}
			elseif d:IsA("Frame") then goal = {BackgroundTransparency = 1}
			elseif d:IsA("UIStroke") then goal = {Transparency = 1} end
			if goal then TweenService:Create(d, TweenInfo.new(dur), goal):Play() end
		end
	end

	local t0 = os.clock()
	while true do
		local t = os.clock() - t0
		if t >= LOAD_SECONDS then break end
		local p = prog(t / LOAD_SECONDS)
		fill.Size = UDim2.fromScale(p, 1)
		pct.Text = math.floor(p * 100) .. "%"
		local msg = STAGES[1][2]
		for _, s in ipairs(STAGES) do if p >= s[1] then msg = s[2] end end
		stageLbl.Text = msg .. string.rep(".", math.floor(t * 2) % 4)
		tipLbl.Text = TIPS[math.floor(t / 6) % #TIPS + 1]
		for i, sq in ipairs(steps) do sq.BackgroundColor3 = p >= (i - 1) * 0.2 and C.pink or C.dark end
		task.wait(0.1)
	end

	pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) end)
	fill.Size = UDim2.fromScale(1, 1); pct.Text = "100%"; stageLbl.Text = "Ready!"; fill.BackgroundColor3 = C.green
	task.wait(0.6)
	fadeAll(0.5)
	task.wait(0.55)
	lg:Destroy()
end
-- ============ END ============
