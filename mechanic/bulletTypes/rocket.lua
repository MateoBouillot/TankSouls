local shootSound = love.audio.newSource("/sounds/cannonShoot.wav", "static")
shootSound:setVolume(0.3)
local img = {}
    img.greenRocket = love.graphics.newImage("/img/Bullets/bigBullets.png")

local offset = {}
    offset.bulletx = img.greenRocket:getWidth() * 0.5
    offset.bullety = img.greenRocket:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")

local rocket = {}
    rocket.speed = 500
    rocket.reloaded = true
    rocket.reloading = false
    rocket.reloadRate = 2
    rocket.reloadTimer = 0

    rocket.init = function()
        rocket.reloaded = true
    end

    rocket.create = function(x, y, tankX, tankY)
        if rocket.reloaded == true then
            shootSound:stop()
            shootSound:play()
            bullet.create(x, y, tankX, tankY, rocket.speed, offset, img.greenRocket, "rocket")
            rocket.reloaded = false
        end
    end

    rocket.reloadUpdate = function(dt)
        if rocket.reloading == true then
            if rocket.reloadTimer >= 0 then
                rocket.reloadTimer = rocket.reloadTimer - dt
            else
                rocket.reloaded = true
                rocket.reloading = false
            end
        end
    end

return rocket
