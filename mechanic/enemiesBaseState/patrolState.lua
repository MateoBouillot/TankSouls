local patrolState = function(dt, enemy)
    math.randomseed(os.time())

    local targets = {}
        targets.one = {
            isThere = true,
            x = 200,
            y = 200
        }
        targets.two = {
            isThere = true,
            x = 200,
            y = love.graphics.getHeight() - 200
        }
        targets.three = {
            isThere = true,
            x = love.graphics.getWidth() - 200,
            y = love.graphics.getHeight() - 200
        }
        targets.four = {
            isThere = true,
            x = love.graphics.getWidth() - 200,
            y = 200
        }


    if enemy.target.isThere == false then
        local target = math.random(1, 4)
        if target == 1 then
            enemy.target = targets.one
        elseif target == 2 then
            enemy.target = targets.two
        elseif target == 3 then
            enemy.target = targets.three
        elseif target == 4 then
            enemy.target = targets.four
        end
        print(target)
    end
    local direction = 1
    local rotAim = math.atan2(enemy.target.y - enemy.y, enemy.target.x - enemy.x)
    if rotAim < enemy.rot then direction = -1 end

    if enemy.rot >= rotAim - (math.pi * 0.05) and enemy.rot <= rotAim + (math.pi * 0.05) then
        enemy.rot = rotAim
        enemy.x = enemy.x + enemy.specifics.speed * math.cos(rotAim) * dt
        enemy.y = enemy.y + enemy.specifics.speed * math.sin(rotAim) * dt
    elseif enemy.x >= enemy.target.x - 50 and enemy.x <= enemy.target.x + 50
    and enemy.y >= enemy.target.y - 50 and enemy.y <= enemy.target.y + 50 then
        enemy.target.isThere = false
    else
        enemy.rot = enemy.rot + math.pi * dt * direction
    end
end

return patrolState