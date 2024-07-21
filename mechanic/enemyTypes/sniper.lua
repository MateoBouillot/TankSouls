local sniperImg = {}
    sniperImg.body = love.graphics.newImage("/img/enemies/sniper/sniperBody.png")
    sniperImg.canon = love.graphics.newImage("/img/enemies/sniper/sniperCanon.png")

local offset = {}
    offset.bodyX = sniperImg.body:getWidth() * 0.5
    offset.bodyY = sniperImg.body:getHeight() * 0.5
    offset.canonX = 0
    offset.canonY = sniperImg.canon:getHeight() * 0.5

local spawnState = require("/mechanic/enemiesBaseState/spawnState")
local patrolState = require("/mechanic/enemiesBaseState/patrolState")
local dodgeState = require("/mechanic/enemiesBaseState/dodgeState")
local enemyBullets = require("/mechanic/bulletTypes/enemyBullets")

local sniper = {}

    sniper.spawn = function()
        local enemyType = {}
            enemyType.type = "sniper"
            enemyType.body = sniperImg.body
            enemyType.bodyOffsetX = offset.bodyX
            enemyType.bodyOffsetY = offset.bodyY 
            enemyType.bodyScale = 1
            enemyType.armament = sniperImg.canon
            enemyType.armamentOffsetX = offset.canonX
            enemyType.armamentOffsetY = offset.canonY
            enemyType.armamentScale = 1
            enemyType.speed = 150
            enemyType.state = "spawning"
            enemyType.hp = 40
            enemyType.maxHp = 40

            enemyType.lifebar = {}
            enemyType.lifebar.yShift = 30
            enemyType.lifebar.width = 80
            enemyType.lifebar.height = 10
        return enemyType
    end

    sniper.update = function(dt, enemy)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy)
        elseif enemy.specifics.state == "attack" then
            sniper.attackState(dt, enemy)
        elseif enemy.specifics.state == "dodge" then
            dodgeState(dt, enemy)
        end
    end

    sniper.attackTimer = 0

    sniper.attackState = function(dt, enemy)
        math.randomseed(os.time())
        enemy.target.isThere = true
        enemy.target.x = tank.x
        enemy.target.y = tank.y
        local direction = 1

        sniper.attackTimer = sniper.attackTimer - dt

        enemy.turretRot = math.atan2(enemy.target.y - enemy.y, enemy.target.x - enemy.x)
        local tankDistance = ((tank.y - enemy.y)^2 + (tank.x - enemy.x)^2)^0.5
        if enemy.turretRot < enemy.rot then direction = -1 end

        if tankDistance <= 600 then
            enemy.rot = enemy.rot + math.pi * dt * direction
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt * -1
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt * -1
        elseif tankDistance <= 600 and enemy.rot >= enemy.turretRot - (math.pi * 0.05) and enemy.rot <= enemy.turretRot + (math.pi * 0.05) then
            enemy.rot = enemy.turretRot
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt * -1
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt * -1
        elseif tankDistance >= 800 then
            enemy.rot = enemy.turretRot
            enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt
            enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt
        end

        if sniper.attackTimer <= 0 then
            sniper.attackTimer = math.random(200, 400) * 0.01
            enemyBullets.sniper(enemy.x, enemy.y)
        end
    end

return sniper