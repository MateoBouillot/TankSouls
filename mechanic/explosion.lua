local tpShot = require("/mechanic/abilities/tpShot")
local collisionCheck = require("/mechanic/collisionsCheck")
local explosion = {}

    explosion.init = function()
        explosion.list = {}
    end
    explosion.list = {}

    local explosionImg = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/Explosion/explosion".. i ..".png")
        table.insert(explosionImg, img)
    end

    local smokeImg = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/Explosion/explosionSmoke".. i ..".png")
        table.insert(smokeImg, img)
    end

    local bluePortals = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/tpParticles/bluePortal".. i ..".png")
        table.insert(bluePortals, img)
    end

    local orangePortals = {}
    for i = 1, 5 do
        local img = love.graphics.newImage("img/tpParticles/orangePortal".. i ..".png")
        table.insert(orangePortals, img)
    end

    explosion.frameRate = 20

    explosion.update = function(dt)
        for i = #explosion.list, 1, -1 do
            explosion.list[i].time = explosion.list[i].time - dt
            if explosion.list[i].time <= 0 then
                explosion.list[i].imgNbr = explosion.list[i].imgNbr + 1
                explosion.list[i].time = 1/explosion.frameRate
            end
        end
    end

    explosion.create = function(x, y, type, tank, tankx, tanky)
        local explo = {}
        if type == "basicBullet" then
            explo.scale = 0.6
            explo.img = explosionImg
            explo.type = "explosion"
            explo.damage = 20
        elseif type == "fullAuto" then
            explo.scale = 0.3
            explo.img = explosionImg
            explo.type = "explosion"
            explo.damage = 2
        elseif type == "rocket" then
            explo.scale = 1.5
            explo.img = explosionImg
            explo.type = "explosion"
            explo.damage = 40
        elseif type == "tpShot" then
            explo.scale = 1.5
            explo.img = orangePortals
            explo.type = "tp"
            explo.bluePortalX = tankx
            explo.bluePortalY = tanky
        elseif type == "mine" then
            explo.scale = 2
            explo.img = explosionImg
            explo.type = "explosion"
            explo.damage = 40
        elseif type == "tnt" then
            explo.scale = 1.7
            explo.img = explosionImg
            explo.type = "enemyExplosion"
            explo.damage = 40
        elseif type == "sniperBullets" then
            explo.scale = 1
            explo.img = explosionImg
            explo.type = "enemyExplosion"
            explo.damage = 30
        elseif type == "bigBullets" then
            explo.scale = 1.3
            explo.img = explosionImg
            explo.type = "enemyExplosion"
            explo.damage = 20
        elseif type == "death" then
            explo.scale = 1.5
            explo.img = smokeImg
            explo.type = "death"
        end
        explo.x = x
        explo.y = y
        explo.imgNbr = 1
        explo.time = 1/explosion.frameRate
        collisionCheck.explosionDamage(explo, tank)
        table.insert(explosion.list, explo)
    end


    explosion.draw = function()
        for i = #explosion.list, 1, -1  do
            local d = explosion.list[i]
            love.graphics.draw(d.img[d.imgNbr], d.x, d.y, 1, d.scale, d.scale, d.img[d.imgNbr]:getHeight() * 0.5, d.img[d.imgNbr]:getWidth() * 0.5)

            if d.type == "tp" then
                love.graphics.draw(bluePortals[d.imgNbr], d.bluePortalX, d.bluePortalY, 1, d.scale, d.scale, bluePortals[d.imgNbr]:getHeight() * 0.5, bluePortals[d.imgNbr]:getWidth() * 0.5)
            end

            if d.imgNbr == 5 then
                table.remove(explosion.list)
            end
        end
    end

return explosion