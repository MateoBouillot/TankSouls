local mine = {}

local landMine = {}
    landMine.offImg = love.graphics.newImage("/img/mine/mine.png")
    landMine.onImg = love.graphics.newImage("/img/mine/mine blinking.png")

    landMine.offTimer = 0.3
    landMine.onTimer = 0.2
    landMine.fullTimer = 3

    landMine.refresh = 0

    landMine.init = function()
        mine = {}
    end

    landMine.create = function(x, y)
        if landMine.refresh <= 0 then
            mine.x = x
            mine.y = y

            mine.off = landMine.offImg
            mine.on = landMine.onImg

            mine.offsetX = landMine.offImg:getWidth() * 0.5
            mine.offsetY = landMine.offImg:getHeight() * 0.5

            mine.offTimer = landMine.offTimer
            mine.onTimer = 0.2
            mine.fullTimer = landMine.fullTimer
            mine.blinking = false

            landMine.refresh = 5
        end
    end

    landMine.update = function(dt, explosion)
        if mine.blinking ~= nil then
            mine.fullTimer =  mine.fullTimer - dt
            if mine.blinking then
                if mine.onTimer <= 0 then
                    mine.onTimer = 0.2
                    mine.blinking = false
                else
                    mine.onTimer = mine.onTimer - dt
                end
            elseif not mine.blinking then
                if mine.offTimer <= 0 then
                    landMine.offTimer = landMine.offTimer - 0.05
                    mine.offTimer = landMine.offTimer
                    mine.blinking = true
                else
                    mine.offTimer = mine.offTimer - dt
                end
            end

            if mine.fullTimer <= 0 then
                explosion.create(mine.x, mine.y, "mine")
                mine = {}
                landMine.offTimer = 0.3
            end
        end

        landMine.refresh =  landMine.refresh - dt
    end

    landMine.draw = function()
        if mine.blinking ~= nil then
            if mine.blinking then
                love.graphics.draw(mine.on, mine.x, mine.y, 1, 1, 1, mine.offsetX, mine.offsetY)
            elseif not mine.blinking then
                love.graphics.draw(mine.off, mine.x, mine.y, 1, 1, 1, mine.offsetX, mine.offsetY)
            end
        end
    end
return landMine
