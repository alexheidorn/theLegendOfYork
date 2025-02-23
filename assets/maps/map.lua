local tileset = [[
***************xxxxxxxxxxxxxxxxxxxxxxxx
*             *xxxxxxxxxxxxxxxxxxxxxxxx
*   closet    *xxxxxxxxxxxxxxxxxxxxxxxx
*             *xxxxxxxxxxxxxxxxxxxxxxxx
*****     *************xxxxxxxxxxxxxxxx
*                     ************xxxxx
*   landing area      <       <  *xxxxx
*                     ******     *xxxxx
*     ****************     *  ^  *xxxxx
*     *                    *     *xxxxx
*     ************     *****  ^  ******
*                 *     *             *
*   Basement      *******    Slide    *
*                            Room     *
*                 *******             *
*                 *     *             *
*     ************     ****************
*     *                      *    *
*     ************     ***** *    ******
*                 ***** *              *
*    Troll                  Guest      *
*    Room         ***** *   Room       *
*                 *     *              *
*******************     ****************
]]

-- lab tilset
local labQuadInfo = {
    {' ', 0, 0},
    {'*', 0, 32},
    {'<', 32, 32},
    {'^', 64, 32}
}

CreateMap(32, 32, 'assets/tilesets/lab.png', labQuadInfo, tileset)