local scene = {}

local explosion = require("../mechanic/explosion")
local background = require("/mechanic/background")
local enemies = require("../mechanic/enemies")

local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local fullAutoBullet = require("/mechanic/bulletTypes/fullAutoBullets")
local tpShot = require("/mechanic/abilities/tpShot")
local rocket = require("/mechanic/bulletTypes/rocket")
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
    tpShot.init()
    landMine.init()
    stamina.init()
    background.init()
    waves.init()
end

scene.update = function(dt)
    if not roll.isRolling then
        inputReading.movements(dt)
        if not tank.dead then
            inputReading.aimingShooting(dt, basicBullet, fullAutoBullet, rocket, tpShot)
            inputReading.cannonSwitch(tank)
            inputReading.abilities(dt, roll.start, landMine, stamina)
            collisionCheck.tankTank(dt)
        end
    end
     if not tank.dead then    
        bullet.update(dt)
        basicBullet.timerUpdate(dt)
        fullAutoBullet.timerUpdate(dt)
        rocket.reloadUpdate(dt)
        tpShot.timerUpdate(dt)
        tank.spriteUpdate()

        roll.update(dt)
        landMine.update(dt, explosion)
        stamina.update(dt)

        waves.spawning(dt)
        enemies.update(dt, explosion)
        waves.winning(dt)

        explosion.update(dt)
        collisionCheck.bulletsTank(explosion)
        collisionCheck.tankBorder(background.crateImg:getWidth(), explosion, "GAME")
        collisionCheck.rewards(waves, explosion)
        tank.ifDeath()
    end
end

scene.draw = function()
    background.draw("GAME")
    waves.draw()
    bullet.draw()
    enemies.draw()
    explosion.draw()
    landMine.draw()
    stamina.draw()
    tank.draw("GAME")
end

scene.keypressed = function(key)

end

scene.unload = function()

end

return scene