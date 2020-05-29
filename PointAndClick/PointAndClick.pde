import ddf.minim.*;
Minim minim;
AudioPlayer Ambiance;

int facing = 0;
int room = 0;
boolean Tuto = false;
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
PImage Cable_red; //id 85
PImage BulbLamp[] = new PImage[2]; //id 86
PImage BlackLamp[] = new PImage[2]; //id 87
PImage ElecPanelOff[] = new PImage[2]; //id 88
PImage ElecPanelOn[] = new PImage[2]; //id 89
PImage Clavier; //id 90
PImage Piano; //id 91

//other
PImage ExitArrow;
PImage MenuBG;
PImage NewGame;
PImage LoadGame;
PImage ExitGame;
PImage MenuTitle;
PImage MaskCable[] = new PImage[3];

//Special var
boolean Light = false;
boolean BlackLight = false;
boolean Menu = true;

boolean DresserOn = false;
int DresserState[][] = {
  {0,0}
};
int DresserID[][] = {
  {85,500,620,0  ,87,1000,680,1}
};

int IdDresser = 0;

boolean PanelOn = false;
boolean Mask[] = new boolean[3];

boolean PianoOn = false;
char Note[] = new char[6];
int NoteID = 0;

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

boolean Change = false;
int PhaseTuto = 0;
int Fade = 0;

int[][][] Elements = 
{
  {{4,3,6,  2,4,2},  {4,2,6,  1,3,2},  {4,4,5,  3,22,14,  3,24,14,  3,23,12,  3,25,12,  20,13,7},  {4,3,6,  1,4,2,  1,10,2},  {0},  {0},  {0},  {0}},
  {{4,6,6},  {82,4,4, 4,7,5},  {83,5,7, 4,12,6},  {84,5,6, 4,2,6},  {80,4,4},  {80,4,4},  {80,4,4},  {80,4,4}},
  {{88,4,4, 4,8,6},  {4,3,6},  {91,7,5, 4,1,3},  {4,10,6},  {86,4,4},  {86,4,4},  {86,4,4},  {86,4,4}}
};
int[][][] DoorMatrice = 
{
  {{40,7,6},  {0}, {0}, {0}},
  {{0},  {41,9,5}, {60,7,6}, {0}},
  {{0},  {0}, {0}, {61,7,6}}
};

void setup(){
  size(1600,900);

  minim = new Minim(this);
  //Load Picture
  Tile = loadImage("/Others/Tile.png");
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
  ElecPanelOff[0] = loadImage("/Object/Interactible/ClosedElecPanel.png");
  ElecPanelOff[1] = loadImage("/Object/Interactible/OpenElecPanelOff.png");
  ElecPanelOn[0] = loadImage("/Object/Interactible/ClosedElecPanel.png");
  ElecPanelOn[1] = loadImage("/Object/Interactible/OpenElecPanelOn.png");
  MaskCable[0] = loadImage("/Object/Others/Panel/YellowCorrec.png");
  MaskCable[1] = loadImage("/Object/Others/Panel/RedCorrec.png");
  MaskCable[2] = loadImage("/Object/Others/Panel/GreenCorrec.png");
  Clavier = loadImage("/Object/Interactible/Clavier.png");
  Piano = loadImage("/Object/Interactible/Piano.png");

  Items[1] = loadImage("/Inventor/Items/Cable_yellow.png");
  Items[2] = loadImage("/Inventor/Items/Cable_red.png");
  Items[3] = loadImage("/Inventor/Items/Cable_Green.png");
  Items[4] = loadImage("/Inventor/Items/BlackLamp.png");
  Cable_red = loadImage("/Inventor/Items/Cable_red.png");
  BulbLamp[0] = loadImage("/Object/Others/Bulb/Lamp_Off.png");
  BulbLamp[1] = loadImage("/Object/Others/Bulb/Lamp_On.png");
  BlackLamp[0] = loadImage("/Object/Others/Bulb/BlackLamp_Off.png");
  BlackLamp[1] = loadImage("/Object/Others/Bulb/BlackLamp_On.png");

  Items[20] = loadImage("/Inventor/Items/Key_0.png");
  Items[21] = loadImage("/Inventor/Items/Key_1.png");
  Key[0] = loadImage("/Inventor/Items/Key_0.png");
  Key[1] = loadImage("/Inventor/Items/Key_1.png");

  ExitArrow = loadImage("/Others/Exit_Arrow.png");
  Ambiance = minim.loadFile("/Sounds/Music/Man Down.wav");

  NewGame = loadImage("/Others/NewGame.png");
  LoadGame = loadImage("/Others/LoadGame.png");
  ExitGame = loadImage("/Others/ExitGame.png");
  MenuBG = loadImage("/Others/MenuBG.png");
  MenuTitle = loadImage("/Others/MenuTitle.png");

  cursor(Cursor, 16, 16);
  MenuPrint();
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
  if (!Ambiance.isPlaying()){
    Ambiance.setGain(-30);
    Ambiance.loop();
  }
}

