setdefault {100, 'modtimer', 100, 'stealthpastreceptors'}
local sin, cos = math.sin, math.cos
local asin, atan2 = math.sin, math.atan2
local pi = math.pi
node {
    'rotationx', 'rotationy', 'rotationz',
    'confusionxoffset', 'confusionyoffset', 'confusionzoffset',
    function(rx, ry, rz, cx, cy, cz)
        -- transform axes
        rx, rz = rz, rx
        cx, cz = cz, cx
        
        -- helpers for r
        local rcosx, rcosy, rcosz, rsinx, rsiny, rsinz =
            cos(rx / 360 * pi), cos(ry / 360 * pi), cos(rz / 360 * pi),
            sin(rx / 360 * pi), sin(ry / 360 * pi), sin(rz / 360 * pi)
        
        -- r to quaternion
        local ra, rb, rc, rd =
            rcosx*rcosy*rcosz-rsinx*rsiny*rsinz,
            rsinx*rsiny*rcosz+rcosx*rcosy*rsinz,
            rsinx*rcosy*rcosz+rcosx*rsiny*rsinz,
            rcosx*rsiny*rcosz-rsinx*rcosy*rsinz
        
        -- helpers for c
        local ccosx, ccosy, ccosz, csinx, csiny, csinz =
            cos(cx/200), cos(cy/200), cos(cz/200),
            sin(cx/200), sin(cy/200), sin(cz/200)
        
        -- c to quaternion
        local ca, cb, cc, cd =
            ccosx*ccosy*ccosz-csinx*csiny*csinz,
            csinx*csiny*ccosz+ccosx*ccosy*csinz,
            csinx*ccosy*ccosz+ccosx*csiny*csinz,
            ccosx*csiny*ccosz-csinx*ccosy*csinz
        
        -- o = c * inverse(r)
        local oa, ob, oc, od =
            ca*ra+cb*rb+cc*rc+cd*rd,
            -ca*rb+cb*ra-cc*rd+cd*rc,
            -ca*rc+cb*rd+cc*ra-cd*rb,
            -ca*rd-cb*rc+cc*rb+cd*ra
        
        -- o to euler angles
        local ox, oy, oz =
            100 * atan2(2*oc*oa-2*ob*od, 1-2*oc*oc-2*od*od),
            100 * asin(2*ob*oc+2*od*oa),
            100 * atan2(2*ob*oa-2*oc*od, 1-2*ob*ob-2*od*od)
        
        -- transform axes
        ox, oz = oz, ox
        return ox, oy, oz
    end,
}
local spb = 60 / 155

local function screenslam(beat)
    func {beat, function()
        AFTSpriteR:effectmagnitude(10, 0, 0)
        AFTSpriteG:effectmagnitude(10, 0, 0)
        AFTSpriteB:effectmagnitude(10, 0, 0)
        AFTSpriteR:addx(-30)
        AFTSpriteR:decelerate(spb)
        AFTSpriteR:addx(30)
        AFTSpriteB:addx(30)
        AFTSpriteB:decelerate(spb)
        AFTSpriteB:addx(-30)
    end, persist = false}
    func {beat + 1, function()
        AFTSpriteR:effectmagnitude(2, 0, 0)
        AFTSpriteG:effectmagnitude(2, 0, 0)
        AFTSpriteB:effectmagnitude(2, 0, 0)
    end, persist = false}
end

func {0, function()
    AFTSpriteR:diffuse(1, 0, 0, 0.9)
    AFTSpriteR:blend('add')
    AFTSpriteG:diffuse(0, 1, 0, 0.9)
    AFTSpriteG:blend('add')
    AFTSpriteB:diffuse(0, 0, 1, 0.9)
    AFTSpriteB:blend('add')
end}

screenslam(32)
screenslam(40)
screenslam(48)
screenslam(50)
screenslam(52)
screenslam(54)
screenslam(56)
screenslam(57)
screenslam(58)
screenslam(59)

