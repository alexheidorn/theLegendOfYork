-- spritesheets
G.animation_atli = {
    player = {name = "player", hitboxWidth = 12, hitboxHeight = 21,
        path = "assets/Zelda-like/character.png", spriteWidth = 16, spriteHeight = 32,
        animations = {
            -- animation frame info for each state
            idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
            down = { row = 1, frameCount = 4, loop = true },
            right = { row = 2, frameCount = 4, loop = true },
            up = { row = 3, frameCount = 4, loop = true },
            left = { row = 4, frameCount = 4, loop = true},

            -- walk
            -- attack
        }
    },
    log = {name = "log", hitboxWidth = 32, hitboxHeight = 32,
        path = "assets/Zelda-like/log.png", spriteWidth = 32, spriteHeight = 32,
        animations = {
            idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
            patrolling = { row = 1, frameCount = 4, loop = true },
        }
    },
}

-- items
G.items = {
    sword = {name = "sword", path = "assets/items/sword.png", spriteWidth = 16, spriteHeight = 16,
        animations = {
            idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
            attack = { row = 1, frameCount = 4, loop = true },
        }
    },
    shield = {name = "shield", path = "assets/items/shield.png", spriteWidth = 16, spriteHeight = 16,
        animations = {
            idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
            block = { row = 1, frameCount = 4, loop = true },
        }
    },
}

-- tilesets
G.asset_atlas = {
    lab = {name = "lab", path = "assets/tilesets/Untitled.png", tileSize = 32, 
        quadData = {
            {' ', 0, 0},
            {'*', 0, 32},
            {'<', 32, 32},
            {'^', 64, 32},
            {'~', 128, 0},
        },
        solidTiles = {
            ['*'] = true,
            ['<'] = true,
            ['^'] = true,
            ['~'] = true
        },
        data = love.filesystem.read('assets/maps/map.txt')
    },
    {name = "overworld", path = "assets/Zelda-like/Overworld.png", pwidth = 32, pheight = 32},
    {name = "inside", path = "assets/Zelda-like/Inner.png", pwidth = 16, pheight = 16},
}

-- fonts
G.fonts = {
    temp = love.graphics.newFont(G.scale * 15),
    temp2 = love.graphics.newFont(G.scale * 20),
    temp3 = love.graphics.newFont(G.scale * 25),
    -- main = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- title = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- pause = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- battle = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- dialogue = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- inventory = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
    -- map = love.graphics.newFont("assets/fonts/PressStart2P.ttf", 16),
}

-- populate entries in the global asset atlas

-- for _, atlas in pairs(G.asset_atlas) do
--     local atlasName = atlas.name
--     local atlasPath = atlas.path
--     local atlasTileSize = atlas.tileSize
--     local atlasQuadData = atlas.quadData
--     local atlasSolidTiles = atlas.solidTiles
--     local atlasData = atlas.data

--     G.ASSET_ATLAS[atlasName] = {
--         name = atlasName,
--         path = atlasPath,
--         tileSize = atlasTileSize,
--         quadData = {},
--         solidTiles = atlasSolidTiles,
--         data = atlasData
--     }

--     for _, info in ipairs(atlasQuadData) do
--         -- info[1] = char, info[2] = x, info[3] = y
--         G.ASSET_ATLAS[atlasName].quadData[info[1]] = love.graphics.newQuad(info[2], info[3], atlasTileSize, atlasTileSize, atlasTileSize, atlasTileSize)
--     end
-- end