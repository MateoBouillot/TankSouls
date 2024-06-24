local scene = {}

local score = 0

scene.init = function(values)
    score = values[2]
end

scene.update = function(dt)

end

scene.draw = function()
    love.graphics.print("pause", 200, 200)
    love.graphics.print("Votre score est " ..score.. " kills", 200, 150)
end

scene.keypressed = function(key)
    if key == "escape" then
        changeScene("GAME")
    end
end

scene.unload = function()

end


return scene