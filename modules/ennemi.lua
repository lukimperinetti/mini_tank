-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

-- Returns the distance between two points
function math.dist(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 end

local player = require('modules.player')

local ennemi = {}

-- State machine ennemi
local TSTATE = {}
TSTATE.NONE = ""
TSTATE.MOVE = "move"
TSTATE.ATTACK = "attack"
TSTATE.SHOT = "shot"
TSTATE.CHANGEDIR = "changedir"
TSTATE.DIE = "die"

-- Create ennemi
function CreateEnnemi()
    ennemi.image = love.graphics.newImage("src/images/ennemi.png")
    ennemi.x = math.random(10 * ennemi.image:getWidth(), love.graphics.getWidth() - 10 * ennemi.image:getWidth())
    ennemi.y = math.random(10 * ennemi.image:getHeight(), love.graphics.getHeight() - 10 * ennemi.image:getHeight())
    ennemi.state = TSTATE.NONE
    ennemi.vx = 0
    ennemi.vy = 0
    ennemi.angle = 0
    ennemi.speed = 1

    ennemi.bullets = {}
    ennemi.bulletSpeed = 200
    ennemi.bulletImage = love.graphics.newImage("src/images/missile.png")
end

-- Function to shoot a bullets
function ennemi.shoot()
    local dx = player.x - ennemi.x
    local dy = player.y - ennemi.y
    local angle = math.atan2(dy, dx)

    table.insert(ennemi.bullets, { x = ennemi.x, y = ennemi.y, angle = angle })
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

-- Update ennemi state
function UpdateEnnemi(pEnnemi)
    local prevX = pEnnemi.x
    local prevY = pEnnemi.y

    if pEnnemi.state == TSTATE.NONE then
        pEnnemi.state = TSTATE.CHANGEDIR
    elseif pEnnemi.state == TSTATE.MOVE then
        local collide = false
        -- Add collision logic as needed

        if math.dist(pEnnemi.x, pEnnemi.y, player.x, player.y) < 350 then
            pEnnemi.state = TSTATE.ATTACK
            ennemi.shoot()
        end
    elseif pEnnemi.state == TSTATE.ATTACK then
        if math.dist(pEnnemi.x, pEnnemi.y, player.x, player.y) > 350 then
            pEnnemi.state = TSTATE.CHANGEDIR
        end
    elseif pEnnemi.state == TSTATE.CHANGEDIR then
        local targetX = math.random(10, love.graphics.getWidth() - 10)
        local targetY = math.random(10, love.graphics.getHeight() - 10)
        local angle = math.angle(pEnnemi.x, pEnnemi.y, targetX, targetY)
        pEnnemi.vx = pEnnemi.speed * 60 * math.cos(angle)
        pEnnemi.vy = pEnnemi.speed * 60 * math.sin(angle)
        pEnnemi.state = TSTATE.MOVE

        -- Check if the ennemi is off the screen and if so, revert the position
        if ennemi.x < 0 or ennemi.x > love.graphics.getWidth() or ennemi.y < 0 or ennemi.y > love.graphics.getHeight() then
            ennemi.x = prevX
            ennemi.y = prevY
        end
        -- difference between the target angle and the current angle
        local dx = targetX - pEnnemi.x
        local dy = targetY - pEnnemi.y

        if dx ~= 0 or dy ~= 0 then
            local targetAngle = (math.deg(math.atan2(dy, dx)) + 270) % 360
            if math.abs(targetAngle - pEnnemi.angle) > 180 then
                if targetAngle > pEnnemi.angle then
                    targetAngle = targetAngle - 360
                else
                    targetAngle = targetAngle + 360
                end
            end
            local lerpFactor = 10 * 0.1 -- to make the rotation smooth
            pEnnemi.angle = pEnnemi.angle + (targetAngle - pEnnemi.angle) * lerpFactor
        end
    end
end

function ennemi.load()
    print("ennemi loaded")
    CreateEnnemi()
end

function ennemi.update(dt)
    UpdateEnnemi(ennemi)

    -- Limiter les déplacements de l'ennemi à l'intérieur de l'écran
    local minX = 0
    local maxX = love.graphics.getWidth() - ennemi.image:getWidth()
    local minY = 0
    local maxY = love.graphics.getHeight() - ennemi.image:getHeight()

    ennemi.x = math.max(minX, math.min(ennemi.x + ennemi.vx * dt, maxX))
    ennemi.y = math.max(minY, math.min(ennemi.y + ennemi.vy * dt, maxY))

    -- Check if the ennemi touches the screen edges
    if ennemi.x <= minX or ennemi.x >= maxX or ennemi.y <= minY or ennemi.y >= maxY then
        ennemi.state = TSTATE.CHANGEDIR
    end

    -- Check collision with player bullets
    if ennemi.checkCollision(ennemi.x, ennemi.y, ennemi.image:getWidth(), ennemi.image:getHeight()) then
        player.score = player.score + 1 -- Increase player score
        -- Additional logic if needed after collision
    end

    for i, bullet in ipairs(ennemi.bullets) do
        bullet.x = bullet.x + ennemi.bulletSpeed * dt * math.cos(bullet.angle)
        bullet.y = bullet.y + ennemi.bulletSpeed * dt * math.sin(bullet.angle)
    end
end

function ennemi.draw()
    love.graphics.draw(ennemi.image, ennemi.x, ennemi.y, math.rad(ennemi.angle), 1, 1, ennemi.image:getWidth(),
        ennemi.image:getHeight())

    -- Draw the bullets
    for i, bullet in ipairs(ennemi.bullets) do
        love.graphics.draw(ennemi.bulletImage, bullet.x, bullet.y, math.rad(bullet.angle), 0.1, 0.1,
            ennemi.bulletImage:getWidth() / 2, ennemi.bulletImage:getHeight() / 2)
    end
end

return ennemi
