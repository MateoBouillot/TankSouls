function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

local tpShot = require("/mechanic/abilities/tpShot")

local collisionCheck = {}

    collisionCheck.bulletsTank = function(explosion, tank)
        for i = #bullets, 1, -1 do
            for e = #enemyList, 1, -1 do
                if CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
                enemyList[e].hitBox.x, enemyList[e].hitBox.y, enemyList[e].hitBox.W, enemyList[e].hitBox.H) then
                    local collisionX = bullets[i].hitBox.x + bullets[i].hitBox.W * 0.5
                    local collisionY = bullets[i].hitBox.y + bullets[i].hitBox.H * 0.5

                    explosion.create(collisionX, collisionY, bullets[i].bulletType, tank, tank.x, tank.y)
                    if bullets[i].bulletType == "tpShot" then
                        tpShot.teleport("enemy", tank, enemyList[e].x, enemyList[e].y, enemyList[e])
                    end
                    table.remove(bullets, i)
                    return
                end
            end
        end
        for i = #enemiesBullets, 1, -1 do
            if CheckCollision(enemiesBullets[i].hitBox.x, enemiesBullets[i].hitBox.y, enemiesBullets[i].hitBox.W, 
            enemiesBullets[i].hitBox.H, tank.hitBoxX, tank.hitBoxY, tank.hitBoxW, tank.hitBoxH) then
                local collisionX = enemiesBullets[i].hitBox.x + enemiesBullets[i].hitBox.W * 0.5
                local collisionY = enemiesBullets[i].hitBox.y + enemiesBullets[i].hitBox.H * 0.5

                explosion.create(collisionX, collisionY, enemiesBullets[i].bulletType, tank, tank.x, tank.y)
                table.remove(enemiesBullets, i)
            end
        end
    end

    collisionCheck.tankBorder = function(tank, borderWidth, explosion)
        if tank.x - tank.offsetX <= borderWidth then
            tank.x = borderWidth + tank.offsetX    
        elseif tank.x + tank.offsetX >= love.graphics.getWidth() - borderWidth then
            tank.x = love.graphics.getWidth() - borderWidth - tank.offsetX
        end
   
        if tank.y - tank.offsetY <= borderWidth then
            tank.y = borderWidth + tank.offsetY
        elseif tank.y + tank.offsetY >= love.graphics.getHeight() - borderWidth then
            tank.y = love.graphics.getHeight() - borderWidth - tank.offsetY
        end

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

        for i = #bullets, 1, -1 do
            local collisionX = bullets[i].hitBox.x + bullets[i].hitBox.W * 0.5
            local collisionY = bullets[i].hitBox.y + bullets[i].hitBox.H * 0.5

            if bullets[i].x - (bullets[i].hitBox.W * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, tank.x, tank.y)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", tank, bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].x + (bullets[i].hitBox.W * 0.5) >= love.graphics.getWidth() - borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, tank.x, tank.y)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", tank, bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].y - (bullets[i].hitBox.H * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, tank.x, tank.y)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", tank, bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)

            elseif bullets[i].y + (bullets[i].hitBox.H * 0.5) >= love.graphics.getHeight() - borderWidth then
                explosion.create(collisionX,collisionY, bullets[i].bulletType, tank.x, tank.y)
                if bullets[i].bulletType == "tpShot" then
                    tpShot.teleport("wall", tank, bullets[i].x, bullets[i].y)
                end
                table.remove(bullets, i)
            end
        end

        for i = #enemiesBullets, 1, -1 do
            local collisionX = enemiesBullets[i].hitBox.x + enemiesBullets[i].hitBox.W * 0.5
            local collisionY = enemiesBullets[i].hitBox.y + enemiesBullets[i].hitBox.H * 0.5

            if enemiesBullets[i].x - (enemiesBullets[i].hitBox.W * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType, tank, tank.x, tank.y)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].x + (enemiesBullets[i].hitBox.W * 0.5) >= love.graphics.getWidth() - borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType, tank, tank.x, tank.y)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].y - (enemiesBullets[i].hitBox.H * 0.5) <= borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType, tank, tank.x, tank.y)
                table.remove(enemiesBullets, i)

            elseif enemiesBullets[i].y + (enemiesBullets[i].hitBox.H * 0.5) >= love.graphics.getHeight() - borderWidth then
                explosion.create(collisionX,collisionY, enemiesBullets[i].bulletType, tank, tank.x, tank.y)
                table.remove(enemiesBullets, i)
            end
        end
    end 

    collisionCheck.explosionDamage = function(explo, tank)
        local baseExploHitBoxW = 100
        local baseExploHitBoxH = 100

        local exploHitBox = {}
            exploHitBox.W =  baseExploHitBoxW * explo.scale
            exploHitBox.H =  baseExploHitBoxH * explo.scale
            exploHitBox.x = explo.x - exploHitBox.W * 0.5
            exploHitBox.y = explo.y - exploHitBox.H * 0.5

        if explo.type == "enemyExplosion" then
            if CheckCollision(exploHitBox.x, exploHitBox.y, exploHitBox.W, exploHitBox.H,
            tank.hitBoxX, tank.hitBoxY, tank.hitBoxW, tank.hitBoxH) then
                tank.hp = tank.hp - explo.damage
            end
        elseif explo.type == "explosion" then
            for i = 1, #enemyList do
                if CheckCollision(exploHitBox.x, exploHitBox.y, exploHitBox.W, exploHitBox.H,
                enemyList[i].hitBox.x, enemyList[i].hitBox.y, enemyList[i].hitBox.W, enemyList[i].hitBox.H) then
                    enemyList[i].specifics.hp = enemyList[i].specifics.hp - explo.damage
                end
            end
        end
    end

return collisionCheck