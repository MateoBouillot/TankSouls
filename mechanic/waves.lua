-- waves setup

local wave1 = {}

local wave2 = {}

local wave3 = {}

local wave4 = {}

local wave5 = {}

wave = 1
currentWave = wave1
local enemies = require("/mechanic/enemies")
local crateImg = love.graphics.newImage("/img/decor/crateWood.png")

local waves = {}
    waves.win = false
    waves.rewardChose = false

    waves.init = function()
        wave1 = {}
        for i = 1, 10  do
            local enemy = "suicider"
            table.insert(wave1, enemy)
        end
        wave2 = {}
        for i = 1, 8 do
            local enemy = "suicider"
            table.insert(wave2, enemy)
        end
        for i = 1, 3 do
            local enemy = "sniper"
            table.insert(wave2, enemy)
        end

        wave3 = {}
        for i = 1, 3 do
            local enemy = "sniper"
            table.insert(wave3, enemy)
        end
        for i = 1, 3 do
            local enemy = "big"
            table.insert(wave3, enemy)
        end

        wave4 = {}
        for i = 1, 6  do
            local enemy = "suicider"
            table.insert(wave4, enemy)
        end
        for i = 1, 3 do
            local enemy = "sniper"
            table.insert(wave4, enemy)
        end
        for i = 1, 3 do
            local enemy = "big"
            table.insert(wave4, enemy)
        end

        wave5 = {}
        for i = 1, 8  do
            local enemy = "suicider"
            table.insert(wave5, enemy)
        end
        for i = 1, 6 do
            local enemy = "sniper"
            table.insert(wave5, enemy)
        end
        for i = 1, 6 do
            local enemy = "big"
            table.insert(wave5, enemy)
        end
        wave = 1
        waves.win = false
        waves.rewardChose = false
        currentWave = wave1
    end

    math.randomseed(os.time())
    waves.spawnTime = 2
    waves.spawnTimer = waves.spawnTime

    waves.spawning = function(dt)
        
        
        if currentWave ~= "won" then 
            waves.spawnTimer = waves.spawnTimer - dt
            if waves.spawnTimer <= 0 then 
                waves.spawnTimer = waves.spawnTime
                if #currentWave >= 1 then
                    local enemySpawn = math.random(1, #currentWave)

                    enemies.spawn(currentWave[enemySpawn])
                    table.remove(currentWave, enemySpawn)
                end
            end
        end
    end

    waves.newWave = function()
        wave = wave + 1
        waves.win = false
        if wave == 1 then
            currentWave = wave1
        elseif wave == 2 then
            currentWave = wave2
        elseif wave == 3 then
            currentWave = wave3
        elseif wave == 4 then
            currentWave = wave4
        elseif wave == 5 then
            currentWave = wave5
        elseif wave == 6 then
            currentWave = "won"
        end
    end

    -- rewards at the end of a wave, setup then drawing

    
    local timer = 0.5

    local baseCannon = love.graphics.newImage("/img/cannons/oneTapCannons/baseCannon.png")
    local autoCannon = love.graphics.newImage("/img/cannons/autoCannons/autoCannon.png")
    local bigCannon = love.graphics.newImage("/img/cannons/bigRocketLauncher/bigCannon.png")

    local tankUpgrade1 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer2.png")
    local tankUpgrade2 = love.graphics.newImage("/img/PlayerTank/tankBodyPlayer3.png")

    local cannon1
    local cannon2

    if tank.cannonType == "oneTap" then
        cannon1 = autoCannon
        cannon2 = bigCannon
    elseif tank.cannonType == "fullAuto" then
        cannon1 = baseCannon
        cannon2 = bigCannon
    elseif tank.cannonType == "rocket" then
        cannon1 = autoCannon
        cannon2 = baseCannon
    end
    waves.reward1 = cannon1

    waves.winning = function(dt)
        if #currentWave < 1 and #enemyList < 1 and not tank.dead then
            waves.win = true
        end

        if currentWave ~= "won" then
            timer = timer - dt
            if timer <= 0 then
                if waves.reward1 == cannon1 then
                    waves.reward1 = cannon2
                elseif waves.reward1 == cannon2 then
                    waves.reward1 = cannon1
                end
                timer = 0.5
            end

            if tank.level == 1 then
                waves.reward2 = tankUpgrade1
            elseif tank.level == 2 then
                waves.reward2 = tankUpgrade2
            elseif tank.level == 3 then
                waves.reward = "skip"
            end
        else
            if love.keyboard.isDown("space") then
                changeScene("MENU")
            end
        end
    end

    waves.draw = function()
        if waves.win then
            love.graphics.draw(crateImg, love.graphics.getWidth() * 0.5 - 150, love.graphics.getHeight() * 0.5, 0, 1.5, 1.5, crateImg:getWidth() * 0.5, crateImg:getHeight() * 0.5)
            love.graphics.draw(waves.reward1, love.graphics.getWidth() * 0.5 - 150, love.graphics.getHeight() * 0.5, 0, 1, 1, waves.reward1:getWidth() * 0.5, waves.reward1:getHeight() * 0.5)

            love.graphics.draw(crateImg, love.graphics.getWidth() * 0.5 + 150, love.graphics.getHeight() * 0.5, 0, 1.5, 1.5, crateImg:getWidth() * 0.5, crateImg:getHeight() * 0.5)
            if waves.reward == "skip" then
                love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 30)
                love.graphics.print("Skip", love.graphics.getWidth() * 0.5 + 150, love.graphics.getHeight() * 0.5)
            else
                love.graphics.draw(waves.reward2, love.graphics.getWidth() * 0.5 + 150, love.graphics.getHeight() * 0.5,  0, 0.7, 0.7, waves.reward2:getWidth() * 0.5, waves.reward2:getHeight() * 0.5)
            end
        end
        if currentWave == "won" then
            love.graphics.setColor(0, 0, 0, 0.6)
            love.graphics.rectangle("fill", 0 , love.graphics.getHeight() * 0.5 - 150, love.graphics.getWidth(), 300)
            love.graphics.setColor(255, 255, 0)
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 100)
            love.graphics.print("You Did Not Died", love.graphics.getWidth() * 0.5 - 350, love.graphics.getHeight() * 0.5 - 50)
            love.graphics.setColor(255, 255, 255)
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 20)
            love.graphics.print("press Space to return to menu", love.graphics.getWidth() * 0.5 - 150, love.graphics.getHeight() - 300)
        end
    end
return waves