void keyPressed(){
  //Mouvement
  if(Menu || Tuto){
    return;
  }
  if(keyCode == TAB){
    Inv = !Inv;
    Load();
 }
 if(DresserOn || PanelOn || PianoOn){
   return;
 }
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

    case(BACKSPACE):
      Save();
      exit();
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
          AddHitbox(Elements[room][facing][i + 1] * 100 + 2, Elements[room][facing][i + 2] * 100 + 5, 195, 95, 84);
        break;

        case(86):
          if(BlackLight){
            image(BulbLamp[1], Elements[room][facing][i + 1] * 100 + 10, Elements[room][facing][i + 2] * 100 + 10, 80, 80);
          } else {
            image(BulbLamp[0], Elements[room][facing][i + 1] * 100 + 10, Elements[room][facing][i + 2] * 100 + 10, 80, 80);
          }
          AddHitbox(Elements[room][facing][i + 1] * 100 + 10, Elements[room][facing][i + 2] * 100 + 10, 80, 80, 86);
        break;

        case(87):
          if(BlackLight){
            image(BlackLamp[1], Elements[room][facing][i + 1] * 100 + 10, Elements[room][facing][i + 2] * 100 + 10, 80, 80);
          } else {
            image(BlackLamp[0], Elements[room][facing][i + 1] * 100 + 10, Elements[room][facing][i + 2] * 100 + 10, 80, 80);
          }
        break;

        case(88):
          image(ElecPanelOff[0], Elements[room][facing][i + 1] * 100 + 28, Elements[room][facing][i + 2] * 100 + 4, 144, 192);
          AddHitbox(Elements[room][facing][i + 1] * 100 + 28, Elements[room][facing][i + 2] * 100 + 4, 144, 192, 88);
        break;

        case(89):
          image(ElecPanelOn[0], Elements[room][facing][i + 1] * 100 + 28, Elements[room][facing][i + 2] * 100 + 4, 144, 192);
          AddHitbox(Elements[room][facing][i + 1] * 100 + 28, Elements[room][facing][i + 2] * 100 + 4, 144, 192, 89);
        break;

        case(91):
          image(Piano,Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 98, 200, 206);
          AddHitbox(Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100 + 98, 200, 206,91);
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
      
      default:
      break;
    }
    rotate(-PI/2 * (facing - 4));
  }
  SpecialLoad();
}

