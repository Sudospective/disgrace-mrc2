-- thanks xero for forgetting to do this
setdefault {100, 'zoomz'}

----------------
-- spellcards --
----------------

card {32, 60, 'buildup 1', 5, '#BFBF4C'}
card {64, 128, 'DROP I', 10, '#EAEC6D'}

card {128, 144, 'abandon all hope', 10, '#7BACF6'}
card {144, 152, 'bounce bounce revolution', 6, '#00CC00'}
card {159, 160, 'did you hit it?', 6, '#4A4A62'}

card {162, 188, 'calm down a moment', 4, '#627BB4'}
card {192, 224, 'd-pad or not d-pad?', 9, '#BFBF4C'}
card {224, 252, 'buildup 2', 8, '#627BB4'}

card {256, 320, 'DROP II Returns: Electric Boogaloo (Again!)', 8, '#7BACF6'}
card {320, 351, 'e', 8, '#EAEC6D'}
card {351.02, 351.98, '', 0, '#000000'}

card {352, 432, 'spiral of madness', 8, '#627BB4'}

-------------------------
-- functions and stuff --
-------------------------

local sin, cos = math.sin, math.cos
local PI = math.pi
local sqrt = math.sqrt
local exp = math.exp
local min, max = math.min, math.max
local gmatch = string.gmatch or string.gfind

local ystandard = THEME:GetMetric('Player', 'ReceptorArrowsYStandard')
local yreverse = THEME:GetMetric('Player', 'ReceptorArrowsYReverse')
local yorig = (ystandard + yreverse) * 0.5

local function _q(t)
	return t < 1 and 1 or 0
end

local function onebeat(b, amt)
	ease {b - 0.5, 1, _q, amt, "beat"}
end

local function vibro(t)
	if t == 0 then
		for pn = 1, 2 do
			P[pn]:stopeffect()
		end
	else
		for pn = 1, 2 do
			P[pn]:vibrate()
			P[pn]:effectmagnitude(t, t, 0)
		end
	end
end

local function vibrox(t)
	if t == 0 then
		for pn = 1, 2 do
			P[pn]:stopeffect()
		end
	else
		for pn = 1, 2 do
			P[pn]:vibrate()
			P[pn]:effectmagnitude(t, 0, 0)
		end
	end
end

local function aftvibro(t)
	AFTSpriteR:effectmagnitude(t + 2, t, 0)
	AFTSpriteG:effectmagnitude(t + 2, t, 0)
	AFTSpriteB:effectmagnitude(t + 2, t, 0)
end

local function aftvibrox(t)
	AFTSpriteR:effectmagnitude(t + 2, 0, 0)
	AFTSpriteG:effectmagnitude(t + 2, 0, 0)
	AFTSpriteB:effectmagnitude(t + 2, 0, 0)
end

local function aftxoffset(t)
	AFTSpriteR:x2(t * -0.5)
	--AFTSpriteG:x2(t)
	AFTSpriteB:x2(t * 0.5)
end

local function aftyoffset(t)
	AFTSpriteR:y2(t * -0.5)
	--AFTSpriteG:y2(t)
	AFTSpriteB:y2(t * 0.5)
end

local function aftzoom(t)
	AFTSpriteR:zoom(exp(-t))
	AFTSpriteB:zoom(exp(t))
end

local function _aftunhide() AFT:hidden(0) end
local function _afthide() AFT:hidden(1) end

local function aftpause(b, l)
	func {b, _aftunhide; persist = false}
	func {b + 0.2, _afthide; persist = false}
	func {b + l, _aftunhide}
end

local function coveramt(t)
	HideBehindAFT:diffusealpha(t)
end

local function aftamt(t)
	AFTSpriteR:diffusealpha(t)
	AFTSpriteG:diffusealpha(t)
	AFTSpriteB:diffusealpha(t)
end

-----------------------
-- initial functions --
-----------------------

func {0,
	function()
		for pn = 1, 2 do
			P[pn]:fov(360 / math.pi * math.atan(math.tan(math.pi * (1 / (360 / 45))) * (sw / sh) * 0.75))
		end
	end
}

----------------------------------------
-- nodes and custom modifiers go here --
----------------------------------------



--[[=={{ MODS SECTION BEGIN }}==]]--

