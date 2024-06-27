local scene = {}



scene.init = function(values)
end

scene.update = function(dt)

end

scene.draw = function()
    love.graphics.print("pause", 200, 200)
end

scene.keypressed = function(key)
    if key == "escape" then
        changeScene("GAME")
    end
end

scene.unload = function()

end


return scene