/* Final Project
* Alex Heidorn
* Description: This my version of our group's final project. It needs the items.csv and rooms.csv files to run properly, otherwise an 
* error will be returned.
*/

#include <iostream>
#include <iomanip>
#include <algorithm>
#include <fstream>
#include <sstream>
using namespace std;

//class to hold Item data
class Items {
private:
    string name;
    string description;
    bool inInventory;
    int coordX = -1;
    int coordY = -1;
public:
    //default ctor
    Items() {
        name = "None";
        description = "None";
    }
    //member methods
    int isItem(Items item[], int playerX, int playerY, int loc[]);
    //void listItemsInRoom(Items arr[], int playerX, int playerY);
    void input(string line);
    void grab(Items arr[], int playerX, int playerY, int itemLoc[]);
    //for use function
    void consume();
    void use(Items item[], int playerX, int playerY, int& hp, int& win);

    //accessor functions
    string getName() { return name; }
    string getDesc() { return description; }
    bool getInv() { return inInventory; }
    int getX() { return coordX; }
    int getY() { return coordY; }
    //mutator functions
    void setName(string n) { name = n; }
    void setDesc(string d) { description = d; }
    void setInv(bool i) { inInventory = i; }
    void setX(int x) { coordX = x; }
    void setY(int y) { coordY = y; }
};

//class to hold Room data
class Rooms {
private:
    string name;
    string description;
    int coordX = -1;
    int coordY = -1;
public:
    //default ctor
    Rooms() {
        name = "None";
        description = "None";
    }
    //member methods
    void displayRoom(Rooms room[], int x, int y, Items item[], int itemLoc[]);
    void input(string line);
    //accessor functions
    string getName() { return name; }
    string getDesc() { return description; }
    int getX() { return coordX; }
    int getY() { return coordY; }
    //mutator functions
    void setName(string n) { name = n; }
    void setDesc(string d) { description = d; }
    void setX(int x) { coordX = x; }
    void setY(int y) { coordY = y; }
};

// Monster struct to hold information about the monster
struct Monster {
    string name;
    int health;
};

//Functions
//booleans
bool initializeRooms(Rooms arr[]);
bool initializeItems(Items arr[]);
bool to_bool(string str);
bool menu(int& win);

//voids
void displayInventory(Items arr[]);
void help();
void map();
void ending(int& win);
void fight(int x, int y, Monster& Gretchen, Items item[], string adj, int& hp);
//integers
int gameplay(bool& game, int& win, Rooms room[], Items item[], int itemLocation[]);
int x_location(int x, int y);
int y_location(int y);
int secret();
//strings
string descriptor(int adj_num);


//Main function
int main()
{
    //Class variables/initializiation
    Rooms room[7]; //array of room objects
    Items item[10]; //array of item objects
    int itemLocation[10] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }; //stores index of items that share player location
    bool roomInt = initializeRooms(room); //checks if the rooms have been properly initialized
    bool itemInt = initializeItems(item); //checks if the items have been properly initialized
    if ((!roomInt) || (!itemInt)) { return -1; } //if the files aren’t found, ends the program

    //bools that determine gamestate should be running
    bool game;
    int win = 0;

    //Program Start
    game = menu(win);

    //Gameplay
    if (game) { win = gameplay(game, win, room, item, itemLocation); }

    ending(win);
    
    return 0;
}


//Function Definitions
// Functions in main:
//task: populates room array
bool initializeRooms(Rooms arr[]) {
    ifstream rooms;
    string line;
    int i = 0;
    rooms.open("rooms.csv");
    if (rooms.is_open()) {
        while (getline(rooms, line)) {
            arr[i].input(line);
            i++;
        }
        rooms.close();
        return true;
    }
    else {
        cout << "'rooms' file not found" << endl;
        return false;
    }
}
//task: populates item array
bool initializeItems(Items arr[]) {
    ifstream items;
    string line;
    int i = 0;
    items.open("items.csv");
    if (items.is_open()) {
        while (getline(items, line)) {
            arr[i].input(line);
            i++;
        }
        items.close();
        return true;
    }
    else {
        cout << "'items' file not found" << endl;
        return false;
    }
}

