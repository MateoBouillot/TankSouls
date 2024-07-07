function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

local collisionCheck = {}
    collisionCheck.bulletsTank = function(explosion)
        for i = #bullets, 1, -1 do
            for e = #enemyList, 1, -1 do
                if CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
                enemyList[e].hitBox.x, enemyList[e].hitBox.y, enemyList[e].hitBox.W, enemyList[e].hitBox.H) then
                    local collisionX = enemyList[e].hitBox.x + enemyList[e].hitBox.W * 0.5
                    local collisionY = enemyList[e].hitBox.y + enemyList[e].hitBox.H * 0.5
                    explosion.create(collisionX, collisionY)
                    table.remove(bullets, i)
                    table.remove(enemyList, e)
                    return
                end
            end
        end
    end

    collisionCheck.tankBorder = function(tank, borderWidth)
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
    end

return collisionCheck