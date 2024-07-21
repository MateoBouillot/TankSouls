bullets = {}
enemiesBullets = {}
local tank = require("/mechanic/tank")

local bullet = {}

    bullet.init = function()
        bullets = {}
        enemiesBullets = {}
    end

    bullet.create = function(aimX, aimY, startX, startY, bulletSpeed, offset, bulletImg, bulletType)
            local angle = math.atan2((aimY - startY), (aimX - startX))
            
            local bulletSpeedX = bulletSpeed * math.cos(angle)
            local bulletSpeedY = bulletSpeed * math.sin(angle)

            local hitBox = {}
            hitBox.x = startX - offset.bulletx
            hitBox.y = startY - offset.bullety
            hitBox.W = bulletImg:getWidth()
            hitBox.H = bulletImg:getHeight()

            if bulletType == "sniperBullets" or bulletType == "bigBullets" then
                table. insert(enemiesBullets, {x = startX, 
                    y = startY, 
                    speedX = bulletSpeedX, 
                    speedY = bulletSpeedY, 
                    angle = angle, 
                    hitBox = hitBox, 
                    bulletImg = bulletImg,
                    offset = offset,
                    bulletType = bulletType
                })
            else
                table. insert(bullets, {x = startX, 
                    y = startY, 
                    speedX = bulletSpeedX, 
                    speedY = bulletSpeedY, 
                    angle = angle, 
                    hitBox = hitBox, 
                    bulletImg = bulletImg,
                    offset = offset,
                    bulletType = bulletType
                })
            end
    end

    bullet.update = function(dt)
        for i = 1, #bullets do
            bullets[i].x = bullets[i].x + bullets[i].speedX * dt
            bullets[i].y = bullets[i].y + bullets[i].speedY * dt
            bullets[i].hitBox.x = bullets[i].x - bullets[i].offset.bulletx
            bullets[i].hitBox.y = bullets[i].y - bullets[i].offset.bullety
        end
        for i = 1, #enemiesBullets do    
            enemiesBullets[i].x = enemiesBullets[i].x + enemiesBullets[i].speedX * dt
            enemiesBullets[i].y = enemiesBullets[i].y + enemiesBullets[i].speedY * dt
            enemiesBullets[i].hitBox.x = enemiesBullets[i].x - enemiesBullets[i].offset.bulletx
            enemiesBullets[i].hitBox.y = enemiesBullets[i].y - enemiesBullets[i].offset.bullety
        end
    end

    bullet.draw = function()
        for i = 1, #bullets do
            love.graphics.draw(bullets[i].bulletImg, bullets[i].x, bullets[i].y, bullets[i].angle, 1, 1, bullets[i].offset.bulletx, bullets[i].offset.bullety)
        end
        for i = 1, #enemiesBullets do
            love.graphics.draw(enemiesBullets[i].bulletImg, enemiesBullets[i].x, enemiesBullets[i].y, enemiesBullets[i].angle, 1, 1, enemiesBullets[i].offset.bulletx, enemiesBullets[i].offset.bullety)
        end
    end

return bullet