-----------------------------------------------------
-- some additional effects on buildup 1 (32 to 60) --
-----------------------------------------------------

--[[
set {46, 100, 'grain'}
set {48, 0, 'grain'}
ease {46, 2, flip(outQuart), 200, 'tanbumpyx'}
ease {46, 2, outQuart, 200, 'tanbumpyxperiod'}
set {46, 2000, 'longboy'}
set {48, 0, 'longboy'}
]]

--------------------------------------
-- drop 1, second half (128 to 160) --
--------------------------------------

set {120, 100, 'hidemines', 100, 'stealthpastreceptors'}

--	ease {128, 1, outQuart, 0, "zoomy"}
--		{128, 1, outQuart, 0, "zoomy"}
--	
set {128, 200, "sudden"}
	{144, 0, "sudden"}
	{plr = 2; 128, 100, "reverse"}
ease {128, 1, flip(outQuad), -800, "mini", 50, "flip", 50, "reverse"}

do
	local m = 1
	for b = 130, 138, 4 do
		onebeat(b, 800 * m)
		m = -m
	end
end

-- ease {129, 1, flip(outQuart), 200, "tiny"}

for _, b in ipairs {128, 130, 131.5, 136, 138.5} do
	func {b, 1, outQuad, 128, 0, vibro}
	func {b, 1, outQuad, 16, 0, aftvibro}
end

func {128, 16, function(b, o)
	for pn = 1, 2 do
		local mul = b < 142 and (3 - pn * 2) or 1

		local q = b - 140
		if b < 140 then
			q = b % 4.0
			if q > 2 then
				q = 4 - q
			end
		end

		q = (q - 1) * 100
		o[pn].suddenoffset = mul * q - 25
	end
end}

do
	local m = 1
	for b = 129, 129.75, 0.25 do
		ease {b, 0.25, bounce, 400 * m, "drunk"}
		m = -m
	end
end

ease
	{130.0, 1, bounce, 80, 'x', 30, 'rotationy', 800, 'zoomz'}
	{131.5, 1, bounce, -80, 'x', -30, 'rotationy', 800, 'zoomz'}
	{137.0, 1, bounce, 80, 'y', 30, 'rotationx', 800, 'zoomz'}
	{138.5, 1, bounce, -80, 'y', -30, 'rotationx', 800, 'zoomz'}

func
	{130.0, 1, bounce, 80, aftxoffset}
	{131.5, 1, bounce, -80, aftxoffset}
	{137.0, 1, bounce, 80, aftyoffset}
	{138.5, 1, bounce, -80, aftyoffset}

plr = 2
ease
	{132.25, 0.5, inOutQuart, 100, 'invert'}
	{132.75, 0.5, inOutQuart, 0, 'invert', 100, 'flip'}
	{133.25, 0.5, inOutQuart, 0, 'flip'}
plr = 1
ease
	{134.25, 0.5, inOutQuart, 100, 'invert'}
	{134.75, 0.5, inOutQuart, 0, 'invert', 100, 'flip'}
	{135.25, 0.5, inOutQuart, 0, 'flip'}
plr = nil

set {137, 100, 'grain'}
for _, b in ipairs{137, 139.5} do
	ease {b, 1, flip(linear), -95, 'zigzagperiod'}
	mirror {b, 1, pop,  400, 'zigzag'}
end

ease {141, 1, inQuart, 0, 'reverse'}

ease {142, 2, flip(outQuad), -4000, 'drunkoffset'}
mirror {plr = 1, 142, 2, impulse[0.5], 1200, 'drunk'}



ease {143, 1, inQuad, 64, 'y'}
do
	local b = 144
	local r = 15
	local t = {1, 1, 0.75, 0.75, 0.5, 1, 0.75, 0.75}
	for i, v in ipairs(t) do
		add {b, v, bounce, -64 * sqrt(v), 'y'}
		ease {b, v, linear, r, 'rotationz'}
		b = b + v
		r = -r
	end
end
ease {150.5, 1.5, outQuad, 0, 'y', 0, 'rotationz'}

set {150.5, 100, 'orient'} {152, 0, 'orient'}
ease {150.5, 1.5, popElastic[10][3], 800, 'parabolax', 96, 'x', 30, 'rotationz'}


set {152, 100, 'dizzyholds', 100, 'halgun'}

set {154, 200, 'sudden'}
	{154, -80, 'suddenoffset'}

