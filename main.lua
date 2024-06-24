love.window.setMode(1280, 768)

require("/scene/SceneManager")

function love.load()
end

function love.update(dt)   
    updateCurrentScene(dt)
end

function love.draw()
    drawCurrentScene()
end

function love.keypressed(key)
    keypressedCurrentScene(key)
end
