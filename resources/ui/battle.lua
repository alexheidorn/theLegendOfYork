Battle = Object:extend()

function Battle:new()
    self.state = "battle"
    self.battleState = "playerTurn"
    self.player = Player(64, 64) -- starting position
    self.enemy = Enemy(200, 100, "log") -- enemy instance
    self.battleUI = BattleMenu()
    self.commands = {
        "Attack",
        "Defend",
        "Item",
        "Run"
    }
    self.selectedCommand = 1
end

function Battle:enterBattle()
    -- Initialize battle state
    -- lock camera to battle area
    -- lock player movement
    -- Set up player and enemy positions, health, etc.
    G.GAME_STATE = G.GAME_STATES.battle
    self.battleUI:open()
    self.battleState = "playerTurn"
    self.selectedCommand = 1
end

function Battle:exitBattle()
    -- Reset battle state
    G.GAME_STATE = G.GAME_STATES.gameplay
    self.battleState = "over"
    self.battleUI:close()
end

function Battle:load()
    -- Load battle assets, animations, etc.
    self.battleUI:load()
end
