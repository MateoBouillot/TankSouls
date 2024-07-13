local img = {}
    img.tpBullet = love.graphics.newImage("/img/tpParticles/tpShot.png")

local offset = {}
    offset.bulletx = img.tpBullet:getWidth() * 0.5
    offset.bullety = img.tpBullet:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")

teleported = 0

local tpShot = {}
    tpShot.speed = 900
    tpShot.shootRate = 3
    tpShot.timer = 0

    tpShot.init = function()
        tpShot.timer = 0
    end

    tpShot.create = function(x, y, tankx, tanky)
        if tpShot.timer <= 0 then
            bullet.create(x, y, tankx, tanky, tpShot.speed, offset, img.tpBullet, "tpShot")
            tpShot.timer = tpShot.shootRate
        end
    end

    tpShot.timerUpdate = function(dt)
        tpShot.timer = tpShot.timer - dt
        teleported = teleported - dt
    end

    tpShot.teleport = function(target, tank, targetX, targetY, enemy)
        if target == "wall" then
            tank.x = targetX
            tank.y = targetY
            
        elseif target == "enemy" then
            enemyList[enemy].x = tank.lastPosX
            enemyList[enemy].y = tank.lastPosY
            tank.x = targetX
            tank.y = targetY
        end

        teleported = 0.5
    end

return tpShot