local suiciderImg = {}
    suiciderImg.tnt = love.graphics.newImage("/img/enemies/small suicider/tnt.png")
    suiciderImg.tntExplo = love.graphics.newImage("/img/enemies/small suicider/tntExplo.png")
    suiciderImg.body = love.graphics.newImage("/img/enemies/small suicider/smallEnemyBody.png")

local offset = {}
    offset.bodyX = suiciderImg.body:getWidth() * 0.5
    offset.bodyY = suiciderImg.body:getHeight() * 0.5
    offset.tntX = suiciderImg.tnt:getWidth() * 0.5
    offset.tntY = suiciderImg.tnt:getHeight() * 0.5

local spawnState = require("/mechanic/enemiesBaseState/spawnState")
local patrolState = require("/mechanic/enemiesBaseState/patrolState")

local suicider = {}

    suicider.spawn = function()
        local enemyType = {}
            enemyType.type = "suicider"
            enemyType.body = suiciderImg.body
            enemyType.bodyOffsetX = offset.bodyX
            enemyType.bodyOffsetY = offset.bodyY 
            enemyType.bodyScale = 0.9
            enemyType.armament = suiciderImg.tnt
            enemyType.armamentOffsetX = offset.tntX
            enemyType.armamentOffsetY = offset.tntY
            enemyType.armamentScale = 1.5
            enemyType.speed = 200
            enemyType.state = "spawning"
            enemyType.hp = 20
            enemyType.damage = 40
            enemyType.maxHp = 20
            enemyType.exploding = false
            enemyType.explosionTimer = 2
            enemyType.exploded = false
        return enemyType
    end

    suicider.update = function(dt, enemy, tank)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy, tank)
        elseif enemy.specifics.state == "attack" then
            suicider.attackState(dt, enemy, tank)
            suicider.exploding(dt, enemy)
        end
    end

    suicider.attackState = function(dt, enemy, tank)
        enemy.target.isThere = true
        enemy.target.x = tank.x
        enemy.target.y = tank.y

        enemy.rot = math.atan2(enemy.target.y - enemy.y, enemy.target.x - enemy.x)
        enemy.x = enemy.x + enemy.specifics.speed * math.cos(enemy.rot) * dt
        enemy.y = enemy.y + enemy.specifics.speed * math.sin(enemy.rot) * dt
        enemy.turretRot = enemy.rot

        suicider.tankDistance = ((enemy.target.y - enemy.y)^2 + (enemy.target.x - enemy.x)^2)^0.5
        if suicider.tankDistance <= 150 then
            enemy.specifics.exploding = true
        end
    end 

    suicider.exploding = function(dt, enemy)
        
        if enemy.specifics.exploding == true then
            enemy.specifics.explosionTimer = enemy.specifics.explosionTimer - dt

            enemy.specifics.armament = suiciderImg.tntExplo
            enemy.specifics.armamentScale = enemy.specifics.armamentScale + 0.2/enemy.specifics.explosionTimer * dt

            if enemy.specifics.explosionTimer <= 0 then
                enemy.specifics.exploded = true
            end
        end
    end

return suicider
