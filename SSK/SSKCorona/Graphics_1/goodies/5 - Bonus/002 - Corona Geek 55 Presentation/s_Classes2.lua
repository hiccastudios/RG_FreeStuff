-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2013 
-- =============================================================
-- =============================================================
--
-- =============================================================

local storyboard = require( "storyboard" )
local scene      = storyboard.newScene()

--local debugLevel = 1 -- Comment out to get global debugLevel from main.cs
local dp = ssk.debugPrinter.newPrinter( debugLevel )
local dprint = dp.print

----------------------------------------------------------------------
--								LOCALS								--
----------------------------------------------------------------------
-- Variables
local screenGroup
local layers 

-- Callbacks/Functions
local onBack
local onNext
local onDemo

----------------------------------------------------------------------
--	Scene Methods:
-- scene:createScene( event )  - Called when the scene's view does not exist
-- scene:willEnterScene( event ) -- Called BEFORE scene has moved onscreen
-- scene:enterScene( event )   - Called immediately after scene has moved onscreen
-- scene:exitScene( event )    - Called when scene is about to move offscreen
-- scene:didExitScene( event ) - Called AFTER scene has finished moving offscreen
-- scene:destroyScene( event ) - Called prior to the removal of scene's "view" (display group)
-- scene:overlayBegan( event ) - Called if/when overlay scene is displayed via storyboard.showOverlay()
-- scene:overlayEnded( event ) - Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
----------------------------------------------------------------------
function scene:createScene( event )
	screenGroup = self.view
	
	-- Create some rendering layers
	layers = ssk.display.quickLayers( screenGroup, "background", "buttons", "overlay" )

	local backImage
	backImage = display.newImage( layers.background, "images/interface/backImage2.jpg" )
	if(build_settings.orientation.default == "landscapeRight") then
		backImage.rotation = 90
	end

	backImage.x = w/2
	backImage.y = h/2

	-- Add dummy touch catcher to backImage to keep touches from 'falling through'
	backImage.touch = function() return true end
	backImage:addEventListener( "touch", backImage )

	local overlayImage
	overlayImage = display.newImage( layers.overlay, "images/interface/protoOverlay.png" )
	if(build_settings.orientation.default == "landscapeRight") then
		overlayImage.rotation = 90
	end

	overlayImage.x = w/2
	overlayImage.y = h/2

	-- AWESOME CONTENT HERE
	ssk.labels:quickLabel( layers.buttons, "'Classes' 2 of 3", centerX, 15, gameFont, 30, _YELLOW_ )

	ssk.labels:quickLabel( layers.buttons, "Object Builders", w/4, 40, gameFont, 20 )
	ssk.labels:quickLabel( layers.buttons, "--------------", w/4, 50, gameFont, 20 )

	ssk.buttons:presetPush( layers.buttons, "default", w/4, 75, 210, 30, "Parameterized",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w/4, 110, 210, 30, "Bodies",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w/4, 145, 210, 30, "Lines and Arrows",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w/4, 180, 210, 30, "Layers",  onDemo )

	ssk.labels:quickLabel( layers.buttons, "Collisions", w/4, 215, gameFont, 20 )
	ssk.labels:quickLabel( layers.buttons, "-----------", w/4, 225, gameFont, 20 )
	ssk.buttons:presetPush( layers.buttons, "default", w/4, 250, 210, 30, "Collision Calculator",  onDemo,{ fontSize = 15} )


	ssk.labels:quickLabel( layers.buttons, "HUDS", w-w/4, 40, gameFont, 20 )
	ssk.labels:quickLabel( layers.buttons, "----------", w-w/4, 50, gameFont, 20 )

	ssk.buttons:presetPush( layers.buttons, "default", w-w/4, 75, 210, 30, "Timer",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w-w/4, 110, 210, 30, "Text",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w-w/4, 145, 210, 30, "Image Counters",  nil,  { textColor = _PINK_ } )
	ssk.buttons:presetPush( layers.buttons, "default", w-w/4, 180, 210, 30, "Percentage Bars",  onDemo )
	ssk.buttons:presetPush( layers.buttons, "default", w-w/4, 215, 210, 30, "Percentage Dials",  onDemo )
		
	ssk.buttons:presetPush( layers.buttons, "default", 55, h-25, 100, 40, "Back", onBack )
	ssk.buttons:presetPush( layers.buttons, "default", w- 55, h-25, 100, 40, "Next", onNext )
	
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willEnterScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:enterScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:exitScene( event )
	screenGroup = self.view	
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExitScene( event )
	screenGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroyScene( event )
	screenGroup = self.view

	layers:removeSelf()
	layers = nil

	screenGroup = nil
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:overlayBegan( event )
	screenGroup = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:overlayEnded( event )
	screenGroup = self.view
	local overlay_name = event.sceneName  -- name of the overlay scene
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------
onBack = function ( event ) 
	ssk.debug.monitorMem()
	local options =
	{
		effect = "fromLeft",
		time = 200,
		params =
		{
			logicSource = nil
		}
	}

	storyboard.gotoScene( "s_Classes1", options  )	

	return true
end

onNext = function ( event ) 
	ssk.debug.monitorMem()
	local options =
	{
		effect = "fromRight",
		time = 200,
		params =
		{
			logicSource = nil
		}
	}

	storyboard.gotoScene( "s_Classes3", options  )	

	return true
end


onDemo = function ( event ) 
	ssk.debug.monitorMem()
	local options =
	{
		effect = "fade",
		time = 200,
		params =
		{
			logicSource = event.target:getText()
		}
	}

	storyboard.showOverlay( "s_Demo", options  )	

	return true
end


---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "willEnterScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "didExitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayBegan", scene )
scene:addEventListener( "overlayEnded", scene )
---------------------------------------------------------------------------------

return scene
