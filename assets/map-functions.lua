local tileTable

function drawMap()
    for rowIndex = 1, #tileTable do
        local row = tileTable[rowIndex]
        for columnIndex = 1, #row do
          local number = row[columnIndex]
          local quad = quads[number]
          local x, y = (columnIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight
          love.graphics.draw(Tileset, quad, x, y)
        end
    end
end