local sceneGameplay = {}

local scenesManager = require('scenes.scenesManager')

local player = require('modules.player')
local ennemi = require('modules.ennemi')
local bgImage

function sceneGameplay.load()
    player.load()
    ennemi.load()

    bgImage = love.graphics.newImage('src/images/Grass_Sample.png')
    bgImageScaleX = 1240 / bgImage:getWidth()
    bgImageScaleY = 700 / bgImage:getHeight()
end

function sceneGameplay.update(dt)
    player.update(dt)
    ennemi.update(dt)

    -- Function to check collision between bullet and enemy
    function player.checkCollision(x, y, width, height)
        for i, bullet in ipairs(ennemi.bullets) do
            if bullet.x > x and bullet.x < x + width and
                bullet.y > y and bullet.y < y + height then
                table.remove(ennemi.bullets, i) -- Remove the colliding bullet
                return true
            end
        end
        return false
    end

    -- Check collision with player bullets
    if player.checkCollision(player.x, player.y, player.image:getWidth(), player.image:getHeight()) then
        ennemi.score = ennemi.score + 1 -- Increase ennemi score
    end

    -- Function to check collision between bullet and enemy
    function ennemi.checkCollision(x, y, width, height)
        for i, bullet in ipairs(player.bullets) do
            if bullet.x > x and bullet.x < x + width and
                bullet.y > y and bullet.y < y + height then
                table.remove(player.bullets, i) -- Remove the colliding bullet
                return true
            end
        end
        return false
    end

    -- Check collision with player bullets
    if ennemi.checkCollision(ennemi.x, ennemi.y, ennemi.image:getWidth(), ennemi.image:getHeight()) then
        player.score = player.score + 1 -- Increase player score
    end

    -- Check if player or ennemi has reached the score limit
    if player.score >= 10 or ennemi.score >= 10 then
        scenesManager.changeScene('GameOver')
    end

end

function sceneGameplay.draw()
    love.graphics.draw(bgImage, 0, 0, 0, bgImageScaleX, bgImageScaleY)
    love.graphics.print('Your Score:  ' .. player.score, 10, 10)
    love.graphics.print('Enemy score:  ' .. ennemi.score, 10, 30)
    player.draw()
    ennemi.draw()
end

function sceneGameplay.keypressed(key)
    if key == "p" then
        scenesManager.changeScene('paused')
    end
    if key == "escape" then
        love.event.quit()
    end
end

return sceneGameplay
