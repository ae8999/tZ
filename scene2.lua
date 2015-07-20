
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

local widget = require( "widget" )


local columnData = 
{
    -- Months
    { 
        align = "left",
        width = 280,
        startIndex = 5,
        labels = {"GMT00:00 Dublin, Edinburgh, Lisbon, London",  "GMT00:00 Greenwich Mean Time",  "GMT00:00  Morocco",  "GMT+01:00 Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",  "GMT+01:00 Belgrade, Bratislava, Budapest, Ljubljana, Prague",  "GMT+01:00 Brussels, Copenhagen, Madrid, Paris",  "GMT+01:00 Namibia",  "GMT+01:00 Sarajevo, Skopje, Warsaw, Zagreb",  "GMT+01:00 West Central Africa",  "GMT+02:00 Beirut",  "GMT+02:00 Bucharest",  "GMT+02:00 Cairo",  "GMT+02:00 Harare, Pretoria",  "GMT+02:00 Helsinki, Riga, Sofia, Tallinn, Vilnius",  "GMT+02:00 Libya",  "GMT+02:00 Syria",  "GMT+02:00 Tel Aviv, Jerusalem",  "GMT+02:00 Turkey",  "GMT+02:00 Ukraine",  "GMT+03:00 Baghdad",  "GMT+03:00 Belarus",  "GMT+03:00 Jordan",  "GMT+03:00 Kaliningrad",  "GMT+03:00 Kuwait, Riyadh",  "GMT+03:00 Nairobi",  "GMT+03:30 Tehran",  "GMT+04:00 Abu Dhabi, Muscat",  "GMT+04:00 Baku",  "GMT+04:00 Crimea",  "GMT+04:00 Mauritius",  "GMT+04:00 Moscow, St. Petersburg, Volgograd",  "GMT+04:00 Samara",  "GMT+04:00 Tbilisi",  "GMT+04:00 Yerevan",  "GMT+04:30 Kabul",  "GMT+05:00 Pakistan",  "GMT+05:00 Tashkent",  "GMT+05:30 Chennai, Kolkata, Mumbai, New Delhi",  "GMT+05:45 Kathmandu",  "GMT+06:00 Bangladesh",  "GMT+06:00 Central Asia",  "GMT+06:00 Ekaterinburg",  "GMT+06:30 Rangoon",  "GMT+07:00 Bangkok, Hanoi, Jakarta",  "GMT+07:00 Kemerovo",  "GMT+07:00 Novosibirsk",  "GMT+08:00 Beijing, Chongqing, Hong Kong, Urumqi",  "GMT+08:00 Krasnoyarsk",  "GMT+08:00 Kuala Lumpur, Singapore",  "GMT+08:00 Perth",  "GMT+08:00 Taipei",  "GMT+08:00 Ulaanbaatar",  "GMT+09:00 Irkutsk",  "GMT+09:00 Osaka, Sapporo, Tokyo",  "GMT+09:00 Seoul",  "GMT+09:00 Ulan-Ude",  "GMT+09:30 Adelaide",  "GMT+09:30 Darwin",  "GMT+10:00 Bougainville Island",  "GMT+10:00 Brisbane",  "GMT+10:00 Canberra, Melbourne, Sydney",  "GMT+10:00 Guam, Port Moresby",  "GMT+10:00 Hobart",  "GMT+10:00 Yakutsk",  "GMT+11:00 Khabarovsk",  "GMT+11:00 Solomon Is., New Caledonia",  "GMT+11:00 Vladivostok",  "GMT+11:30 Norfolk Island",  "GMT+12:00 Auckland, Wellington",  "GMT+12:00 Fiji",  "GMT+12:00 Magadan",  "GMT+12:00 Marshall Islands",  "GMT+12:00 Petropavlovsk",  "GMT+13:00 Nuku'alofa",  "GMT-01:00 Azores",  "GMT-01:00 Cape Verde Is.",  "GMT-03:00 Argentina",  "GMT-03:00 Bahia, Brazil",  "GMT-03:00 Brasilia",  "GMT-03:00 Chile",  "GMT-03:00 Falkland Islands",  "GMT-03:00 Georgetown, South America Eastern Time",  "GMT-03:00 Greenland",  "GMT-03:00 San Luis, Argentina",  "GMT-03:00 St Pierre and Miquelon",  "GMT-03:00 Uruguay",  "GMT-03:30 Newfoundland",  "GMT-04:00 Atlantic Time Canada",  "GMT-04:00 Cuiaba, Brazil",  "GMT-04:00 La Paz",  "GMT-04:00 Paraguay",  "GMT-04:30 Venezuela",  "GMT-05:00 Bogota, Lima, Quito",  "GMT-05:00 Cayman Islands",  "GMT-05:00 Cuba Standard Time",  "GMT-05:00 Eastern Time US & Canada",  "GMT-05:00 Rio Branco, Brazil",  "GMT-05:00 Turks and Caicos",  "GMT-06:00 Central America",  "GMT-06:00 Central Time US & Canada",  "GMT-06:00 Guadalajara, Mexico City, Monterrey",  "GMT-06:00 Guatemala",  "GMT-06:00 Quintana Roo, Mexico",  "GMT-06:00 Saskatchewan",  "GMT-07:00 Arizona",  "GMT-07:00 Chihuahua, La Paz, Mazatlan",  "GMT-07:00 Mountain Time US & Canada",  "GMT-08:00 Pacific Time US & Canada; Tijuana",  "GMT-09:00 Alaska",  "GMT-09:30 Marquesas Islands",  "GMT-10:00 Adak",  "GMT-10:00 Hawaii",  "GMT-11:00 Midway Island",  "GMT-12:00 International Date Line West",  "GMT-13:00 Samoa"}
    }

}

-- Create the widget
local pickerWheel = widget.newPickerWheel
{
    top = display.contentHeight - 400,
    columns = columnData,
    fontSize = 9
}

-- Configure the picker wheel columns
local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        local values = pickerWheel:getValues()
        local values  = string.sub(values[1].value, 4, 10)  
        azOffset = values
        print( values )
        composer.gotoScene("scene1")
        composer.removeHidden()
    end
end

-- Get the table of current values for all columns
-- This can be performed on a button tap, timer execution, or other event
-- Function to handle button events

-- Create the widget
local button1 = widget.newButton
{
    left = 100,
    top = 400,
    id = "button1",
    label = "Set TZ",
    onEvent = handleButtonEvent
}


function scene:create( event )
    local sceneGroup = self.view
    
    sceneGroup:insert( button1 ) 
    sceneGroup:insert( pickerWheel ) 
end

function scene:show( event )
    local phase = event.phase
    local previousScene = composer.getSceneName( "previous" )
    if(previousScene~=nil) then
        composer.removeScene(previousScene)
    end
   if ( phase == "did" ) then 


end
end 

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
