local chopper = love.graphics.newImage("assets/pictureAttackChoppers_thumb.png")

local frameInfo = {
	{ 1, 0, 0 },
	{ 2, 128, 0 },
	{ 3, 0, 64 },		
	{ 4, 128, 64 },
	{ 5, 0, 128 },
	{ 6, 128, 128 },

}

return CreateSprite(128, 64, "assets/spritesheets/pictureAttackChoppers.png", frameInfo)