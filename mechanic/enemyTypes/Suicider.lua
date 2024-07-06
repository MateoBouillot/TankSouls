local suiciderImg = {}
    suiciderImg.tnt = love.graphics.newImage("/img/enemies/small suicider/tnt.png")
    suiciderImg.body = love.graphics.newImage("/img/enemies/small suicider/smallEnemyBody.png")

local offset = {}
    offset.bodyX = suiciderImg.body:getWidth() * 0.5
    offset.bodyY = suiciderImg.body:getHeight() * 0.5
    offset.tntX = suiciderImg.tnt:getWidth() * 0.5
    offset.tntY = suiciderImg.tnt:getHeight() * 0.5

local suicider = {}

    suicider.spawn = function()
        local enemyType = {}
            enemyType.type = "suicider"
            enemyType.body = suiciderImg.body
            enemyType.armament = suiciderImg.tnt
            enemyType.speed = 200
            enemyType.state = "spawning"
        return enemyType
    end
return suicider
