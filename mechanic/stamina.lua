local stamina = {}

    stamina.max = 100
    stamina.current = 100

    stamina.regenRate = 30

    stamina.timeBeforeRegen = 0.5
    stamina.timer = 0

    stamina.init = function()
        stamina.current = 100
    end

    stamina.use = function(staminaUsed)
        stamina.current = stamina.current - staminaUsed
        stamina.timer = stamina.timeBeforeRegen
    end

    stamina.update = function(dt)
        if stamina.current < 100 then
            stamina.timer = stamina.timer - dt
            if stamina.timer <= 0 then
                stamina.current = stamina.current + stamina.regenRate * dt
            end
        end
    end

    stamina.draw = function()
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", love.graphics.getWidth() - 500, 20, 300, 10)
        love.graphics.setColor(0, 255, 0)
        local stam = (300 * 0.01) * (stamina.current / (stamina.max * 0.01))
        love.graphics.rectangle("fill", love.graphics.getWidth() - 500, 20, stam, 10)
        love.graphics.setColor(255, 255, 255)
    end
return stamina