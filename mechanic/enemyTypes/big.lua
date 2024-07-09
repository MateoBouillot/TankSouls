local bigImg = {}
    bigImg.body = love.graphics.newImage("/img/enemies/Tank/tankBody_bigRed_outline.png")
    bigImg.canon = love.graphics.newImage("/img/enemies/Tank/tankCanon.png")

local offset = {}
    offset.bodyX = bigImg.body:getWidth() * 0.5
    offset.bodyY = bigImg.body:getHeight() * 0.5
    offset.canonX = 0
    offset.canonY = bigImg.canon:getHeight() * 0.5

local spawnState = require("/mechanic/enemiesBaseState/spawnState")
local patrolState = require("/mechanic/enemiesBaseState/patrolState")
local enemyBullets = require("/mechanic/bulletTypes/enemyBullets")

local big = {}

    big.spawn = function()
        local enemyType = {}
            enemyType.type = "big"
            enemyType.body = bigImg.body
            enemyType.bodyOffsetX = offset.bodyX
            enemyType.bodyOffsetY = offset.bodyY 
            enemyType.bodyScale = 1
            enemyType.armament = bigImg.canon
            enemyType.armamentOffsetX = offset.canonX
            enemyType.armamentOffsetY = offset.canonY
            enemyType.armamentScale = 1.3
            enemyType.speed = 100
            enemyType.state = "spawning"
            enemyType.hp = 50
            enemyType.damage = 20
            enemyType.maxHp = 50
        return enemyType
    end

    big.update = function(dt, enemy, tank)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy, tank)
        elseif enemy.specifics.state == "attack" then
            big.attackState(dt, enemy, tank)
        end
    end

    big.attackTimer = 0

    big.attackState = function(dt, enemy, tank)
        math.randomseed(os.time())
        enemy.target.isThere = true
        enemy.target.x = tank.x
        enemy.target.y = tank.y
        local direction = 1
        

        big.attackTimer = big.attackTimer - dt

        enemy.turretRot = math.atan2(enemy.target.y - enemy.y, enemy.target.x - enemy.x)
        local tankDistance = ((tank.y - enemy.y)^2 + (tank.x - enemy.x)^2)^0.5
        if enemy.turretRot < enemy.rot then direction = -1 end

        if tankDistance <= 400 then
            enemy.rot = enemy.rot + math.pi * dt * direction
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt * -1
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt * -1
        elseif tankDistance <= 400 and enemy.rot >= enemy.turretRot - (math.pi * 0.05) and enemy.rot <= enemy.turretRot + (math.pi * 0.05) then
            enemy.rot = enemy.turretRot
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt * -1
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt * -1
        elseif tankDistance >= 600 then
            enemy.rot = enemy.turretRot
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt
        end

        if big.attackTimer <= 0 then
            big.attackTimer = math.random(100, 400) * 0.01
            enemyBullets.big(tank.x, tank.y, enemy.x, enemy.y)
        end
    end

return big