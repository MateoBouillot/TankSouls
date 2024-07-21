local tankimg = {}
    tankimg.bodyLv1 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer1.png")
    tankimg.bodyLv2 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer2.png")
    tankimg.bodyLv3 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer3.png")
    tankimg.baseTurret = love.graphics.newImage("/img/cannons/oneTapCannons/baseCannon.png")
    tankimg.fullAutoTurret = love.graphics.newImage("/img/cannons/autoCannons/autoCannon.png")
    tankimg.rocketTurret = love.graphics.newImage("/img/cannons/bigRocketLauncher/bigCannon.png")
    
local offset = {}
    offset.turretx = 0
    offset.turrety = tankimg.baseTurret:getHeight() * 0.5 

tank = {}
    tank.x = love.graphics.getWidth() * 0.5
    tank.y = love.graphics.getHeight() * 0.5
    tank.rot = 0
    tank.turretRot = 0

    tank.rotspeed = math.pi
    tank.speed = 300
    
    tank.cannonLength = tankimg.baseTurret:getWidth()
    tank.cannonType = "oneTap"
    tank.cannonImg = tankimg.baseTurret
   
    tank.sprite =  tankimg.bodyLv1
    tank.offsetX = tank.sprite:getWidth() * 0.5
    tank.offsetY = tank.sprite:getHeight() * 0.5

    tank.scaleX = 1
    tank.scaleY = 1

    tank.sideCannon = false
    tank.level = 1
    tank.hp = 70
    tank.maxHp = 70

    tank.lastPosX = 0
    tank.lastPosY = 0

    tank.hitBoxX = tank.x - tank.offsetX
    tank.hitBoxY = tank.y - tank.offsetY
    tank.hitBoxW = tank.sprite:getWidth()
    tank.hitBoxH = tank.sprite:getHeight()

    tank.init = function(scene, dir)
        if scene == "CANONTUTO" or dir == "left" then
            tank.x = 20
            
        elseif scene == "ABTUTO" or dir == "right" then
            tank.x = love.graphics.getWidth() - 20
            tank.rot = math.pi
        else
            tank.x = love.graphics.getWidth() * 0.5
            tank.rot = 0
        end
        tank.y = love.graphics.getHeight() * 0.5

        if scene == "MENU" then
            tank.cannonType = "oneTap"
        end
        
        tank.rotspeed = math.pi
        tank.speed = 300
        tank.turretRot = 0
        tank.level = 1
        tank.hp = 70
    end

    tank.spriteUpdate = function()
        
        if tank.level == 1 then
            tank.sprite =  tankimg.bodyLv1
            tank.offsetX = tank.sprite:getWidth() * 0.5
            tank.offsetY = tank.sprite:getHeight() * 0.5
            tank.maxHp = 70
        elseif tank.level == 2 then
            tank.sprite =  tankimg.bodyLv2
            tank.offsetX = tank.sprite:getWidth() * 0.5
            tank.offsetY = tank.sprite:getHeight() * 0.5
            tank.maxHP = 100
        elseif tank.level == 3 then
            tank.maxHP = 130
            tank.sprite =  tankimg.bodyLv3
            tank.offsetX = tank.sprite:getWidth() * 0.5
            tank.offsetY = tank.sprite:getHeight() * 0.5
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
        tank.lastPosX = tank.x
        tank.lastPosY = tank.y
        tank.x = tank.x + tank.speed * math.cos(tank.rot) * dt * direction 
        tank.y = tank.y + tank.speed * math.sin(tank.rot) * dt * direction

        tank.hitBoxX = tank.x - tank.offsetX
        tank.hitBoxY = tank.y - tank.offsetY
    end

    tank.aim = function(x, y)
        tank.turretRot = math.atan2(y - tank.y, x - tank.x)
    end

    tank.ifDeath = function()
        if tank.hp < 0 then
            love.audio.stop()
            tank.dead = true
            tank.hp = 0
        end
    end

    tank.lifebarW = 300
    tank.lifebarH = 20
    tank.lifebarX = 50
    tank.lifebarY = 20

    tank.draw = function(scene)
        if scene == "GAME" then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", tank.lifebarX, tank.lifebarY, tank.lifebarW, tank.lifebarH)
            love.graphics.setColor(255, 0, 0)
            local life = (tank.lifebarW * 0.01) * (tank.hp / (tank.maxHp * 0.01))
            love.graphics.rectangle("fill", tank.lifebarX, tank.lifebarY, life, tank.lifebarH)
            love.graphics.setColor(255, 255, 255)
        end
        love.graphics.draw(tank.sprite, tank.x, tank.y, tank.rot, tank.scaleX, tank.scaleY, tank.offsetX, tank.offsetY)
        love.graphics.draw(tank.cannonImg, tank.x, tank.y, tank.turretRot, tank.scaleX, tank.scaleY, offset.turretx, offset.turrety)
        if tank.dead then
            love.graphics.setColor(0, 0, 0, 0.3)
            love.graphics.rectangle("fill", 0 , 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(0, 0, 0, 0.6)
            love.graphics.rectangle("fill", 0 , love.graphics.getHeight() * 0.5 - 150, love.graphics.getWidth(), 300)
            love.graphics.setColor(255, 0, 0)
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 100)
            love.graphics.print("You Died", love.graphics.getWidth() * 0.5 - 200, love.graphics.getHeight() * 0.5 - 50)
            love.graphics.setColor(255, 255, 255)
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 20)
            love.graphics.print("press Space to return to menu", love.graphics.getWidth() * 0.5 - 150, love.graphics.getHeight() - 300)
        end
    end

return tank