add {154, 6, flip(linear), 400, 'suddenoffset'}
ease {152, 2, outQuart, 2000, 'zoomz', 60, 'rotationx'}
	{153, 1, inQuart,
	50, 'zoom', 800, 'zoomz',
	100, 'centered', -800, 'z',
	-80, 'rotationx', PI * 80 / 180 * 100, 'confusionxoffset',
}

func {152, 2, bounce, aftzoom}

ease {154, 5, outQuad, -60, 'rotationx', PI * 60 / 180 * 100, 'confusionxoffset'}

set {154, 15, 'reverse', 100, 'drawsize'}
ease {plr = 2; 154, 3, flip(outCirc), 50, 'reverse'}

set {plr = 1; 154, 100, 'stealth0', 100, 'stealth3'}
set {plr = 2; 154, 100, 'stealth1', 100, 'stealth2'}

ease {154, 5, linear, 50, 'reverse'}
set {154, 200, 'tornadoperiod'}
set {plr = 2, 154, 100, 'dark'}
ease
	{plr = 1; 154, 1, outQuart, -90, 'bumpyxperiod2'}
	{plr = 1; 154, 5, outQuart, 100, 'bumpyxperiod2'}
	{plr = 1; 154, 3, flip(outQuart), 800, 'bumpyxoffset2'}
	{plr = 1; 154, 1, outQuart, 400, 'bumpyx2'}
	{plr = 1; 154, 3, outQuad, 0, 'bumpyx2'}
	{plr = 2; 154, 5, outQuad, -100, 'tornadoperiod'}
	{plr = 2; 154, 5, flip(outQuad), -1600, 'confusionoffset0', -1600, 'confusionoffset3'}
	{plr = 2; 154, 1, outCirc, 100, 'tornado'}

func {154, 4, outQuart, 128, 0, aftvibro}




ease {159, 0.5, outQuart,
	75, 'zoom', 75, 'zoomz',
	100, 'centered', -40, 'z',
	-30, 'rotationx', PI * 30 / 180 * 100, 'confusionxoffset',
}

ease {159.5, 0.5, outQuart,
	100, 'zoom', 100, 'zoomz',
	100, 'centered', 0, 'z',
	0, 'rotationx', 0, 'confusionxoffset',
}

ease {159, 0.5, outQuart, 25, 'reverse'}
ease {159.5, 0.5, outQuart, 0, 'reverse'}

reset {160, exclude = {'hidemines', 'stealthpastreceptors', 'centered', 'sudden', 'suddenoffset'}}
ease {160, 2, outQuart, 0, 'centered'}
set {160, 100, 'sudden'}
ease {160, 2, outQuart, 0, 'sudden'}
set {161, 0, 'suddenoffset'}
set {162, 0, 'hidemines'}

-----------------------------------------------
-- calm before the second storm (160 to 192) --
-----------------------------------------------

set {160, 50, 'dark', 50, 'drunkperiod', 500, 'drunkspacing'}
ease {160, 2, outQuart, 90, 'stealth'}
ease {160, 4, outQuart, 50, 'brake', 90, 'dark', 50, 'flip'}
mirror {160, 4, outQuart, 25, 'drunk', 25, 'tipsy'}

--ease {176, 8, popElastic[1][8], -100, 'tiny'}
add {176, 2, impulse[0.5], -600, 'tiny'}

ease {187, 5, inQuart, 0.05, 'xmod', 0, 'brake', 50, 'stealth', 0, 'drunk', 0, 'tipsy', 100, 'centered', 760, 'z'}

func {187, 5, inQuart, 100, aftvibro; persist = false}

for col = 0, 3 do
	local mul = col - 1.5
	set {160, 700, 'bumpyxperiod'..col}
	ease {160, 4, outQuart, 300 * mul, 'bumpyx'..col}
	ease {187, 5, inQuart, 0, 'bumpyx'..col}
end

set {184, 90, 'hideholds'}
ease {188, 4, linear, 100, 'hideholds'}

reset {192, exclude = {'stealth'}}
ease {192, 2, outQuad, 0, 'stealth'}

func {160, function()
	AFTSpriteRecursive:hidden(0)
	AFTSpriteRecursive:diffusealpha(0.9)
end}

