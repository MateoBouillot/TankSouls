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
        return enemyType
    end

    sniper.update = function(dt, enemy)
        if enemy.specifics.state == "spawning" then
            spawnState(dt, enemy)
        elseif enemy.specifics.state == "patrol" then
            patrolState(dt, enemy)
        elseif enemy.specifics.state == "attack" then
            sniper.attackState(dt, enemy)
        end
    end

return sniper