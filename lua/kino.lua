-- you can just chuck mods in here lol

local sin, cos = math.sin, math.cos
local PI = math.pi
local sqrt = math.sqrt



local function _q(t)
	return t < 1 and 1 or 0
end

local function onebeat(b, amt)
	ease {b - 0.5, 1, _q, amt, "beat"}
end

----------------------
-- beats 128 to 160 --
----------------------

card {128, 144, 'abandon all hope', 10, '#BADCEE'}
card {144, 152, 'bounce bounce revolution', 6, '#90B9DF'}
card {159, 160, 'did you hit it?', 6, '#BADCEE'}



set {120, 100, 'hidemines', 100, 'stealthpastreceptors'}

ease {128, 1, outQuart, 0, "zoomy"}
ease {128, 1, outQuart, 0, "zoomy"}

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

ease {130.0, 1, bounce, 30, 'rotationy', 800, 'zoomz'}
ease {131.5, 1, bounce, -30, 'rotationy', 800, 'zoomz'}
ease {137.0, 1, bounce, 80, 'y', 30, 'rotationx', 800, 'zoomz'}
ease {138.5, 1, bounce, -80, 'y', -30, 'rotationx', 800, 'zoomz'}



plr = 2
ease {132.25, 0.5, inOutQuart, 100, 'invert'}
ease {132.75, 0.5, inOutQuart, 0, 'invert', 100, 'flip'}
ease {133.25, 0.5, inOutQuart, 0, 'flip'}

plr = 1
ease {134.25, 0.5, inOutQuart, 100, 'invert'}
ease {134.75, 0.5, inOutQuart, 0, 'invert', 100, 'flip'}
ease {135.25, 0.5, inOutQuart, 0, 'flip'}

plr = nil
set {137, 100, 'grain'}
ease {137, 1, flip(linear), -95, 'zigzagperiod'}
ease {plr = 1; 137, 1, pop,  400, 'zigzag'}
ease {plr = 2; 137, 1, pop, -400, 'zigzag'}



ease {141, 1, inQuart, 0, 'reverse'}
ease {plr = 1, 142, 2, impulse[0.5], 1200, 'drunk'}
ease {plr = 2, 142, 2, impulse[0.5], -1200, 'drunk'}
ease {142, 2, flip(outQuad), -4000, 'drunkoffset'}



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



set {152, 100, 'dizzyholds', 100, 'halgun'}

set {154, 200, 'sudden'}
set {154, -80, 'suddenoffset'}

add {154, 6, flip(linear), 400, 'suddenoffset'}
ease {152, 2, outQuart, 2000, 'zoomz', 60, 'rotationx'}
ease {153, 1, inQuart,
	50, 'zoom', 800, 'zoomz',
	100, 'centered', -800, 'z',
	-80, 'rotationx', PI * 80 / 180 * 100, 'confusionxoffset',
}

ease {154, 5, outQuad, -60, 'rotationx', PI * 60 / 180 * 100, 'confusionxoffset'}

set {154, 15, 'reverse', 100, 'drawsize'}
ease {plr = 2; 154, 3, flip(outCirc), 50, 'reverse'}

set {plr = 1; 154, 100, 'stealth0', 100, 'stealth3'}
set {plr = 2; 154, 100, 'stealth1', 100, 'stealth2'}

ease {154, 5, linear, 50, 'reverse'}
set {154, 200, 'tornadoperiod'}
ease {plr = 2; 154, 1, outCirc, 100, 'tornado'}
--	ease {plr = 2; 154, 5, outQuart, 0, 'tornado'}
ease {plr = 2; 154, 5, outQuad, -100, 'tornadoperiod'}

ease {plr = 1; 154, 1, outQuart, -90, 'bumpyxperiod2'}
ease {plr = 1; 154, 5, outQuart, 100, 'bumpyxperiod2'}
ease {plr = 1; 154, 3, flip(outQuart), 800, 'bumpyxoffset2'}
ease {plr = 1; 154, 1, outQuart, 400, 'bumpyx2'}
ease {plr = 1; 154, 3, outQuad, 0, 'bumpyx2'}

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
ease {160, 1, outQuart, 0, 'sudden'}
set {161, 0, 'suddenoffset'}
set {162, 0, 'hidemines'}












