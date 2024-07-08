
local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local background = require("/mechanic/background")

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

scene.init = function()
    tank.init()
    explosion.init()
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
        inputReading.abilities(dt, roll.start, tank.rot, tank.x, tank.y, landMine)
    end
    
    roll.update(dt, tank)
    landMine.update(dt, explosion)

    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    fullAutoBullet.timerUpdate(dt)
    rocket.reloadUpdate(dt)
    sideCannons.timerUpdate(dt)
    tpShot.timerUpdate(dt)
    tank.spriteUpdate()

    explosion.update(dt)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth(), explosion)
end

scene.draw = function()
    local menu = true
    background.draw(menu)
    bullet.draw()
    tank.draw()
    explosion.draw()
    landMine.draw()
end

scene.keypressed = function(key)
    if key == "return" then
        changeScene("GAME", { true })
    end
end

scene.unload = function()

end


return scene