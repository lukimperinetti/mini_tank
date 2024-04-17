local ennemi = {}
-- ennemi.image = love.graphics.newImage("src/images/tank.png")
ennemi.x = math.random(0, love.graphics.getWidth())
ennemi.y = math.random(0, love.graphics.getHeight())
ennemi.speed = 50
ennemi.vx = 0
ennemi.vy = 0

function ennemi.load()
    print("ennemi loaded")
end

function ennemi.update(dt)
end

function ennemi.draw()
end

return ennemi
