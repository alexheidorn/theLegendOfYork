-- lab tileset
local labQuadInfo = {
    {' ', 0, 0},
    {'*', 0, 32},
    {'<', 32, 32},
    {'^', 64, 32},
    {'~', 128, 0},
}
local mapTxtFile = love.filesystem.read('assets/maps/map.txt')
CreateMap(32, 32, 'assets/tilesets/Untitled.png', labQuadInfo, mapTxtFile)