bool menu(int& win) {
    while (true){
        int select = 0;
        cout << "~*~*~*~*~*~*~*Welcome to York*~*~*~*~*~*~*~" << endl
            << "You take on the role of john hero, the CEO" << endl
            << "of heroes. You've been hired to enter a " << endl
            << "dungeon and take out the troll Gretchen!" << endl
            << "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~" << endl;
        cout << "1) start game" << endl
            << "2) view map" << endl
            << "3) view commands" << endl
            << "4) exit :(" << endl
            << "enter a number: ";
        cin >> select;
        switch (select)
        {
        case 1:
            return true;

        case 2:
            map();
            break;

        case 3:
            help();
            break;

        case 4:
            win = 5;
            return false;

        default:
            cout << "That's not one of the options >:(\n";
        }
    }
}
int gameplay(bool& game, int& win, Rooms room[], Items item[], int itemLocation[]) {
    //rng for damage & name
    srand(time(0));
    //sets up gretchen with random descriptor
    int adj_num = rand() % 5;
    string adj = descriptor(adj_num);
    Monster Gretchen = { "Gretchen the ", 100 };
    string input;
    //sets player starting position (Closet) and stats
    int x = 0;
    int y = 3;
    int hp = 50;

    //we need to display room immediately
    room->displayRoom(room, x, y, item, itemLocation);

    while(game && (win==0)){
        cout << endl << "What is your command? (type 'help' for  list of commands): ";
        cin >> input;
        if (input == "north" || input == "south" || input == "west" || input == "east")
        {
            if (input == "north") { y++; }
            if (input == "south") { y--; }
            if (input == "east") { x++; }
            if (input == "west") { x--; }
            x = x_location(x, y);
            y = y_location(y);
            room->displayRoom(room, x, y, item, itemLocation);
        }
        else if (input == "help") { help(); }
        else if (input == "look") { room->displayRoom(room, x, y, item, itemLocation); }
        else if (input == "muero") { //spanish for I die, This is a lil bit of a josh on the player
            cout << "PRANKED XD\n";
            return 5; //returns 5 to int "win" - silly fake ending for exiting the game
        }
        else if (input == "inventory") { displayInventory(item); }
        else if (input == "map") { map(); }
        else if (input == "grab") { item->grab(item, x, y, itemLocation); }
        else if (input == "use") { item->use(item, x, y, hp, win); }
        else if (input == "attack") { fight(x,y,Gretchen,item,adj,hp); }
        else { cout << "I don't understand " << input << ". Please Try again"; }

        //Post input processes
        //player dies & returns 1 for int "win" & plays 1st ending
        if (hp <= 0) { return 1; } 
        //player kills Gretchen and returns 2 for int "win" & plays 2nd ending
        if (Gretchen.health <= 0) { return 2; }  
        
        //if (x == 1 && y == 0) { hp -= troll_attack(Gretchen.name, adj); }
    }

}