func {176, 4, outQuad, 1.2, 1,
	function(t)
		AFTSpriteRecursive:zoom(t)
	end
}

func {192, function()
	AFTSpriteRecursive:hidden(1)
end}

-------------------------------------
-- some extras on beats 192 to 224 --
-------------------------------------

plr = 1
for b = 192, 216, 4 do
	ease
		{b, 4, flip(outQuad), 50, 'hideholds'}
		{b, 2, flip(outQuart), -4000, 'straightholds'}
end
ease {216.05, 7.9, inOutQuart, 0, 'hideholds'}
plr = nil

---------------------------------
-- second buildup (224 to 252) --
---------------------------------

ease {224.05, 4, outQuad, 0.5, 'xmod'}
set {224.05, 100, 'hidemines'}

for i, b in ipairs {232, 240, 242, 244, 246, 248, 249, 250, 251}
do
	local l = (i > 5) and 1 or 2
	
	if i ~= 2 then
		ease {b - 1, 1, tap, i * -40 + 100, 'mini'}
	end
	ease
		{b - 1, 1, inBack, i * -50, 'mini'}
		{b, l, flip(outQuad), 1, 'hidemines'}
	func
		{b, l, outQuad, 40, 0, aftxoffset}
		{b, l, outQuad, 10, 0, aftvibrox}
end

do
	local j = 0
	local swaps = {[0] = 'ldur', 'dlru', 'rudl', 'urld'}
	local s = '.---.---.---.---.---.---.---.---'
	       .. '.---.---.---.---.---.---.-...-.-'
	       .. '.---.---.---.---.---.---.---.---'
	       .. '.-.-.---.-.-.-------------------'
	       .. '.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-'
	       .. '.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-'
	       .. '.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-'
	
	for _i, _ in gmatch(s, '()(%.)') do
		local i = _i - 1
		local b = 224 + i / 8
		local sw = swaps[j % 4]
		swap {b, 0, instant, sw}
		j = j + 1
	end
end

set
	{238, 10000, 'tandrunkspeed', 500, 'tandrunkspacing'}
ease
	{237.51, 0.49, inBack, 1.5, 'xmod', 30, 'rotationx', 20, 'y', -500, 'mini', 50, 'flip'}
	{238, 1, flip(linear), 100, 'tandrunk'}
	{239, 1, inQuad, 0.5, 'xmod', 0, 'rotationx', 0, 'y', 0, 'flip', 0, 'tandrunk'}

func {238, function()
	HideEvent:diffuse(0.5, 0, 0, 1)
	HideEvent:sleep(120/155)
	HideEvent:diffuse(0, 0, 0, 1)
end; persist = false}

ease {248, 4, inQuad, 1.5, 'xmod'}
ease {251, 1, inQuart, 200, 'mini'}
set {251.5, 1.5, 'xmod', 0, 'mini', 0, 'hidemines'}
swap {251.5, 0, instant, 'ldur'}

-------------------------------------
-- before the drop 2, (252 to 256) --
-------------------------------------

set {252, 200, 'sudden', 150, 'suddenoffset'}
ease {252, 4.5, linear, -50, 'suddenoffset'}
ease {255, 0.5, outQuart, 0, 'sudden'}
set {256.5, 0, 'suddenoffset'}

set
	{252, 0, 'zoomx'}
	{252.5, 50, 'reverse'}
ease
	{252.5, 0.5, outQuart, 100, 'zoomx'}
	{253, 0.5, outQuart, 0, 'reverse', 50, 'alternate'}
	{253.5, 0.5, outQuart, 0, 'alternate'}

ease
	{254 + 0/8, 1/8, linear, 0, 'flip', 100, 'invert'}
	{254 + 1/8, 1/8, linear, 100, 'flip', 0, 'invert'}
	{254 + 2/8, 1/8, linear, 100, 'flip', -100, 'invert'}
	{254 + 3/8, 1/8, linear, 0, 'flip', 0, 'invert'}

ease
	{255, 0.5, outQuart, 100, 'reverse'}
	{255.5, 0.5, outQuart, 0, 'reverse'}

-------------------------------------
-- drop 2, first half (256 to 320) --
-------------------------------------

local function zbeat(b, amt)
	mirror {b - 0.5, 0.5, inQuad, amt, 'z'}
	ease {b, 0.5, inQuad, 0, 'z'}
