
local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local basicBullet = require("../mechanic/bulletTypes/basicBullets")
local bullet = require("/mechanic/Bullets")
local inputReading = require("/mechanic/inputsManager")
local background = require("/mechanic/background")
local collisionCheck = require("/mechanic/collisionsCheck")

scene.init = function()
    tank.init()
    explosion.init()
    bullet.init()
    basicBullet.init()
end

scene.update = function(dt)
    inputReading.movements(dt, tank.rotate, tank.move)
    inputReading.aimingShooting(dt, tank, basicBullet, fullAutoBullet)

    bullet.update(dt)
    basicBullet.timerUpdate(dt)
end

scene.draw = function()
    background.draw()
    bullet.draw()
    tank.draw()
end

scene.keypressed = function(key)
    if key == "return" then
        changeScene("GAME", { true })
    end
end

scene.unload = function()

end


return scene