void SpecialLoad() {
  if(DresserOn || PanelOn || PianoOn){
    NbElements = 0;
    for(int i = 0; i < 4; i++){
      image(Tile, i * 400, 0, 400, 400);
      image(Tile, i * 400, 400, 400, 400);
      image(Tile, i * 400, 800, 400, 400);
    }
  }
  
  if(DresserOn){
    IdDresser = 0;
    image(ExitArrow, 10, 10, 160, 120);
    AddHitbox(10, 10, 160, 120, 1);
    if(room == 1 && facing == 3){
      IdDresser = 0;
    }
    int id = DresserState[IdDresser][0] * 1 + DresserState[IdDresser][1] * 2;
    image(Dresser[id], 20, 140, 1560, 760);
    for(int i = 0; i < DresserID[IdDresser].length; i = i + 4){
      if(DresserState[IdDresser][DresserID[IdDresser][i + 3]] == 1){
        switch(DresserID[IdDresser][i]){
          case(85):
            image(Cable_red, DresserID[IdDresser][i + 1], DresserID[IdDresser][i + 2], 260, 240);
            AddHitbox(DresserID[IdDresser][i + 1], DresserID[IdDresser][i + 2], 260, 240, 85);
          break;

          case(87):
            image(Items[4], DresserID[IdDresser][i + 1], DresserID[IdDresser][i + 2], 180, 180);
            AddHitbox(DresserID[IdDresser][i + 1], DresserID[IdDresser][i + 2], 180, 180, 87);
          break;
            
          default:
          break;
        }
      }
    }
    AddHitbox(220, 340, 560, 520, 2);
    AddHitbox(820, 340, 560, 520, 3);
  }

  if(PanelOn){
    image(ExitArrow, 10, 10, 160, 120);
    AddHitbox(10, 10, 160, 120, 1);
    boolean PanelFonction = false;
    if(Mask[0] && Mask[1] && Mask[2]){
      PanelFonction = true;
    }
    if(PanelFonction){
      image(ElecPanelOn[1],512,70,576,768);
    }
    else{
      image(ElecPanelOff[1],512,70,576,768);
      if(Mask[0]){
        image(MaskCable[0],608,260,48,168);
      }
      else{
        AddHitbox(558,210,148,168,2);
      }
      if(Mask[1]){
        image(MaskCable[1],943,501,48,240);
      }
      else{
        AddHitbox(893,451,148,340,3);
      }
      if(Mask[2]){
        image(MaskCable[2],944,188,48,216);
      }
      else{
        AddHitbox(894,138,148,266,4);
      }
    }
  }
  if (PianoOn){
    AddHitbox(10, 10, 160, 120, 1);
    image(Clavier,0,9,1600,883);
    image(ExitArrow, 10, 10, 160, 120);
  }

  if(room == 1 && !Light){
    fill(0,70);
    rect(0,0,width,height);
  }
  if(room == 2 && !BlackLight){
    fill(0,70);
    rect(0,0,width,height);
  }
  if(room == 2 && BlackLight && Elements[2][5][0] == 87){
    if(facing < 4){
      if(PanelOn){
        PImage BlackLightImageCeiling = loadImage("Others/Blacklight/BlacklightCeiling.png");
        image(BlackLightImageCeiling,0,0,1600,900);
      } else {
        PImage BlackLightImage = loadImage("Others/Blacklight/BlacklightFacing-" + str(facing) + ".png");
        image(BlackLightImage,0,0,1600,900);
      }
    } else {
      PImage BlackLightImageCeiling = loadImage("Others/Blacklight/BlacklightCeiling.png");
      image(BlackLightImageCeiling,0,0,1600,900);
    }
  }
  if(Inv){
    InventoryPrint();
  }
}

void mousePressed() {
  boolean HitboxOn = true;
  if(Tuto){
    Change = true;
  }
  //hitboxe
  for(int i = 0; i < NbElements; i++){
    if(mouseX > Hitbox[i][0] && mouseX < (Hitbox[i][0] + Hitbox[i][2])){
      if(mouseY > Hitbox[i][1] && mouseY < (Hitbox[i][1] + Hitbox[i][3])){
        if(HitboxOn){
          OnHitbox(Hitbox[i][4]);
          Load();
          HitboxOn = false;
          if(Tuto){
            return;
          }
        }
      }
    }
  }
  if(Inv){
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
  }
  SelectItem = 10;
  cursor(Cursor, 16, 16);
}

