local tankimg = {}
    tankimg.body = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer1.png")
    tankimg.baseTurret = love.graphics.newImage("/img/cannons/oneTapCannons/baseCannon.png")
    tankimg.fullAutoTurret = love.graphics.newImage("/img/cannons/autoCannons/autoCannon.png")
    
offset = {}
    offset.tankx = tankimg.body:getWidth() * 0.5
    offset.tanky = tankimg.body:getHeight() * 0.5
    offset.turretx = 0
    offset.turrety = tankimg.baseTurret:getHeight() * 0.5 


local tank = {}
    tank.x = love.graphics.getWidth() * 0.5
    tank.y = love.graphics.getHeight() * 0.5
    tank.rot = 0
    tank.rotspeed = math.pi
    tank.speed = 200
    tank.turretRot = 0
    tank.cannonLength = tankimg.baseTurret:getWidth()
    tank.cannonType = "oneTap"
    tank.cannonImg = tankimg.baseTurret

    tank.init = function()
        tank.x = love.graphics.getWidth() * 0.5
        tank.y = love.graphics.getHeight() * 0.5
        tank.rot = 0
        tank.rotspeed = math.pi
        tank.speed = 200
        tank.turretRot = 0
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

    tank.draw = function()
        love.graphics.draw(tankimg.body, tank.x, tank.y, tank.rot, 1, 1, offset.tankx, offset.tanky)
        love.graphics.draw(tank.cannonImg, tank.x, tank.y, tank.turretRot, 1, 1, offset.turretx, offset.turrety)
    end

return tank
