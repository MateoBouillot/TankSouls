local explosion = {}

    explosion.init = function()
        explosion.list = {}
    end
    explosion.list = {}
    explosion.img = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/Explosion/explosion".. i ..".png")
        table.insert(explosion.img, img)
    end
    explosion.SmokeImg = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/Explosion/explosionSmoke".. i ..".png")
        table.insert(explosion.SmokeImg, img)
    end
    explosion.frameRate = 20

    explosion.update = function(dt)
        for i = 1, #explosion.list do
            explosion.list[i].time = explosion.list[i].time - dt
            if explosion.list[i].time <= 0 then
                explosion.list[i].imgNbr = explosion.list[i].imgNbr + 1
                explosion.list[i].time = 1/explosion.frameRate
                if explosion.list[i].imgNbr >= 6 then
                    table.remove(explosion.list)
                end
            end
        end
    end

    explosion.create = function(x, y)
        local explo = {}
        explo.x = x
        explo.y = y
        explo.imgNbr = 1
        explo.time = 1/explosion.frameRate
        table.insert(explosion.list, explo)
    end

    explosion.draw = function()
        for i = 1, #explosion.list do
            local d = explosion.list[i]
            love.graphics.draw(explosion.img[d.imgNbr], d.x, d.y, 1, 1.3, 1.3, explosion.img[d.imgNbr]:getHeight() * 0.5, explosion.img[d.imgNbr]:getWidth() * 0.5)
        end
    end

return explosion