void InventoryPrint(){
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
  if(DresserOn){
    switch(id){
      case(1):
        DresserOn = false;
      break;

      case(2):
        DresserState[IdDresser][0] = 1-DresserState[IdDresser][0];
      break;

      case(3):
        DresserState[IdDresser][1] = 1-DresserState[IdDresser][1];
      break;

      default:
      break;
    }
  }
  if(PanelOn){
    switch(id){
      case(1):
        PanelOn = false;
      break;

      case(2):
        if(SelectItem != 10){
          if(Inventory[SelectItem] == 1){
            Mask[0] = true;
            Inventory[SelectItem] = 0;
            if(Mask[0] && Mask[1] && Mask[2]){
              ChangeElementsById(88,89);
              BlackLight = true;
            }
          }
        }
      break;

      case(3):
        if(SelectItem != 10){
          if(Inventory[SelectItem] == 2){
            Mask[1] = true;
            Inventory[SelectItem] = 0;
            if(Mask[0] && Mask[1] && Mask[2]){
              ChangeElementsById(88,89);
              BlackLight = true;
            }
          }
        }
      break;

      case(4):
        if(SelectItem != 10){
          if(Inventory[SelectItem] == 3){
            Mask[2] = true;
            Inventory[SelectItem] = 0;
            if(Mask[0] && Mask[1] && Mask[2]){
              ChangeElementsById(88,89);
              BlackLight = true;
            }
          }
        }
      break;

      default:
      break;
    }
  }
  if (PianoOn){
    switch(id){
      case(1):
        PianoOn = false;
      break;

      default:
      break;
    }
  }
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
          
          case(41):
            DoorMatrice[room][facing][0] = 62;
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

    case(-1):
      MenuNew();
    break;

    case(-2):
      MenuLoad();
    break;

    case(-3):
      exit();
    break;

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

    case(84):
      DresserOn = true;
    break;

    case(85):
      InventoryAdd(2);
      ChangeDresserElementsById(85,0);
    break;

    case(86):
      if(SelectItem != 10){
        if(Inventory[SelectItem] == 4){
          ChangeElementsById(86,87);
          Inventory[SelectItem] = 0;
        }
      }
    break;

    case(87):
      InventoryAdd(4);
      ChangeDresserElementsById(87,0);
    break;

    case(88):
      PanelOn = true;
    break;

    case(89):
      PanelOn = true;
    break;

    case(91):
      PianoOn = true;
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

void ChangeDresserElementsById(int PrevId, int Newid){
  for(int i = 0; i < DresserID[IdDresser].length; i = i + 4){
    if(DresserID[IdDresser][i] == PrevId){
      DresserID[IdDresser][i] = Newid;
    }
  }
}

void MenuPrint(){
  image(MenuBG, 0, 0, 1600, 900);
  image(NewGame, 600, 350, 400, 90);
  AddHitbox(600, 350, 400, 90, -1);
  image(LoadGame, 600, 500, 400, 90);
  AddHitbox(600, 500, 400, 90, -2);
  image(ExitGame, 600, 650, 400, 90);
  AddHitbox(600, 650, 400, 90, -3);
  image(MenuTitle, 500, 85, 600, 237);
}

void MenuNew(){
  Tuto = true;
  Menu = false;
  Save();
}

void MenuLoad(){
  Menu = false;
  Tuto = false;
  String[] StringLoad = loadStrings("File.txt");
  room = Integer.parseInt(StringLoad[0]);
  facing = Integer.parseInt(StringLoad[1]);
  String[] ElementsLoad1 = split(StringLoad[2], '/');
  for(int i = 0; i < ElementsLoad1.length; i++){
    String[] ElementsLoad2 = split(ElementsLoad1[i], '%');
    for(int j = 0; j < ElementsLoad2.length; j++){
      String[] ElementsLoad3 = split(ElementsLoad2[j], ',');
      for(int k = 0; k < ElementsLoad3.length; k++){
        Elements[i][j][k] = Integer.parseInt(ElementsLoad3[k]);
      }
    }
  }

  String[] DoorLoad1 = split(StringLoad[3], '/');
  for(int i = 0; i < DoorLoad1.length; i++){
    String[] DoorLoad2 = split(DoorLoad1[i], '%');
    for(int j = 0; j < DoorLoad2.length; j++){
      String[] DoorLoad3 = split(DoorLoad2[j], ',');
      for(int k = 0; k < DoorLoad3.length; k++){
        DoorMatrice[i][j][k] = Integer.parseInt(DoorLoad3[k]);
      }
    }
  }

  String[] InventoryLoad = split(StringLoad[4], ',');
  for(int i = 0; i < InventoryLoad.length; i++){
    Inventory[i] = Integer.parseInt(InventoryLoad[i]);
  }

  String[] DresserIDLoad1 = split(StringLoad[5], '%');
  for(int i = 0; i < DresserIDLoad1.length; i++){
    String[] DresserIDLoad2 = split(DresserIDLoad1[i], ',');
    for(int j = 0; j < DresserIDLoad2.length; j++){
      DresserID[i][j] = Integer.parseInt(DresserIDLoad2[j]);
    }
  }

  String[] PanelMaskLoad = split(StringLoad[6], ',');
  for(int i = 0; i < PanelMaskLoad.length; i++){
    if(PanelMaskLoad[i].charAt(0) == '1'){
      Mask[i] = true;
    }
  }

  if(Elements[2][0][0] == 89){
    BlackLight = true;
  }
}

void Save(){
  String[] List = new String[7];
  List[0] = str(room);
  List[1] = str(facing);
  String ElementSave = "";
  for(int i = 0; i < Elements.length; i++){
    for(int j = 0; j < Elements[i].length; j++){
      for(int k = 0; k < Elements[i][j].length; k++){
        ElementSave += str(Elements[i][j][k]);
        ElementSave += ',';
      }
      ElementSave = ElementSave.substring(0, ElementSave.length()-1);
      ElementSave += '%';
    }
    ElementSave = ElementSave.substring(0, ElementSave.length()-1);
    ElementSave += '/';
  }
  ElementSave = ElementSave.substring(0, ElementSave.length()-1);
  List[2] = ElementSave;

  String DoorSave = "";
  for(int i = 0; i < DoorMatrice.length; i++){
    for(int j = 0; j < DoorMatrice[i].length; j++){
      for(int k = 0; k < DoorMatrice[i][j].length; k++){
        DoorSave += str(DoorMatrice[i][j][k]);
        DoorSave += ',';
      }
      DoorSave = DoorSave.substring(0, DoorSave.length()-1);
     DoorSave += '%';
    }
    DoorSave = DoorSave.substring(0, DoorSave.length()-1);
    DoorSave += '/';
  }
  DoorSave = DoorSave.substring(0, DoorSave.length()-1);
  List[3] = DoorSave;

  String InventorySave = "";
  for(int i = 0; i < Inventory.length; i++){
    InventorySave += str(Inventory[i]);
    InventorySave += ',';
  }
  InventorySave = InventorySave.substring(0, InventorySave.length()-1);
  List[4] = InventorySave;

  String DresserIDSave = "";
  for(int i = 0; i < DresserID.length; i++){
    for(int j = 0; j < DresserID[i].length; j++){
      DresserIDSave += str(DresserID[i][j]);
      DresserIDSave += ',';
    }
    DresserIDSave = DresserIDSave.substring(0, DresserIDSave.length()-1);
    DresserIDSave += '%';
  }
  DresserIDSave = DresserIDSave.substring(0, DresserIDSave.length()-1);
  List[5] = DresserIDSave;

  String PanelMaskSave = "";
  for(int i = 0; i < Mask.length; i++){
    if(Mask[i]){
      PanelMaskSave += '1';
    }
    else{
      PanelMaskSave += '0';
    }
    PanelMaskSave += ',';
  }
  PanelMaskSave = PanelMaskSave.substring(0, PanelMaskSave.length()-1);
  List[6] = PanelMaskSave;

  saveStrings("File.txt", List);
}

void Piano(char NewNote){
  if(NoteID == 6){
    return;
  }
  Note[NoteID] = NewNote;
  NoteID++;
  if(NoteID == 6){
    if(Note == {'F', 'A', 'G', 'E', 'D', 'G'}){
      //Do something
    }
  }
}