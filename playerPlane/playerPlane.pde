// int bombTimeCounter = 0; //count the time passed since the bomb boo!!!!
// boolean bombShoted = false; //check if the bomb is shoted
// int numberOfEnemy; //number of normal enemy
// int numOfBoss; //number of boss. Normally is 0, while boss appear, become 1.
// // playerPlane player = new playerPlane(200,680,100,100,3,3,10);

// // void setup(){
// //     size(400,700);
// // }

// // void draw(){
// //     background(0);
// //     player.updatePosition();
// // }

// //class of the player plane
// /*
// Fields:
//     playerX: x position of plane
//     playerY: y position of plane
//     bloodVol: blood volume of the player's plane
//     basicAttack: the basic harm caused by attacktion
//     numOfBomb: the number of bomb owned by the player. Default value is 3.
//     numOfLife: the player defaultly have 3 life.
//     maxWalkSpeed: Max walk speed
//     walkAccelx=0: acceleration on x aixs
//     walkAccelxtmp=0: acceleration on x aixs temp
//     walkSpeedx=0: initial speed on x aixs
//     walkAccely=0: acceleration on y aixs
//     walkAccelytmp=0: acceleration on x aixs temp
//     walkSpeedy=0: initial speed on x aixs
// */

// /*
// Methods:
//     moveLeft(),moveRight(),moveUp(),moveDown(): control the movement of the player plane
//     stopLeft(),stopRight(),stopUp(), stopDown(): stop the movement of the player plane
//     updatePosition(): update the position of the play and draw
//     useBomb(): use the bomb
//     changeBasicAttack(): change the basic attacktion of the plane
//     beAttacked(): control the hp of the plane while it is attacked
//     destroyed(): defined the process that the plane is destroy and control the animation
// */

// class playerPlane{
//     //define the basic parameters of the players planes
//     int playerX; //x position of plane
//     int playerY; //y position of plane
//     int bloodVol; //blood volume of the player's plane
//     int basicAttack; //the basic harm caused by attacktion
//     int numOfBomb; //the number of bomb owned by the player. Default value is 3.
//     int numOfLife; //the player defaultly have 3 life.
//     int maxWalkSpeed; //Max walk speed
//     float walkAccelx=0; //acceleration on x aixs
//     float walkAccelxtmp=0; //acceleration on x aixs temp
//     float walkSpeedx=0; //initial speed on x aixs
//     float walkAccely=0; //acceleration on y aixs
//     float walkAccelytmp=0; //acceleration on x aixs temp
//     float walkSpeedy=0; //initial speed on x aixs

//     //constructor to define the basic properties of the player's plane
//     playerPlane(int x, int y, int hp, int attack, int bomb, int life, int maxSpeed){
//         playerX = x;
//         playerY = y;
//         bloodVol = hp;
//         basicAttack = attack;
//         numOfBomb = bomb;
//         numOfLife = life;
//         maxWalkSpeed = maxSpeed;
//     }

//     //the case while left key pressed
//     void moveLeft(){
//         walkAccelx = -1;
//         walkAccelxtmp = 0;
//     }

//     //the case while left key released
//     void stopLeft(){
//         walkAccelxtmp = walkAccelx;
//         walkAccelx = 0;
//     }

//     //the case while right key pressed
//     void moveRight(){
//         walkAccelx = 1;
//         walkAccelxtmp = 0;
//     }

//     //the case while right key released
//     void stopRight(){
//         walkAccelxtmp = walkAccelx;
//         walkAccelx = 0;
//     }

//     //the case while up key pressed
//     void moveUp(){
//         walkAccely = -1;
//         walkAccelytmp = 0;
//     }

//     //the case while up key released
//     void stopUp(){
//         walkAccelytmp = walkAccely;
//         walkAccely = 0;
//     }

//     //the case while down key pressed
//     void moveDown(){
//         walkAccely = 1;
//         walkAccelytmp = 0;
//     }

//     //the case while down key released
//     void stopDown(){
//         walkAccelytmp = walkAccely;
//         walkAccely = 0;
//     }

