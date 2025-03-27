-- Globals

function Game:setGlobals()
    Cam = Camera()

    --||||||||||||||||||||||||||||||
    --          INSTANCES
    --||||||||||||||||||||||||||||||
    self.ANIMATION_ATLAS = {}
    self.ASSET_ATLAS = {}
    self.MOVEABLES = {}
    self.ANIMATIONS = {}
    self.DRAW_HASH = {}

    self.GAME_STATE = {
        start = 0,
        menu = 2,
        GAMEPLAY = 1,
        PAUSE = 3,
    }

end

G = Game()