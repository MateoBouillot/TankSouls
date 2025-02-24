function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

local tpShot = require("/mechanic/abilities/tpShot")

local collisionCheck = {}

    collisionCheck.bulletsTank = function(explosion, scene)

        -- collision bullets => enemies

        for i = #bullets, 1, -1 do
            for e = #enemyList, 1, -1 do
                if CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
                enemyList[e].hitBox.x, enemyList[e].hitBox.y, enemyList[e].hitBox.W, enemyList[e].hitBox.H) then
                    local collisionX = bullets[i].hitBox.x + bullets[i].hitBox.W * 0.5
                    local collisionY = bullets[i].hitBox.y + bullets[i].hitBox.H * 0.5

                    explosion.create(collisionX, collisionY, bullets[i].bulletType)
                    if bullets[i].bulletType == "tpShot" then
                        tpShot.teleport("enemy", enemyList[e].x, enemyList[e].y, e)
                    end
                    table.remove(bullets, i)
                    return
                end
            end
        end

        -- collision bullets => player

        for i = #enemiesBullets, 1, -1 do
            if not isRolling then
                if CheckCollision(enemiesBullets[i].hitBox.x, enemiesBullets[i].hitBox.y, enemiesBullets[i].hitBox.W, 
                enemiesBullets[i].hitBox.H, tank.hitBoxX, tank.hitBoxY, tank.hitBoxW, tank.hitBoxH) then
                    local collisionX = enemiesBullets[i].hitBox.x + enemiesBullets[i].hitBox.W * 0.5
                    local collisionY = enemiesBullets[i].hitBox.y + enemiesBullets[i].hitBox.H * 0.5

                    explosion.create(collisionX, collisionY, enemiesBullets[i].bulletType)
                    table.remove(enemiesBullets, i)
                end
            end
        end
    end

    collisionCheck.tankTank = function(dt, scene)

        -- collision enemies => player

        for i = 1, #enemyList do
            if teleported <= 0 then
                if CheckCollision(enemyList[i].hitBox.x, enemyList[i].hitBox.y, enemyList[i].hitBox.W, 
                enemyList[i].hitBox.H, tank.hitBoxX, tank.hitBoxY, tank.hitBoxW, tank.hitBoxH) then
                    local distanceX = enemyList[i].lastPosX - tank.lastPosX
                    local distanceY = enemyList[i].lastPosY - tank.lastPosY
                    enemyList[i].x = tank.x + distanceX
                    enemyList[i].y = tank.y + distanceY
                end
            end

            -- collision enemies => enemies

            for e = 1, #enemyList do
                if i ~= e then
                    if CheckCollision(enemyList[i].hitBox.x, enemyList[i].hitBox.y, enemyList[i].hitBox.W, enemyList[i].hitBox.H,
                    enemyList[e].hitBox.x, enemyList[e].hitBox.y, enemyList[e].hitBox.W, enemyList[e].hitBox.H) then
                        
                        enemyList[i].distanceY = enemyList[e].lastPosY - enemyList[i].lastPosY
                        enemyList[i].distanceX = enemyList[e].lastPosX -  enemyList[i].lastPosX

                        enemyList[i].dodgeAngle = math.atan2(enemyList[e].lastPosY - enemyList[i].lastPosY, enemyList[e].lastPosX -  enemyList[i].lastPosX)
                        enemyList[i].dodging = 0.5

                        enemyList[i].specifics.state = "dodge"
                    end
                end
            end
        end
    end

    collisionCheck.tankBorder = function(borderWidth, explosion, scene)

        -- collision border => player

        if tank.x - tank.offsetX <= borderWidth then
            if crateHitbox[3].destroyed and tank.y - tank.offsetY >= crateHitbox[3].y and tank.y <= crateHitbox[3].y + crateHitbox[3].height then
                if tank.x <= 0 and scene == "MENU" then
                    changeScene("ABTUTO", "left")
                end
            elseif  scene == "CANONTUTO" and tank.y - tank.offsetY >= crateHitbox[3].y and tank.y <= crateHitbox[3].y + crateHitbox[3].height then
                if tank.x <= 0 then
                    changeScene("MENU", "right")
                end
            else
                tank.x = borderWidth + tank.offsetX    
            end
        elseif tank.x + tank.offsetX >= love.graphics.getWidth() - borderWidth then
            if crateHitbox[4].destroyed and tank.y - tank.offsetY  >= crateHitbox[4].y and tank.y <= crateHitbox[4].y + crateHitbox[4].height then
                if tank.x >= love.graphics.getWidth() and scene == "MENU" then
                    changeScene("CANONTUTO", "right")
                end
            elseif scene == "ABTUTO"and tank.y - tank.offsetY  >= crateHitbox[4].y and tank.y <= crateHitbox[4].y + crateHitbox[4].height then
                if tank.x >= love.graphics.getWidth() then
                    changeScene("MENU", "left")
                end
            else
                tank.x = love.graphics.getWidth() - borderWidth - tank.offsetX
            end
        end
        if tank.y - tank.offsetY <= borderWidth then
            if crateHitbox[1].destroyed and tank.x - tank.offsetX >= crateHitbox[1].x and tank.x + tank.offsetX <= crateHitbox[1].x + crateHitbox[1].width then
                if tank.y <= 0 and scene == "MENU" then
                    love.audio.stop()
                    changeScene("GAME")
                end
            else
                tank.y = borderWidth + tank.offsetY
            end
        elseif tank.y + tank.offsetY >= love.graphics.getHeight() - borderWidth then
            if crateHitbox[2].destroyed and tank.x - tank.offsetX >= crateHitbox[2].x and tank.x + tank.offsetX <= crateHitbox[2].x + crateHitbox[2].width then
                if tank.y >= love.graphics.getHeight() and scene == "MENU" then
                    love.event.quit()
                end
            else
                tank.y = love.graphics.getHeight() - borderWidth - tank.offsetY
            end
        end

        -- collision border => enemies

        for i = 1, #enemyList do
            if enemyList[i].specifics.state ~= "spawning" then
                if enemyList[i].x - (enemyList[i].hitBox.W * 0.5) <= borderWidth then
                    enemyList[i].x = borderWidth + (enemyList[i].hitBox.W * 0.5)    
                elseif enemyList[i].x + (enemyList[i].hitBox.W * 0.5) >= love.graphics.getWidth() - borderWidth then
                    enemyList[i].x = love.graphics.getWidth() - borderWidth - (enemyList[i].hitBox.W * 0.5)
                end
        
                if enemyList[i].y - (enemyList[i].hitBox.H * 0.5) <= borderWidth then
                    enemyList[i].y = borderWidth + (enemyList[i].hitBox.H * 0.5)
                elseif enemyList[i].y + (enemyList[i].hitBox.H * 0.5) >= love.graphics.getHeight() - borderWidth then
                    enemyList[i].y = love.graphics.getHeight() - borderWidth - (enemyList[i].hitBox.H * 0.5)
                end
            end
        end
    
        -- collision border => bullets

        for i = #bullets, 1, -1 do
            local collisionX = bullets[i].hitBox.x + bullets[i].hitBox.W * 0.5
            local collisionY = bullets[i].hitBox.y + bullets[i].hitBox.H * 0.5

            if bullets[i].x - (bullets[i].hitBox.W * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, scene)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].x + (bullets[i].hitBox.W * 0.5) >= love.graphics.getWidth() - borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, scene)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].y - (bullets[i].hitBox.H * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, scene)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].y + (bullets[i].hitBox.H * 0.5) >= love.graphics.getHeight() - borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, scene)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)
            end
        end
        for i = #enemiesBullets, 1, -1 do
            local collisionX = enemiesBullets[i].hitBox.x + enemiesBullets[i].hitBox.W * 0.5
            local collisionY = enemiesBullets[i].hitBox.y + enemiesBullets[i].hitBox.H * 0.5

            if enemiesBullets[i].x - (enemiesBullets[i].hitBox.W * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].x + (enemiesBullets[i].hitBox.W * 0.5) >= love.graphics.getWidth() - borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].y - (enemiesBullets[i].hitBox.H * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].y + (enemiesBullets[i].hitBox.H * 0.5) >= love.graphics.getHeight() - borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType)
                table.remove(enemiesBullets, i)
            end
        end
    end 

    collisionCheck.explosionDamage = function(explo, scene)
        local baseExploHitBoxW = 100
        local baseExploHitBoxH = 100

        local exploHitBox = {}
            exploHitBox.W =  baseExploHitBoxW * explo.scale
            exploHitBox.H =  baseExploHitBoxH * explo.scale
            exploHitBox.x = explo.x - exploHitBox.W * 0.5
            exploHitBox.y = explo.y - exploHitBox.H * 0.5

        -- collision explosion

        if explo.type == "enemyExplosion" and not isRolling then
            if CheckCollision(exploHitBox.x, exploHitBox.y, exploHitBox.W, exploHitBox.H,
            tank.hitBoxX, tank.hitBoxY, tank.hitBoxW, tank.hitBoxH) then
                tank.hp = tank.hp - explo.damage
            end
        elseif explo.type == "explosion" then
            for i = 1, #enemyList do
                if CheckCollision(exploHitBox.x, exploHitBox.y, exploHitBox.W, exploHitBox.H,
                enemyList[i].hitBox.x, enemyList[i].hitBox.y, enemyList[i].hitBox.W, enemyList[i].hitBox.H) then
                    enemyList[i].specifics.hp = enemyList[i].specifics.hp - explo.damage
                    enemyList[i].specifics.state = "attack"
                end
            end
        end
        if scene == "MENU" then
            for i = 1, #crateHitbox do
                if CheckCollision(exploHitBox.x, exploHitBox.y, exploHitBox.W, exploHitBox.H,
                    crateHitbox[i].x, crateHitbox[i].y, crateHitbox[i].width, crateHitbox[i].height) then
                    crateHitbox[i].destroyed = true
                end
            end
        end
    end

    local crateImg = love.graphics.newImage("/img/decor/crateWood.png")
    local reward1 = {
        x = love.graphics.getWidth() * 0.5 - 150 - crateImg:getWidth() * 0.5 * 1.5,
        y = love.graphics.getHeight() * 0.5 - crateImg:getWidth() * 0.5 * 1.5,
        W = crateImg:getWidth() * 1.5,
        H = crateImg:getHeight() * 1.5
    }
    local reward2 = {
        x = love.graphics.getWidth() * 0.5 + 150 - crateImg:getWidth() * 0.5 * 1.5,
        y = love.graphics.getHeight() * 0.5 - crateImg:getWidth() * 0.5 * 1.5,
        W = crateImg:getWidth() * 1.5,
        H = crateImg:getHeight() * 1.5
    }
    math.randomseed(os.time())

    collisionCheck.rewards = function(waves, explosion)
        if waves.win then
            for i = #bullets, 1, -1 do
                if CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
                    reward1.x, reward1.y, reward1.W, reward1.H) then
                        explosion.create(reward1.x, reward1.y, bullets[i].bulletType)
                        table.remove(bullets, i)
                        if tank.cannonType == "oneTap" then
                            if math.random(1, 2) == 1 then
                                tank.cannonType = "fullAuto"
                            else
                                tank.cannonType = "rocket"
                            end
                            waves.newWave()
                            tank.hp = tank.maxHp
                        elseif  tank.cannonType == "fullAuto" then
                            if math.random(1, 2) == 1 then
                                tank.cannonType = "oneTap"
                            else
                                tank.cannonType = "rocket"
                            end
                            waves.newWave()
                            tank.hp = tank.maxHp
                        elseif tank.cannonType == "rocket" then
                            if math.random(1, 2) == 1 then
                                tank.cannonType = "oneTap"
                            else
                                tank.cannonType = "fullAuto"
                            end
                            waves.newWave()
                            tank.hp = tank.maxHp
                        end
                elseif CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
                reward2.x, reward2.y, reward2.W, reward2.H) then
                    explosion.create(reward2.x, reward2.y, bullets[i].bulletType)
                    table.remove(bullets, i)
                    if tank.level == 1 then
                        tank.level = 2
                        tank.hp = tank.maxHp
                        waves.newWave()
                    elseif tank.level == 2 then
                        tank.level = 3
                        tank.hp = tank.maxHp
                        waves.newWave()
                    else
                        waves.newWave()
                        tank.hp = tank.maxHp
                    end
                end
            end
        end
    end


return collisionCheck