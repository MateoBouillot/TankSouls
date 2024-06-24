local background = {}
    background.img = love.graphics.newImage("img/bg/dirt.png")
    background.width = 10
    background.height = 6
    background.draw = function()
        for i = 1, background.width do
            for u = 1, background.height do
                love.graphics.draw(background.img, (i - 1) * 128, (u - 1) * 128)
            end
        end
    end

local scene = {}

local explosion = require("../mechanic/explosion")
local tank = require("../mechanic/tank")
local enemies = require("../mechanic/enemies")
local score = 0

function love.mousepressed(x, y, button)
    tank.createBullet(x, y)
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

scene.init = function(needInit)
    if not needInit then return end
    tank.init()
    explosion.init()
    enemies.init()
    score = 0
end

scene.update = function(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    tank.aim(mouseX, mouseY)

    if love.keyboard.isDown("d") then
        tank.rotate(dt, 1)
    elseif love.keyboard.isDown("q") then
        tank.rotate(dt, -1)
    end

    if love.keyboard.isDown("z") then
        tank.move(dt, 1)
    elseif love.keyboard.isDown("s") then
        tank.move(dt, -1)
    end
    
    tank.updateBullet(dt)
    enemies.Spawning(dt)
    enemies.update(dt)
    explosion.update(dt)

    for i = 1, #bullets do
        for e = 1, #enemyList do
            if CheckCollision(bullets[i].hitBox.x, bullets[i].hitBox.y, bullets[i].hitBox.W, bullets[i].hitBox.H,
            enemyList[e].hitBox.x, enemyList[e].hitBox.y, enemyList[e].hitBox.W, enemyList[e].hitBox.H) then
                local collisionX = (bullets[i].hitBox.x + enemyList[e].hitBox.x) * 0.5
                local collisionY = (bullets[i].hitBox.y + enemyList[e].hitBox.y) * 0.5
                explosion.create(collisionX, collisionY)
                score = score + 1
                table.remove(bullets, i)
                table.remove(enemyList, e)
                return
            end
        end
    end
end

scene.draw = function()
    background.draw()
    tank.drawBullet()
    tank.draw()
    enemies.draw()
    explosion.draw()
end

scene.keypressed = function(key)
    if key == "return" then
        changeScene("MENU")
    elseif key == "escape" then
        changeScene("PAUSE", { false, score })
    end
end

scene.unload = function()

end

return scene