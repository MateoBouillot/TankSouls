local img = {}
    img.greenBullet = love.graphics.newImage("img/tank/bulletGreenSilver.png")

local offset = {}
    offset.bulletx = img.greenBullet:getWidth() * 0.5
    offset.bullety = img.greenBullet:getHeight() * 0.5
bullets = {}
local tank = require("/mechanic/tank")

local bullet = {}
    bullet.Speed = 900
    bullet.ShootRate = 1
    bullet.timer = 0

    bullet.init = function()
        bullets = {}
        bullet.timer = 0
    end

    bullet.create = function(x, y)
        if bullet.timer <= 0 then
            local startX = tank.x
            local startY = tank.y
            local aimX = x
            local aimY = y

            local angle = math.atan2((aimY - startY), (aimX - startX))

            local bulletSpeedX = bullet.Speed * math.cos(angle)
            local bulletSpeedY = bullet.Speed * math.sin(angle)

            local hitBox = {}
            hitBox.x = startX - offset.bulletx
            hitBox.y = startY - offset.bullety
            hitBox.W = img.greenBullet:getWidth()
            hitBox.H = img.greenBullet:getHeight()

            table. insert(bullets, {x = startX, y = startY, speedX = bulletSpeedX, speedY = bulletSpeedY, angle = angle, hitBox = hitBox})
            bullet.timer = bullet.ShootRate
        end
    end

    bullet.update = function(dt)
        bullet.timer = bullet.timer - dt
        
        for i = 1, #bullets do
            bullets[i].x = bullets[i].x + bullets[i].speedX * dt
            bullets[i].y = bullets[i].y + bullets[i].speedY * dt
            bullets[i].hitBox.x = bullets[i].x - offset.bulletx
            bullets[i].hitBox.y = bullets[i].y - offset.bullety
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
            love.graphics.draw(img.greenBullet, bullets[i].x, bullets[i].y, bullets[i].angle, 1, 1, offset.bulletx, offset.bullety)
        end
    end
return bullet