local tileTable, tileset, tileWidth, tileHeight, quads, quad

function loadMap(path)
    tileTable = {}
    local file = love.filesystem.newFile(path)
    for line in file:lines() do
      table.insert(tileTable, line)
    end
    file:close()
end


function drawMap()
    for rowIndex = 1, #tileTable do
        local row = tileTable[rowIndex]
        for columnIndex = 1, #row do
          local number = row[columnIndex]
          local quad = quads[number]
          local x, y = (columnIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight
          love.graphics.draw(tileset, quad, x, y)
        end
    end
end