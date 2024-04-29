-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

-- Returns the distance between two points
function math.dist(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 end

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
    ennemi.x = math.random(10, screenWidth - 10)
    ennemi.y = math.random(10, (screenHeight / 2) - 10)
    ennemi.state = TSTATE.NONE
    ennemi.vx = 0
    ennemi.vy = 0
    ennemi.angle = 0
    ennemi.speed = 1
end

-- Update ennemi state
function UpdateEnnemi(pEnnemi)
    local prevX = pEnnemi.x
    local prevY = pEnnemi.y

    if pEnnemi.state == TSTATE.NONE then
        pEnnemi.state = TSTATE.CHANGEDIR
    elseif pEnnemi.state == TSTATE.MOVE then
        local collide = false
        if pEnnemi.x < 0 then
            pEnnemi.x = 0
            collide = true
        end
        if pEnnemi.x > screenWidth then
            pEnnemi.x = screenWidth
            collide = true
        end
        if pEnnemi.y < 0 then
            pEnnemi.y = 0
            collide = true
        end
        if pEnnemi.y > screenHeight then
            pEnnemi.y = screenHeight
            collide = true
        end
        if collide then
            pEnnemi.state = TSTATE.CHANGEDIR
        end
    elseif pEnnemi.state == TSTATE.ATTACK then
    elseif pEnnemi.state == TSTATE.CHANGEDIR then
        local targetX = math.random(10, screenWidth - 10)
        local targetY = math.random(10, screenHeight - 10)
        local angle = math.angle(pEnnemi.x, pEnnemi.y, targetX, targetY)
        pEnnemi.vx = pEnnemi.speed * 60 * math.cos(angle)
        pEnnemi.vy = pEnnemi.speed * 60 * math.sin(angle)
        pEnnemi.state = TSTATE.MOVE

        -- difference between the target angle and the current angle
        local dx = targetX - pEnnemi.x
        local dy = targetY - pEnnemi.y

        if dx ~= 0 or dy ~= 0 then
            local targetAngle = (math.deg(math.atan2(dy, dx)) + 270) % 360
            if math.abs(targetAngle - pEnnemi.angle) > 180 then -- if the angle is greater than 180 degrees to ensure the shortest path
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
    -- Check if the player is off the screen and if so, revert the position
    if ennemi.x < 0 or ennemi.x > love.graphics.getWidth() or ennemi.y < 0 or ennemi.y > love.graphics.getHeight() then
        ennemi.x = prevX
        ennemi.y = prevY
    end
end

function ennemi.load()
    print("ennemi loaded")
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    CreateEnnemi()
end

function ennemi.update(dt)
    UpdateEnnemi(ennemi)
    ennemi.x = ennemi.x + ennemi.vx * dt
    ennemi.y = ennemi.y + ennemi.vy * dt
end

function ennemi.draw()
    love.graphics.draw(ennemi.image, ennemi.x, ennemi.y, math.rad(ennemi.angle), 1, 1, ennemi.image:getWidth(),
        ennemi.image:getHeight())
end

return ennemi
