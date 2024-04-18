-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2) return math.atan2(y2 - y1, x2 - x1) end

-- Returns the distance between two points
function math.dist(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5 end

local ennemi = {}

-- State machine ennemi
local TSTATE = {}
TSTATE.NONE = ""
TSTATE.WALK = "move"
TSTATE.ATTACK = "attack"
TSTATE.BITE = "shot"
TSTATE.CHANGEDIR = "changedir"


-- Create ennemi
function CreateEnnemis()
    ennemi.image = love.graphics.newImage("src/images/ennemi.png")
    ennemi.x = math.random(10, screenWidth - 10)
    ennemi.y = math.random(10, (screenHeight / 2) - 10)

    ennemi.speed = 50
    ennemi.vx = 0
    ennemi.vy = 0

    ennemi.state = TSTATE.NONE
end

function ennemi.load()
    print("ennemi loaded")
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    CreateEnnemis()
end

function ennemi.update(dt)

end

function ennemi.draw()
    love.graphics.draw(ennemi.image, ennemi.x, ennemi.y)
end

return ennemi
