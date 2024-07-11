
local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local background = require("/mechanic/background")

local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local bullet = require("/mechanic/Bullets")

local inputReading = require("/mechanic/inputsManager")
local collisionCheck = require("/mechanic/collisionsCheck")

scene.init = function(value)
    background.init(value)
    tank.init("MENU", value)
    explosion.init()
    bullet.init()
    basicBullet.init()
end

scene.update = function(dt)

    inputReading.movements(dt, tank.rotate, tank.move)
    inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons, tpShot)

    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    tank.spriteUpdate()

    explosion.update(dt)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth(), explosion, "MENU")
end

scene.draw = function()
    background.draw("MENU")
    bullet.draw()
    tank.draw()
    explosion.draw()
end

scene.keypressed = function(key)

end

scene.unload = function()

end


return scene