local roll = {}
    roll.timeout = 3
    roll.timer = 0

    roll.distance = 900
    roll.iFrames = 0.2
    roll.iTimer = 0

    roll.staminaUse = 40

    isRolling = false
    roll.steps = "none"

    roll.axis = nil
    roll.Dir = 1

    roll.scaleChange = nil
    roll.placeChange = nil

    roll.start = function(keypress, tankRot, stamina)
        if not isRolling and stamina.current >= roll.staminaUse then
            stamina.use(roll.staminaUse)
            isRolling = true
            roll.steps = "shrink"

            tankRot = tankRot % (2 * math.pi)
            if tankRot <= 0 then
                tankRot = 2 * math.pi + tankRot
            end
            

            if tankRot <= 3 * math.pi * 0.25 and tankRot >= math.pi * 0.25 then
                roll.Dir = 1
                roll.axis = "y"

            elseif tankRot <= 7 * math.pi * 0.25 and tankRot >= 5 * math.pi * 0.25 then
                roll.Dir = -1
                roll.axis = "y"

            elseif tankRot < 5 * math.pi * 0.25 and tankRot > 3 * math.pi * 0.25 then
                roll.Dir = -1
                roll.axis = "x"

            else
                roll.Dir = 1
                roll.axis = "x"
            end

            if keypress == "s" then
                roll.Dir = roll.Dir * -1
            end
        end
    end

    roll.update = function(dt, tank)
        roll.timer = roll.timer - dt

        if roll.steps == "shrink" then
            if roll.axis == "x" then
                if tank.scaleX <= 0.1 then
                    roll.steps = "dash"
                    roll.iTimer = roll.iFrames
                else
                    tank.scaleX = tank.scaleX - 10 * dt
                    tank.scaleY = tank.scaleY - 10 * dt
                end

            elseif roll.axis == "y" then
                if tank.scaleY <= 0.1 then
                    roll.steps = "dash"
                    roll.iTimer = roll.iFrames
                else
                    tank.scaleY = tank.scaleY - 10 * dt
                    tank.scaleX = tank.scaleX - 10 * dt
                end
            end

        elseif roll.steps == "dash" then
            roll.iTimer = roll.iTimer - dt

            if roll.axis == "x" then
                if roll.iTimer <= 0 then
                    roll.steps = "grow"
                else
                    tank.x = tank.x + 2 * roll.distance * dt * roll.Dir
                end

            elseif roll.axis == "y" then
                if roll.iTimer <= 0 then
                    roll.steps = "grow"
                else
                    tank.y = tank.y + 2 * roll.distance * dt * roll.Dir
                end
            end

        elseif roll.steps == "grow" then
            if roll.axis == "x" then
                if tank.scaleX >= 0.95 then
                    tank.scaleX = 1
                    tank.scaleY = 1
                    isRolling = false
                    roll.steps = "none"
                    roll.timer = roll.timeout
                else
                    tank.scaleX = tank.scaleX + 10 * dt
                    tank.scaleY = tank.scaleY + 10 * dt
                end

            elseif roll.axis == "y" then
                if tank.scaleY >= 0.95 then
                    tank.scaleY = 1
                    tank.scaleX = 1
                    isRolling = false
                    roll.steps = "none"
                    roll.timer = roll.timeout
                else
                    tank.scaleY = tank.scaleY + 10 * dt
                    tank.scaleX = tank.scaleX + 10 * dt
                end
            end
        end
    end

return roll