//     //update the position of the plane
//     void updatePosition(){
//         //update the y position of the player
//         //check if y is in the movable space
//         if(playerY >= 10 && playerY <= height - 10){
//             //update the Y value of player
//             playerY += walkSpeedy;
//             //use accleration to decide if the player is pressing up or down
//             if(walkAccely != 0){
//                 if(abs(walkSpeedy) < maxWalkSpeed){
//                     walkSpeedy += walkAccely;
//                 }
//                 else{
//                     if(walkSpeedy > 0){
//                         walkSpeedy = maxWalkSpeed;
//                     }
//                     else{
//                         walkSpeedy = -maxWalkSpeed;
//                     }
//                 }
//             }
//             //if the up or dowm is not pressed
//             else{
//                 //if speed is larger than 1, keep deccelerate, otherwise change speed to 0
//                 if(abs(walkSpeedy) > 1){
//                     walkSpeedy -= walkAccelytmp;
//                 }
//                 else{
//                     walkSpeedy = 0;
//                     walkAccelytmp = 0;
//                 }
//             }

//         }
//         //While the player is at the edge of the frame
//         else{
//             if (playerY < 10){
//                 walkSpeedy = 0;
//                 playerY = 10;
//                 walkAccely = 0;
//             }
//             if (playerY > height - 10){
//                 walkSpeedy = 0;
//                 playerY = height - 10;
//                 walkAccely = 0;
//             }
//         }
//         //Update the x position of the players
//         //check if x is in the movable space
//         if(playerX >= 10 && playerX <= width - 10){
//             //update the X value of player
//             playerX += walkSpeedx;
//             //use acceleration to decide if the player is pressing left or right
//             if(walkAccelx != 0){
//                 if(abs(walkSpeedx) < maxWalkSpeed){
//                     walkSpeedx += walkAccelx;
//                 }
//                 else{
//                     if(walkAccelx > 0){
//                         walkSpeedx = maxWalkSpeed;
//                     }
//                     else{
//                         walkSpeedx =- maxWalkSpeed;
//                     }
//                 }
//             }
//             // left or right key is not pressed
//             else{
//                 //if speed is larger than 1, keep decceleration, otherwise change speed to 0
//                 if(abs(walkSpeedx) > 1){
//                     walkSpeedx -= walkAccelxtmp;
//                 }
//                 else{
//                     walkSpeedx = 0;
//                     walkAccelxtmp = 0;
//                 }
//             }
//         }
//         //While the player is at the edge of the frame
//         else{
//             if(playerX < 10){
//                 walkSpeedx = 0;
//                 playerX = 10;
//                 walkAccelx = 0;
//             }
//             if(playerX > width - 10){
//                 walkSpeedx = 0;
//                 playerX = width - 10;
//                 walkAccelx = 0;
//             }
//         }
//         //draw the plane in the canvas
//         rectMode(CENTER);
//         fill(255,255,255);
//         rect(playerX, playerY, 20, 20);
//         drawAttaction();
//     }

//     //clear the small enemy, cause 200 harm to the boss, decrease the num of bomb by 1, lead to the animimation
//     void useBomb(){
//         numOfBomb --;
//         if (bombTimeCounter == 10){
//             if(numOfBoss != 0){
//                 boss.bloodVol -= 200;
//             }
//             numOfNormalEnemy = 0;
//         }
//         colorMode(RGB,255,255,255,100);
//         fill(255,255,255,100-Math.abs(100 - i*10));
//         rect(0,0,width,height);
//         if(bombTimeCounter == 20){
//             bombShoted = false;
//             bombTimeCounter = 0;
//         }else{
//             bombTimeCounter ++;
//         }
//     }

//     //change the basic attack and also control the animation of the bullet
//     void changeBasicAttack(char bulletType){
//         switch(bulletType){
//             case 'A':
//             case 'B':
//             case 'C':
//         }
//     }

//     //minus the life while be attacked
//     void beAttacked(int attackType){
//         switch(attackType){
//             case 1:
//             case 2:
//             case 3:
//         }
//     }

//     //The player is killed. Life num -1. check if still have life
//     void destroyed(){
//         if(bloodVol == 0){
//             numOfLife --;
//             //animation of destroy
//         }
//     }
// }

// //defined the keyPressed action
// void keyPressed(){
//     switch(keyCode){
//         case LEFT:
//             player.moveLeft();
//         break;
//         case RIGHT:
//             player.moveRight();
//         break;
//         case UP:
//             player.moveUp();
//         break;
//         case DOWN:
//             player.moveDown();
//         break;
//     }
// }

// //defined the keyReleased action
// void keyReleased(){
//     switch(keyCode){
//         case LEFT:
//             player.stopLeft();
//         break;
//         case RIGHT:
//             player.stopRight();
//         break;
//         case UP:
//             player.stopUp();
//         break;
//         case DOWN:
//             player.stopDown();
//         break;
//     }
// }