//text for all possible endings
void ending(int& win)
{
    switch (win) {
    case 1:
        cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl
            << "You have failed to take out  the troll ;)" << endl
            << "            GAME OVER                   " << endl
            << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
        break;
    case 2:
        cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl
            << "      You have killed Gretchen :(" << endl
            << "               YOU WIN?                 " << endl
            << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
        break;
    case 3:
        cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl
            << "        You are a horrible hero" << endl
            << "               GAME OVER                 " << endl
            << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
        break;
    case 4:
        cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl
            << "     You live happily ever after" << endl
            << "               YOU WIN!                 " << endl
            << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
        break;
    case 5:
        cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl
            << "     You have cast the death spell" << endl
            << "              GAME OVER                 " << endl
            << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
        break;
    }
}
//secret ending text ;)
int secret()
{
    string vows;
    cout << "Flash forward five years its your wedding day." << endl
        << "Before you stands your bride in an ornate and " << endl
        << "flowing dress. The officiant clears their throat" << endl
        << "'We are all gathered here to celebrate the most" << endl
        << "holy matrimony of this beautiful couple before us today." << endl
        << "Do you john hero CEO of heroes take Gretchen to be" << endl
        << "your lawfully wedded wife in both sickness and in health?'" << endl
        << "YOU SAY (use an underscore for a space): ";
    cin >> vows;
    if (vows != "i_do" && vows != "I_do")
    {
        cout << "Shocked and stunned the whole audience gasps." << endl
            << "As chaos begins to stir you look across at Gretchen." << endl
            << "Tears begin to trickle down both your faces as" << endl
            << "She pulls out the legendary battle axe of york" << endl
            << "weighing nearly a ton and deftly swings it as if it" << endl
            << "was a stick off the ground and splits you in two." << endl;
        return 3;
    }
    else
    {
        cout << "\nFast forward five more years." << endl
            << "You and Gretchen have been living happily in the countryside" << endl
            << "Following your wedding you retired from being a hero" << endl
            << "in order to focus on your real quest, Being a great father" << endl
            << "you have 2 wonderful kids with another on the way." << endl
            << "John jr. is playing hero in the yard with Gretchen jr." << endl
            << "As the sun begins to set you think back to your old" << endl
            << "adventures and wonder where the time has gone." << endl
            << "Before you know it your tucking the kids into bed" << endl
            << "when they ask 'daddy how did you meet mommy'" << endl
            << "and so you tell them the tale as they drift off to sleep" << endl;
        return 4;
    }




}
//Troll fight functions
//need to fix fight maths
void fight(int x, int y, Monster& Gretchen, Items item[], string adj, int& hp) { 
    if ((x == 1) && (y == 0)) //player is in the Guest room
    {
        //you attack gretchen
        int wp = 10;
        string weapon;
        int damage = (rand() % 10) + 1;
        cout << "What do you wish to use a weapon: ";
        cin >> weapon;
        for (int i = 0; i < 10; i++)
        {
            if (weapon == item[i].getName() && item[i].getInv()) { wp = i; }
        }
        if (wp == 10)
        {
            cout << "Item not found, so you use your hands." << endl;
        }
        if (wp == 7)
        {
            cout << "You swing your sword!" << endl; damage *= 2;
        }
        if (wp == 3)
        {
            cout << "You swing the axe with gusto!" << endl; damage = damage * 1.5 + 3;
        }
        Gretchen.health -= damage;
        cout << "Gretchen has taken " << damage << " points of damage and is now at " << Gretchen.health << " Hit points :(\n\n";
        
        
        
        //gretchen attacks you. she only attacks if you do, in retaliation
        if(Gretchen.health >0)
        {
            int trollAttack = rand() % 10 + 1;
            hp -= trollAttack;
            cout << "Gretchen strikes back!\nYou took " << trollAttack << " points of damage from " << Gretchen.name << adj << endl
                << "and are at " << hp << " hit points. :(\n";
        }
        
    }
    else { cout << "There is no target to attack in this room" << endl; }
}


//Misc. functions
// Voids:
//displays all items from item array w/ 'true' in getInv
void displayInventory(Items arr[]) {
    string itemToInspect;
    char inspect;
    bool check = false;
    cout << "Current Inventory: \n";
    for (int i = 0; i < 10; i++) {
        if (arr[i].getInv()) {
            cout << " - " << arr[i].getName() << endl;
            check = true;
        }
    }
    if (!check) { cout << " - none"; }
    cout << endl;    
    if (check) {
        cout << "Would you like to inspect an item? (y/n) ";
        cin >> inspect;
        while (toupper(inspect) == 'Y') {
            cout << "Which Item? ";
            cin >> itemToInspect;
            bool itemExists = false; // Initialize flag variable
            for (int i = 0; i < 10; i++) {
                if (arr[i].getInv() && (arr[i].getName() == itemToInspect)) {
                    cout << arr[i].getName() << ": " << arr[i].getDesc() << endl;
                    itemExists = true;
                    break;
                }
            }
            if (!itemExists) {
                cout << "There was either a spelling error or " << itemToInspect << " has not been found." << endl;
            }
            cout << "Would you like to inspect another item? (y/n) ";
            cin >> inspect;
        }

        cout << endl;
    }
}
//list of commands for the player
void help()
{
    cout << " List of Commands Case sensitive" <<
        endl << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" <<
        endl << "north,south,east,west: Moves player in direction indicated" <<
        endl << "grab: picks up an item if available" <<
        endl << "attack: attack an available enemy" <<
        endl << "look: Gives a description of current room" <<
        endl << "use: Uses an item " <<
        endl << "map: displays the map" <<
        endl << "inventory: list items you are holding" <<
        endl << "muero: ???" <<
        endl << "Other notes" <<
        endl << "When typing an item it is case " <<
        endl << "sensitive and must include all" <<
        endl << "Underscores, no spaces" <<
        endl << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
    return;
}
//prints out the map
void map()
{
    cout << "Map of the Dungeon?" << endl;
    cout << "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" << endl;
    cout << "* * * * * * * *\n"
        "*             *\n"
        "*   closet    *\n"
        "*             *\n"
        "* * *     * * * * * * *\n"
        "*                     * * * * * * *\n"
        "*   landing area      <        <  *\n"
        "*                     * * * *     *\n"
        "*     * * * * * * * * *     *  ^  *\n"
        "*     *                     *     *\n"
        "*     * * * * * * *     * * *  ^  * * *\n"
        "*                 *     *             *\n"
        "*   Basement      * * * *    Slide    *\n"
        "*                            Room     *\n"
        "*                 * * * *             *\n"
        "*                 *     *             *\n"
        "*     * * * * * * *     * * * * * * * *\n"
        "*     *                       *    *\n"
        "*     * * * * * * *     * * * *    * * *\n"
        "*                 * * * *              *\n"
        "*    Troll                  Guest      *\n"
        "*    Room         * * * *   Room       *\n"
        "*                 *     *              *\n"
        "* * * * * * * * * *     * * * * * * *  *\n"
        "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
}


