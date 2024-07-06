local tankimg = {}
    tankimg.bodyLv1 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer1.png")
    tankimg.bodyLv2 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer2.png")
    tankimg.bodyLv2SideCannon = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer2Front.png")
    tankimg.bodyLv3 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer3.png")
    tankimg.bodyLv3SideCannon = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer3FrontBack.png")
    tankimg.baseTurret = love.graphics.newImage("/img/cannons/oneTapCannons/baseCannon.png")
    tankimg.fullAutoTurret = love.graphics.newImage("/img/cannons/autoCannons/autoCannon.png")
    tankimg.rocketTurret = love.graphics.newImage("/img/cannons/bigRocketLauncher/bigCannon.png")
    
local offset = {}
    offset.turretx = 0
    offset.turrety = tankimg.baseTurret:getHeight() * 0.5 

local tank = {}
    tank.x = love.graphics.getWidth() * 0.5
    tank.y = love.graphics.getHeight() * 0.5
    tank.rot = 0
    tank.rotspeed = math.pi
    tank.speed = 250
    tank.turretRot = 0
    tank.cannonLength = tankimg.baseTurret:getWidth()
    tank.cannonType = "oneTap"
    tank.cannonImg = tankimg.baseTurret
    tank.sideCannon = false
    tank.level = 1
    tank.sprite =  tankimg.bodyLv1
    tank.offsetX = tank.sprite:getWidth() * 0.5
    tank.offsetY = tank.sprite:getHeight() * 0.5

    tank.init = function()
        tank.x = love.graphics.getWidth() * 0.5
        tank.y = love.graphics.getHeight() * 0.5
        tank.rot = 0
        tank.rotspeed = math.pi
        tank.speed = 200
        tank.turretRot = 0
    end

    tank.spriteUpdate = function()
        
        if tank.level == 1 then
            tank.sprite =  tankimg.bodyLv1
            tank.offsetX = tank.sprite:getWidth() * 0.5
            tank.offsetY = tank.sprite:getHeight() * 0.5
        elseif tank.level == 2 then
            if tank.sideCannon == true then
                tank.sprite = tankimg.bodyLv2SideCannon
                tank.offsetX = tank.sprite:getWidth() * 0.5
                tank.offsetY = tank.sprite:getHeight() * 0.5
            else
                tank.sprite =  tankimg.bodyLv2
                tank.offsetX = tank.sprite:getWidth() * 0.5
                tank.offsetY = tank.sprite:getHeight() * 0.5
            end
        elseif tank.level == 3 then
            if tank.sideCannon == true then
                tank.sprite = tankimg.bodyLv3SideCannon
                tank.offsetX = tank.sprite:getWidth() * 0.5
                tank.offsetY = tank.sprite:getHeight() * 0.5
            else
                tank.sprite =  tankimg.bodyLv3
                tank.offsetX = tank.sprite:getWidth() * 0.5
                tank.offsetY = tank.sprite:getHeight() * 0.5
            end
        end

        if tank.cannonType == "oneTap" then
            tank.cannonImg = tankimg.baseTurret
            offset.turrety = tankimg.baseTurret:getHeight() * 0.5 
        elseif tank.cannonType == "fullAuto" then
            tank.cannonImg = tankimg.fullAutoTurret
            offset.turrety = tankimg.fullAutoTurret:getHeight() * 0.5 
        elseif tank.cannonType == "rocket" then
            tank.cannonImg = tankimg.rocketTurret
            offset.turrety = tankimg.rocketTurret:getHeight() * 0.5 
        end
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
        love.graphics.draw(tank.sprite, tank.x, tank.y, tank.rot, 1, 1, tank.offsetX, tank.offsetY)
        love.graphics.draw(tank.cannonImg, tank.x, tank.y, tank.turretRot, 1, 1, offset.turretx, offset.turrety)
    end

return tank
