local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local enemies = require("../mechanic/enemies")
local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local fullAutoBullet = require("/mechanic/bulletTypes/fullAutoBullets")
local rocket = require("/mechanic/bulletTypes/rocket")
local sideCannons = require("/mechanic/bulletTypes/sideCannons")
local bullet = require("/mechanic/Bullets")
local inputReading = require("/mechanic/inputsManager")
local background = require("/mechanic/background")
local collisionCheck = require("/mechanic/collisionsCheck")

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
end

scene.update = function(dt)

    inputReading.movements(dt, tank.rotate, tank.move)
    inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons)
    inputReading.cannonSwitch(tank)

    bullet.update(dt)
    basicBullet.timerUpdate(dt)
    fullAutoBullet.timerUpdate(dt)
    rocket.reloadUpdate(dt)
    sideCannons.timerUpdate(dt)
    tank.spriteUpdate()

    enemies.Spawning(dt)
    enemies.update(dt)

    explosion.update(dt)
    collisionCheck.bulletsTank(explosion, score)
    collisionCheck.tankBorder(tank, background.crateImg:getWidth())
end

scene.draw = function()
    background.draw()
    bullet.draw()
    tank.draw()
    enemies.draw()
    explosion.draw()
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