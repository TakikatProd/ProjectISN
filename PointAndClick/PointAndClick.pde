int facing = 0;
int room = 0;
PImage BG;
PImage Door; //id 1
PImage Windows; //id 2
PImage Curtains; //id 3
PImage Key; //id 20-30
PImage Personnage;

int[][][] Elements = 
{
  {{0},  {0},  {1,10,10,  1,10,10,  20,10,10},  {0},  {0},  {0},  {0},  {0}}
};
int[][][] DoorMatrice = 
{
  {{20,5,4},  {0}, {0}, {0}}
};

void setup(){
  size(1600,900);
  Door = loadImage("/Object/Interactible/Porte.png");
  //Travail de theophile
}

void draw(){
  fill(255);
  square(10,10,500);
  fill(0);
  text(str(facing), 20, 30);
}

void keyPressed(){
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
  //BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/FACING_" + str(facing) + ".png");
  //image(BG, 0, 0, width, height);
  if(facing < 4){
    if(DoorMatrice[room][facing][0] != 0){
      image(Door, DoorMatrice[room][facing][1] * 100, DoorMatrice[room][facing][2] * 100, 164, 200);
    }
  }
}

void Tuto(){
  //Boulot de max
  //Si tu veux load des images fait le seulement dans la fonction
}
