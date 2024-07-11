local reloadSound = love.audio.newSource("/sounds/reloading.wav", "static")

local inputReading = {}

    inputReading.cannonSwitch = function(tank)
        if love.keyboard.isDown("kp1") then
            tank.cannonType = "oneTap"
        elseif love.keyboard.isDown("kp2") then
            tank.cannonType = "fullAuto"
        elseif love.keyboard.isDown("kp3") then
            tank.cannonType = "rocket"
        end

        if love.keyboard.isDown("kp4") then
            tank.level = 1
        elseif love.keyboard.isDown("kp5") then
            tank.level = 2
        elseif love.keyboard.isDown("kp6") then
            tank.level = 3
        end

        if love.keyboard.isDown("kp0") then
            if tank.sideCannon == true then
                tank.sideCannon = false
            else 
                tank.sideCannon = true
            end
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

    inputReading.abilities = function(dt, startRoll, tankRot, tankX, tankY, landMine, stamina)
        if love.keyboard.isDown("lshift") then
            if love.keyboard.isDown("z") then
                startRoll("z", tankRot, stamina)
            elseif love.keyboard.isDown("s") then
                startRoll("s", tankRot, stamina)
            end
        end

        if love.keyboard.isDown("e") then
            landMine.create(tankX, tankY)
        end

    end

    local mouse1Down = false
    local mouse2Down = false
    
    inputReading.aimingShooting = function(dt, tank, basicBullet, fullAutoBullet, rocket, sideCannons, tpShot)

        local mouseX, mouseY = love.mouse.getPosition()
        tank.aim(mouseX, mouseY)

        if love.mouse.isDown(1) then
            if tank.cannonType == "oneTap" then
                if mouse1Down ~= true then 
                    basicBullet.create(mouseX, mouseY, tank.x, tank.y)
                end
            elseif tank.cannonType == "fullAuto" then
                fullAutoBullet.create(mouseX, mouseY, tank.x, tank.y)
            elseif tank.cannonType == "rocket" then
                rocket.create(mouseX, mouseY, tank.x, tank.y)
            end
            mouse1Down = true
        else
            mouse1Down = false
        end

        if tank.sideCannon == true then
            if love.mouse.isDown(2) then
                if mouse2Down ~= true then 
                    sideCannons.create(tank)
                end
                mouse2Down = true
            else
                mouse2Down = false
            end
        end

        if love.keyboard.isDown("a") then
            tpShot.create(mouseX, mouseY, tank.x, tank.y)
        end

        if love.mouse.isDown(3) then
            if tank.cannonType == "rocket" then
                if rocket.reloaded == false and rocket.reloading == false then
                    reloadSound:play()
                    rocket.reloading = true
                    rocket.reloadTimer = rocket.reloadRate
                end
            end
        end
    
    end
return inputReading