end

do
	local m = 1
	for b = 258, 302, 4 do
		zbeat(b, -400 * m)
		m = -m
	end
end

ease {256, 0.5, outQuad, 100, 'stealth', 100, 'dark'}
set {256.5, 0, 'stealth', 0, 'dark', 200, 'tiny', -90, 'zigzagperiod'}
ease {256.5, 1.5, linear, -200, 'tiny'}
ease {256.5, 1.5, flip(linear), 400, 'zigzag', -800, 'zigzagoffset'}
ease {257.5, 1, inOutQuart, 0, 'tiny'}

set {258, -99, 'waveperiod'}
for b = 258, 262, 2 do
	ease {b, 1, flip(linear), 400, 'wave', 800, 'bumpy'}
	func {b, 1, outQuad, 64, 0, aftvibrox}
	func {b, 1, outQuad, 32, 0, aftxoffset}
end
set {264, 0, 'waveperiod'}

ease
	{plr = 1; 259, 0.25, outQuad, -128, 'x', 200, 'zoomx'}
	{plr = 1; 259.5, 0.25, outQuad, 0, 'x', 100, 'zoomx'}
	{plr = 2; 259, 0.25, outQuad, 100, 'flip', 100, 'reverse'}
	{plr = 2; 259.5, 0.25, outQuad, 0, 'flip', 1, 'reverse'}
	{plr = 1; 261, 0.25, outQuad, 128, 'x', 200, 'zoomx'}
	{plr = 1; 261.5, 0.25, outQuad, 0, 'x', 100, 'zoomx'}
	{plr = 2; 261, 0.25, outQuad, 100, 'flip', 100, 'reverse'}
	{plr = 2; 261.5, 0.25, outQuad, 0, 'flip', 0, 'reverse'}
	{262.5, 0.25, outQuad, 50, 'skewx', 200, 'zoomx'}
	{263, 0.25, outQuad, -200, 'skewx', 100, 'zoomx', 200, 'zoomy'}
	{263.5, 0.25, outQuad, 0, 'skewx', 100, 'zoomy'}

do
	local m = 1
	for b = 264, 268, 2 do
		for pn = 1, 2 do
			local offset = (pn - 1.5) * 0.15
			plr = pn
			ease
				{b + offset, 2, bounce, -10 * m, 'rotationz'}
				{b - 0.5 + offset, 1, inverse, 1600 * m, 'drunk'}
				{b + 0.5 + offset, 1, inverse, 1600 * m, 'tipsy'}
				{b - 0.5 + offset, 1, spike, -1600, 'tinyx'}
				{b + 0.5 + offset, 1, spike, -1600, 'tinyy'}
		end
		m = -m
	end
end
plr = nil

ease
	{270.5, 0.5, bounce, 30, 'rotationz', 100, 'skewx'}
	{271, 0.5, bounce, -30, 'rotationz', -100, 'skewx'}
	{271.5, 0.5, bounce, 30, 'rotationz', 100, 'skewx'}

ease
	{272, 0.5, outQuart, 100, 'invert'}
	{272.5, 0.5, outQuart, 0, 'invert'}
	{273, 0.5, outQuart, 100, 'invert'}
	{273.25, 0.5, outQuart, 0, 'invert', 100, 'flip'}
	{273.75, 0.25, outQuad, 0, 'flip'}

for i = 0, 7 do
	local b = 274 + i * 0.5
	
	rand.seed(7741 + i)
	local rx = rand.float(-160, 160)
	
	rand.seed(1116 + i * 8)
	local rr, rg, rb = rand.float(), rand.float(), rand.float()
	local colormul = 0.4 / max(max(rr, rg), rb)
	rr, rg, rb = rr * colormul, rg * colormul, rb * colormul
	
	ease
		{b, 0.5, linear, 75, 'centered2'}
		{b, 0.5, outQuad, 100, 'stealth', 100, 'dark'}
	set
		{b, rx, 'x'}
		{b + 0.5, 0, 'centered2', 0, 'stealth', 0, 'dark', (b + 0.5) % 2 * PI * 100, 'confusionoffset'}
	
	func {b, 0.5, linear,
		function(t)
			local q = 1 - t
			HideEvent:diffuse(rr * q, rg * q, rb * q, 1)
			aftxoffset(t * 256)
		end;
	persist = false}
