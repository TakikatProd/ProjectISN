int facing = 0;
int room = 0;
PImage BG;
PImage Door;
PImage Windows; //id 1
PImage Curtains; //id 2
PImage Box; //id 3
PImage Key; //id 20-30
PImage Personnage; //id 4

PImage[] Tutorial;

boolean Tuto = false;
boolean Change = false;
int PhaseTuto = 0;
int Fade = 0;

int[][][] Elements = 
{
  {{0},  {0},  {3,28,20,  3,27,22,  3,29,22,  3,30,20,  3,30,18,  20,10,10},  {0},  {0},  {0},  {0},  {0}}
};
int[][][] DoorMatrice = 
{
  {{20,5,4},  {0}, {0}, {0}}
};

void setup(){
  size(1600,900);
  Door = loadImage("/Object/Interactible/Porte.png");
  Box = loadImage("/Object/Others/Boite.png");
  Windows = loadImage("/Object/Others/Windows.png");
  Curtains = loadImage("/Object/Others/Rideau.png");
  
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
     
    default:
      break;
 }
}

void Load(){
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
        image(BG, 350, 0, 900, 900);
      break;

      case(5):
        image(BG, 0, -1250, 900, 900);
      break;

      case(6):
        image(BG, -1250, -900, 900, 900);
      break;

      case(7):
        image(BG, -900, 350, 900, 900);
      break;
    }
  }
  if(Elements[room][facing][0] != 0){
    for(int i = 0; i < Elements[room][facing].length; i = i + 3){
      switch(Elements[room][facing][i]){
        case(3):
          image(Box, Elements[room][facing][i + 1] * 25, Elements[room][facing][i + 2] * 25, 68, 50);
        break;

        default:
        break;
      }
    }
  }
}

void mousePressed() {
  if(Tuto){
    Change = true;
  }
}
