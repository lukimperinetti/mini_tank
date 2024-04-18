local player = {}
player.image = love.graphics.newImage("src/images/tank.png")
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
player.speed = 50
player.vx = 0
player.vy = 0
player.angle = 0

function player.load()
    print("player loaded")
end

function player.update(dt)
    local prevX = player.x
    local prevY = player.y

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

    -- Calculate the angle of movement
    local dx = player.x - prevX
    local dy = player.y - prevY

    -- If there is movement ~= mean !=
    if dx ~= 0 or dy ~= 0 then
        local targetAngle = math.deg(math.atan2(dy, dx)) + 90
        local lerpFactor = 10 * dt -- Adjust this value to change the speed of rotation
        player.angle = player.angle + (targetAngle - player.angle) * lerpFactor
    end
end

function player.draw()
    love.graphics.draw(player.image, player.x, player.y, math.rad(player.angle), 1, 1, player.image:getWidth() / 2,
        player.image:getHeight() / 2)
end

return player