end

set {278, 0, 'x'}
func {278, function(self) aftxoffset(0); HideEvent:diffuse(0, 0, 0, 1) end}

ease
	{279, 0.2, linear, 30, 'centered', 20, 'flip', 200, 'zoom', 2, 'xmod'}
	{280, 0.2, linear, 0, 'centered', 0, 'flip', 100, 'zoom', 1.5, 'xmod', 0, 'x', 0, 'rotationz', 0, 'confusionoffset'}
mirror {279, 0.2, linear, -32, 'x', -45, 'rotationz', PI * 25, 'confusionoffset'}

func
	{279, function() vibro(32); HideEvent:linear(0.05); HideEvent:diffuse(0.5, 0, 0, 1) end; persist = false}
	{280, function() vibro(0); HideEvent:linear(0.05); HideEvent:diffuse(0, 0, 0, 1) end; persist = false}

set {280, -97, 'squareperiod'}
mirror {280, 1, outQuart, 500, 'square', 10, 'rotationz', 10, 'rotationx'}
ease {280, 1, outQuart, 100, 'stealth', 100, 'dark'}

rand.seed(800)
for i = 0, 3 do
	local b = 281 + i * 0.25
	local amt = (3 - i) * 0.25
	mirror {b,
		0, instant, 500 * amt, 'square',
		rand.float(-1, 1) * 10 * amt, 'rotationz',
		rand.float(-1, 1) * 10 * amt, 'rotationx'}
	set {b, 100 * amt, 'stealth', 50 * amt + 50, 'dark'}
end

ease
	{282.5, 1, bounce, 45, 'rotationy'}
	{284, 1, bounce, -45, 'rotationy'}

mirror
	{282.5, 1, bounce, 400, 'drunk'}
	{284, 1, bounce, -400, 'drunk'}

set
	{281, 500, 'invert', 100, 'halgun'}
	{plr = 1, 281, -320, 'x', 9e6, 'movez1', 9e6, 'movez3'}
	{plr = 2, 281, 320, 'x', 9e6, 'movez0', 9e6, 'movez2'}

ease
	{286, 1, pop, 60, 'rotationx', 80, 'zoom', -40, 'y'}
	{287, 1, pop, -60, 'rotationx', 80, 'zoom', -90, 'y'}
func
	{286, 1, outQuad, 64, 0, aftvibro}
	{287, 1, outQuad, 64, 0, aftvibro}

reset {288}

func {288, 2, linear, 128, 0, vibrox}
func {288, 2, linear, 64, 0, aftvibrox}

set
	{288, 50, 'grain'}
	{plr = 1; 288, 8000, 'tandrunkspeed'}
	{plr = 2; 288, 8100, 'tandrunkspeed'}
	{290, 0, 'tandrunkspeed', 0, 'grain'}
mirror
	{288, 2, flip(inQuad), 20, 'tandrunk'}
	--{288.75, 1, spike, 800, 'tandrunk'}
ease
	{288.25, 2, flip(inOutQuad), -8000, 'drunkoffset'}
	{288.25, 2, spike, 2000, 'drunk'}
	{289.25, 1, outQuart, 100, 'drunk'}

set {290, -99, 'waveperiod'}
for b = 290, 294, 2 do
	ease {b, 1, flip(linear), 400, 'wave', 800, 'bumpy'}
	func {b, 1, outQuad, 64, 0, aftvibrox}
	func {b, 1, outQuad, 32, 0, aftxoffset}
end
set {298, 0, 'waveperiod'}

ease
	{plr = 1; 291, 0.25, outQuad, -128, 'x', 200, 'zoomx'}
	{plr = 1; 291.5, 0.25, outQuad, 0, 'x', 100, 'zoomx'}
	{plr = 2; 291, 0.25, outQuad, 100, 'flip', 100, 'reverse'}
	{plr = 2; 291.5, 0.25, outQuad, 0, 'flip', 1, 'reverse'}
	{plr = 1; 293, 0.25, outQuad, 128, 'x', 200, 'zoomx'}
	{plr = 1; 293.5, 0.25, outQuad, 0, 'x', 100, 'zoomx'}
	{plr = 2; 293, 0.25, outQuad, 100, 'flip', 100, 'reverse'}
	{plr = 2; 293.5, 0.25, outQuad, 0, 'flip', 0, 'reverse'}
	{294.5, 0.25, outQuad, -50, 'skewx', 200, 'zoomx'}
	{295, 0.25, outQuad, 200, 'skewx', 100, 'zoomx', 200, 'zoomy'}
	{295.5, 0.25, outQuad, 0, 'skewx', 100, 'zoomy'}

