

local img = {}
    img.greenFullAutoBullet = love.graphics.newImage("/img/Bullets/fullAutoBullets.png")

local offset = {}
    offset.bulletx = img.greenFullAutoBullet:getWidth() * 0.5
    offset.bullety = img.greenFullAutoBullet:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")

local fullAutoBullet = {}
    fullAutoBullet.speed = 900
    fullAutoBullet.shootRate = 0.1
    fullAutoBullet.timer = 0

    fullAutoBullet.init = function()
        fullAutoBullet.timer = 0
    end

    fullAutoBullet.create = function(x, y)
        if fullAutoBullet.timer <= 0 then
            bullet.create(x, y, tank.x, tank.y, fullAutoBullet.speed, offset, img.greenFullAutoBullet, "fullAuto")
            fullAutoBullet.timer = fullAutoBullet.shootRate
        end
    end

    fullAutoBullet.timerUpdate = function(dt)
        fullAutoBullet.timer = fullAutoBullet.timer - dt
    end

return fullAutoBullet
