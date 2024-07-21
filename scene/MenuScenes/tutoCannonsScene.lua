local scene = {}

local explosion = require("../mechanic/explosion")
local background = require("/mechanic/background")

local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local fullAutoBullet = require("/mechanic/bulletTypes/fullAutoBullets")
local rocket = require("/mechanic/bulletTypes/rocket")
local bullet = require("/mechanic/Bullets")

local inputReading = require("/mechanic/inputsManager")
local collisionCheck = require("/mechanic/collisionsCheck")

scene.init = function()
    tank.init("CANONTUTO")
    explosion.init()
    bullet.init()
    basicBullet.init()
    fullAutoBullet.init()
    rocket.init()
end

scene.update = function(dt)

    inputReading.movements(dt)
    inputReading.aimingShooting(dt, basicBullet, fullAutoBullet, rocket, tpShot)
    inputReading.cannonSwitch(tank)


    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    fullAutoBullet.timerUpdate(dt)
    rocket.reloadUpdate(dt)
    tank.spriteUpdate()

    explosion.update(dt)
    collisionCheck.tankBorder(background.crateImg:getWidth(), explosion, "CANONTUTO")
end

scene.draw = function()
    background.draw("CANONTUTO")
    bullet.draw()
    tank.draw()
    explosion.draw()
end

scene.keypressed = function(key)

end

scene.unload = function()

end

return scene