do
	local m = 1
	for b = 296, 300, 2 do
		for pn = 1, 2 do
			local offset = (pn - 1.5) * 0.15
			plr = pn
			ease
				{b + offset, 2, bounce, 10 * m, 'rotationz'}
				{b - 0.5 + offset, 1, inverse, -1600 * m, 'drunk'}
				{b - 0.5 + offset, 1, inOutSine, -100 * m, 'drunk'}
				{b + 0.5 + offset, 1, inverse, 1600 * m, 'tipsy'}
				{b - 0.5 + offset, 1, spike, -1600, 'tinyx'}
				{b + 0.5 + offset, 1, spike, -1600, 'tinyy'}
		end
		m = -m
	end
end
plr = nil

ease {302, 2, outQuad, 0, 'drunk'}

add {302, 2, bounce, 100, 'zoomx', -75, 'zoomy'}
do
	local m = 1
	for b = 302, 303.5, 0.5 do
		ease {b, 0.5, bounce, 50 * m, 'skewx'}
		m = -m
	end
end

reset {304}
ease {304, 0.5, outQuart, 100, 'invert'}
ease {304.5, 0.5, outQuart, 0, 'invert'}

aftpause(306, 1.5)
aftpause(307.5, 2.5)
aftpause(310, 1.5)

func
	{304, 1, linear, 0.8, 1, coveramt}
	{304, 1, linear, 0.9, 0, aftamt}
	{306, 0.5, linear, 1, 1, aftamt}
	{306.5, 1, linear, 1, 0, aftamt}
	{307.5, 1.5, linear, 1, 1, aftamt}
	{309, 1, linear, 1, 0, aftamt}
	{310, 2, linear, 1, 1, aftamt}
	
	{306, function() HideEvent:diffuse(0.3, 0, 0, 1) end; persist = false}
	{307.5, function() HideEvent:diffuse(0, 0.3, 0, 1) end; persist = false}
	{310, function() HideEvent:diffuse(0, 0, 0.3, 1) end; persist = false}
	{311.5, function() HideEvent:diffuse(0, 0, 0, 1) end}
	
	{311, 0.5, outQuart, 1, 0, 
		function(t)
			AFTSpriteR:zoomx(t)
			AFTSpriteG:zoomx(t)
			AFTSpriteB:zoomx(t)
			AFTSpriteR:zoomy(1.125 / (t + 0.125))
			AFTSpriteG:zoomy(1.125 / (t + 0.125))
			AFTSpriteB:zoomy(1.125 / (t + 0.125))
		end
	}
	{311.5, 0.5, outQuart, 0, 1, 
		function(t)
			AFTSpriteR:zoomx(1)
			AFTSpriteG:zoomx(1)
			AFTSpriteB:zoomx(1)

			AFTSpriteR:zoomy(t)
			AFTSpriteG:zoomy(t)
			AFTSpriteB:zoomy(t)
		end
	}
	{312, 1, linear, 1, 0.8, coveramt}
	{312, 1, linear, 1, 0.9, aftamt}

set
	{306 - 0.1, 100, 'halgun', -160, 'x', -40, 'rotationx', 20, 'rotationy'}
	{307.5 - 0.1, 0, 'flip', 100, 'invert', 160, 'x', 40, 'rotationx', 20, 'rotationy'}
	{310 - 0.1, 100, 'flip', 0, 'invert', 100, 'reverse', 0, 'x', -40, 'rotationx', -20, 'rotationy'}
	{310.5 - 0.1, 0, 'flip', 0, 'invert', 0, 'reverse', 0, 'x', 0, 'rotationx', 0, 'rotationy'}
	{312, 0, 'halgun'}

do
	local m = 1
	for i = 0, 6 do
		local b = 312 + i
		local q = (7 - i) / 7
		ease
			{b, 1, flip(outQuad), 1.5 * (1 - q) + 0.01 * q, 'xmod'}
			{b, 1, pop, 200 * q * m, 'drunk'}
		m = -m
	end
