local patrolState = function(dt, enemy, tank)
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

    if enemy.x >= enemy.target.x - 50 and enemy.x <= enemy.target.x + 50
    and enemy.y >= enemy.target.y - 50 and enemy.y <= enemy.target.y + 50 then
        enemy.target.isThere = false
    else
        enemy.rot = rotAim
        enemy.x = enemy.x + enemy.specifics.speed * math.cos(rotAim) * dt
        enemy.y = enemy.y + enemy.specifics.speed * math.sin(rotAim) * dt
    end
    enemy.turretRot = enemy.rot

    local viewDistance
    if enemy.specifics.type == "suicider" then
        viewDistance = 400
    elseif enemy.specifics.type == "sniper" then
        viewDistance = 800
    elseif enemy.specifics.type == "big" then
        viewDistance = 600
    end

    local tankDir = math.atan2(tank.y - enemy.y, tank.x - enemy.x)
    local tankDistance = ((tank.y - enemy.y)^2 + (tank.x - enemy.x)^2)^0.5
    if tankDir >= rotAim - math.pi * 0.25 and tankDir <= rotAim + math.pi * 0.25 and tankDistance <= viewDistance then
        enemy.specifics.state = "attack"
    elseif tankDistance <= 200 then
        enemy.specifics.state = "attack"
    end
end

return patrolState