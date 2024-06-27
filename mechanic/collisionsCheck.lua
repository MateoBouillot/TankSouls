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
                    local collisionX = enemyList[e].hitBox.x + offset.tankx
                    local collisionY = enemyList[e].hitBox.y + offset.tanky
                    explosion.create(collisionX, collisionY)
                    table.remove(bullets, i)
                    table.remove(enemyList, e)
                    return
                end
            end
        end
    end

    collisionCheck.tankBorder = function()

    end

return collisionCheck