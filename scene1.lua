
---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------
require "CiderDebugger";
local sceneName = ...
local composer = require( "composer" )
-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )


-- Declaring local values
local fontSize = 16 --size dependent 
local xc = display.contentWidth / 2
local yc = display.contentHeight / 2

local x1=xc-85 -- time zone 1  label
local x2=xc+85 -- time zone 2  label
local y1=yc-240 -- time zone label
local y2=yc-240 -- date 
local y3=yc-220 -- current time 
local y4=yc-200 -- time scale starts here

local localTime = os.date("%H")
local widget = require "widget"

--Painting background 
local background = display.newImage("images/bckgrnd.png",xc, yc)
adbanner = display.newRect( display.contentCenterX, display.contentHeight+5, display.contentWidth, 80 )
adbanner:setFillColor  (1, .694, .286)
    
--Function to calculate time in other timezone 
function format_time(timestamp, format, tzoffset, tzname)
   if tzoffset == "local" then  -- calculate local time zone (for the server)
      local now = os.time()
      local local_t = os.date("*t", now)
      local utc_t = os.date("!*t", now)
      local delta = (local_t.hour - utc_t.hour)*60 + (local_t.min - utc_t.min)
      local h, m = math.modf( delta / 60)
      tzoffset = string.format("%+.4d", 100 * h + 60 * m)
   end
   tzoffset = tzoffset or "GMT"
   format = format:gsub("%%z", tzname or tzoffset)
   if tzoffset == "GMT" then
      tzoffset = "+0000"
   end
   tzoffset = tzoffset:gsub(":", "")

   local sign = 1
   if tzoffset:sub(1,1) == "-" then
      sign = -1
      tzoffset = tzoffset:sub(2)
   elseif tzoffset:sub(1,1) == "+" then
      tzoffset = tzoffset:sub(2)
   end
   tzoffset = sign * (tonumber(tzoffset:sub(1,2))*60 +
tonumber(tzoffset:sub(3,4)))*60
   return os.date(format, timestamp + tzoffset)
end


print (format_time(os.time(), "!%H",azOffset, "EST"))
print (format_time(os.time(), "!%H:%M:%S %z",azOffset, "EST"))


local anotherTime = format_time(os.time(), "!%H",azOffset, "EST")

--Printing out date and time 
--Local time
local lclDateText = display.newText(format_time(os.time(), "%a %b %d"), x1, y2, native.systemFont, fontSize);
local clockText = display.newText(format_time(os.time(), "%X"), x1, y3, native.systemFont, fontSize);
lclDateText:setFillColor (.341,.216,.055)
lclDateText:setFillColor (.62, .518, .325)
clockText:setFillColor (.62, .518, .325)

--Alternative time
local altDateText = display.newText(format_time(os.time(), "%a %b %d",azOffset), x2, y2, native.systemFont, fontSize);
local altClockText = display.newText(format_time(os.time(), "!%H:%M:%S %z",azOffset), x2, y3, native.systemFont, fontSize);
altDateText:setFillColor (.62, .518, .325)
altClockText:setFillColor (.62, .518, .325)

local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene("scene2")
        composer.removeHidden()
    end
end 
               -- Create the button 
    local leftButton = widget.newButton
{
    label = "button",
    onEvent = handleButtonEvent,
    width = 160,
    height = 40,
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }}, 
    defaultFile = "images/button.png",
    overFile = "images/button.png" 
--    emboss = false,
--    properties for a rounded rectangle button...
--    shape="roundedRect",
--
--    cornerRadius = 1,
--    fillColor = { default={ .341, .588, .106 }, over={ 1, 0.1, 0.7, 0.4 } },
--    strokeColor = { default={ 1, 1, 1, 1 }, over={ 0.8, 0.8, 1, 1 } },
--    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }}, 
--    strokeWidth = 1
}
    -- Center the button
    leftButton.x = 240
    leftButton.y = display.contentHeight-55
    -- Change the button's label text
    leftButton:setLabel( azCity )
    leftButton._view._label.size = 18

               -- Create the button 
    local rightButton = widget.newButton
{
    label = "button",
    onEvent = handleButtonEvent,
    width = 160,
    height = 40,
    defaultFile = "images/button.png",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 }}, 
    overFile = "images/button.png" 
--    emboss = false,
--    properties for a rounded rectangle button...
--    shape="roundedRect",
--
--    cornerRadius = 1,
--    fillColor = { default={ .341, .588, .106 }, over={ 1, 0.1, 0.7, 0.4 } },
--    strokeColor = { default={ 1, 1, 1, 1 }, over={ 0.8, 0.8, 1, 1 } },
--   
--    strokeWidth = 1
}
    -- Center the button
    rightButton.x = 80
    rightButton.y = display.contentHeight-55
    -- Change the button's label text
    rightButton:setLabel( "ALMATY" )
    rightButton._view._label.size = 18

    
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    sceneGroup:insert( background )   
    sceneGroup:insert( lclDateText )   
    sceneGroup:insert( clockText )   
    sceneGroup:insert( altDateText )   
    sceneGroup:insert( altClockText )  

--Printing cycle scale 
for i=1,24 do
    --showing date changes
    if anotherTime == 24 then anotherTime = 0 
        display.newText(format_time(os.time(), "%a %b %d",azOffset), xc+80, y4, native.systemFont, fontSize);
    end
    if localTime == 24 then localTime = 0 
        local nxtday = os.date("*t")
        nxtday.day = nxtday.day + 1    
        display.newText(format_time(os.time(nxtday), "%a %b %d"), xc-80, y4, native.systemFont, fontSize);    
    end

--[[display icons
if localTime == 9 then display.newImage("images/wakeup_small.png",xc-50, y4)
end
--]]

    anotherTime=anotherTime+1
    localTime =localTime+1

-- Major time scale 
    local localTimeText = display.newText(localTime, xc-20, y4, native.systemFont, fontSize);
    if localTime >=22 or localTime <=8 or localTime == 13 then 
        localTimeText:setFillColor (.62, .518, .325)
            else
        localTimeText:setFillColor (.341,.216,.055)
    end
    
    local altTimeText = display.newText(anotherTime, xc+20, y4, native.systemFont, fontSize);
    if anotherTime >=22 or anotherTime <=8 or anotherTime ==13 then 
       altTimeText:setFillColor (.62, .518, .325)
            else
       altTimeText:setFillColor (.341,.216,.055)
    end
sceneGroup:insert (localTimeText)
sceneGroup:insert (altTimeText)
sceneGroup:insert( leftButton )  

    fontSize = fontSize-0 --scaling time fond down
    y4=y4+fontSize+3
end
end

function scene:show( event )
    local phase = event.phase
    if ( phase == "did" ) then

        local function updateTime()
            clockText.text = format_time(os.time(), "%X");
            altClockText.text = format_time(os.time(), "!%H:%M:%S", azOffset)
        end
     
        if countdownTimer == nil then
            countDownTimer = timer.performWithDelay( 1000, updateTime, -1 )
        else 
            timer.resume(countownTimer)
        end
    end
end

function scene:hide( event )
    if ( phase == "will" ) then
          timer.pause( countdownTimer )
        -- NO: 
        -- timerSpawn = nil
        -- countdownTimer = nil
    end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene


