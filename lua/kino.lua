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

-------------------------
-- functions and stuff --
-------------------------

local sin, cos = math.sin, math.cos
local PI = math.pi
local sqrt = math.sqrt
local exp = math.exp
local min, max = math.min, math.max
local gmatch = string.gmatch or string.gfind

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

ease {128, 1, outQuart, 0, "zoomy"}
	{128, 1, outQuart, 0, "zoomy"}

set {129, 100, "zoomy", 200, "sudden"}
	{144, 0, "sudden"}
	{plr = 2; 129, 100, "reverse"}

do
	local m = 1
	for b = 130, 138, 4 do
		onebeat(b, 800 * m)
		m = -m
	end
end

ease {129, 1, flip(outQuart), 200, "tiny"}

func {129, function()
	for pn = 1, 2 do
		P[pn]:x(scx)
	end
end}

for _, b in ipairs {128, 130, 131.5, 136, 138.5} do
	func {b, 1, outQuad, 128, 0, vibro}
	func {b, 1, outQuad, 16, 0, aftvibro}
end

func {129, 15, function(b, o)
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
		ease {b, 0.25, bounce, 200 * m, "drunk"}
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

reset {192, exclude = {'stealth', 'hideholds'}}
ease {192, 2, outQuad, 0, 'stealth'}

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
	{238, 0.5, outQuart, 1.5, 'xmod', 30, 'rotationx', 20, 'y', -500, 'mini', 50, 'flip'}
	{238, 1, flip(linear), 40, 'tandrunk'}
	{239, 1, inQuad, 0.5, 'xmod', 0, 'rotationx', 0, 'y', 0, 'flip', 0, 'tandrunk'}

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
	local colormul = 0.2 / max(max(rr, rg), rb)
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
	{279, function() vibro(32); HideEvent:linear(0.05); HideEvent:diffuse(0.4, 0, 0, 1) end; persist = false}
	{280, function() vibro(0); HideEvent:linear(0.05); HideEvent:diffuse(0, 0, 0, 1) end; persist = false}

set {280, -97, 'squareperiod'}
ease {280, 1, outQuart, 600, 'square', 100, 'stealth'}
for i = 0, 3 do
	local b = 281 + i * 0.25
	local amt = (3 - i) * 0.25
	set {b, 600 * amt, 'square', 100 * amt, 'stealth'}
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








