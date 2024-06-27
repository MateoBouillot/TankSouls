

local inputReading = {}

    inputReading.cannonSwitch = function(tank)
        if love.keyboard.isDown("kp1") then
            tank.cannonType = "oneTap"
        elseif love.keyboard.isDown("kp2") then
            tank.cannonType = "fullAuto"
        end
    end

    inputReading.movements = function(dt, tankRotate, tankMove)
        if love.keyboard.isDown("d") then
            tankRotate(dt, 1)
        elseif love.keyboard.isDown("q") then
            tankRotate(dt, -1)
        end
    
        if love.keyboard.isDown("z") then
            tankMove(dt, 1)
        elseif love.keyboard.isDown("s") then
            tankMove(dt, -1)
        end
    end

    local mouseIsDown = false
    
    inputReading.aimingShooting = function(dt, tank, basicBullet, fullAutoBullet)

        local mouseX, mouseY = love.mouse.getPosition()
        tank.aim(mouseX, mouseY)

        if love.mouse.isDown(1) then
            if tank.cannonType == "oneTap" then
                if mouseIsDown ~= true then 
                    basicBullet.create(mouseX, mouseY, tank.x, tank.y)
                    mouseIsDown = true
                end
            elseif tank.cannonType == "fullAuto" then
                fullAutoBullet.create(mouseX, mouseY, tank.x, tank.y)
            end
        end
    
        function love.mousereleased(x, y, button)
            if button == 1 then
                mouseIsDown = false
            end
        end
    end
return inputReading