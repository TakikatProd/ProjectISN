int facing = 0;
int room = 1;
PImage BG;
PImage Door;
PImage Box;
PImage Key;
PImage Windows;
PImage Curtains;
PImage Personnage;


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
  BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/Facing_" + str(facing) + ".png");
  image(BG, 0, 0, width, height);

}

void Tuto(){
  //Boulot de max
  //Si tu veux load des images fait le seulement dans la fonction
}
