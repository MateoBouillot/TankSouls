local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local background = require("/mechanic/background")

local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local bullet = require("/mechanic/Bullets")
local tpShot = require("/mechanic/abilities/tpShot")

local inputReading = require("/mechanic/inputsManager")
local collisionCheck = require("/mechanic/collisionsCheck")

local roll = require("/mechanic/abilities/roll")
local landMine = require("/mechanic/abilities/landMine")
local stamina = require("/mechanic/stamina")

scene.init = function()
    stamina.init()
    tank.init("ABTUTO")
    explosion.init()
    bullet.init()
    basicBullet.init()
    tpShot.init()
    landMine.init()
end

scene.update = function(dt)
    if not roll.isRolling then
        inputReading.movements(dt, tank.rotate, tank.move)
        inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons, tpShot)
        inputReading.abilities(dt, roll.start, tank.rot, tank.x, tank.y, landMine, stamina)
    end

    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    tpShot.timerUpdate(dt)
    tank.spriteUpdate()

    roll.update(dt, tank)
    landMine.update(dt, explosion)
    stamina.update(dt)

    explosion.update(dt)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth(), explosion, "ABTUTO")
end

scene.draw = function()
    background.draw("ABTUTO")
    bullet.draw()
    tank.draw()
    explosion.draw()
    landMine.draw()
    stamina.draw()
end

scene.keypressed = function(key)

end

scene.unload = function()

end

return scene