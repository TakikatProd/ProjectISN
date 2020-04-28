int facing = 0;
int room = 0;
PImage BG;
PImage Tile;
//Item
PImage Door; //id 40-59
PImage OpenDoor; //id 60-79
PImage Windows; //id 1
PImage Curtains; //id 2
PImage Box; //id 3
PImage Barrel; //id 5
PImage[] Key = new PImage[20]; //id 20-39
PImage Personnage; //id 4

//Special Item
PImage LampKey[] = new PImage[2];//id 80
PImage Lamp[] = new PImage[2]; //id 81
PImage Lever[] = new PImage[2]; //id 82
PImage Cable_Barrel; //id 83
PImage Dresser[] = new PImage[4]; //id 84

//Special var
boolean Light = false;

boolean DresserOn = false;
int DresserState[][] = {
  {0,0}
};

//Tutorial
PImage[] Tutorial = new PImage[3];

//Inventaire
int[] Inventory = new int[9];
boolean Inv = false;
PImage SlotInventor;
PImage[] Items = new PImage[40];

int SelectItem = 10;

PImage Cursor;

//hitbox
int[][] Hitbox = new int[10][5];
int NbElements = 0;

boolean Tuto = true;
boolean Change = false;
int PhaseTuto = 0;
int Fade = 0;

int[][][] Elements = 
{
  {{4,3,6,  2,4,2},  {1,3,2},  {3,22,14,  3,24,14,  3,23,12,  3,25,12,  20,13,7},  {1,4,2,  1,10,2},  {0},  {0},  {0},  {0}},
  {{0},  {82,4,4},  {83,6,7},  {84,6,7},  {80,4,4},  {80,4,4},  {80,4,4},  {80,4,4}}
};
int[][][] DoorMatrice = 
{
  {{40,7,6},  {0}, {0}, {0}},
  {{0},  {0}, {0}, {0}}
};

void setup(){
  size(1600,900);
  //Load Picture
  Door = loadImage("/Object/Interactible/Porte.png");
  OpenDoor = loadImage("/Object/Interactible/OpenDoor.png");
  Box = loadImage("/Object/Others/Boite.png");
  Barrel = loadImage("/Object/Others/Barrel.png");
  Windows = loadImage("/Object/Others/Windows.png");
  Curtains = loadImage("/Object/Others/Rideau.png");
  Personnage = loadImage("/Object/Others/Player.png");
  SlotInventor = loadImage("/Inventor/Box.png");
  Cursor = loadImage("/Others/idle_cursor.png");
  Tutorial[0] = loadImage("/Others/tuto1.png");
  Tutorial[1] = loadImage("/Others/tuto2.png");
  Tutorial[2] = loadImage("/Others/tuto3.png");
  LampKey[0] = loadImage("/Object/Others/Lamp/Lamp.png");
  LampKey[1] = loadImage("/Object/Others/Lamp/Lamp_On_key.png");
  Lamp[0] = LampKey[0];
  Lamp[1] = loadImage("/Object/Others/Lamp/Lamp_On.png"); 
  Lever[0] = loadImage("/Object/Interactible/Lever_Off.png");
  Lever[1] = loadImage("/Object/Interactible/Lever_On.png");
  Cable_Barrel = loadImage("/Object/Interactible/Cable_Barrel.png");
  Dresser[0] = loadImage("/Object/Interactible/Dresser.png");
  Dresser[1] = loadImage("/Object/Interactible/Dresser_left_door.png");
  Dresser[2] = loadImage("/Object/Interactible/Dresser_right_door.png");
  Dresser[3] = loadImage("/Object/Interactible/Dresser_open_door.png");

  Items[1] = loadImage("/Inventor/Items/Cable_yellow.png");

  Items[20] = loadImage("/Inventor/Items/Key_0.png");
  Items[21] = loadImage("/Inventor/Items/Key_1.png");
  Key[0] = loadImage("/Inventor/Items/Key_0.png");
  Key[1] = loadImage("/Inventor/Items/Key_1.png");

  cursor(Cursor, 16, 16);
  Load();
}

void draw(){
  //Fonction tutorial
  if(Tuto){
    //Afficher l'image du tutorial
    if(Fade == 0){
      image(Tutorial[PhaseTuto],0,0);
    }
    
    //Changer de phase du tutorials
    if(Fade > 30){
      PhaseTuto++;
      Fade = 0;
      Change = false;
      //Fin du tuto
      if(PhaseTuto >= 3){
        Tuto = false;
        Load();
      }
    }

    //Fade out
    if(Change){
      Fade++;
      fill(0,20);
      rect(0, 0, width, height);
      return;
    }
  }
}