end

add
	{318, 2, spike, 20, 'zoomx'}
	{318.5, 1, spike, 8080, 'zoomx'}

func {318, 2, spike, 400, aftxoffset}

reset {320}

-------------------------
-- finale (352 to end) --
-- = oooh splines... = --
-------------------------

local _allcolumns = {0, 1, 2, 3}

local function funcspline(stype, n, f, col)
	if n > 39 then n = 39 end
	
	if type(col) == 'number' then
		col = {col}
	elseif col == nil then
		col = _allcolumns
	end
	
	local splinestr = 'Set' .. stype .. 'Spline'
	for pn = 1, 2 do
		local a = P[pn]
		for _, c in ipairs(col) do
			for i = 0, n do
				local o, v = f(i / n)
				a[splinestr](a, i, c, v, o, -1)
			end
		end
	end
end

local function spline0pos(t)
	local o = t * t
	return o * 800, o * (1 - o) ^ 3 * 6400
end

local function spline0neg(t)
	local o = t * t
	return o * 800, o * (1 - o) ^ 3 * -6400
end

local function spline1(t)
	return inSine(t) * 200, inSine(1 - t) * 1000
end

local function spline2(t)
	return t * 25600 + 6400, t * t * 1625 * PI
end

local function splinestealth(t)
	return outQuart(t) * 400 + 200, t * 90
end

func
	{351, function() coveramt(1) aftamt(0) end; persist = false}
	{352, function() coveramt(1) aftamt(1) end}

reset {352}
set {352,
	16, 'xmod', 155 / 8, 'cmod',
	75, 'brake',
	50, 'flip', 50, 'reverse',
	50, 'zoom', 100, 'tinyz',
	50, 'dark',
	100, 'halgun',
	100, 'stealthtype',
	100, 'spiralholds', 100, 'dizzyholds', 100, 'grain', 100, 'ztest',
	-99, 'spiralxperiod', -99, 'spiralyperiod',
	400, 'drawsize', -100, 'drawsizeback',
}
mirror {352, 0, instant, 50, 'spiralx', 50, 'spiraly'}
ease
	{352, 80, linear, -4000, 'spiralxoffset', -4000, 'spiralyoffset'}
	{352, 8, outQuart, 100, 'dark'}

func {351.5,
	function()
		funcspline('X', 32, spline0neg, 0)
		funcspline('Y', 32, spline0pos, 1)
		funcspline('Y', 32, spline0neg, 2)
		funcspline('X', 32, spline0pos, 3)
		funcspline('Z', 32, spline1)
		funcspline('RotZ', 32, spline2)
		funcspline('Stealth', 1, splinestealth)
	end
}

func {352, 432, function()
	for pn = 1, 2 do
		P[pn]:y(scy - yorig)
	end
end}

ease
	{408, 8, linear, 0, 'arrowpath'}
	{408, 8, inOutSine, 0, 'spiralx', 0, 'spiraly'}
	{408, 8, outQuart, -100, 'spiralxperiod', -100, 'spiralyperiod'}

-- aft effects for finale

aux 'kinoaftwaggle'
set {352, 100, 'kinoaftwaggle'}
ease {408, 8, linear, 0, 'kinoaftwaggle'}

local function _waggle(actor, b, amt, offset)
	local q = (b + offset) % 16 * 0.25 * math.pi
	actor:skewx(cos(q) * amt * 0.25)
	actor:zoomy(1 + sin(q) * amt * 0.25)
	actor:rotationz(sin(q * 0.5) * amt * 2.5)
end

func {352, 80, function(b, poptions)
	local amt = poptions[1].kinoaftwaggle / 100
	_waggle(AFTSpriteR, b, amt, 0.2)
	_waggle(AFTSpriteG, b, amt, 0)
	_waggle(AFTSpriteB, b, amt, -0.2)
	
	if b >= 384 then
		_waggle(AFTSpriteRecursive, b, amt * 0.5, 0)
	end
end}

func {352, function()
	AFTSpriteRecursive:hidden(0)
	AFTSpriteRecursive:zoom(1.02)
	AFTSpriteRecursive:diffusealpha(0.85)
end}

func {408, 8, linear, 1, 0, function(t)
	AFTSpriteRecursive:diffusealpha(t ^ 0.25 * 0.85)
end}













