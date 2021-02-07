-- Default Mods and Variables
setdefault {100, 'modtimer', 100, 'stealthpastreceptors'}
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

-- Begin Mod Section --
func {0, function()
    AFTSpriteR:diffuse(1, 0, 0, 0.9)
    AFTSpriteR:blend('add')
    AFTSpriteG:diffuse(0, 1, 0, 0.9)
    AFTSpriteG:blend('add')
    AFTSpriteB:diffuse(0, 0, 1, 0.9)
    AFTSpriteB:blend('add')
end}

func {0, function()
    HideEvent:diffuse(0.6, 0, 0, 1)
    HideEvent:decelerate(2 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}

set
    {0, 50, 'flip', 50, 'reverse', -2500, 'tiny', 98, 'dark'}
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
    {0, 1, outQuad, 100, 'stealth', 100, 'dark'}
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
screenslam(46)
screenslam(48)
screenslam(50)
screenslam(52)
screenslam(54)
screenglitch(56, 4)
screenslam(56)
screenslam(57)
screenslam(58)
screenslam(59)

for beat = 32, 42 do
    ease
        {beat, 0.5, pop, 100, 'tipsy'}
        {beat + 0.5, 0.5, pop, -100, 'tipsy'}
end
for beat = 48, 59.5, 0.5 do
    ease
        {beat, 0.25, bounce, 75, 'tipsy'}
        {beat + 0.25, 0.25, bounce, -75, 'tipsy'}
end
set
    {32, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {40, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
    {48, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', -15, 'rotationy', -15, 'rotationz'}
    {50, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', 15, 'rotationy', 15, 'rotationz'}
    {52, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', -15, 'rotationy', -15, 'rotationz'}
    {54, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', 15, 'rotationy', 15, 'rotationz'}
    {56, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', -15, 'rotationy', -15, 'rotationz'}
    {57, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', 15, 'rotationy', 15, 'rotationz'}
    {58, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', -15, 'rotationy', -15, 'rotationz'}
    {59, 100, 'invert', -300, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz', 15, 'rotationy', 15, 'rotationz'}
ease
    {32, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}
    {39.75, 0.5, pop, -100, 'drunk'}
    {40, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}

    {43, 0.5, pop, 100, 'tipsy'}
    {43.25, 0.5, pop, 100, 'drunk'}
    {44, 0.5, pop, 100, 'tipsy'}
    {44.25, 0.5, pop, 100, 'drunk'}
    {44.75, 0.5, pop, -100, 'drunk'}
    {45, 0.5, pop, 100, 'drunk'}

    {45, 2, spike, -500, 'tiny'}
    {45.5, 1, spike, -1000, 'tiny'}
    {45.5, 2, bell, -100, 'mini', 10, 'flip'}
    {46.75, 1, bell, 0.75, 'xmod', 100, 'invert'}

    {48, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {50, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {52, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {54, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {56, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {57, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {58, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
    {59, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz', 0, 'rotationy', 0, 'rotationz'}
mirror
    {45.5, 0.5, inExpo, 160, 'x'}
    {47, 1, inExpo, 0, 'x'}

swap
    {48, 0, instant, 'dlru'}
    {50, 0, instant, 'uldr'}
    {52, 0, instant, 'rudl'}
    {54, 0, instant, 'dlru'}
    {56, 0, instant, 'uldr'}
    {57, 0, instant, 'rudl'}
    {58, 0, instant, 'dlru'}
    {59, 0, instant, 'uldr'}
    {60, 1, outExpo, 'ldur'}

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

for beat = 60, 62.75, 0.5 do
    ease {beat, 0.25, bounce, 50, 'drunk', 50, 'tipsy'}
    ease {beat + 0.25, 0.25, bounce, -50, 'drunk', -50, 'tipsy'}
end

mirror
    {56, 2, pop, 50, 'movex'}
    {57, 2, pop, 50, 'movex'}
    {58, 2, pop, 50, 'movex'}
    {59, 2, pop, 50, 'movex'}
    {60, 0, instant, -160, 'x'}
set
    {64, 500, 'z', 0, 'mini', -500, 'tiny', 50, 'flip', 50, 'stealth', 0, 'rotationz', 0, 'confusionzoffset'}
ease
    {60, 2, pop, 50, 'movex'}
    {60, 1.5, bounce, -150, 'movex', -30, 'rotationy'}
    {61.5, 1.5, bounce, 75, 'movex', 30, 'rotationy'}
    {60, 1, outExpo, 0, 'x'}
    {62, 2, inOutExpo, 200, 'mini', 360, 'rotationz'}
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
    {79, 800, 'tornadoperiod'}
ease
    {73, 1, inExpo, -100, 'mini', 0, 'rotationx', 0, 'rotationy', 5, 'rotationz', 0, 'stealth', 0, 'dark'}
    {74, 0.25, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {74, 2, pop, 150, 'drunk', 150, 'tipsy'}
    {74, 2, inExpo, 480, 'y', 0, 'rotationz'}
    {79, 1, bounce, -100, 'attenuatex', -50, 'tornado'}
    {79, 0.5, bounce, -5000, 'tinyz'}
    {79.5, 0.5, bounce, 5000, 'tinyz'}
swap
    {75, 1, bell, 'dlru'}
    {79, 1, bell, 'rudl'}
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
    {80, 1, pop, -400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 800, 'zoomz', 200, 'zoomy', 100, 'invert', 200, 'tornado', 200, 'sawtooth'}
    {81, 1, pop, -400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 800, 'zoomz', 200, 'zoomy', 100, 'flip', 200, 'tornado', 200, 'sawtooth'}
    {81, 2, spike, 200, 'mini'}
    {81.5, 1, inOutExpo, 50, 'tipsy', 50, 'drunk', -100, 'split', 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 400, 'z', 100, 'mini', 300, 'movey', 100, 'dizzyholds', 500, 'zoomz', 15, 'rotationx', -314.15 / 12, 'confusionxoffset'}
    {81.5, 1, inOutExpo, 100, 'reverse', plr = 2}
    {82, 5, outExpo, 0, 'tinyz'}
    {86, 2, spike, 200, 'mini'}
mirror
    {81.5, 1, inOutExpo, -5, 'rotationy'}

reset {86.5, 1, inOutExpo}

swap {87, 1, bell, 'dlru'}
ease
    {87, 2, inverse, 400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 400, 'zoomz', 200, 'zoomy', 5000, 'tinyz', 200, 'tornado', 400, 'tornadoperiod', 200, 'drunk', 400, 'drunkperiod'}
    {87.5, 2, bell, 100, 'reverse'}
    {88, 2, spike, 200, 'mini'}
    {88.5, 1, inOutExpo, 50, 'tipsy', 50, 'drunk', 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 100, 'mini', 100, 'dizzyholds', 500, 'zoomz', 400, 'z', 100, 'alternate'}
    {89, 5, outExpo, 0, 'tinyz'}
    {91.5, 1, inOutExpo, -50, 'tipsy', -50, 'drunk', 100, 'split', 100, 'reverse', 0, 'alternate'}
    {93, 2, spike, 200, 'mini'}
    {94.5, 1, bell, -7500, 'tinyz'}
    {94, 1, inExpo, 100, 'reverse'}
    {95, 1, inExpo, 0, 'reverse'}
add
    {88.5, 1, inOutExpo, -250, 'movey'}
    {94.25, 1, bell, 100, 'flip'}
mirroradd
    {88.5, 1, inOutExpo, 50, 'centered', 350, 'movey', 0, 'movex', 15, 'rotationx', -314.15 / 12, 'confusionxoffset', -5, 'rotationy'}
    {94, 1, bell, -10, 'rotationy', -75, 'movex'}

reset {93.5, 1, inOutExpo}

func {82, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.1, 0, 0.1, 1)
    HideEvent:sleep(4 * spb)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}
func {89, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.1, 0.1, 0, 1)
    HideEvent:sleep(2.25 * spb)
    HideEvent:linear(0.25 * spb)
    HideEvent:diffuse(0, 0.1, 0.1, 1)
    HideEvent:sleep(1.25 * spb)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}

screenslam(80)
screenslam(81)
screenglitch(82, 5)
screenslam(88)
screenglitch(89, 5)

-- heckies this is a lot of work for some angy arrows
screenslam(96)
screenslam(98)
screenslam(100)
screenslam(102)
screenslam(106)
screenslam(108)
screenslam(110)
add
    {95, 1, bounce, 50, 'brake'}
    {96, 8, linear, 360 * 2, 'rotationy', -314.15 * 4, 'confusionyoffset'}
    {96, 1, outExpo, 25, 'flip'}
    {97, 2, inOutExpo, -50, 'flip', 0.6, 'xmod', 100, 'dizzyholds'}
    {97, 1, inExpo, -25, 'flip'}
    {98, 0.5, pop, 150, 'flip'}
    {98, 1, pop, 200, 'wave', 100, 'brake'}
    {98, 2, inOutExpo, 50, 'flip'}
    {99, 2, inOutExpo, -50, 'flip'}
    {100, 0.5, pop, 150, 'flip'}
    {100, 1, pop, 200, 'wave', 100, 'brake'}
    {100, 2, inOutExpo, 50, 'flip'}
    {101, 2, inOutExpo, -50, 'flip'}
    {102, 0.5, pop, 150, 'flip'}
    {102, 1, pop, 200, 'wave', 100, 'brake'}
    {102, 2, inOutExpo, 50, 'flip'}
    {106, 4, linear, 360, 'rotationx', -314.15 * 2, 'confusionxoffset'}
    {106, 2, inOutExpo, -50, 'flip'}
    {106, 0.5, pop, 150, 'flip'}
    {106, 1, pop, 200, 'wave', 100, 'brake'}
    {106, 2, inOutExpo, 50, 'flip'}
    {107, 2, inOutExpo, -50, 'flip'}
    {108, 0.5, pop, 150, 'flip'}
    {108, 1, pop, 200, 'wave', 100, 'brake'}
    {108, 2, inOutExpo, 50, 'flip'}
    {109, 2, inOutExpo, -50, 'flip'}
    {110, 0.5, pop, 150, 'flip'}
    {110, 1, pop, 200, 'wave', 100, 'brake'}
    {110, 2, inOutExpo, 50, 'flip'}
    {111.5, 0.5, bounce, 0, 'reverse', 50000, 'tinyz', 30, 'rotationx', -314.15 / 6, 'confusionxoffset', 800, 'parabolaz', 400, 'zoomz'}
plr = 1
set
    {104, 100, 'stealth', 100, 'dark', 100, 'holdstealth'}
    {105, 50, 'stealth', 0, 'dark', -1000, 'z'}
    {106, 0, 'holdstealth'}
ease
    {104, 2, pop, 500, 'flip', -300, 'reverse', -1000, 'drunk', -1000, 'tipsy', 314.15 * 4, 'confusionxoffset', 314.15 * 4, 'confusionyoffset'}
    {105, 1, inSine, 0, 'z', 0, 'stealth'}
plr = 2
ease
    {104, 1, pop, 400, 'zoomz', 5000, 'tinyz', 300, 'bumpy'}
    {103.75, 1, bell, 75, 'flip', 25, 'reverse'}
    {104, 0.5, inOutExpo, -500, 'tiny', 50, 'flip', 50, 'reverse', 314.15, 'confusionxoffset'}
    {104.5, 0.5, outExpo, 100, 'stealth', 100, 'dark'}
plr = nil
ease
    {95, 2, spike, -1500, 'tiny', 1000, 'z'}
    {95, 1, inExpo, 0.75, 'xmod'}
    {96, 2, bounce, 200, 'attenuatex'}
    {95, 4, bell, 210, 'mini'}
    {98, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {98.5, 1, inOutExpo, 100, 'invert'}
    {99, 1, inOutExpo, 100, 'cross'}
    {99.5, 1, inOutExpo, 0, 'invert', 0, 'cross', 100, 'reverse'}
    {100, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {100.5, 1, inOutExpo, 100, 'invert'}
    {101, 1, inOutExpo, 100, 'cross', 0, 'reverse'}
    {101.5, 1, inOutExpo, 0, 'invert', 0, 'cross', 0, 'reverse'}
    {102, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
reset {106, 0, instant}
ease
    {106, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {106.5, 1, inOutExpo, 100, 'invert'}
    {107, 1, inOutExpo, 100, 'cross'}
    {107.5, 1, inOutExpo, 0, 'invert', 0, 'cross', 100, 'reverse'}
    {108, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {108.5, 1, inOutExpo, 100, 'invert'}
    {109, 1, inOutExpo, 100, 'cross', 0, 'reverse'}
    {109.5, 1, inOutExpo, 0, 'invert', 0, 'cross', 0, 'reverse'}
    {110, 0.5, pop, 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 400, 'zoomz', 100, 'arrowpath', 200, 'tornado', 200, 'sawtooth'}
    {110, 0.5, outExpo, 100, 'invert'}
    {110.5, 0.5, outExpo, 0, 'invert'}
    {111, 0.5, outExpo, 100, 'flip'}
    {111.5, 0.5, outExpo, 0, 'flip'}
    {111, 1, outExpo, 1.5, 'xmod'}
mirror
    {98, 0.5, pop, 200, 'movex', -15, 'rotationz', -400, 'parabolax'}
    {100, 0.5, pop, 200, 'movex', -15, 'rotationz', -400, 'parabolax'}
    {102, 0.5, pop, 200, 'movex', -15, 'rotationz', -400, 'parabolax'}
add
    {111.5, 2, bell, 150, 'mini'}
    {112.5, 1.25, inverse, 100, 'flip', -50, 'invert', 300, 'tipsy', 300, 'drunk', -50, 'reverse', -50, 'flip', 0, 'reverse', 50000, 'tinyz', 30, 'rotationx', -314.15 / 6, 'confusionxoffset', 800, 'parabolaz', -800, 'zoomz', -50, 'zoomy', 1600, 'zoomx'}

reset {111.95, 0, instant}

ease
    {111.5, 1, inOutExpo, 0, 'flip'}
    {113, 2, spike, 200, 'mini'}
    {113.5, 1, inOutExpo, -100, 'alternate', 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 400, 'z', 100, 'mini', 300, 'movey', 100, 'dizzyholds', 500, 'zoomz', 15, 'rotationx', -314.15 / 12, 'confusionxoffset'}
    {113.5, 1, inOutExpo, 100, 'reverse', plr = 2}
    {114, 5, outExpo, 0, 'tinyz'}
    {118, 2, spike, 200, 'mini'}
mirroradd
    {113.5, 1, inOutExpo, -5, 'rotationy'}

reset {118.5, 1, inOutExpo}

swap
    {119, 0.25, outExpo, 'ldru'}
    {119.25, 0.25, outExpo, 'lrdu'}
    {119.5, 0.25, outExpo, 'rldu'}
    {120, 0.5, inOutExpo, 'ldur'}
ease
    {119, 2, inverse, -400, 'tiny', 15, 'rotationx', 1500, 'parabolaz', 400, 'zoomz', 200, 'zoomy', 5000, 'tinyz', 200, 'tornado', 400, 'tornadoperiod', 200, 'drunk', 400, 'drunkperiod'}
    {120, 2, spike, 200, 'mini'}
    {120.5, 1, inOutExpo, 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', -1000, 'tinyz', 100, 'tornado', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 100, 'mini', 100, 'dizzyholds', 500, 'zoomz', 400, 'z', 100, 'cross'}
    {121, 5, outExpo, 0, 'tinyz'}
    {124, 8, spike, 200, 'mini'}
add
    {120.5, 1, inOutExpo, -200, 'movey'}
    {123.5, 1, inOutExpo, 0, 'flip', 0, 'cross', 100, 'split'}
    {122, 6, inQuart, -1500, 'tiny', 50, 'flip', 800, 'zoomz'}
mirroradd
    {120.5, 1, inOutExpo, 50, 'centered', 350, 'movey', 0, 'movex', 15, 'rotationx', -314.15 / 12, 'confusionxoffset', -5, 'rotationy'}
    {123.5, 1, inOutExpo, 100, 'movex'}
    {122, 6, inQuart, 150, 'movey'}

reset {127.5, 1, inOutExpo}

func {114, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.1, 0, 0.1, 1)
    HideEvent:sleep(4 * spb)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}
func {121, function()
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.2, 0, 0, 1)
    HideEvent:sleep(2.25 * spb)
    HideEvent:linear(0.5 * spb)
    HideEvent:diffuse(0.0, 0.05, 0.15, 1)
    HideEvent:sleep(2.25 * spb)
    HideEvent:accelerate(1.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}

screenglitch(114, 5)
screenslam(120)
screenglitch(121, 7)
add
    {144, 1, pop, -30, 'rotationy', 400, 'zoomz'}
    {145, 1, pop, 30, 'rotationy', 400, 'zoomz'}
    {146, 1, pop, -30, 'rotationy', 400, 'zoomz'}
    {146.75, 1, pop, 30, 'rotationy', 400, 'zoomz'}
    {147.5, 1, pop, -30, 'rotationy', 400, 'zoomz'}
    {148, 1, pop, 30, 'rotationy', 400, 'zoomz'}
    {149, 1, pop, -30, 'rotationy', 400, 'zoomz'}
    {149.75, 1, pop, 30, 'rotationy', 400, 'zoomz'}
    {150.5, 1, pop, -30, 'rotationy', 400, 'zoomz'}


screenslam(176)
screenslam(192)

func {191.5, function()
    HideEvent:diffuse(0, 0, 0, 1)
    HideEvent:accelerate(0.5 * spb)
    HideEvent:diffuse(1, 1, 1, 1)
end, persist = false}
func {192, function()
    HideEvent:diffuse(1, 1, 1, 1)
    HideEvent:decelerate(0.5 * spb)
    HideEvent:diffuse(0.9, 0.8, 0.7, 1)
    AFTSpriteRecursive:hidden(0)
    AFTSpriteRecursive:zoom(1.1)
    AFTSpriteRecursive:diffusealpha(0.88)
    AFTSpriteRecursive:decelerate(2 * spb)
    AFTSpriteRecursive:zoom(1.05)
    AFTSpriteRecursive:diffusealpha(0.7)
end, persist = false}
func {216, function()
    AFTSpriteRecursive:linear(4 * spb)
    AFTSpriteRecursive:diffusealpha(0)
end, persist = false}
func {220, function()
    AFTSpriteRecursive:hidden(1)
end, persist = false}

reset {191.75, 0, instant}

set
    {192, 400, 'z', 1000, 'zoomz', 60, 'rotationx', 1000, 'parabolaz', 100, 'dizzyholds', 0, 'straightholds', 300, 'dizzy'}
    {192, 80, 'dark', 100, 'hidenoteflash', 50, 'hidden', -90, 'hiddenoffset', 100, 'halgun'}
    {192, 20, 'stealth', plr = 1}
    {192, 90, 'stealth', 100, 'flip', 100, 'dark', plr = 2}
mirror
    {192, 1, outExpo, 0, 'z', -5000, 'attenuatex', -5000, 'attenuatez', 50, 'brake', 50, 'wave', 75, 'targetx1', 50, 'targetx2', -50, 'targetx3', -75, 'targetx4', -75, 'targetz2', 75, 'targetz3', 600, 'zoomz', -90, 'rotationx', 314.15 / 2, 'confusionxoffset', 0, 'parabolaz'}
ease
    {192, 1, outExpo, -10, 'dizzy', 100, 'arrowpath', 200, 'arrowpathgirth', 100, 'drunk', 50, 'drunkperiod', 0.85, 'xmod', 300, 'drawsize', -150, 'holdgirth'}
    {192, 32, linear, 360 * 2, 'rotationy', 314.15 * 4, 'confusionzoffset'}
    {216, 2, linear, 0, 'arrowpath'}
    {220, 4, linear, 0, 'stealth', plr = 1}
    {216, 4, linear, 100, 'stealth', 100, 'holdstealth', 100, 'hideholds', 100, 'dark', plr = 2}
add
    {216.05, 7.95, inOutQuad, 314.15 * 4, 'confusionzoffset'}
reset {216, 8, inOutQuad, exclude = {'rotationy', 'confusionzoffset', 'dizzy', 'stealth', 'holdstealth', 'dark', 'halgun', 'hide', 'hideholds', 'hidenoteflash', 'hidden', 'hiddenoffset', 'wave'}, plr = 1}

func {214, function()
    HideEvent:diffuse(0.9, 0.8, 0.7, 1)
    HideEvent:accelerate(8 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}

screenslam(224)

reset {223.95, 0, instant}
set
    {224, 0, 'stealth', 0, 'flip', 0, 'dark', 100, 'invert', -100, 'tiny', 45, 'rotationx', -314.15 / 4, 'confusionxoffset', 1500, 'parabolaz', 800, 'zoomz'}
ease
    {224, 4, outExpo, 0, 'invert', 0, 'tiny', 0, 'rotationx', 0, 'confusionxoffset', 0, 'parabolaz', 100, 'zoomz'}

screenslam(320)
screenglitch(322, 0.5)
screenslam(323)
screenslam(323.5)
screenslam(325.5)
screenslam(326, 0.5)
screenslam(328)
screenslam(330, 0.5)
screenslam(331)
screenglitch(332, 0.5)
screenslam(332.5)

screenslam(334)
screenslam(334.75)

set
    {332.5, 0, 'rotationy', 0, 'confusionyoffset'}
    {333, 20, 'stealth', 90, 'dark'}
    {334, 0, 'stealth', 0, 'dark'}
ease
    {319, 2, spike, 200, 'mini'}
    {320, 0.5, outExpo, 50, 'flip', 50, 'invert', 100, 'split', 1200, 'attenuatex', -500, 'z', -100, 'tinyz', 800, 'attenuatez', 400, 'zoomz'}
    {320.5, 1, inOutExpo, 0, 'flip', 0, 'invert', 0, 'split', 0, 'attenuatex', 0, 'z', 0, 'tinyz', 0, 'attenuatez', 0, 'zoomz'}
    {321, 2, inverse, -1000, 'tiny', 200, 'flip', 200, 'mini', -90, 'rotationx', -2400, 'parabolaz', -3200, 'zoomz'}
    {323, 1, inverse, -200, 'tiny', 20, 'reverse', -100, 'invert'}
    {323, 4, bell, 800, 'zoomz'}
    {325, 1, inOutExpo, 100, 'reverse'}
    {325, 4, bell, 800, 'zoomz'}
    {327, 1, inOutExpo, 0, 'reverse'}
    {328.25, 1, bell, 400, 'zoomz'}
    {328.75, 1, bell, 400, 'zoomz'}
    {329.25, 1, bell, 400, 'zoomz'}
    {329.75, 1, bell, 400, 'zoomz'}
    {330.25, 1, bell, 400, 'zoomz'}
    {327.25, 1, bell, 100, 'flip'}
    {328.25, 0.5, inOutExpo, 100, 'reverse'}
    {328.75, 0.5, inOutExpo, 0, 'reverse'}
    {329.25, 0.5, inOutExpo, 100, 'reverse'}
    {329.75, 0.5, inOutExpo, 0, 'reverse'}
    {330.25, 0.5, inOutExpo, 100, 'reverse'}
    {330.5, 1, inOutExpo, 0, 'reverse', 0, 'skewx'}
    {331, 2, pop, -50, 'flip'}
    {331.5, 1, inQuad, 360 * 4, 'rotationy', -314.15 * 8, 'confusionyoffset', 100, 'reverse'}
    {331.5, 1, tap, 0.5, 'xmod', 100, 'tornado', -500, 'tinyz', 400, 'zoomz'}
    {332, 2, spike, 200, 'mini'}
    {332.5, 1, inOutExpo, -100, 'split', 2000, 'attenuatex', 2000, 'attenuatez', 100, 'arrowpath', -50, 'holdgirth', 0, 'tinyz', 300, 'tornadoperiod', 100, 'tornadoz', 100, 'tornadozperiod', 110, 'brake', 1.5, 'xmod', 400, 'z', 100, 'mini', 300, 'movey', 100, 'dizzyholds', 500, 'zoomz', 30, 'rotationx', -314.15 / 6, 'confusionxoffset'}
    {332.5, 1, inOutExpo, 0, 'reverse', plr = 1}
    {332.5, 1, inOutExpo, 100, 'reverse', plr = 2}
mirror
    {324, 2, bell, -15, 'rotationy', -200, 'movex'}
    {326, 2, bell, -15, 'rotationy', 200, 'movex'}
    {323.75, 1, bell, 50, 'noteskewx', -50, 'noteskewy', -50, 'skewx'}
    {324.25, 1, bell, -50, 'noteskewx', 50, 'noteskewy', 50, 'skewx'}
    {324.75, 1, bell, 50, 'noteskewx', -50, 'noteskewy', -50, 'skewx'}
    {325.75, 1, bell, 50, 'noteskewx', -50, 'noteskewy', -50, 'skewx'}
    {326.25, 1, bell, -50, 'noteskewx', 50, 'noteskewy', 50, 'skewx'}
    {326.75, 1, bell, 50, 'noteskewx', -50, 'noteskewy', -50, 'skewx'}
    {328.25, 1, bell, 30, 'rotationx'}
    {328.75, 1, bell, 30, 'rotationx'}
    {329.25, 1, bell, 30, 'rotationx'}
    {329.75, 1, bell, 30, 'rotationx'}
    {330.25, 1, bell, 30, 'rotationx'}
mirroradd
    {332.5, 1, inOutExpo, 10, 'rotationy'}
reset {333.5, 1, inOutExpo, exclude = {'tinyz', 'zoomx', 'zoomz'}}
swap
    {334, 0.5, outQuad, 'dlru'}
    {334.75, 0.5, outQuad, 'rudl'}
    {335.5, 0.5, outQuad, 'dlru'}
    {335.5, 0.5, inQuad, 'ldur'}
ease
    {333.75, 0.5, inOutExpo, -100, 'tiny', 200, 'zoomx', 800, 'zoomz'}
    {335.75, 0.5, inOutExpo, 0, 'tiny', 100, 'zoomx', 100, 'zoomz'}
    {333.75, 0.5, inverse, -25, 'rotationy', -25, 'rotationx', 5000, 'tinyz', 100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}
    {334.5, 0.5, inverse, 25, 'rotationy', -25, 'rotationx', -5000, 'tinyz', -100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}
    {335.25, 0.5, inverse, -25, 'rotationy', -25, 'rotationx', 5000, 'tinyz', 100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}
    {335.75, 0.5, inverse, 25, 'rotationy', -25, 'rotationx', -5000, 'tinyz', -100, 'noteskewx', 100, 'invert', 500, 'tipsy', 100, 'tornado', 1600, 'tornadoperiod'}

screenslam(336)
screenslam(337)
screenslam(338)
screenslam(338.75)
screenslam(340)
screenslam(341)
screenslam(341.75)
screenslam(343)

func {333, function()
    HideEvent:diffuse(0.75, 0.75, 0.6, 1)
    HideEvent:sleep(1 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
    AFTSpriteRecursive:hidden(0)
    AFTSpriteRecursive:zoom(1.001)
    AFTSpriteRecursive:diffusealpha(0.9)
end, persist = false}
func {334, function()
    AFTSpriteRecursive:hidden(1)
end, persist = false}

func {344, function()
    for pn = 1, 2 do
        PJ[pn]:hidden(1)
        PC[pn]:hidden(1)
    end
    AFTSpriteRecursive:hidden(0)
    AFTSpriteRecursive:zoom(1.2)
    AFTSpriteRecursive:diffusealpha(0.8)
    HideEvent:diffuse(0.3, 0, 0, 1)
    HideEvent:sleep(6.5 * spb)
    HideEvent:diffuse(0, 0, 0, 1)
end, persist = false}
func {350, function()
    for pn = 1, 2 do
        PJ[pn]:hidden(0)
        PC[pn]:hidden(0)
    end
    AFTSpriteRecursive:hidden(1)
end, persist = false}

screenslam(344)
screenglitch(344, 6)
screenslam(350)

-- some bouncy frens here
hide 
    {336, 8, plr = 1}
    {344, 1, plr = 2}

plr = 1
    set
        {336, 314.15 / 2, 'confusionzoffset', 100, 'dark'}
    ease
        {341.75, 1, outElastic, 0, 'confusionzoffset'}
        {340, 1, bounce, 1.25, 'xmod'}
        {341.25, 1, inOutExpo, 1, 'xmod'}
        {343, 1, outBack, 3, 'xmod'}
plr = nil
set
    {336, 100, 'dizzyholds'}
    {344, 100, 'halgun'}
    {350, 0, 'halgun'}
ease
    {335, 2, spike, 150, 'movey', 70, 'zoomy', 45, 'rotationz', 30, 'rotationx', -30, 'rotationy', 1600, 'zoomz', 400, 'movex'}
    {336, 2, spike, 150, 'movey', 70, 'zoomy', -45, 'rotationz', 30, 'rotationx', 30, 'rotationy', 1600, 'zoomz', -400, 'movex'}
    {337, 2, spike, 150, 'movey', 70, 'zoomy', 45, 'rotationz', -30, 'rotationx', -30, 'rotationy', 1600, 'zoomz', 400, 'movex'}
    {337.75, 2, spike, 150, 'movey', 70, 'zoomy', -45, 'rotationz', -30, 'rotationx', 30, 'rotationy', 1600, 'zoomz', -400, 'movex'}
    {339, 2, spike, 150, 'movey', 70, 'zoomy', 45, 'rotationz', 30, 'rotationx', -30, 'rotationy', 1600, 'zoomz', 400, 'movex'}
    {340, 2, spike, 150, 'movey', 70, 'zoomy', -45, 'rotationz', 30, 'rotationx', 30, 'rotationy', 1600, 'zoomz', -400, 'movex'}
    {340.75, 2, spike, 150, 'movey', 70, 'zoomy', 45, 'rotationz', -30, 'rotationx', -30, 'rotationy', 1600, 'zoomz', 400, 'movex'}
    {341.5, 2, spike, 150, 'movey', 70, 'zoomy', -45, 'rotationz', -30, 'rotationx', 30, 'rotationy', 1600, 'zoomz', -400, 'movex'}
    {343, 1, tap, 6, 'xmod'}
    {343.5, 1, inOutExpo, 100, 'dark'}
    {343.5, 1, inOutExpo, -10, 'dizzy', 50, 'tipsy', 50, 'drunk', 45, 'flip', 350, 'movey', 1000, 'attenuatex', 1000, 'attenuatez', 100, 'arrowpath', 100, 'hideholds', -0, 'tinyz', 75, 'tornado', 300, 'tornadoperiod', 75, 'tornadoz', 100, 'tornadozperiod', -50, 'brake', 00, 'wave', 0.5, 'xmod', 100, 'mini', 0, 'movey', 100, 'dizzyholds', 800, 'zoomz'}
mirror
    {343.5, 1, inOutExpo, 490, 'z', 90, 'rotationx', -314.15 / 2, 'confusionxoffset'}
add
    {338.5, 2, inverse, 100, 'brake', 100, 'drunk', 1600, 'drunkperiod', 100, 'tipsy', 1600, 'tipsyperiod', -50, 'tiny', 30, 'rotationx', -314.15 / 6, 'confusionxoffset', 800, 'parabolaz', 800, 'zoomz'}
    {342, 2, inverse, 100, 'brake', 100, 'drunk', 1600, 'drunkperiod', 100, 'tipsy', 1600, 'tipsyperiod', -50, 'tiny', 30, 'rotationx', -314.15 / 6, 'confusionxoffset', 800, 'parabolaz', 800, 'zoomz'}

plr = 1
swap
    {335.5, 1, inOutExpo, 'ldur'}
    {336.5, 1, inOutExpo, 'urld'}
    {337.5, 1, inOutExpo, 'dlru'}
    {338.25, 1, inOutExpo, 'ldur'}
    {339, 1, inOutExpo, 'urld'}
    {339.5, 1, inOutExpo, 'dlru'}
    {340.5, 1, inOutExpo, 'ldur'}
    {341.25, 1, inOutExpo, 'rudl'}
    {342, 1, inOutExpo, 'dlru'}
plr = 2
swap
    {335.5, 1, inOutExpo, 'dlru'}
    {336.5, 1, inOutExpo, 'rudl'}
    {337.5, 1, inOutExpo, 'ldur'}
    {338.25, 1, inOutExpo, 'dlru'}
    {339, 1, inOutExpo, 'rudl'}
    {339.5, 1, inOutExpo, 'ldur'}
    {340.5, 1, inOutExpo, 'dlru'}
    {341.25, 1, inOutExpo, 'rudl'}
    {342, 1, inOutExpo, 'dlru'}
plr = nil

reset {343, 1, outExpo}
reset {350.25, 0, instant}

screenslam(408)
screenslam(413)
screenglitch(423, 9)

func {428.25, function()
    SCREENMAN:GetTopScreen():vibrate()
    SCREENMAN:GetTopScreen():effectmagnitude(0, 6, 0)
end, persist = false}
func {432, function()
    SCREENMAN:GetTopScreen():stopeffect()
end, persist = false}

set 
    {349.75, 100, 'stealth', 1, 'xmod'}
    {350.25, -200, 'mini', 0.5, 'xmod'}
    {351, 100, 'hide', 0, 'mini', 1, 'xmod'}
    {352, 0, 'hide'}
    {423, -100, 'zoomy'}
    {423.25, 100, 'zoomy'}
    {423.75, 1000, 'tinyz'}
    {427.75, -100, 'zoomy'}
    {428, 100, 'zoomy'}
    {429.75, -100, 'zoomy'}
    {430, 100, 'zoomy'}
    {431.75, -100, 'zoomy'}
    {432, 100, 'zoomy'}
ease
    {408, 8, linear, 100, 'brake'}
    {416, 14, linear, 50, 'z'}
    {416, 16, inOutSine, 75, 'brake'}
    {423, 0.5, bell, 10000, 'tandigital', 100, 'tandigitalperiod', 400, 'tandigitalsteps', 200, 'tornado'}
    {427.75, 0.5, bell, -10000, 'tandigital', 100, 'tandigitalperiod', 400, 'tandigitalsteps', 200, 'tornado'}
    {430, 2, linear, 0, 'tinyz'}
    {430, 2, inExpo, 400, 'zoomz', -1750, 'z'}
for beat = 428.25, 431.75, 0.25 do
    ease
        {beat, 0.125, bell, 10000, 'tandigital', 100, 'tandigitalperiod', 400, 'tandigitalsteps', 200, 'tornado'}
        {beat + 0.125, 0.125, bell, -10000, 'tandigital', 100, 'tandigitalperiod', 400, 'tandigitalsteps', 200, 'tornado'}
end
-- End Mods Section --