void keyPressed(){
  //Mouvement
  switch(keyCode){
   case(UP):
     if(facing < 4){
       facing += 4;
     }
     Load();
     break;
     
   case(DOWN):
     if(facing >= 4){
       facing -= 4;
     }
     Load();
     break;
     
   case(LEFT):
     if(facing >= 4){
      break;
     }
     if(facing == 3){
       facing = 0;
     } else {
       facing++;
     }
     Load();
     break;
     
   case(RIGHT):
     if(facing >= 4){
       break;
     }
     if(facing == 0){
       facing = 3;
     } else {
       facing--;
     }
     Load();
     break;

    case(TAB):
      Inv = !Inv;
      Load();
      break;
     
    default:
      break;
 }
}

void Load(){
  NbElements = 0;
  if(facing < 4){
    //Background
    BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/Facing_" + str(facing) + ".png");
    image(BG, 0, 0, width, height);
    //Door
    if(DoorMatrice[room][facing][0] >= 40 && DoorMatrice[room][facing][0] < 60){
      image(Door, DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200);
      AddHitbox(DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200, DoorMatrice[room][facing][0]);
    }
    if(DoorMatrice[room][facing][0] >= 60 && DoorMatrice[room][facing][0] < 80){
      image(OpenDoor, DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200);
      AddHitbox(DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200, DoorMatrice[room][facing][0]);
    }
    
  } else {
    //Ceiling
    BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/Ceiling.png");
    rotate(PI/2 * (facing - 4));
    background(63,56,91);
    switch(facing){
      case(4):
        translate(350,0);
      break;

      case(5):
        translate(0,-1250);
      break;

      case(6):
        translate(-1250,-900);
      break;

      case(7):
        translate(-900,350);
      break;
    }
    image(BG, 0, 0, 900, 900);
  }
  //Elements
  if(Elements[room][facing][0] != 0){
    for(int i = 0; i < Elements[room][facing].length; i = i + 3){
      switch(Elements[room][facing][i]){
        case(3):
          image(Box, Elements[room][facing][i + 1] * 50 + 20, Elements[room][facing][i + 2] * 50, 136, 100);
        break;

        case(2):
          image(Curtains, Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 310);
        break;

        case(4):
          image(Personnage, Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 50, 112, 150);
        break;

        case(1):
          image(Windows, Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 - 10, 170, 210);
        break;

        case(5):
          image(Barrel, Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 7, 100, 93);
        break;

        case(80):
          if(Light){
            image(LampKey[1], Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100);
          }
          else{
            image(LampKey[0], Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100);
          }
          AddHitbox(Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100, 80);
        break;

        case(81):
          if(Light){
            image(Lamp[1], Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100);
          }
          else{
            image(Lamp[0], Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100);
          }
        break;

        case(82):
          if(Light){
            image(Lever[1], Elements[room][facing][i + 1] * 100 + 32, Elements[room][facing][i + 2] * 100 + 15, 35, 70);
          }
          else{
            image(Lever[0], Elements[room][facing][i + 1] * 100 + 32, Elements[room][facing][i + 2] * 100 + 15, 35, 70);
          }
          AddHitbox(Elements[room][facing][i + 1] * 100 + 32, Elements[room][facing][i + 2] * 100 + 15, 35, 70, 82);
        break;

        case(83):
          image(Cable_Barrel, Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 7, 100, 93);
          AddHitbox(Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 7, 100, 93, 83);
        break;

        case(84):
          image(Dresser[0], Elements[room][facing][i + 1] * 100 + 2, Elements[room][facing][i + 2] * 100 + 5, 195, 95);
          
        break;

        default:
        break;
      }
      if(Elements[room][facing][i] >= 20 && Elements[room][facing][i] < 40){
        image(Key[Elements[room][facing][i] - 20], Elements[room][facing][i + 1] * 100 + 25, Elements[room][facing][i + 2] * 100 + 50, 50, 50);
        AddHitbox(Elements[room][facing][i + 1] * 100 + 25, Elements[room][facing][i + 2] * 100 + 50, 50, 50, Elements[room][facing][i]);
      }
    }
  }
  rotate(0);
  translate(0,0);
  if(Inv){
    InventoryPrint();
  }
  SpecialLoad();
}

void SpecialLoad() {
  if(DresserOn){
    int IdDresser = 0;
    for(int i = 0; i < 7; i++){
      image(Tile, i * 100, 0, 100, 100);
      image(Tile, i * 100, 100, 100, 100);
    }
    if(room == 1 && facing == 3){
      IdDresser = 0;
    }
    int id = DresserState[IdDresser][0] * 1 + DresserState[IdDresser][1] * 2;
    image(Dresser[id]);
  }
  if(room == 1 && !Light){
    fill(0,70);
    rect(0,0,width,height);
  }
}

