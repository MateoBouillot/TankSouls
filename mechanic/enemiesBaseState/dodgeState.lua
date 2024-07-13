local dodgeState = function (dt, enemy)
    if enemy.dodging <= 0 then
        enemy.specifics.state = "attack"
    else
        enemy.dodging = enemy.dodging - dt

        enemy.rot = enemy.dodgeAngle

        enemy.x = enemy.x - enemy.specifics.speed * math.cos(enemy.rot) * dt
        enemy.y = enemy.y - enemy.specifics.speed * math.sin(enemy.rot) * dt
    end
end

return dodgeState