local scenesManager = {}

local allScenes = {}
local currentScene = {}

-- liste scene

-- Nom de la seine | adresse

function scenesManager.addScenes(name, module)
    local ref = require(module)
    ref.loaded = false
    allScenes[name] = ref
end

function scenesManager.changeScene(name)
    currentScene = allScenes[name]
    if currentScene.load and not currentScene.loaded then
        currentScene.load()
        currentScene.loaded = true
    end
end

function scenesManager.update(dt)
    currentScene.update(dt)
end

function scenesManager.draw()
    currentScene.draw()
end

function scenesManager.keypressed(key)
    currentScene.keypressed(key)
end

return scenesManager
