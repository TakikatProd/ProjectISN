int facing = 0;
int room = 0;
PImage BG;
PImage Door; //id 40-59
PImage OpenDoor; //id 60-79
PImage Windows; //id 1
PImage Curtains; //id 2
PImage Box; //id 3
PImage[] Key = new PImage[20]; //id 20-39
PImage Personnage; //id 4

PImage[] Tutorial;

//Inventaire
int[] Inventory = new int[9];
boolean Inv = true;
PImage SlotInventor;
PImage[] Items = new PImage[21];

//hitbox
int[][] Hitbox = new int[10][5];
int NbElements = 0;

boolean Tuto = false;
boolean Change = false;
int PhaseTuto = 0;
int Fade = 0;

int[][][] Elements = 
{
  {{4,3,6,  2,4,2,  20,1,1},  {0},  {3,22,14,  3,24,14,  3,23,12,  3,25,12,  20,10,10},  {0},  {2,1,1},  {2,1,1},  {2,1,1},  {2,1,1}}
};
int[][][] DoorMatrice = 
{
  {{20,7,6},  {0}, {0}, {0}}
};

void setup(){
  size(1600,900);
  Door = loadImage("/Object/Interactible/Porte.png");
  Box = loadImage("/Object/Others/Boite.png");
  Windows = loadImage("/Object/Others/Windows.png");
  Curtains = loadImage("/Object/Others/Rideau.png");
  Personnage = loadImage("/Object/Others/Player.png");
  SlotInventor = loadImage("/Inventor/Box.png");

  Items[20] = loadImage("/Inventor/Items/Key.png");
  Key[0] = loadImage("/Inventor/Items/Key.png");
  InventoryAdd(20);
  //Travail de theophile
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
      }
    }

    //Fade out
    if(Change){
      Fade++;
      fill(0,10);
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
    BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/Facing_" + str(facing) + ".png");
    image(BG, 0, 0, width, height);
    if(DoorMatrice[room][facing][0] != 0){
      image(Door, DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200);
    }
  } else {
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

        case(20):
          image(Key[0], Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100);
          AddHitbox(Elements[room][facing][i + 1] * 100, Elements[room][facing][i + 2] * 100, 100, 100, 20);
        break;

        default:
        break;
      }
    }
  }
  rotate(0);
  translate(0,0);
  if(Inv){
    InventoryPrint();
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
  Hitbox[NbElements][0] = posx;
  Hitbox[NbElements][1] = posy;
  Hitbox[NbElements][2] = sizex;
  Hitbox[NbElements][3] = sizey;
  Hitbox[NbElements][4] = id;
  NbElements++;
}

void OnHitbox(int id){
  switch(id){
    case(20):
      InventoryAdd(20);
      for(int i = 0; i < Elements[room][facing].length; i = i + 3){
        if(Elements[room][facing][i] == 20){
          Elements[room][facing][i] = 0;
          Elements[room][facing][i+1] = 0;
          Elements[room][facing][i+2] = 0;
        }
      }
    break;
    case(41):

    break;
    case(42):

    break;
    case(43):

    break;
    default:
    break;
  }
}