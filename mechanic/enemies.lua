local enemyimg = {}
    enemyimg.sniper = love.graphics.newImage("/img/enemies/sniper/sniperBody.png")
    enemyimg.barrel = love.graphics.newImage("/img/enemies/sniper/sniperCanon.png")
    enemyimg.tnt = love.graphics.newImage("/img/enemies/small suicider/tnt.png")
    enemyimg.suicider = love.graphics.newImage("/img/enemies/small suicider/smallEnemyBody.png")

local offset = {}
    offset.tankX = enemyimg.suicider:getWidth() * 0.5
    offset.tankY = enemyimg.suicider:getHeight() * 0.5
    offset.barrelX = 0
    offset.barrelY = enemyimg.barrel:getHeight() * 0.5
    offset.tntX = enemyimg.tnt:getWidth() * 0.5
    offset.tntY = enemyimg.tnt:getHeight() * 0.5

enemyList = {}
local suicider = require("/mechanic/enemyTypes/Suicider")
local sniper = require("/mechanic/enemyTypes/sniper")
local big = require("/mechanic/enemyTypes/big")

local enemies = {}

    enemies.init = function()
        enemyList = {}
    end
    enemies.spawnTime = 2
    enemies.spawnTimer = enemies.spawnTime
    enemies.randomRotTime = 0.01
    enemies.randomRotTimer = enemies.randomRotTime
    enemies.speed = 150

    enemies.Spawning = function(dt)
        enemies.spawnTimer = enemies.spawnTimer - dt
        if enemies.spawnTimer <= 0 then
            enemies.spawn()
            enemies.spawnTimer = enemies.spawnTime
        end
    end
    math.randomseed(os.time())
    enemies.spawn = function()
      if #enemyList == 5 then return end 
        local enemy = {}
        enemies.spawnSide = math.random(1, 4)
        if enemies.spawnSide == 1 then
            enemy.x = 0 - 30
            enemy.y = love.graphics.getHeight() * 0.5
            enemy.rot = 0
        elseif enemies.spawnSide == 2 then
            enemy.x = love.graphics.getWidth() + 30
            enemy.y = love.graphics.getHeight() * 0.5
            enemy.rot = math.pi
        elseif enemies.spawnSide == 3 then
            enemy.x = love.graphics.getWidth() * 0.5
            enemy.y = 0 - 30
            enemy.rot = math.pi * 0.5
        elseif enemies.spawnSide == 4 then
            enemy.x = love.graphics.getWidth() * 0.5
            enemy.y = love.graphics.getHeight() + 30
            enemy.rot = 3 * math.pi * 0.5
        end
        enemy.spawnSide = enemies.spawnSide

        enemy.target = {
            isThere = false,
            x = 0,
            y = 0
        }

        enemy.turretRot = enemy.rot

        enemy.spawnType = math.random(1, 3)
        if enemy.spawnType == 1 then
            enemy.specifics = suicider.spawn()
        elseif enemy.spawnType == 2 then
            enemy.specifics = big.spawn()
        elseif enemy.spawnType == 3 then
            enemy.specifics = sniper.spawn()
        end

        enemy.hitBox = {}
        enemy.hitBox.x = enemy.x - enemy.specifics.body:getWidth() * 0.5
        enemy.hitBox.y = enemy.y - enemy.specifics.body:getHeight() * 0.5
        enemy.hitBox.W = enemy.specifics.body:getWidth()
        enemy.hitBox.H = enemy.specifics.body:getHeight()

        table.insert(enemyList, enemy)
    end

    enemies.update = function(dt, tank, explosion)
        for i = #enemyList, 1, -1 do
            if enemyList[i].specifics.type == "suicider" then
                suicider.update(dt, enemyList[i], tank)
            elseif enemyList[i].specifics.type == "sniper" then
                sniper.update(dt, enemyList[i], tank)
            elseif enemyList[i].specifics.type == "big" then
                big.update(dt, enemyList[i], tank)
            end

            enemyList[i].hitBox.x = enemyList[i].x - enemyList[i].specifics.body:getWidth() * 0.5
            enemyList[i].hitBox.y = enemyList[i].y - enemyList[i].specifics.body:getHeight() * 0.5

            if enemyList[i].specifics.exploded then
                explosion.create(enemyList[i].x, enemyList[i].y, "tnt", tank)
                table.remove(enemyList, i)
            end

            if enemyList[i].specifics.hp <= 0 then
                explosion.create(enemyList[i].x, enemyList[i].y, "death")
                table.remove(enemyList, i)
            end
        end
    end

    enemies.draw = function()
        for i = 1, #enemyList do
            local e = enemyList[i] 
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", e.hitBox.x, e.hitBox.y - e.specifics.lifebar.yShift, e.specifics.lifebar.width, e.specifics.lifebar.height)
            love.graphics.setColor(255, 0, 0)
            local life = (e.specifics.lifebar.width * 0.01) * (e.specifics.hp / (e.specifics.maxHp * 0.01))
            love.graphics.rectangle("fill", e.hitBox.x, e.hitBox.y - e.specifics.lifebar.yShift, life, e.specifics.lifebar.height)
            love.graphics.setColor(255, 255, 255)
            love.graphics.draw(e.specifics.body, e.x, e.y, e.rot, e.specifics.bodyScale, e.specifics.bodyScale, e.specifics.bodyOffsetX, e.specifics.bodyOffsetY)
            love.graphics.draw(e.specifics.armament, e.x, e.y, e.turretRot, e.specifics.armamentScale, e.specifics.armamentScale, e.specifics.armamentOffsetX, e.specifics.armamentOffsetY)
           
        end
    end
return enemies