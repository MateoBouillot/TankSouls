local tankimg = {}
    tankimg.body = love.graphics.newImage("img/tank/tankGreen.png")
    tankimg.turret = love.graphics.newImage("img/tank/barrelGreen.png")
    tankimg.bullet = love.graphics.newImage("img/tank/bulletGreenSilver.png")
    
local offset = {}
    offset.tankx = tankimg.body:getWidth() * 0.5
    offset.tanky = tankimg.body:getHeight() * 0.5
    offset.turretx = 0
    offset.turrety = tankimg.turret:getHeight() * 0.5
    offset.bulletx = tankimg.bullet:getWidth() * 0.5
    offset.bullety = tankimg.bullet:getHeight() * 0.5

bullets = {}

local tank = {}
    tank.x = 640
    tank.y = 364
    tank.rot = 0
    tank.rotspeed = math.pi
    tank.speed = 200
    tank.turretRot = 0
    tank.bulletSpeed = 900

    tank.init = function()
        tank.x = 640
        tank.y = 364
        tank.rot = 0
        tank.rotspeed = math.pi
        tank.speed = 200
        tank.turretRot = 0
        tank.bulletSpeed = 900
        bullets = {}
    end

    tank.rotate = function(dt, direction)
        tank.rot = tank.rot + tank.rotspeed * direction * dt 
    end

    tank.move = function(dt, direction)
        tank.x = tank.x + tank.speed * math.cos(tank.rot) * dt * direction 
        tank.y = tank.y + tank.speed * math.sin(tank.rot) * dt * direction
    end

    tank.aim = function(x, y)
        tank.turretRot = math.atan2(y - tank.y, x - tank.x)
    end


    tank.createBullet = function(x, y)
        local startX = tank.x
        local startY = tank.y
        local aimX = x
        local aimY = y

        local angle = math.atan2((aimY - startY), (aimX - startX))

        local bulletSpeedX = tank.bulletSpeed * math.cos(angle)
        local bulletSpeedY = tank.bulletSpeed * math.sin(angle)

        local hitBox = {}
        hitBox.x = startX - offset.bulletx
        hitBox.y = startY - offset.bullety
        hitBox.W = tankimg.bullet:getWidth()
        hitBox.H = tankimg.bullet:getHeight()

        table. insert(bullets, {x = startX, y = startY, speedX = bulletSpeedX, speedY = bulletSpeedY, angle = angle, hitBox = hitBox})
    end

    tank.updateBullet = function(dt)
        for i = 1, #bullets do
            bullets[i].x = bullets[i].x + bullets[i].speedX * dt
            bullets[i].y = bullets[i].y + bullets[i].speedY * dt
            bullets[i].hitBox.x = bullets[i].x - offset.bulletx
            bullets[i].hitBox.y = bullets[i].y - offset.bullety

        end    
    end

    tank.drawBullet = function()
        for i = 1, #bullets do
            love.graphics.draw(tankimg.bullet, bullets[i].x, bullets[i].y, bullets[i].angle, 1, 1, offset.bulletx, offset.bullety)
        end
    end

    tank.draw = function()
        love.graphics.draw(tankimg.body, tank.x, tank.y, tank.rot, 1, 1, offset.tankx, offset.tanky)
        love.graphics.draw(tankimg.turret, tank.x, tank.y, tank.turretRot, 1, 1, offset.turretx, offset.turrety)
    end

return tank
