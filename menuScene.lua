_W = display.contentWidth
_H = display.contentHeight

display.setStatusBar(display.HiddenStatusBar)


local composer = require( "composer" )

local scene = composer.newScene()
local sceneGroup = display.newGroup()
local sceneText
local background
local ground
local man 
local man2
local man3
local menuGroup
local menuTint
local settingsButton

function nextScene()
    composer.gotoScene("gameScene")
    -- body
end


function scene:show( event )
    print("testing")
    if(event.phase == "did") then
        background = display.newImageRect("images/bg.png", _W, _H)
        background.x = _W/2
        background.y = _H/2

        ground = display.newRect(_W/2, _H - 25, _W, 50)
        ground:setFillColor(48/255, 214/255, 48/255)
        
        man = display.newImageRect("images/man.png", 47, 87 )
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

        sceneText = display.newText("Touch the cats and dogs!", _W/2, _H/2 - 20, native.systemFont, 26)
        sceneText2 = display.newText("Tap anywhere to start!", _W/2, _H/2 + 20, native.systemFont, 26)

        menuTint = display.newRect(_W/2, _H/2, _W, _H)        
        menuTint:setFillColor(0, 0, 225)
        menuTint.alpha = 0.25

        sceneGroup:insert(background)
        sceneGroup:insert(ground)
        sceneGroup:insert(man)
        sceneGroup:insert(man2)
        sceneGroup:insert(man3)           
        sceneGroup:insert(menuTint)
        sceneGroup:insert(sceneText)
        sceneGroup:insert(sceneText2)
        sceneGroup.isVisible = true

        sceneGroup:addEventListener("tap", nextScene)

  
    end
end

function scene:hide( event )
    if (event.phase == "did") then 
        sceneGroup:removeSelf()
        sceneGroup = nil
    end
end


-- -------------------------------------------------------------------------------

scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

-- -------------------------------------------------------------------------------

return scene