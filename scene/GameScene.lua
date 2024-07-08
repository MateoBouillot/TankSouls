local scene = {}

local explosion = require("../mechanic/explosion")
local background = require("/mechanic/background")
local tank = require("../mechanic/tank")
local enemies = require("../mechanic/enemies")

local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local fullAutoBullet = require("/mechanic/bulletTypes/fullAutoBullets")
local tpShot = require("/mechanic/abilities/tpShot")
local rocket = require("/mechanic/bulletTypes/rocket")
local sideCannons = require("/mechanic/bulletTypes/sideCannons")
local bullet = require("/mechanic/Bullets")

local inputReading = require("/mechanic/inputsManager")
local collisionCheck = require("/mechanic/collisionsCheck")

local roll = require("/mechanic/abilities/roll")
local landMine = require("/mechanic/abilities/landMine")

scene.init = function(needInit)
    if not needInit then return end
    tank.init()
    explosion.init()
    enemies.init()
    bullet.init()
    basicBullet.init()
    fullAutoBullet.init()
    rocket.init()
    sideCannons.init()
    tpShot.init()
    landMine.init()
end

scene.update = function(dt)
    if not roll.isRolling then
        inputReading.movements(dt, tank.rotate, tank.move)
        inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons, tpShot)
        inputReading.cannonSwitch(tank)
        inputReading.abilities(dt, roll.start, tank.rot, tank.x, tank.y, landMine.create)
    end
    
    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    fullAutoBullet.timerUpdate(dt)
    rocket.reloadUpdate(dt)
    sideCannons.timerUpdate(dt)
    tpShot.timerUpdate(dt)
    tank.spriteUpdate()

    roll.update(dt, tank)
    landMine.update(dt, explosion)

    enemies.Spawning(dt)
    enemies.update(dt, tank)

    explosion.update(dt)
    collisionCheck.bulletsTank(explosion, tank)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth(), explosion)
end

scene.draw = function()
    background.draw()
    bullet.draw()
    tank.draw()
    enemies.draw()
    explosion.draw()
    landMine.draw()
end

scene.keypressed = function(key)
    if key == "return" then
        changeScene("MENU")
    elseif key == "escape" then
        changeScene("PAUSE", { false, score })
    end
end

scene.unload = function()

end

return scene