// Ints:
//verifies player position so it's not out of bounds
int x_location(int x, int y)
{
    if (x < 0)
    {
        cout << "Erm actually you can't go that way" << endl;
        return 0;
    }
    if (x > 1)
    {
        cout << "That's a wall :|" << endl;
        return 1;
    }


    if (x == 1 && y == 2)
    {
        cout << "Slide\nWEEEEEEEEEEE" << endl;
        return 0;
    }
    if (x == 1 && y == 3)
    {
        cout << "The door out of the closet is South." << endl;
        return 0;
    }
    return x;
}
int y_location(int y)
{
    if (y < 0)
    {
        cout << "You've hit rock bottom " << endl;
        return 0;
    }
    if (y > 3)
    {
        cout << "There is no escape" << endl;
        return 3;
    }
    return y;
}

// Strings:
//Give gretchen our beloved a random descriptor
string descriptor(int adj_num)
{
    if (adj_num == 0) { return "gretch"; }
    if (adj_num == 1) { return "wretched"; }
    if (adj_num == 2) { return "lonely"; }
    if (adj_num == 3) { return "Gretchen the Gretchen the Gretchen"; }
    if (adj_num == 4) { return "grand templar and eater of stars"; }
    else { return "This shouldn't happen"; }
}

//Rooms member functions
void Rooms::displayRoom(Rooms room[], int playerX, int playerY, Items item[], int itemLoc[]) {
    int i = 0;
    bool check = false;
    for (i = 0; i < 7; i++) {
        if ((room[i].coordX == playerX) && (room[i].coordY == playerY)) {
            cout << room[i].name << ":\n"
                << room[i].description << endl << endl;
        }
    }
    //tell user if Items are in the Room    
    // 1. CHECK for Items matching player coords that ARENT in the inventory
    int j = item->isItem(item, playerX, playerY, itemLoc);
    if (j > 0) {
        cout << "You see ";
        // 2. IF there are ANY items in the room, list ONLY THE ITEMS that share pX &pY: cout << "You see [list] << " in the room"
        for (i = 0; i < j; i++) {
            if (itemLoc[i] == -1) { break; }
            if ((!item[itemLoc[i]].getInv()) && (item[itemLoc[i]].getX() > -1)) {
            cout << item[itemLoc[i]].getName();
            cout << ", ";
            }
        }
        cout << "in the room.\n";
    }
}
void Rooms::input(string line) {
    istringstream lineStream(line);
    string item;
    getline(lineStream, item, ',');
    name = item;

    getline(lineStream, item, ',');
    description = item;

    getline(lineStream, item, ',');
    coordX = stoi(item);

    getline(lineStream, item, ',');
    coordY = stoi(item);
}

