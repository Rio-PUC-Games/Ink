--  main.lua
--  Project Nanquim
--  Created by RPG Programming Team
--  Copyright © 2016 Rio PUC Games. All rights reserved.

io.stdout:setvbuf("no")
require "utils"

local dir = love.filesystem.getSourceBaseDirectory() .. '/Ink/'
love.filesystem.setRequirePath("?.lua;?/init.lua;" .. dir .. "?.lua;")

local RPG_Logo = require "RPG_Full_Logo/RPG_Logo"
local game = require "src/game"
local menu = require "Menu/menu"

local scene

local joystickList = love.joystick.getJoysticks()
joystick1 = joystickList[1]

function love.load()
    love.mouse.setVisible(false)
    --love.keyboard.setKeyRepeat( true )
    RPG_Logo.load(1.5,1.5,1.5,function ()
    	change_scene("menu")
  	end)
    scenes = { logo = RPG_Logo, game = game, menu = menu }
    change_scene("logo")
end

function change_scene(new,...)
    scene = new
    scenes[scene].start(...)
end

function love.update(dt)
    scenes[scene].update(dt)
end

function love.keypressed(key)
  if scenes[scene].keypressed then
    scenes[scene].keypressed(key)
  end
end

function love.gamepadpressed( joystick, button )
  if button == "dpright" then
    love.keypressed("right")
  end
  
  if button == "dpleft" then
      love.keypressed("left")
  end
end

function love.gamepadreleased(joystick, button)
  if button == "dpright" then
    love.keyreleased("right")
  end
  
  if button == "dpleft" then
      love.keyreleased("left")
  end
end

function love.joystickpressed(joystick, button)
  if button == 1 then
    love.keypressed("up")
  end
  
  if button == 3 then
    love.keypressed("d")
  end
  
  if button == 8 then
    love.keypressed("return")
  end
end

function love.joystickreleased(joystick, button)
  if button == 1 then
    love.keyreleased("up")
  end
  
  if button == 3 then
    love.keyreleased("d")
  end
end

function love.keyreleased(key)
  if scenes[scene].keyreleased then
    scenes[scene].keyreleased(key)
  end
end

function love.mousepressed(x, y, button, istouch)
  if scenes[scene].mousepressed then
    scenes[scene].mousepressed(x, y, button, istouch)
  end
end

function love.mousereleased(x, y, button, istouch)
  if scenes[scene].mousereleased then
    scenes[scene].mousereleased(x, y, button, istouch)
  end
end

function love.mousemoved(x, y, dx, dy )
  if scenes[scene].mousemoved then
    scenes[scene].mousemoved(x, y, dx, dy)
  end
end

function love.draw()
    scenes[scene].draw()
end
