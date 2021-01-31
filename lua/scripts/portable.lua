--If you plan on using this:
--[[
Required manual edits: (@ is axis, # is column in {1, 2, 3, 4}
- confusion@offset# -> targetrotation@#
- move@# -> target@#
- sw, sh -> bw, bh (if you are inferring SD theme scaling)

In-progress conversions:
- noteskewx# -> targetskewx#
]]

bw, bh = 640, 480
sm_scale = sh / bh
sm_fix = (FUCK_EXE and 0) or 1

--[[
	////////////////////////////////////////////////////////////////
	// USE THESE COMPATIBLITY MODS INSTEAD OF THE NITG EQUIVALENT //
	////////////////////////////////////////////////////////////////

	- SetHiddenRegion on P[pn]: 'hideregion' in set (recommended using oatmealine's "hiddenregion" plugin instead)
	- Anything using screen variables (sw, sh) should use the defined base variables (bw, bh)

	Everything else should work the same.
	If you put in a little bit of effort, you save Kid a lot of work.

	TODO:
	- Column-specific noteskew conversion
--]]

-- Generic Conversion
alias
{'targetrotationx1', 'confusionxoffset'..sm_fix}			-- Column ConfusionX
{'targetrotationx2', 'confusionxoffset'..sm_fix + 1}
{'targetrotationx3', 'confusionxoffset'..sm_fix + 2}
{'targetrotationx4', 'confusionxoffset'..sm_fix + 3}

{'targetrotationy1', 'confusionyoffset'..sm_fix}				-- Column ConfuionY
{'targetrotationy2', 'confusionyoffset'..sm_fix + 1}
{'targetrotationy3', 'confusionyoffset'..sm_fix + 2}
{'targetrotationy4', 'confusionyoffset'..sm_fix + 3}

{'targetrotationz1', 'confusionoffset'..sm_fix}					-- Column ConfusionZ
{'targetrotationz2', 'confusionoffset'..sm_fix + 1}
{'targetrotationz3', 'confusionoffset'..sm_fix + 2}
{'targetrotationz4', 'confusionoffset'..sm_fix + 3}

{'targetx1', 'movex'..sm_fix}									-- Column MoveX
{'targetx2', 'movex'..sm_fix + 1}
{'targetx3', 'movex'..sm_fix + 2}
{'targetx4', 'movex'..sm_fix + 3}

{'targety1', 'movey'..sm_fix}									-- Column MoveY
{'targety2', 'movey'..sm_fix + 1}
{'targety3', 'movey'..sm_fix + 2}
{'targety4', 'movey'..sm_fix + 3}

{'targetz1', 'movez'..sm_fix}									-- Column MoveZ
{'targetz2', 'movez'..sm_fix + 1}
{'targetz3', 'movez'..sm_fix + 2}
{'targetz4', 'movez'..sm_fix + 3}

{'targetskewx1', 'noteskewx'..sm_fix}									-- Column NoteSkewX
{'targetskewx2', 'noteskewx'..sm_fix + 1}
{'targetskewx3', 'noteskewx'..sm_fix + 2}
{'targetskewx4', 'noteskewx'..sm_fix + 3}

{'confusionzoffset', 'confusionoffset'}							-- no i like the z in there

function hideregion(t)
	local pn = t.plr or get_plr()
	if type(pn) == 'number' then
		if FUCK_EXE then
			P[pn]:SetHiddenRegions({{t[1], t[2]}})
		else
			P[pn]:GetChild('NoteField'):add_hidden_regions({{t[1], t[2]}})
		end
	elseif type(pn) == 'table' then

		for _, plr in ipairs(plr) do
			if FUCK_EXE then
				P[pn]:SetHiddenRegions({{t[1], t[2]}})
			else
				P[pn]:GetChild('NoteField'):add_hidden_regions({{t[1], t[2]}})
			end
		end
	end
	return hideregion
end


-- SM Specific Conversion
if not FUCK_EXE then
	--local Actor = ...
	Actor:fardistz(1000 * sm_scale)
	aux
	{'x', 'y', 'z'}													-- X, Y, and Z position tweenmods
	{'rotationx', 'rotationy', 'rotationz'}							-- X, Y, and Z rotation tweenmods
	{'tiny'}														-- Non-column to column tiny
	{'hide'}														-- cmon man
	{'hidenoteflash'}												-- THANKS SM5 VERY COOL

	node
	{
		'x',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):x(n) end
		end
	}
	{
		'y',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):y(n) end
		end
	}
	{
		'z',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):z(n) end
		end
	}
	{
		'rotationx',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):rotationx(n) end
		end
	}
	{
		'rotationy',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):rotationy(n) end
		end
	}
	{
		'rotationz',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):rotationz(n) end
		end
	}
	{
		'tiny',
		function(n)
			return n, n
		end,
		'tinyx', 'tinyy'
	}
	{
		'hide',
		function(n, pn)
			if P[pn] then P[pn]:GetChild('NoteField'):visible(n <= 0) end
		end
	}
	{
		'hidenoteflash',
		function(n)
			return n, n, n, n
		end,
		'hidenoteflash1', 'hidenoteflash2', 'hidenoteflash3', 'hidenoteflash4'
	}
end