local music = {}
    music.menu = love.audio.newSource("/sounds/music/MenuMusic.wav", "stream")
    music.inGame = love.audio.newSource("/sounds/music/inGameMusic.wav", "stream")

local background = {}
    background.groundImg = love.graphics.newImage("img/bg/dirt.png")
    background.barricadeImg = love.graphics.newImage("/img/decor/barricadeWood.png")
    background.crateImg = love.graphics.newImage("/img/decor/crateWood.png")

    background.width = (love.graphics.getWidth() / 128) + 1
    background.height = (love.graphics.getHeight() / 128) + 1

    crateHitbox = {}
    local top = {
        x = (((love.graphics.getWidth() / background.barricadeImg:getWidth()) * 0.5 - 2.5) - 1) * (background.barricadeImg:getWidth() + 0.5),
        y = 0,
        height = background.barricadeImg:getWidth(),
        width = background.barricadeImg:getWidth() * 4,
        side = top,
        destroyed = false
    }
    table.insert(crateHitbox, top)

    local bottom = {
        x = top.x,
        y = love.graphics.getHeight() - background.barricadeImg:getHeight(),
        height = background.barricadeImg:getWidth(),
        width = background.barricadeImg:getWidth() * 4,
        side = bottom,
        destroyed = false  
    }
    table.insert(crateHitbox, bottom)

    local left = {
        x = 0,
        y = (((love.graphics.getHeight() / background.barricadeImg:getHeight()) * 0.5 - 1.5) - 1) * (background.barricadeImg:getHeight() + 0.7),
        height = background.barricadeImg:getWidth() * 3,
        width = background.barricadeImg:getWidth(),
        side = left,
        destroyed = false
    }
    table.insert(crateHitbox, left)

    local right = {
        x = love.graphics.getWidth() - background.barricadeImg:getWidth(),
        y = left.y,
        height = background.barricadeImg:getWidth() * 3,
        width = background.barricadeImg:getWidth() ,
        side = right,
        destroyed = false
    }
    table.insert(crateHitbox, right)
    
    background.init = function(value)
        if value == nil then
            for i = 1, #crateHitbox do
                crateHitbox[i].destroyed = false
            end
        end
    end

    background.draw = function(scene)

        -- ground drawing

        for i = 1, background.width do
            for u = 1, background.height do
                love.graphics.draw(background.groundImg, (i - 1) * 128, (u - 1) * 128)
            end
        end

        -- barricade drawing

        for i = 1, (love.graphics.getWidth() / background.barricadeImg:getWidth()) do
            if i < (love.graphics.getWidth() / background.barricadeImg:getWidth()) * 0.5 + 1 and i > (love.graphics.getWidth() / background.barricadeImg:getWidth()) * 0.5 - 2.5 then
                if scene == "MENU" then
                    if not crateHitbox[1].destroyed then
                        love.graphics.draw(background.crateImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), 0)
                    end
                    if not crateHitbox[2].destroyed then
                        love.graphics.draw(background.crateImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), love.graphics.getHeight() - background.barricadeImg:getHeight())
                    end
                elseif scene == "ABTUTO" or scene == "CANONTUTO" then
                    love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), 0)
                    love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), love.graphics.getHeight() - background.barricadeImg:getHeight())
                end
            else
                love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), 0)
                love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), love.graphics.getHeight() - background.barricadeImg:getHeight())
            end
        end

        for i = 1, (love.graphics.getHeight() / background.barricadeImg:getHeight()) do
            if i < (love.graphics.getHeight() / background.barricadeImg:getHeight()) * 0.5 + 2 and i > (love.graphics.getHeight() / background.barricadeImg:getHeight()) * 0.5 - 1.5 then
                if scene == "MENU" then
                    if not crateHitbox[3].destroyed then
                        love.graphics.draw(background.crateImg, 0, (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                    end
                    if not crateHitbox[4].destroyed then
                        love.graphics.draw(background.crateImg, love.graphics.getWidth() - background.barricadeImg:getWidth(), (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                    end
                elseif scene == "ABTUTO" then
                    love.graphics.draw(background.barricadeImg, 0, (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                elseif scene == "CANONTUTO" then 
                    love.graphics.draw(background.barricadeImg, love.graphics.getWidth() - background.barricadeImg:getWidth(), (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                end
            else
                love.graphics.draw(background.barricadeImg, 0, (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                love.graphics.draw(background.barricadeImg, love.graphics.getWidth() - background.barricadeImg:getWidth(), (i - 1) * (background.barricadeImg:getHeight() + 0.7))
            end
        end

        -- menu writing

        if scene == "MENU" then
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 100)
            love.graphics.print("Tank Souls", love.graphics.getWidth() * 0.5 - 320, 300)

            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 60)
            love.graphics.print("Exit", love.graphics.getWidth() * 0.5 - 120, love.graphics.getHeight() - 130)
            love.graphics.print("Play", love.graphics.getWidth() * 0.5 - 120, 60)

            love.graphics.print("Cannons", love.graphics.getWidth() - 350, love.graphics.getHeight() * 0.5 - 60)
            love.graphics.print("tutorial", love.graphics.getWidth() - 350, love.graphics.getHeight() * 0.5 )

            love.graphics.print("Abilities", 80, love.graphics.getHeight() * 0.5 - 60)
            love.graphics.print("tutorial", 80, love.graphics.getHeight() * 0.5)

        elseif scene == "CANONTUTO" then
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 60)
            love.graphics.print("Use 1, 2 or 3 to switch and try out the different cannons types", 250, 100, 0, 0.7, 0.7)

            if tank.cannonType == "oneTap" then
                love.graphics.print("One click, One shoot", 200, love.graphics.getHeight() - 400)
                love.graphics.print("mid shootrate for mid damages", 400, love.graphics.getHeight() - 300)
                love.graphics.print("just your basic cannon", 800, love.graphics.getHeight() - 200)
            
            elseif tank.cannonType == "fullAuto" then
                love.graphics.print("Full automatic cannon", 200, love.graphics.getHeight() - 400)
                love.graphics.print("very high shootrate for very low damage", 400, love.graphics.getHeight() - 300)
                love.graphics.print("stay clicked and enjoy!", 800, love.graphics.getHeight() - 200)

            elseif tank.cannonType == "rocket" then
                love.graphics.print("So big you have to reload yourself", 400, love.graphics.getHeight() - 400)
                love.graphics.print("very low shootrate for very high damage", 300, love.graphics.getHeight() - 300)
                love.graphics.print("click on the scroll wheel after a shot to reload", 200, love.graphics.getHeight() - 200)
            end
        elseif scene == "ABTUTO" then
            love.graphics.setNewFont("/img/BlackOpsOne-Regular.ttf", 30)
            love.graphics.print("Press 'shift' to dash", 250, 200)
            love.graphics.print("you take no damage while dashing", 200, 250)
            love.graphics.print("it also uses stamina", 250, 300)
            love.graphics.print("stamnia will recover on its own", 200, 350)
            
            love.graphics.print("press 'A' to shoot a portal", love.graphics.getWidth() - 900, 300)
            love.graphics.print("you will be teleported wherever your shot lands", love.graphics.getWidth() - 1000, 350)
            love.graphics.print("if it is an enemy he will swap place with you", love.graphics.getWidth() - 950, 400)
            love.graphics.print("it will take 5 seconds to recharge", love.graphics.getWidth() - 900, 450)

            love.graphics.print("press 'E' to drop a landMine", 500, 700)
            love.graphics.print("it will take a few seconds to explode", 450, 750)
            love.graphics.print("and damage everyone in a wide radius", 500, 800)
            love.graphics.print("it will take 10 seconds to recharge", 480, 850)
        end

        if scene == "GAME" and not tank.dead then
            music.inGame:play()
        else
            music.menu:play()
        end
    end
return background