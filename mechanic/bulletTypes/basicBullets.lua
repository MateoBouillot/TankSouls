local img = {}
    img.greenBullet = love.graphics.newImage("/img/Bullets/basicBullets.png")

local offset = {}
    offset.bulletx = img.greenBullet:getWidth() * 0.5
    offset.bullety = img.greenBullet:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")

local basicBullet = {}
    basicBullet.speed = 900
    basicBullet.shootRate = 0.6
    basicBullet.timer = 0

    basicBullet.init = function()
        basicBullet.timer = 0
    end

    basicBullet.create = function(x, y, tankx, tanky)
        if basicBullet.timer <= 0 then
            bullet.create(x, y, tankx, tanky, basicBullet.speed, offset, img.greenBullet)
            basicBullet.timer = basicBullet.shootRate
        end
    end

    basicBullet.timerUpdate = function(dt)
        basicBullet.timer = basicBullet.timer - dt
    end

return basicBullet