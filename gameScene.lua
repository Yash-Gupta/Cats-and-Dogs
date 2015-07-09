_W = display.contentWidth
_H = display.contentHeight

display.setStatusBar(display.HiddenStatusBar)


local composer = require( "composer" )
local physics = require "physics";
physics.start();
physics.setGravity(0, 1);

local scene = composer.newScene()
local sceneGroup = display.newGroup()
local background
local ground
local man 
local man2
local man3
local dogs = {}
local cats = {}
local environmentGroup
local barrier
local barrierLeft
local barrierRight
local restartButton

function scene:show( event )

    if(event.phase == "did") then
        background = display.newImageRect("images/bg.png", _W, _H)
        background.x = _W/2
        background.y = _H/2

        ground = display.newRect(_W/2, _H - 25, _W, 50)
        ground:setFillColor(48/255, 214/255, 48/255)
        physics.addBody(ground, "static")

        barrier = display.newRect(_W/2, _H - 100, _W, 50)
        barrier.alpha = 0
        physics.addBody(barrier, "static")

        barrierLeft = display.newRect(0, _H/2, 1, _H + 1000)
        barrierLeft.alpha = 0
        physics.addBody(barrierLeft, "static")

        barrierRight = display.newRect(_W, _H/2, 1, _H + 1000)
        barrierRight.alpha = 0
        physics.addBody(barrierRight, "static")

        man = display.newImageRect("images/man.png", 47, 87)
        man.x = _W/2
        man.y = _H-50
        man.anchorX = 0.5
        man.anchorY = 1

        man2 = display.newImageRect("images/man.png", 47, 87 )
        man2.x = _W/5
        man2.y = _H-50
        man2.anchorX = 0.5
        man2.anchorY = 1

        man3 = display.newImageRect("images/man.png", 47, 87 )
        man3.x = _W/1.25
        man3.y = _H-50
        man3.anchorX = 0.5
        man3.anchorY = 1


        environmentGroup = display.newGroup();
        environmentGroup:insert(background)
        environmentGroup:insert(ground)
        environmentGroup:insert(barrier)
        environmentGroup:insert(man)
        environmentGroup:insert(man2)
        environmentGroup:insert(man3)
        environmentGroup:insert(barrierLeft)
        environmentGroup:insert(barrierRight)
        environmentGroup.isVisible = true

        function recycleAnimals(e)
            e.target.x = math.random(_W/9,_W/1.125)
            e.target.y = math.random(-1* _H/12 - 200,-1*_H/12)
            -- body
        end
        
        for i=0,2 do
            cats[i] = display.newImageRect("images/cat.png", 75,60)
            --cats[i].x = 100
            --cats[i].y = 100
            environmentGroup:insert(cats[i])
            cats[i].x = math.random(_W/9,_W/1.125)
            cats[i].y = math.random(-1* _H/12 - 200,-1*_H/12)
            cats[i]:addEventListener("tap", recycleAnimals)
            cats[i].name = "enemy"


            dogs[i] = display.newImageRect("images/dog1.png", 60, 75)
            environmentGroup:insert(dogs[i])
            dogs[i].x = math.random(_W/9, _W/1.125)
            dogs[i].y = math.random(-1* _H/12 - 200,-1*_H/12)
            dogs[i]:addEventListener("tap", recycleAnimals)
            dogs[i].name = "enemy"
             
        end


        local counter = 0
        function spawnAnimals()
            physics.addBody(cats[counter], "dynamic")
            physics.addBody(dogs[counter], "dynamic")
            counter = counter + 1
        end

        timer.performWithDelay(3000, spawnAnimals, 3)
        
                 
    end
end
    function onCollision(e)
        if((e.object2.name == "enemy") and (e.object1 == barrier) and (e.phase == "began"))then
            display.newText("Game Over!", _W/2, _H/2- 20 , native.systemFont, 30)
            physics:stop()
            Runtime:removeEventListener("collision", onCollision)
        end
    end
function scene:hide( event )
    if (event.phase == "did") then 
        environmentGroup:removeSelf()
        environmentGroup = nil

    end
end

-- -------------------------------------------------------------------------------

scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
Runtime:addEventListener("collision", onCollision)
-- -------------------------------------------------------------------------------

return scene