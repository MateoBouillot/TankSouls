local suiciderImg = {}
    suiciderImg.tnt = love.graphics.newImage("/img/enemies/small suicider/tnt.png")
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
        return enemyType
    end

    suicider.update = function(dt, enemy)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy)
        elseif enemy.specifics.state == "attack" then
            suicider.attackState(dt, enemy)
        end
    end


return suicider
