
local scene = {}

scene.init = function()

end

scene.update = function(dt)

end

scene.draw = function()
    love.graphics.print("menu", 200, 200)
end

scene.keypressed = function(key)
    if key == "return" then
        changeScene("GAME", { true })
    end
end

scene.unload = function()

end


return scene