set
    {32, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {40, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {48, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {50, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {52, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {54, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {56, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {57, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {58, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {59, 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
ease
    {32, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {40, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {48, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {50, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {52, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {54, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {56, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {57, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {58, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {59, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}

func {60, function()
    for pn = 1, 2 do
        P[pn]:x(scx)
    end
end}

screenslam(66)
screenslam(68)
screenslam(70)
screenslam(74)
screenslam(76)

mirror
    {60, 0, instant, -160, 'x'}
ease
    {60, 2, outExpo, 0, 'x'}
    {62, 1, inExpo, 200, 'mini'}
    {63, 1, inExpo, 0, 'mini'}
    {64, 1, inExpo, 480, 'y'}
plr = 1
set
    {65, 0, 'y', 200, 'mini'}
ease
    {65, 1, inExpo, -100, 'mini', 5, 'rotationz'}
    {66, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {66, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {66, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {67, 1, bell, 'dlru'}
set
    {69, 0, 'y', 200, 'mini'}
ease
    {69, 1, inExpo, -100, 'mini', 5, 'rotationz'}
    {70, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {70, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {70, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {71, 1, bell, 'dlru'}
set
    {72, 0, 'y', 200, 'mini', 10, 'rotationx', -10, 'rotationy', -160, 'rotationz', 100, 'stealth', 100, 'dark'}
ease
    {73, 1, inExpo, -100, 'mini', 0, 'rotationx', 0, 'rotationy', 5, 'rotationz', 0, 'stealth', 0, 'dark'}
    {74, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {74, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {74, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {75, 1, bell, 'dlru'}
plr = 2
set
    {67, 0, 'y', 200, 'mini'}
ease
    {67, 1, inExpo, -100, 'mini', -5, 'rotationz'}
    {68, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {68, 2, pop, -150, 'drunk', -150, 'tipsy'}
    {68, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {69, 1, bell, 'dlru'}
set
    {71, 0, 'y', 200, 'mini', 100, 'reverse'}
    {73.5, 480, 'y', 200, 'mini', 0, 'stealth', 0, 'dark', 0, 'spiralx'}
ease
    {71, 2, inOutExpo, -100, 'mini'}
    {72, 1, outExpo, 0, 'reverse'}
    {73, 0.5, outQuad, 100, 'stealth', 100, 'dark', 50, 'spiralx'}
swap
    {72, 0.5, outExpo, 'dlru'}
    {72.5, 0.5, outExpo, 'rudl'}
    {73, 0.5, outExpo, 'ldur'}
set
    {75, 0, 'y', 200, 'mini',}
ease
    {75, 1, inExpo, -100, 'mini', -5, 'rotationz'}
    {76, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {76, 2, pop, -150, 'drunk', -150, 'tipsy'}
    {76, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {77, 1, bell, 'dlru'}

plr = nil
set {80, 0, 'y', 0, 'mini'}

--[[ -- so thats what zoomz is for
add
    {144, 1, pop, -30, 'rotationy', 800, 'zoomz'}
    {145, 1, pop, 30, 'rotationy', 800, 'zoomz'}
    {146, 1, pop, -30, 'rotationy', 800, 'zoomz'}
    {146.75, 1, pop, 30, 'rotationy', 800, 'zoomz'}
    {147.5, 1, pop, -30, 'rotationy', 800, 'zoomz'}
    {148, 1, pop, 30, 'rotationy', 800, 'zoomz'}
    {149, 1, pop, -30, 'rotationy', 800, 'zoomz'}
    {149.75, 1, pop, 30, 'rotationy', 800, 'zoomz'}
    {150.5, 1, pop, -30, 'rotationy', 800, 'zoomz'}
]]--

screenslam(192)

func {192, function()
    AFTSpriteR:vibrate()
    AFTSpriteR:effectmagnitude(2, 0, 0)
    AFTSpriteG:vibrate()
    AFTSpriteG:effectmagnitude(2, 0, 0)
    AFTSpriteB:vibrate()
    AFTSpriteB:effectmagnitude(2, 0, 0)
end}
set
    {192, 400, 'z', 1000, 'zoomz', 60, 'rotationx', 1000, 'parabolaz', 100, 'dizzyholds', 0, 'straightholds', 300, 'dizzy'}
    {192, 80, 'dark', 100, 'hidenoteflashes', 50, 'hidden', -90, 'hiddenoffset', 100, 'halgun'}
    {192, 90, 'stealth', 100, 'flip', 100, 'dark', plr = 2}
    {223.95, 0, 'rotationy', 0, 'confusionzoffset', 0, 'halgun', 0, 'hide', 0, 'hidenoteflashes', 0, 'hidden', 0, 'hiddenoffset', 0, 'wave'}
mirror
    {192, 3, outExpo, 0, 'z', -5000, 'attenuatex', -5000, 'attenuatez', -100, 'wave', 75, 'targetx1', 50, 'targetx2', -50, 'targetx3', -75, 'targetx4', -75, 'targetz2', 75, 'targetz3', 600, 'zoomz', -90, 'rotationx', 314.15 / 2, 'confusionxoffset', 0, 'parabolaz'}
ease
    {192, 1, outExpo, -10, 'dizzy', 100, 'drunk', 50, 'drunkperiod', 0.75, 'xmod', 300, 'drawsize', -150, 'holdgirth'}
    {192, 32, linear, 360 * 2, 'rotationy', 314.15 * 4, 'confusionzoffset'}
    {216, 4, linear, 100, 'stealth', 100, 'dark', plr = 2}
    {216, 8, inOutQuad, 0, 'longholds', 0, 'z', 0, 'attenuatex', 0, 'attenuatez', 0, 'targetx1', 0, 'targetx2', 0, 'targetx3', 0, 'targetx4', 0, 'targetz2', 0, 'targetz3', 100, 'zoomz', 0, 'dizzy', 0, 'drunk', 0, 'tipsy', 1.5, 'xmod', 100, 'drawsize', 0, 'holdgirth', 0, 'rotationx', 0, 'confusionxoffset'}

screenslam(224)

set
    {224, 0, 'stealth', 0, 'flip', 0, 'dark', 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
ease
    {224, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}