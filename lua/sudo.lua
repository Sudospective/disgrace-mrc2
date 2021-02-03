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
        AFTSpriteR:effectmagnitude(5, 0, 0)
        AFTSpriteG:effectmagnitude(5, 0, 0)
        AFTSpriteB:effectmagnitude(5, 0, 0)
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

local function screenglitch(beat, len)
    func {beat, function()
        for pn = 1, 2 do
            P[pn]:vibrate()
            P[pn]:effectmagnitude(2, 2, 0)
        end
        AFTSpriteR:effectmagnitude(10, 0, 0)
        AFTSpriteG:effectmagnitude(10, 0, 0)
        AFTSpriteB:effectmagnitude(10, 0, 0)
    end, persist = false}
    func {beat + len, function()
        for pn = 1, 2 do
            P[pn]:stopeffect()
        end
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

set
    {0, 50, 'flip', 50, 'reverse', -2500, 'tiny'}
    {26, 100, 'mini'}
mirror
    {0, 0, instant, 160, 'x'}
    {0, 4, inExpo,
        0, 'tiny',
        0, 'flip',
        0, 'reverse',
        100, 'cross',
        200, 'tornado',
        100, 'tornadoperiod',
        200, 'tornadoz',
        50, 'tornadozperiod',
        200, 'drunk',
        200, 'tipsy',
        200, 'zoomz',
    }

ease
    {0, 1, outExpo, 100, 'stealth', 100, 'dark'}
    {2, 30, inSine, 360, 'rotationy', 360, 'rotationx', 360, 'rotationz'}
    {24, 8, inExpo, 0, 'stealth', 0, 'dark'}
    {26, 6, inSine, 0, 'mini'}
add
    {6, 1, pop, 20, 'arrowpath1'}
    {8, 1, pop, 20, 'arrowpath3'}
    {10, 1, pop, 20, 'arrowpath0'}
    {13.5, 2, pop, 20, 'arrowpath0', -5, 'dark'}
    {16, 1, pop, 20, 'arrowpath2'}
    {17.5, 1, pop, 20, 'arrowpath3'}
    {21, 3, pop, 20, 'arrowpath1', -5, 'dark'}
    {22.25, 3, bounce, 20, 'arrowpath0'}
reset {26, 6, outSine, exclude = {'stealth', 'dark', 'rotationx', 'rotationy', 'rotationz'}}
reset {32, 0, instant}


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

screenslam(64)
screenslam(66)
screenslam(68)
screenslam(70)
screenslam(74)
screenslam(76)
screenslam(78)

mirror
    {60, 0, instant, -160, 'x'}
set
    {64, 500, 'z', 0, 'mini', -500, 'tiny', 50, 'flip', 50, 'stealth'}
ease
    {60, 2, outExpo, 0, 'x'}
    {62, 1, inExpo, 200, 'mini'}
    {64, 0.5, outExpo, 0, 'z', 0, 'mini', 0, 'tiny', 0, 'flip', 0, 'stealth'}
    {63.5, 1, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz'}
    {64, 1, inExpo, 480, 'y'}
plr = 1
set
    {65, 0, 'y', 200, 'mini'}
ease
    {65, 1, inExpo, -100, 'mini', 5, 'rotationz'}
    {66, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {66, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {66, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {67, 1, bell, 'dlru'}
set
    {69, 0, 'y', 200, 'mini'}
ease
    {69, 1, inExpo, -100, 'mini', 5, 'rotationz'}
    {70, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {70, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {70, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {71, 1, bell, 'dlru'}
set
    {72, 0, 'y', 200, 'mini', 10, 'rotationx', -10, 'rotationy', -160, 'rotationz', 100, 'stealth', 100, 'dark'}
ease
    {73, 1, inExpo, -100, 'mini', 0, 'rotationx', 0, 'rotationy', 5, 'rotationz', 0, 'stealth', 0, 'dark'}
    {74, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {74, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {74, 2, inExpo, 480, 'y', 0, 'rotationz'}
swap
    {75, 1, bell, 'dlru'}
plr = 2
set
    {67, 0, 'y', 200, 'mini'}
ease
    {67, 1, inExpo, -100, 'mini', -5, 'rotationz'}
    {68, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
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
    {76, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {76, 2, pop, -150, 'drunk', -150, 'tipsy'}
    {76, 4, inExpo, 480, 'y', 0, 'rotationz'}
    {78, 1, pop, -200, 'tiny'}
swap
    {77, 1, bell, 'dlru'}
    {77.5, 1, inOutExpo, 'rudl'}
    {78, 1, inOutExpo, 'urld'}
    {78.5, 1, inOutExpo, 'dlru'}
    {79, 1, inOutExpo, 'ldur'}

plr = nil
reset {79, 1, outExpo, plr = 1}
reset {79.95, 0.05, outExpo, plr = 2}

ease
    {79, 4, bell, 30, 'reverse', -100, 'mini'}
    --{80, 2, inQuad, 95, 'holdstealth'}
    {80, 1, pop, -400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 800, 'zoomz', 200, 'zoomy', 100, 'invert', 200, 'tornado', 200, 'sawtooth'}
    {81, 1, pop, -400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 800, 'zoomz', 200, 'zoomy', 100, 'flip', 200, 'tornado', 200, 'sawtooth'}
    {81.5, 1, inOutExpo, -100, 'split', 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 400, 'z', 100, 'mini', 300, 'movey', 100, 'dizzyholds', 500, 'zoomz', 15, 'rotationx', -314.15 / 12, 'confusionxoffset'}
    {81.5, 1, inOutExpo, 100, 'reverse', plr = 2}
    {82, 5, outExpo, 0, 'tinyz'}
mirror
    {81.5, 1, inOutExpo, -5, 'rotationy'}

reset {86.5, 1, inOutExpo}

swap {87, 1, bell, 'dlru'}
ease
    {87, 2, inverse, 400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 400, 'zoomz', 200, 'zoomy', 5000, 'tinyz', 200, 'tornado', 400, 'tornadoperiod', 200, 'drunk', 400, 'drunkperiod'}
    {87.5, 2, bell, 100, 'reverse'}
    {88.5, 1, inOutExpo, 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 100, 'mini', 100, 'dizzyholds', 500, 'zoomz', 400, 'z', 100, 'alternate'}
    {89, 5, outExpo, 0, 'tinyz'}
    {91.5, 1, inOutExpo, 100, 'split', 100, 'reverse', 0, 'alternate'}
add
    {88.5, 1, inOutExpo, -250, 'movey'}
mirroradd
    {88.5, 1, inOutExpo, 50, 'centered', 350, 'movey', 0, 'movex', 15, 'rotationx', -314.15 / 12, 'confusionxoffset', -5, 'rotationy'}

reset {93.5, 1, inOutExpo}

func {82, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.05, 0, 0.05, 1)
    HideEvent:sleep(4 * spb)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}
func {89, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.1, 0, 0, 1)
    HideEvent:sleep(2.25 * spb)
    HideEvent:accelerate(0.25 * spb)
    HideEvent:diffuse(0.05, 0.025, 0.025, 1)
    HideEvent:decelerate(0.25 * spb)
    HideEvent:diffuse(0, 0.05, 0.05, 1)
    HideEvent:sleep(1.25 * spb)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}

screenslam(80)
screenslam(81)
screenglitch(82, 5)
screenslam(88)
screenglitch(89, 5)
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


screenslam(192)

set
    {192, 400, 'z', 1000, 'zoomz', 60, 'rotationx', 1000, 'parabolaz', 100, 'dizzyholds', 0, 'straightholds', 300, 'dizzy'}
    {192, 80, 'dark', 100, 'hidenoteflashes', 50, 'hidden', -90, 'hiddenoffset', 100, 'halgun'}
    {192, 90, 'stealth', 100, 'flip', 100, 'dark', plr = 2}
mirror
    {192, 3, outExpo, 0, 'z', -5000, 'attenuatex', -5000, 'attenuatez', -100, 'wave', 75, 'targetx1', 50, 'targetx2', -50, 'targetx3', -75, 'targetx4', -75, 'targetz2', 75, 'targetz3', 600, 'zoomz', -90, 'rotationx', 314.15 / 2, 'confusionxoffset', 0, 'parabolaz'}
ease
    {192, 1, outExpo, -10, 'dizzy', 100, 'drunk', 50, 'drunkperiod', 0.75, 'xmod', 300, 'drawsize', -150, 'holdgirth'}
    {192, 32, linear, 360 * 2, 'rotationy', 314.15 * 4, 'confusionzoffset'}
    {216, 4, linear, 100, 'stealth', 100, 'holdstealth', 100, 'hideholds', 100, 'dark', plr = 2}
reset
    {216, 8, inOutQuad, exclude = {'rotationy', 'confusionzoffset', 'dizzy', 'stealth', 'holdstealth', 'dark', 'halgun', 'hide', 'hideholds', 'hidenoteflashes', 'hidden', 'hiddenoffset', 'wave'}, plr = 1}

screenslam(224)

screenslam(334)
screenslam(334.75)
set
    {224, 0, 'stealth', 0, 'flip', 0, 'dark', 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
ease
    {224, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
reset
    {223.95, 0, instant}
swap
    {334, 0.5, outQuad, 'dlru'}
    {334.75, 0.5, outQuad, 'rudl'}
    {335.5, 0.5, outQuad, 'dlru'}
    {335.5, 0.5, inQuad, 'ldur'}
ease
    {333, 1, inExpo, -100, 'tiny', 200, 'zoomx', 800, 'zoomz'}
    {335, 1, inExpo, 0, 'tiny', 100, 'zoomx', 100, 'zoomz'}
    {333.5, 1, inverse, -25, 'rotationy', -25, 'rotationx', 5000, 'tinyz', 100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}
    {334.25, 1, inverse, 25, 'rotationy', -25, 'rotationx', -5000, 'tinyz', -100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}
    {335, 1, inverse, -25, 'rotationy', -25, 'rotationx', 5000, 'tinyz', 100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}