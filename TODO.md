## TODO

- [x] Add camera
    - [x] zoom camera
        - [ ] now make it less grainy??
    - [ ] camera stops moving when out of bounds
    - [ ] remove camera functions from G:update()
    - [?] fix tiles jittering when camera moves

- [ ] fix enemy movement
    - [x] fix enemies move back & forth
        - [x] fix enemy switch direction when hit a wall
    - [ ] add more types of enemy movement
    - [ ] add enemy pathfinding on tileset

- [x] Add collision
    - [x] fix collision - define solid tiles in map or tileset
    - [ ] add enemy collision with player
    - [x] fix collision with height/width of entity
        - [ ] create hitbox with rounded corners?

- [ ] change map tileset to Zelda-like
- [x] Put map creation in a separate file

- [x] implement asset atlas
    - [ ] clean asset atlas?? idk, it doesn't look nice rn lol


- [x] update player animations for all directions
    - [ ] fix swap to idle animation when not moving
    - [ ] finishing playing walk cycle before switching to idle 

- [x] fix map drawing extra tile at the end of each row

- [x] create keybinds for input
    - [x] remove player movement from input handling function
        - [x] just return the action that is pressed?    
    - [x] only check for "is pressed" when a key is pressed when in menu's

- [ ] UI
    - [x] create pause menu
        - [ ] & settings
        - [ ] add save/load game option
    - [ ] create game over screen
    - [x] create title screen
        - [ ] create fade transition out of titlescreen
        - [ ] add options on titlescreen
        - [ ] fix jump when transitioning to gameplay
    - [ ] create fonts atlas for UI
        - [ ] implement fonts in title screen & pause menu

- [ ] create map editor

- [ ] create inventory
    - [ ] create item system

- [ ] game state system
    - [ ] create game state machine
        - [ ] in battle
        - [ ] in menu
        - [ ] on title screen
        - [ ] 
    - [ ] create dialogue system
        - [ ] in dialogue
    - [ ] smooth out game state checks in code, ie remove all of the if statemenst in the update & draw functions

- [ ] create battle system
    - [ ] Chronotrigger/Sea of Stars-like battle system with turn based battles IN overworld (no screne transitions)
        - [ ] draw battle UI on top of map
    - [ ] OR action rpg like battle system
        - [ ] ie, Xenoblade Chronicles / ffvii remake style

    
- [ ] create save system

- [ ] create music & sound system

- [ ] reorganize code into modules for better organization
    - ie, fix file structure
    - [ ] create characters module for player & enemies
        - [ ] create sprite & animations file, collision/hitbox/physics file, battle file
                - [ ] battle file: stats, abilities, equipment, etc
            - [ ] (for player) inventory file, 