void mousePressed() {
  if(Tuto){
    Change = true;
  }
  //hitboxe
  for(int i = 0; i < NbElements; i++){
    if(mouseX > Hitbox[i][0] && mouseX < (Hitbox[i][0] + Hitbox[i][2])){
      if(mouseY > Hitbox[i][1] && mouseY < (Hitbox[i][1] + Hitbox[i][3])){
        OnHitbox(Hitbox[i][4]);
        Load();
      }
    }
  }
  for(int i = 0; i < 9; i++){
    if(mouseX > 1505 && mouseX < 1595){
      if(mouseY > 100 * i + 5 && mouseY < 100 * i + 105){
        if(Inventory[i] != 0){
          SelectItem = i;
          cursor(Items[Inventory[i]],0,0);
          return;
        }
      }
    }
  }
  SelectItem = 10;
  cursor(Cursor, 16, 16);
}

void InventoryPrint(){
  if(facing >= 4){
    switch(facing){
      case(4):
        translate(-350,0);
      break;

      case(5):
        translate(0,1250);
      break;

      case(6):
        translate(1250,900);
      break;

      case(7):
        translate(900,-350);
      break;
    }
    rotate(PI/2 * (4 - facing - 4));
  }
  for (int i = 0; i < 9; i++) {
    image(SlotInventor,1505, (i*100)+5, 90, 90);
    if(Inventory[i] != 0){
      image(Items[Inventory[i]], 1515, i*100+15, 70, 70);
    }
  }


}

void InventoryAdd(int id){
  for(int i = 0; i < 9; i++){
    if(Inventory[i] == 0){
      Inventory[i] = id;
      return;
    }
  }
}

void AddHitbox(int posx, int posy, int sizex, int sizey, int id){
  //Ceiling
  if(facing >= 4){
    if(facing == 4){
      Hitbox[NbElements][0] = posx + 350;
      Hitbox[NbElements][1] = posy;
      Hitbox[NbElements][2] = sizex;
      Hitbox[NbElements][3] = sizey;
    }
    if(facing == 5){
      Hitbox[NbElements][0] = 1250 - posy - sizey;
      Hitbox[NbElements][1] = posx;
      Hitbox[NbElements][2] = sizex;
      Hitbox[NbElements][3] = sizey;
    }
    if(facing == 6){
      Hitbox[NbElements][0] = 1250 - posx - sizex;
      Hitbox[NbElements][1] = 900 - posy - sizey;
      Hitbox[NbElements][2] = sizey;
      Hitbox[NbElements][3] = sizex;
    }
    if(facing == 7){
      Hitbox[NbElements][0] = posy + 350;
      Hitbox[NbElements][1] = 900 - posx - sizex;
      Hitbox[NbElements][2] = sizey;
      Hitbox[NbElements][3] = sizex;
    }
  } else {
    //No Ceiling
    Hitbox[NbElements][0] = posx;
    Hitbox[NbElements][1] = posy;
    Hitbox[NbElements][2] = sizex;
    Hitbox[NbElements][3] = sizey;
  }
  Hitbox[NbElements][4] = id;
  NbElements++;
}

void OnHitbox(int id){
  if(id <= 39 && id >= 20){
    InventoryAdd(id);
    ChangeElementsById(id,0);
  }
  if(id <= 59 && id >= 40){
    if(SelectItem != 10){
      if(Inventory[SelectItem] == id - 20){
        switch(DoorMatrice[room][facing][0]){
          case(40):
            DoorMatrice[room][facing][0] = 61;
            Inventory[SelectItem] = 0;
          break;
          
          default:
          break;

        }
      }
    }
  }
  if(id <= 79 && id >= 60){
    room = id - 60;
  }
  switch(id){

    case(80):
      InventoryAdd(21);
      ChangeElementsById(80,81);
    break;

    case(82):
      Light = !Light;
    break;

    case(83):
      InventoryAdd(1);
      ChangeElementsById(83, 5);
    break;

    default:
    break;
  }
}

void ChangeElementsById(int PrevId, int Newid){
  if(facing < 4){
        for(int i = 0; i < Elements[room][facing].length; i = i + 3){
          if(Elements[room][facing][i] == PrevId){
            Elements[room][facing][i] = Newid;
          }
        }
      } else {
        for(int i = 0; i < Elements[room][4].length; i = i + 3){
          if(Elements[room][4][i] == PrevId){
            Elements[room][4][i] = Newid;
            Elements[room][5][i] = Newid;
            Elements[room][6][i] = Newid;
            Elements[room][7][i] = Newid;
          }
        }
      }
}
