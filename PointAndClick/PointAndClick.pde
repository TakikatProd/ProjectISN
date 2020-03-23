int facing = 0;
int room = 1;
PImage BG;
PImage Door;

void setup(){
  size(1600,900);
  Door = loadImage("/Object/Interactible/Idle.png")
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
     RoomUpdate();
     break;
     
   case(DOWN):
     if(facing >= 4){
       facing -= 4;
     }
     RoomUpdate();
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
     RoomUpdate();
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
     RoomUpdate();
     break;
     
    default:
      break;
 }
}

void RoomUpdate(){
  BG = loadImage("/Room_" + str(room) + "/Facing_" + str(facing) + ".png");
  image(BG, 0, 0, width, height);
}

void Load(){
  BG = loadImage("/Rooms" + "/ROOM_" + str(room) + "/Facing_" + str(facing) + ".png");
  image(BG, 0, 0, width, height);

}