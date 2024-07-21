local reloadSound = love.audio.newSource("/sounds/reloading.wav", "static")
local shootSound = love.audio.newSource("/sounds/fullAuto.wav", "static")
shootSound:setVolume(0.5)
local tankMovingSound = love.audio.newSource("/sounds/TankMovingSound.wav", "static")
tankMovingSound:setVolume(0.1)


local inputReading = {}

    inputReading.cannonSwitch = function()    
            if love.keyboard.isDown("kp1") then
                tank.cannonType = "oneTap"
            elseif love.keyboard.isDown("kp2") then
                tank.cannonType = "fullAuto"
            elseif love.keyboard.isDown("kp3") then
                tank.cannonType = "rocket"
            end
    end

    inputReading.movements = function(dt)
        if not tank.dead then
            if love.keyboard.isDown("d") then
                tank.rotate(dt, 1)
            elseif love.keyboard.isDown("q") then
                tank.rotate(dt, -1)
            end
        
            if love.keyboard.isDown("z") then
                tankMovingSound:play()
                tank.move(dt, 1)
            elseif love.keyboard.isDown("s") then
                tank.move(dt, -1)
                tankMovingSound:play()
            end
        end

        if tank.dead then
            if love.keyboard.isDown("space") then
                changeScene("MENU")
                tank.dead = false
                tank.hp = tank.maxHp
            end
        end
    end

    inputReading.abilities = function(dt, startRoll, landMine, stamina)
        if love.keyboard.isDown("lshift") then
            if love.keyboard.isDown("z") then
                startRoll("z", stamina)
            elseif love.keyboard.isDown("s") then
                startRoll("s", stamina)
            end
        end

        if love.keyboard.isDown("e") then
            landMine.create()
        end

    end

    local mouse1Down = false
    local mouse2Down = false
    
    inputReading.aimingShooting = function(dt, basicBullet, fullAutoBullet, rocket, tpShot)

        local mouseX, mouseY = love.mouse.getPosition()
        tank.aim(mouseX, mouseY)

        if love.mouse.isDown(1) then
            if tank.cannonType == "oneTap" then
                if mouse1Down ~= true then 
                    basicBullet.create(mouseX, mouseY)
                end
            elseif tank.cannonType == "fullAuto" then
                fullAutoBullet.create(mouseX, mouseY)
                shootSound:play()
            elseif tank.cannonType == "rocket" then
                rocket.create(mouseX, mouseY)
            end
            mouse1Down = true
        else
            mouse1Down = false
        end

        if love.keyboard.isDown("a") then
            tpShot.create(mouseX, mouseY)
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