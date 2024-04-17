local player = {}
player.image = love.graphics.newImage("src/images/tank.png")
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
player.speed = 50
player.vx = 0
player.vy = 0

function player.load()
    print("player loaded")
end

function player.update(dt)
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("q") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("z") then
        player.y = player.y - player.speed * dt
    end
end

function player.draw()
    love.graphics.draw(player.image, player.x, player.y)
end

print("player")

return player
