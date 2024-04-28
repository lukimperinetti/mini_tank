local player = {}
player.image = love.graphics.newImage("src/images/tank.png")
player.x = love.graphics.getWidth() / 2
player.y = love.graphics.getHeight() / 2
player.speed = 50
player.vx = 0
player.vy = 0
player.angle = 0
-- Bullets
player.bullets = {}
player.bulletSpeed = 200
player.bulletImage = love.graphics.newImage("src/images/missile.png")

function player.load()
    print("player loaded")
end

function player.shoot()
    local bullet = {}
    bullet.x = player.x
    bullet.y = player.y
    bullet.angle = player.angle - 90
    table.insert(player.bullets, bullet)
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
    if love.keyboard.isDown("space") then
        player.shoot()
    end

    for i, bullet in ipairs(player.bullets) do
        bullet.x = bullet.x + player.bulletSpeed * dt * math.cos(math.rad(bullet.angle))
        bullet.y = bullet.y + player.bulletSpeed * dt * math.sin(math.rad(bullet.angle))
    end

    -- Calculate the angle of movement
    local dx = player.x - prevX
    local dy = player.y - prevY

    -- If there is movement
    if dx ~= 0 or dy ~= 0 then
        local targetAngle = (math.deg(math.atan2(dy, dx)) + 90) % 360
        if math.abs(targetAngle - player.angle) > 180 then
            if targetAngle > player.angle then
                targetAngle = targetAngle - 360
            else
                targetAngle = targetAngle + 360
            end
        end
        local lerpFactor = 10 * dt
        player.angle = player.angle + (targetAngle - player.angle) * lerpFactor
    end
end

function player.draw()
    love.graphics.draw(player.image, player.x, player.y, math.rad(player.angle), 1, 1, player.image:getWidth() / 2,
        player.image:getHeight() / 2)

    -- Draw the bullets
    for i, bullet in ipairs(player.bullets) do
        love.graphics.draw(player.bulletImage, bullet.x, bullet.y, math.rad(bullet.angle), 0.1, 0.1,
            player.bulletImage:getWidth() / 2, player.bulletImage:getHeight() / 2)
    end
end

return player
