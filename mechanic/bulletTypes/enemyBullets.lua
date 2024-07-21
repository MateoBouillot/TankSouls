local shootSound = love.audio.newSource("/sounds/cannonShoot.wav", "static")
shootSound:setVolume(0.3)
local img = {}
    img.bigBullets = love.graphics.newImage("/img/Bullets/bigTankBullets.png")
    img.sniperBullets = love.graphics.newImage("/img/Bullets/sniperBullets.png")

local offset = {}
    offset.bulletx = img.sniperBullets:getWidth() * 0.5
    offset.bullety = img.sniperBullets:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")

local enemyBullets = {}

    enemyBullets.sniper = function(enemyX, enemyY)
        local sniperBulletsSpeed = 900
        shootSound:stop()
        shootSound:play()
        bullet.create(tank.x, tank.y, enemyX, enemyY, sniperBulletsSpeed, offset, img.sniperBullets, "sniperBullets")
    end

    enemyBullets.big = function(enemyX, enemyY)
        local bigBulletsSpeed = 700
        shootSound:stop()
        shootSound:play()
        bullet.create(tank.x, tank.y, enemyX, enemyY, bigBulletsSpeed, offset, img.bigBullets, "bigBullets")
    end
return enemyBullets