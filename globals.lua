-- Globals

function Game:setGlobals()
    self.CAM = nil
    self.scale = 1
    self.vertical = false

    --||||||||||||||||||||||||||||||
    --          INSTANCES
    --||||||||||||||||||||||||||||||
    self.ANIMATION_ATLAS = {}
    self.ASSET_ATLAS = {}
    self.MOVEABLES = {}
    self.ANIMATIONS = {}
    self.DRAW_HASH = {}

    self.GAME_STATES = {
        title_screen = 0,
        gameplay = 1,
        paused = 2,
        inventory = 3,
        map = 4,
        dialogue = 5,
        battle = 6,
        cutscene = 7,
    }
    self.GAME_STATE = self.GAME_STATES.title_screen

    self.CURRENT_MAP = nil

end

G = Game()