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
local stamina = require("/mechanic/stamina")

local waves = require("/mechanic/waves")

scene.init = function()
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
    stamina.init()
    background.init()
    waves.init()
end

scene.update = function(dt)
    if not roll.isRolling then
        inputReading.movements(dt, tank.rotate, tank.move)
        inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons, tpShot)
        inputReading.cannonSwitch(tank)
        inputReading.abilities(dt, roll.start, tank.rot, tank.x, tank.y, landMine, stamina)
        collisionCheck.tankTank(dt)
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
    stamina.update(dt)

    waves.spawning(dt)
    enemies.update(dt, tank, explosion)
    waves.winning(dt)

    explosion.update(dt)
    collisionCheck.bulletsTank(explosion, tank)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth(), explosion, "GAME")
    tank.ifDeath(changeScene)
end

scene.draw = function()
    background.draw("GAME")
    waves.draw()
    bullet.draw()
    tank.draw("GAME")
    enemies.draw()
    explosion.draw()
    landMine.draw()
    stamina.draw()
end

scene.keypressed = function(key)

end

scene.unload = function()

end

return scene