//Items member funcitons
//Task: checks if there are ANY items that share the player's current coordinates that haven't been picked up
// also populates a new array that stores index numbers of ONLY the items that share the player's current coords
int Items::isItem(Items arr[], int playerX, int playerY, int loc[]) {
    int i, j = 0;
    for (i = 0; i < 10; i++)
        if ((arr[i].coordX == playerX) && (arr[i].coordY == playerY) && (!arr[i].inInventory)) {
            loc[j] = i;
            j++;
        }
    return j;
}
void Items::input(string line) {
    istringstream lineStream(line);
    string item;
    getline(lineStream, item, ',');
    name = item;

    getline(lineStream, item, ',');
    description = item;

    getline(lineStream, item, ',');
    inInventory = to_bool(item);

    getline(lineStream, item, ',');
    coordX = stoi(item);

    getline(lineStream, item, ',');
    coordY = stoi(item);

}
//function used to transform inInventory .csv data into a bool
bool to_bool(string str) {
    transform(str.begin(), str.end(), str.begin(), ::tolower);
    istringstream is(str);
    bool b;
    is >> boolalpha >> b;
    return b;
}
//pick up/grab function
void Items::grab(Items arr[], int playerX, int playerY, int itemLoc[]) {
    string itemInput;
    bool check = false;
    cout << "What would you like to pick up?\n";
    cin >> itemInput;
    for (int i = 0; i < 10; i++) {
        if ((itemInput == arr[i].name) && (arr[i].coordX == playerX) && (arr[i].coordY == playerY) && (!arr[i].inInventory)) {
            arr[i].setInv(true);
            cout << "You picked up the " << itemInput << "!\n"
                << arr[i].description << endl;
            check = true;
        }
    }
    if (!check) { cout << "There is no " << itemInput << " in this room\n\n"; }
}

