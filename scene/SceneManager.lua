local scenes = {}
scenes.GAME = require("/scene/GameScene")
scenes.MENU = require("/scene/MenuScenes/MenuScene")
scenes.PAUSE = require("/scene/PauseScene")
scenes.ABTUTO = require("/scene/MenuScenes/tutoAbilitiesScene")
scenes.CANONTUTO = require("/scene/MenuScenes/tutoCannonsScene")

currentScene = scenes.MENU

function changeScene(key, value)
    if currentScene ~= nil then
        currentScene.unload()
    end
    currentScene = scenes[key]
    print(value)
    currentScene.init(value)
end

function updateCurrentScene(dt)
    if currentScene == nil then return end
    currentScene.update(dt)
end

function drawCurrentScene()
    if currentScene == nil then return end
    currentScene.draw()
end

function keypressedCurrentScene(key)
    if currentScene == nil then return end
    currentScene.keypressed(key)
end