require "CiderDebugger";---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1 )
--putting banners

adbanner = display.newRect( display.contentCenterX, display.contentHeight+5, display.contentWidth, 80 )
adbanner:setFillColor  (1, .694, .286)

azOffset = "+09:00" --alternative time offset
azCity = "TOKYO"


-- require the composer library
local composer = require ( "composer" )

-- load scene1
composer.gotoScene( "scene1" )