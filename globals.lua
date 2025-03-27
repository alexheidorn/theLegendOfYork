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
        main_menu = 0,
        gameplay = 1,
        pause = 2,
        inventory = 3,
        map = 4,
    }

end

G = Game()