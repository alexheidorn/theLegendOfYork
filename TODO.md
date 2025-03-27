## TODO

- [x] Add camera
    - [ ] zoom camera
    - [x] camera stops moving when out of bounds
    - [ ] remove camera functions from G:update()
    - [ ] fix tiles jittering when camera moves

- [ ] fix enemy movement
    - [x] fix enemies move back & forth
        - [ ] fix enemy switch direction when hit a wall
    - [ ] add more types of enemy movement
    - [ ] add enemy pathfinding on tileset

- [x] Add collision
    - [x] fix collision - define solid tiles in map or tileset
    - [ ] add enemy collision with player
    - [x] fix collision with height/width of entity
        - [ ] create hitbox with rounded corners?

- [ ] change map tileset to Zelda-like
- [ ] Put map creation in a separate file
- [ ] implement asset atlas
- [x] update player animations for all directions
    - [ ] fix swap to idle animation when not moving
    - [ ] finishing playing walk cycle before switching to idle 

- [x] fix map drawing extra tile at the end of each row
