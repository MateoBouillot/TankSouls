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
        return enemyType
    end

    big.update = function(dt, enemy)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy)
        elseif enemy.specifics.state == "attack" then
            big.attackState(dt, enemy)
        end
    end

return big