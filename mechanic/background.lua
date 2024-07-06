local background = {}
    background.groundImg = love.graphics.newImage("img/bg/dirt.png")
    background.barricadeImg = love.graphics.newImage("/img/decor/barricadeWood.png")
    background.crateImg = love.graphics.newImage("/img/decor/crateWood.png")

    background.width = (love.graphics.getWidth() / 128) + 1
    background.height = (love.graphics.getHeight() / 128) + 1

    background.draw = function(menu)
        for i = 1, background.width do
            for u = 1, background.height do
                love.graphics.draw(background.groundImg, (i - 1) * 128, (u - 1) * 128)
            end
        end

        for i = 1, (love.graphics.getWidth() / background.barricadeImg:getWidth()) do
            if i < (love.graphics.getWidth() / background.barricadeImg:getWidth()) * 0.5 + 1 and i > (love.graphics.getWidth() / background.barricadeImg:getWidth()) * 0.5 - 2.5 then
                if menu then
                    love.graphics.draw(background.crateImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), 0)
                    love.graphics.draw(background.crateImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), love.graphics.getHeight() - background.barricadeImg:getHeight())
                end
            else
                love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), 0)
                love.graphics.draw(background.barricadeImg, (i - 1) * (background.barricadeImg:getWidth() + 0.5), love.graphics.getHeight() - background.barricadeImg:getHeight())
            end
        end

        for i = 1, (love.graphics.getHeight() / background.barricadeImg:getHeight()) do
            if i < (love.graphics.getHeight() / background.barricadeImg:getHeight()) * 0.5 + 2 and i > (love.graphics.getHeight() / background.barricadeImg:getHeight()) * 0.5 - 1.5 then
                if menu then
                    love.graphics.draw(background.crateImg, 0, (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                    love.graphics.draw(background.crateImg, love.graphics.getWidth() - background.barricadeImg:getWidth(), (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                end
            else
                love.graphics.draw(background.barricadeImg, 0, (i - 1) * (background.barricadeImg:getHeight() + 0.7))
                love.graphics.draw(background.barricadeImg, love.graphics.getWidth() - background.barricadeImg:getWidth(), (i - 1) * (background.barricadeImg:getHeight() + 0.7))
            end
        end
    end
return background