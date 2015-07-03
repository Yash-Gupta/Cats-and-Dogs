_W = display.contentWidth
_H = display.contentHeight

display.setStatusBar(display.HiddenStatusBar)


local composer = require( "composer" )

local scene = composer.newScene()
local sceneGroup = display.newGroup()

function nextScene()
    composer.gotoScene("gameScene")
    -- body
end

function scene:show( event )
    print("testing")
    if(event.phase == "did") then
        sceneText = display.newText("Play", _W/2, _H/2, native.systemFont, 26)
        sceneGroup:insert(sceneText) 
        sceneText:addEventListener("tap", nextScene)

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