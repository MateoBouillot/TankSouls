local spawnState = function(dt, enemy)
    if enemy.spawnSide == 1 then
        if enemy.x >= 56 + enemy.specifics.bodyOffsetX then
            enemy.specifics.state = "patrol"
        else 
            enemy.x = enemy.x + enemy.specifics.speed * dt
        end

    elseif enemy.spawnSide == 2 then
        if enemy.x <= love.graphics.getWidth() - (56 + enemy.specifics.bodyOffsetX) then
            enemy.specifics.state = "patrol"
        else 
            enemy.x = enemy.x - enemy.specifics.speed * dt
        end

    elseif enemy.spawnSide == 3 then
        if enemy.y >= 56 + enemy.specifics.bodyOffsetY then
            enemy.specifics.state = "patrol"
        else 
            enemy.y = enemy.y + enemy.specifics.speed * dt
        end

    elseif enemy.spawnSide == 4 then
        if enemy.y <= love.graphics.getHeight() - (56 + enemy.specifics.bodyOffsetY) then
            enemy.specifics.state = "patrol"
        else 
            enemy.y = enemy.y - enemy.specifics.speed * dt
        end
    end
end

return spawnState

