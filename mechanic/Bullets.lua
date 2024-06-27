bullets = {}
local tank = require("/mechanic/tank")

local bullet = {}

    bullet.init = function()
        bullets = {}
    end

    bullet.create = function(aimX, aimY, tankx, tanky, bulletSpeed, offset, bulletType)
            local angle = math.atan2((aimY - tanky), (aimX - tankx))

            local startX = tankx + (tank.cannonLength * math.cos(angle))
            local startY = tanky + (tank.cannonLength * math.sin(angle))
            
            local bulletSpeedX = bulletSpeed * math.cos(angle)
            local bulletSpeedY = bulletSpeed * math.sin(angle)

            local hitBox = {}
            hitBox.x = startX - offset.bulletx
            hitBox.y = startY - offset.bullety
            hitBox.W = bulletType:getWidth()
            hitBox.H = bulletType:getHeight()

            table. insert(bullets, {x = startX, 
                y = startY, 
                speedX = bulletSpeedX, 
                speedY = bulletSpeedY, 
                angle = angle, 
                hitBox = hitBox, 
                bulletType = bulletType,
                offset = offset
            })
    end

    bullet.update = function(dt)
        for i = 1, #bullets do
            bullets[i].x = bullets[i].x + bullets[i].speedX * dt
            bullets[i].y = bullets[i].y + bullets[i].speedY * dt
            bullets[i].hitBox.x = bullets[i].x - bullets[i].offset.bulletx
            bullets[i].hitBox.y = bullets[i].y - bullets[i].offset.bullety
        end    
    end

    bullet.checkIsFree = function()
        for i = #bullets, 1, -1 do
            if bullets[i].x < -20 or bullets[i].x > love.graphics.getHeight() + 20
            or bullets[i].y < -20 or bullets[i].y > love.graphics.getWidth() + 20 then
                table.remove(bullets, i)
            end
        end
    end

    bullet.draw = function()
        for i = 1, #bullets do
            love.graphics.draw(bullets[i].bulletType, bullets[i].x, bullets[i].y, bullets[i].angle, 1, 1, bullets[i].offset.bulletx, bullets[i].offset.bullety)
        end
    end

return bullet