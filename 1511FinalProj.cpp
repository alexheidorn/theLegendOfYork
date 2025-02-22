/*This code includes the Items class and Rooms class w/ all of their functions & necessary variables to run properly.
This most recent version also includes more comments to clarify the purpose of certain bits of code.
*/

#include <iostream>
#include <iomanip>
#include <algorithm>
#include <fstream>
#include <sstream>
using namespace std;

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
    bool isItem(Items item[], int playerX, int playerY, int loc[]);
    //void listItemsInRoom(Items arr[], int playerX, int playerY);
    void input(string line);
    void grab(Items arr[], int playerX, int playerY, int itemLoc[]);

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

//other functions
bool initializeRooms(Rooms arr[]);
bool initializeItems(Items arr[]);
void displayInventory(Items arr[]);
bool to_bool(string str);

int main()
{
    int x = 0;
    int y = 0;
    Rooms room[7];
    Items item[10];
    int itemLocation[10] = { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 };
    bool roomInt = initializeRooms(room); //checks if the rooms have been properly initialized
    bool itemInt = initializeItems(item); //checks if the items have been properly initialized
    if ((!roomInt) || (!itemInt)) { return -1; } //if the files aren’t found, ends the program

    //INSERT YOUR CODE HERE!!

    return 0;
}

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
//displays all items from item array w/ 'true' in getInv
void displayInventory(Items arr[]) {
    int count = 0;
    cout << "Current Inventory: \n";
    for (int i = 0; i < 10; i++) {
        if (arr[i].getInv()) {
            cout << " - " << arr[i].getName() << endl;
        }
        count++;
    }
    cout << endl;
    if (count == 0) { cout << "none"; }
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
    if (item->isItem(item, playerX, playerY, itemLoc)) {
        cout << "You see ";
        // 2. IF there are ANY items in the room, list ONLY THE ITEMS that share pX &pY: cout << "You see [list] << " in the room"
        for (i = 0; i < 10; i++) {
            if (itemLoc[i] == -1) { break; }
            cout << item[itemLoc[i]].getName();
            cout << ", ";
        }
        cout << "in the room.\n\n";
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
bool Items::isItem(Items arr[], int playerX, int playerY, int loc[]) {
    int i, j = 0;
    bool check = false;
    for (i = 0; i < 10; i++)
        if ((arr[i].coordX == playerX) && (arr[i].coordY == playerY) && (!arr[i].inInventory)) {
            loc[j] = i;
            j++;
            check = true;
        }
    if (check) { return true; }
    else { return false; }
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

//function used to transform inInventory .csv into a bool
bool to_bool(string str) {
    transform(str.begin(), str.end(), str.begin(), ::tolower);
    istringstream is(str);
    bool b;
    is >> boolalpha >> b;
    return b;
}

//pick up/grab function
void Items::grab(Items arr[], int playerX, int playerY, int itemLoc[]) {
    string input;
    bool check = false;
    cout << "What would you like to pick up?\n";
    getline(cin, input);
    for (int i = 0; i < 10; i++) {
        if ((input == arr[i].getName()) && (arr[i].coordX == playerX) && (arr[i].coordY == playerY) && (!arr[i].inInventory)) {
            arr[i].setInv(true);
            cout << "You picked up the " << input << "!\n\n";
            check = true;
        }
    }
    if (!check) { cout << "There is no " << input << " in this room\n\n"; }
}