local shootSound = love.audio.newSource("/sounds/fullAuto.wav", "static")

local img = {}
    img.greenFullAutoBullet = love.graphics.newImage("/img/Bullets/fullAutoBullets.png")

local offset = {}
    offset.bulletx = img.greenFullAutoBullet:getWidth() * 0.5
    offset.bullety = img.greenFullAutoBullet:getHeight() * 0.5

local bullet = require("/mechanic/Bullets")
local tank = require("/mechanic/tank")

local sideCannons = {}
    sideCannons.speed = 800
    sideCannons.shootRate = 0.5
    sideCannons.timer = 0

    sideCannons.init = function()
        sideCannons.timer = 0
    end

    sideCannons.create = function(tank)
        if sideCannons.timer <= 0 then
            shootSound:stop()
            shootSound:play()
            if tank.level == 3 then 
                bullet.create(tank.x + math.cos(tank.rot + math.pi * 0.25),
                    tank.y + math.sin(tank.rot + math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")

                bullet.create(tank.x + math.cos(tank.rot - math.pi * 0.25),
                    tank.y + math.sin(tank.rot - math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")

                bullet.create(tank.x + math.cos(tank.rot - 3 * math.pi * 0.25),
                    tank.y + math.sin(tank.rot - 3 * math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")

                bullet.create(tank.x + math.cos(tank.rot + 3 * math.pi * 0.25),
                    tank.y + math.sin(tank.rot + 3 * math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")
                sideCannons.timer = sideCannons.shootRate

            elseif tank.level == 2 then
                bullet.create(tank.x + math.cos(tank.rot + math.pi * 0.25),
                    tank.y + math.sin(tank.rot + math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")

                bullet.create(tank.x + math.cos(tank.rot - math.pi * 0.25),
                    tank.y + math.sin(tank.rot - math.pi * 0.25), 
                    tank.x, tank.y, sideCannons.speed, offset, img.greenFullAutoBullet, "fullAuto")
                sideCannons.timer = sideCannons.shootRate 
            end
        end
    end

    sideCannons.timerUpdate = function(dt)
        sideCannons.timer = sideCannons.timer - dt
    end

return sideCannons