//removes item from inventory & locates it out of bounds so it can't be picked up again
void Items::consume() {
    inInventory = false;
    coordX = -1;
    coordY = -1;
}
void Items::use(Items item[], int playerX, int playerY, int& hp, int& win) {
    //ITEMS THAT ARE USABLE: 
    // 1. cakemix - used to make cake 
    //  array: 0
    // 2. water jar - used to make cake
    //  array: 1
    // 3. cake
    //  array: 2
    // 4. potion - any where - adds 20 to player health(hp)
    //  array: 4
    // 5. match - used to make cake
    //  array: 8
    // 6. evil jar - @ 0,0 for water jar
    //  array: 9
    // cook book:
    //   array: 5
    string itemUse;
    char useAgain = 'Y';
    char confirm;
    
    while (toupper(useAgain) == 'Y') {
        cout << "What item would you like to use? ";
        cin >> itemUse;
        //first checks if the item is in the inventory
        bool itemExists = false; // Initialize flag variable
        for (int i = 0; i < 10; i++) {
            if (item[i].getInv() && (item[i].getName() == itemUse)) {
                itemExists = true;
            }
        }
        if (!itemExists) { cout << "You aren't carrying an item called " << itemUse << ".\n"; }
        if (itemExists) {
            //making the cake
            if ((itemUse == "cake_mix") || (itemUse == "water_jar") || (itemUse == "match") || (itemUse == "cook_book")) {
                if ((item[0].getInv()) && (item[1].getInv()) && (item[5].getInv()) && (item[8].getInv())) {
                    cout << "Would you like to make a cake? (y/n) ";
                    cin >> confirm;
                    if (toupper(confirm) == 'Y') {
                        //set cakemix [0] to out of inventory && location out of bounds so it can't be picked up again
                        item[0].consume();
                        //set waterjar [1] to out of inventory && waterjar location is ALREADY OoB, so it can't be picked up again
                        item[1].consume();
                        //set match [8] to out of inventory && location out of bounds so it can't be picked up again
                        item[8].consume();
                        cout << "You used the cake_mix, water_jar, and match to make a cake!\n"
                            << item[2].description << endl;
                        //put cake [2] in inventory; location doesn't mater
                        item[2].inInventory = true;
                        //displayInventory, to show that items were consumed & you now have the cake
                        displayInventory(item);
                    }
                }
                else if (!item[5].getInv()) { cout << "You can't do anything with that right now... Maybe it's useful in a recipe?\n"; }
                else if (itemUse == "cook_book") { cout << item[5].description << "\nIt doesn't seem like you have enough materials for making the cake...\n"; }
                else { cout << "According to the cook book, this could be useful for making a cake, but you don't have the suffiicent materials.\n"; }
            }
            //fill evil jar [9] (need to be in troll room
            //give player the water_jar [1]
            else if ((playerX == 0) && (playerY == 0) && (itemUse == "evil_jar")) {
                cout << "You filled the evil_jar with the water coming out of the cracks in the room.\n"
                    << item[1].description << endl;
                item[9].consume();
                item[1].setInv(true);
                displayInventory(item);
            }
            else if (itemUse == "evil_jar") { cout << "You can't use the " << itemUse << " here. But maybe you fill it with something?\n"; }

            //using potion [4]
            else if (itemUse == "potion") {
                int potionHealth = 20; //variable so we can set/change the amount of healing easily
                hp += potionHealth;
                item[4].consume();
                cout << "You used the " << itemUse << "!\n"
                    << "You restored " << potionHealth << " hit points!\n"
                    << "You are now at " << hp << " hit points.\n";
            }

            //using poem_book
            else if (itemUse == "poem_book") {
                int poem;
                poem = rand() % 3 + 1;
                switch (poem) {
                case 1:
                    cout << "\n\"Once upon a bridge, a troll did dwell,\n"
                        << "His life was solitary, as far as he could tell,\n"
                        << "He longed for love, a companion to share,\n"
                        << "But no one ever crossed his bridge, no one would dare.\n\n"

                        << "\"He watched as happy couples passed him by,\n"
                        << "Holding hands, laughing, with love in their eyes,\n"
                        << "The troll couldn't help but feel a little blue,\n"
                        << "He yearned for someone to love him too.\n\n"

                        << "\"But trolls aren't known for being sweet or kind,\n"
                        << "And his gruff demeanor made most people blind,\n"
                        << "To the tender heart that lay deep within,\n"
                        << "And the longing for love that consumed him.\n"

                        << "\"One day, a brave soul crossed his bridge,\n"
                        << "The troll was surprised, but didn't give her a hitch,\n"
                        << "She saw past his rough exterior,\n"
                        << "And found in him a heart that was pure.\n\n"

                        << "\"They talked for hours, and the troll felt alive,\n"
                        << "For the first time in his life, he felt a drive,\n"
                        << "To loveand be loved, to open his heart,\n"
                        << "To share his life with someone from the start.\n\n"

                        << "\"The trolland his love, they lived happily ever after,\n"
                        << "The end of his lonely days, it was the start of laughter,\n"
                        << "And though he was a troll, gruffand rough,\n"
                        << "He found loveand it was more than enough.\"\n";
                    break;
                case 2:
                    cout << "\n\"In solitude, I dwell beneath the bridge,\n"
                        << "A troll with heartand yet no hand to hold,\n"
                        << "Longing for love, to cross the water's ridge,\n"
                        << "And break the spell of loneliness so cold.\n\n"

                        << "\"My rough exterior keeps them at bay,\n"
                        << "And yet, inside, a fire doth burn bright,\n"
                        << "A hope that someone might come my way,\n"
                        << "And see beyond the darkness to the light.\n\n"

                        << "\"Oh, love!How sweet thy touch upon my soul,\n"
                        << "To feel thy warmthand share in thy embrace,\n"
                        << "To know that I, a troll, can be made whole,\n"
                        << "And find in thee a refugeand a grace.\n\n"

                        << "\"So here I stand, beneath the bridge so still,\n"
                        << "Awaiting love, to break this lonely chill.\"\n";
                    break;
                case 3:
                    cout << "\n\"Beneath bridge I hide,\n"
                        << "Longing for a love unknown,\n"
                        << "Lonely troll am I.\"\n";
                    break;
                default:
                    cout << "\nIt's just a lot of sappy, disgusting lovey-dovey crap.\n";
                }
            }

            //use cake
            else if ((playerX == 1) && (playerY == 0) && (itemUse == "cake")) { 
                cout << "You offer the cake to Gretchen the troll, and she graciously accepts it with blushing cheeks";
                win = secret(); 
            }
            else if(itemUse == "cake") { cout << "You can't use the " << itemUse << " here. But maybe you could give it to someone?\n"; }

            else { cout << "The item " << itemUse << " doesn't have a clear use right now...\n"; }

        }
        cout << "Would you like to use another item? (y/n) ";
        cin >> useAgain;
    }
}