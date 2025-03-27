-- spritesheets
G.animation_atli = {
    player = {name = "player", path = "assets/Zelda-like/character.png", pixelWidth = 16, pixelHeight = 32,
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
    log = {name = "log", path = "assets/Zelda-like/log.png", pixelWidth = 32, pixelHeight = 32,
        animations = {
            idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
            patrolling = { row = 1, frameCount = 4, loop = true },
        }
    },
}
-- tilesets
G.asset_atlas = {
    {name = "lab", path = "assets/tilesets/Untitled.png", pwidth = 32, pheight = 32},
    {name = "overworld", path = "assets/Zelda-like/Overworld.png", pwidth = 32, pheight = 32},
    {name = "inside", path = "assets/Zelda-like/Inner.png", pwidth = 16, pheight = 16},
}

-- populate entries in the global asset atlas
