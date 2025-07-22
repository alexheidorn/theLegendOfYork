-- main.lua
Object = require 'lib/classic'

require 'game'
require 'globals'
require 'save'
require 'resources/ui/pause'
require 'resources/ui/titlescreen'
require 'resources/ui/fileselect'
require 'assets/sprites'
require 'lib/input'
require 'lib/animation'
require 'lib/cam'
require 'resources/map'
require 'resources/entity'
require 'resources/player'
require 'resources/enemy'

function love.load()
    Game:load()
end

function love.update(dt) 
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.quit()
    return false
end

