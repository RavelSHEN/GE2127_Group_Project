import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class playerPlane extends PApplet {

int bombTimeCounter = 0; //count the time passed since the bomb boo!!!!
boolean bombShoted = false; //check if the bomb is shoted
int numberOfEnemy; //number of normal enemy
int numOfBoss; //number of boss. Normally is 0, while boss appear, become 1.
playerPlane player = new playerPlane(200,680,100,100,3,3,10);

public void setup(){
    size(400,700);
}

public void draw(){
    background(0);
    player.updatePosition();
}

//class of the player plane
/*
Fields:
    playerX: x position of plane
    playerY: y position of plane
    bloodVol: blood volume of the player's plane
    basicAttack: the basic harm caused by attacktion
    numOfBomb: the number of bomb owned by the player. Default value is 3.
    numOfLife: the player defaultly have 3 life.
    maxWalkSpeed: Max walk speed
    walkAccelx=0: acceleration on x aixs
    walkAccelxtmp=0: acceleration on x aixs temp
    walkSpeedx=0: initial speed on x aixs
    walkAccely=0: acceleration on y aixs
    walkAccelytmp=0: acceleration on x aixs temp
    walkSpeedy=0: initial speed on x aixs
*/

/*
Methods:
    moveLeft(),moveRight(),moveUp(),moveDown(): control the movement of the player plane
    stopLeft(),stopRight(),stopUp(), stopDown(): stop the movement of the player plane
    updatePosition(): update the position of the play and draw
    useBomb(): use the bomb
    changeBasicAttack(): change the basic attacktion of the plane
    beAttacked(): control the hp of the plane while it is attacked
    destroyed(): defined the process that the plane is destroy and control the animation
*/

class playerPlane{
    //define the basic parameters of the players planes
    int playerX; //x position of plane
    int playerY; //y position of plane
    int bloodVol; //blood volume of the player's plane
    int basicAttack; //the basic harm caused by attacktion
    int numOfBomb; //the number of bomb owned by the player. Default value is 3.
    int numOfLife; //the player defaultly have 3 life.
    int maxWalkSpeed; //Max walk speed
    float walkAccelx=0; //acceleration on x aixs
    float walkAccelxtmp=0; //acceleration on x aixs temp
    float walkSpeedx=0; //initial speed on x aixs
    float walkAccely=0; //acceleration on y aixs
    float walkAccelytmp=0; //acceleration on x aixs temp
    float walkSpeedy=0; //initial speed on x aixs

    //constructor to define the basic properties of the player's plane
    playerPlane(int x, int y, int hp, int attack, int bomb, int life, int maxSpeed){
        playerX = x;
        playerY = y;
        bloodVol = hp;
        basicAttack = attack;
        numOfBomb = bomb;
        numOfLife = life;
        maxWalkSpeed = maxSpeed;
    }

    //the case while left key pressed
    public void moveLeft(){
        walkAccelx = -1;
        walkAccelxtmp = 0;
    }

    //the case while left key released
    public void stopLeft(){
        walkAccelxtmp = walkAccelx;
        walkAccelx = 0;
    }

    //the case while right key pressed
    public void moveRight(){
        walkAccelx = 1;
        walkAccelxtmp = 0;
    }

    //the case while right key released
    public void stopRight(){
        walkAccelxtmp = walkAccelx;
        walkAccelx = 0;
    }

    //the case while up key pressed
    public void moveUp(){
        walkAccely = -1;
        walkAccelytmp = 0;
    }

    //the case while up key released
    public void stopUp(){
        walkAccelytmp = walkAccely;
        walkAccely = 0;
    }

    //the case while down key pressed
    public void moveDown(){
        walkAccely = 1;
        walkAccelytmp = 0;
    }

    //the case while down key released
    public void stopDown(){
        walkAccelytmp = walkAccely;
        walkAccely = 0;
    }

    //update the position of the plane
    public void updatePosition(){
        //update the y position of the player
        //check if y is in the movable space
        if(playerY >= 10 && playerY <= height - 10){
            //update the Y value of player
            playerY += walkSpeedy;
            //use accleration to decide if the player is pressing up or down
            if(walkAccely != 0){
                if(abs(walkSpeedy) < maxWalkSpeed){
                    walkSpeedy += walkAccely;
                }
                else{
                    if(walkSpeedy > 0){
                        walkSpeedy = maxWalkSpeed;
                    }
                    else{
                        walkSpeedy = -maxWalkSpeed;
                    }
                }
            }
            //if the up or dowm is not pressed
            else{
                //if speed is larger than 1, keep deccelerate, otherwise change speed to 0
                if(abs(walkSpeedy) > 1){
                    walkSpeedy -= walkAccelytmp;
                }
                else{
                    walkSpeedy = 0;
                    walkAccelytmp = 0;
                }
            }

        }
        //While the player is at the edge of the frame
        else{
            if (playerY < 10){
                walkSpeedy = 0;
                playerY = 10;
                walkAccely = 0;
            }
            if (playerY > height - 10){
                walkSpeedy = 0;
                playerY = height - 10;
                walkAccely = 0;
            }
        }
        //Update the x position of the players
        //check if x is in the movable space
        if(playerX >= 10 && playerX <= width - 10){
            //update the X value of player
            playerX += walkSpeedx;
            //use acceleration to decide if the player is pressing left or right
            if(walkAccelx != 0){
                if(abs(walkSpeedx) < maxWalkSpeed){
                    walkSpeedx += walkAccelx;
                }
                else{
                    if(walkAccelx > 0){
                        walkSpeedx = maxWalkSpeed;
                    }
                    else{
                        walkSpeedx =- maxWalkSpeed;
                    }
                }
            }
            // left or right key is not pressed
            else{
                //if speed is larger than 1, keep decceleration, otherwise change speed to 0
                if(abs(walkSpeedx) > 1){
                    walkSpeedx -= walkAccelxtmp;
                }
                else{
                    walkSpeedx = 0;
                    walkAccelxtmp = 0;
                }
            }
        }
        //While the player is at the edge of the frame
        else{
            if(playerX < 10){
                walkSpeedx = 0;
                playerX = 10;
                walkAccelx = 0;
            }
            if(playerX > width - 10){
                walkSpeedx = 0;
                playerX = width - 10;
                walkAccelx = 0;
            }
        }
        //draw the plane in the canvas
        rectMode(CENTER);
        fill(255,255,255);
        rect(playerX, playerY, 20, 20);
        drawAttaction();
    }

    //clear the small enemy, cause 200 harm to the boss, decrease the num of bomb by 1, lead to the animimation
    public void useBomb(){
        numOfBomb --;
        if (bombTimeCounter == 10){
            if(numOfBoss != 0){
                boss.bloodVol -= 200;
            }
            numOfNormalEnemy = 0;
        }
        colorMode(RGB,255,255,255,100);
        fill(255,255,255,100-Math.abs(100 - i*10));
        rect(0,0,width,height);
        if(bombTimeCounter == 20){
            bombShoted = false;
            bombTimeCounter = 0;
        }else{
            bombTimeCounter ++;
        }
    }

    //change the basic attack and also control the animation of the bullet
    public void changeBasicAttack(char bulletType){
        switch(bulletType){
            case 'A':
            case 'B':
            case 'C':
        }
    }

    //minus the life while be attacked
    public void beAttacked(int attackType){
        switch(attackType){
            case 1:
            case 2:
            case 3:
        }
    }

    //The player is killed. Life num -1. check if still have life
    public void destroyed(){
        if(bloodVol == 0){
            numOfLife --;
            //animation of destroy
        }
    }
}

//defined the keyPressed action
public void keyPressed(){
    switch(keyCode){
        case LEFT:
            player.moveLeft();
        break;
        case RIGHT:
            player.moveRight();
        break;
        case UP:
            player.moveUp();
        break;
        case DOWN:
            player.moveDown();
        break;
    }
}

//defined the keyReleased action
public void keyReleased(){
    switch(keyCode){
        case LEFT:
            player.stopLeft();
        break;
        case RIGHT:
            player.stopRight();
        break;
        case UP:
            player.stopUp();
        break;
        case DOWN:
            player.stopDown();
        break;
    }
}

class BossEnemy extends Character{
    float angle;
    float speed;
    int deadTime;
    boolean totallyDied;
    ArrayList <Projectile> bossBullets = new ArrayList<Projectile>();
    BossEnemy(PVector pos, PVector vel, PVector acc, float scaleFactor){
        super(pos, vel, acc);
        alive = true;
        this.scaleFactor = scaleFactor;
        // the size of boss
        wid = 200;
        hei = 200;
        health = (int)random(8,12); 
        totallyDied = false;
        // boss moves in wavy movement
        speed = 40; 
        angle = 0; 
    }
  
    BossEnemy(){
        super();
        totallyDied = true;
    }
    public void update(){
        super.update();
        angle += 0.04f;
    }
  
    public void shoot(){
    // boss bullete attract to player
        PVector bulletPos = new PVector(pos.x+ speed * cos(angle) , pos.y + hei / 2);
        float bulletAngle = atan2(Main.player.pos.y - bulletPos.y, Main.player.pos.x - bulletPos.x);
        PVector bulletVel = new PVector(8 * cos(bulletAngle), 8 * sin(bulletAngle));
        bossBullets.add(new Projectile(bulletPos, bulletVel, 2));
    }
  
    public void trackBullets(){
        // bossbullet control
        for(int i = 0; i < bossBullets.size(); i++){
            Projectile temp = bossBullets.get(i);
            temp.update();
            temp.drawMe();
            if(temp.detectBound()){
            bossBullets.remove(temp);
            }
        }
        for(int i = 0; i < bossBullets.size(); i++){
            Projectile temp = bossBullets.get(i);
            // if boss bullet hits player
            if(temp.hitCharacter(Main.player) && !Main.player.invincible){
                Main.player.decreaseHealth(1);
                Main.player.pos = new PVector(width / 2, height * 9 / 10);
                Main.player.invincible = true;
                Main.player.invincibleTime = millis();
            }
        }
    }
    public void drawMe(){
        pushMatrix();
        translate(pos.x + speed * cos(angle),pos.y);
         
        // head
        fill(87, 70, 165);  // blue
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        beginShape();
        vertex(-100, 0);
        bezierVertex(-20, -90, 20, -90, 100, 0);
        vertex(100, 0);
        endShape();

        // body
        fill(142, 134, 175);  // light blue
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        beginShape();
        vertex(-100, 0);
        vertex(100, 0);
        vertex(130, 20);
        vertex(-130, 20);
        endShape();
        fill(87, 70, 165);  // blue
        if(!alive)  fill(131, 131, 131);  // grey
        beginShape();
        vertex(-130, 20);
        vertex(-140, 50);
        vertex(140, 50);
        vertex(130, 20);
        endShape();
        // bottom
        fill(172, 79, 183);  // pink
        if(!alive)  fill(131, 131, 131);  // grey
        beginShape();
        vertex(-110, 50);
        vertex(-70, 90);
        bezierVertex(-50, 95, 50, 95, 70, 90);
        vertex(70, 90);
        vertex(110, 50);
        endShape();

        // windows
        fill(108, 93, 170);  // purple
        if(!alive)  fill(131, 131, 131);  // grey
        ellipse(-50, 70, 20, 20);
        ellipse(0, 70, 20, 20);
        ellipse(50, 70, 20, 20);

        // door
        fill(255);  // white
        stroke(227, 96, 245);  // pink
        if(!alive)  fill(131, 131, 131);  // grey
        strokeWeight(5);
        beginShape();
        vertex(-25, 0);
        vertex(-10, -25);
        vertex(10, -25);
        vertex(25, 0);
        endShape();

        // special windows
        fill(255, 238, 39);  // yellow
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        strokeWeight(5);
        beginShape();
        vertex(13, -30);
        vertex(50, -30);
        bezierVertex(55, -28, 58, 20, 13, -30);
        endShape();
        fill(255, 238, 39);  // yellow
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        strokeWeight(5);
        beginShape();
        vertex(-13, -30);
        vertex(-50, -30);
        bezierVertex(-55, -28, -58, 20, -13, -30);
        endShape();

        strokeWeight(1);
        popMatrix();
    }
  
}
class Character{

    //fields
    PVector pos, vel, acc;  // position, velocity, and acceleration
    int health;  // health of the object
    float wid, hei;  // width and height of the object
    float scaleFactor;  // size of the object
    float damp = 0.8f;  // constant damping factor
    boolean alive;  // check if the character is alive
    int colour;  // color of the character
    // define position, velocity and acceleration of airplane
    Character(PVector pos, PVector vel, PVector acc){
        this.pos = new PVector(pos.x, pos.y);
        this.vel = new PVector(vel.x, vel.y);
        this.acc = new PVector(acc.x, acc.y);

    }
    Character(){
        pos = new PVector(-1,-1);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
    }
    // the look of characters
    public void drawMe(){
        //rocket fin 1
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,3);
        bezierVertex(10,12,-10,15,-25,15);
        vertex(-25,13);
        bezierVertex(-20,13,-18,10,-18,5);
        vertex(-16,5);
        bezierVertex(-12,7,-12,8,-6,10);
        bezierVertex(-5,10,0,8,10,4);
        endShape();

        //rocket fin 2
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,-3);
        bezierVertex(10,-12,-10,-15,-25,-15);
        vertex(-25,-13);
        bezierVertex(-20,-13,-18,-10,-18,-5);
        vertex(-16,-5);
        bezierVertex(-12,-7,-12,-8,-6,-10);
        bezierVertex(-5,-10,0,-8,10,-4);
        endShape(CLOSE);


        //rocket bell
        fill(colour);
        stroke(10);
        beginShape();
        vertex(-20,3);
        bezierVertex(-20,5,-25,5,-27,6);
        vertex(-27,-6);
        bezierVertex(-25,-5,-20,-5,-20,-3);
        endShape(CLOSE);

        //rocket body
        fill(colour);
        stroke(10);
        beginShape();
        vertex(30,0);
        bezierVertex(20,8,0,8,-20,7);
        bezierVertex(-20,5,-20,-5,-20,-7);
        bezierVertex(0,-8,20,-8,30,0);
        endShape(CLOSE);

        //doors & windows
        fill(colour);
        stroke(10);
        ellipseMode(CENTER);
        ellipse(4,4.5f,7,3);
        line(5,5,7.5f,5);
        fill(100);
        stroke(10);
        ellipse(18,2,4,2);
        ellipse(18,-2,4,2);

        //rocket fin top
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,0);
        vertex(7,1);
        vertex(-25,1);
        vertex(-25,-1);
        vertex(7,-1);
        endShape(CLOSE);

    }
    public void update() {
        vel.mult(damp);
        os.add(vel);
    }

    public void move(PVector acc){
        this.acc = acc;
        vel.add(acc);
    }

    // detect if this character hits the other
    public boolean hitCharacter(Character other){
        // ditect distance between objects
        if(abs(other.pos.x - pos.x) < (wid / 2 + other.wid / 2) && abs(other.pos.y - pos.y) < (hei / 2 + other.hei / 2)){
            return true;
        }
        else {
            return false;
        }
    }
    // calculate health
    public void decreaseHealth(int lostHealth){
        health = health - lostHealth;
    }

    // when character reaches the left or right edge of the screen, wrap around
    public void detectBound(){
        if(pos.x <0){
            pos.x = width;
        }
        else if(pos.x > width){
            pos.x = 0;
        }
    }
}
class Enemy extends Character{
    int deadTime;
    int dir = 1;
    float angle;
    Enemy(PVector pos, PVector vel, PVector acc, float scaleFactor){
        super(pos, vel, acc);
        this.scaleFactor = scaleFactor;
        this.wid = 25;
        this.hei = 50;
        colour = color(random(92, 252), random(92, 252), random(92, 252));
        alive = true;
        angle = PI / 4;
        float randomHealth = random(2,3);
        if(randomHealth < 2.5f){
            health = 2;
        }
        else{
            health = 3;
        }
    }

    public void drawMe(){
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(PI / 2);
        if(!alive){
            colour = color(147, 147, 147);  // grey
        }
        scale(scaleFactor);
        super.drawMe();
        popMatrix();
    }

    public void update(){
        // random move
        if(alive){
            pos.x += vel.x * cos(angle);
            pos.y += vel.y * sin(angle);
            angle += 0.04f * dir;
            if(random(0, 16) < 8){
                dir *= -1;
            }
        } 
    }

    public void detectBound(){
        super.detectBound();
        // if enemy reaches the bottom of the scrren, disappear and removed from enemies arraylist
        if (pos.y > height || pos.y < 0){
            Main.enemies.remove(this);
        }
    }
    
}
int NUM_ENEMY = 5;
float speed = 2;
// accelerations controled by keyboard
PVector upAcc = new PVector(0, -speed);
PVector downAcc = new PVector(0, speed);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);
boolean up, down, left, right, shoot;
boolean welcomePage = true;  // welcome page
boolean restart = false;  // restart game
static int score = 0;
boolean alive = true;  // if the player is alive
int shootTime = 0;  // shoot interval time
int bossShootInterval = 0;  // boss shoot interval time
int bossShootTime = 0;  // boss shooting time
int bossRestTime = millis();  // boss resting time
int killedEnemy = 0;  // count the number of died enemy, boss appears every killed 30 enemies
static Player player;
static BossEnemy boss;
// arraylist hold bullets and enemies
static ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage img;  // background image

public void setup(){
    size(600, 800);
    img = loadImage("space.jpg");
    
    // create player
    PVector pos = new PVector(width/2, height*9/ 10);
    PVector vel = new PVector(0, 0);
    PVector acc = new PVector(0, 0); 
    player = new Player(pos, vel, acc);
    
    // initialize bossEnemy
    boss = new BossEnemy();

    // enemy create, show up at top of the screen, move down
    for(int i = 0; i < NUM_ENEMY; i++){
        PVector enemyPos = new PVector(random(0, width), 0);
        PVector enemyVel = new PVector(random(-3, 3), random(1, 3));// flow down vertically
        PVector enemyAcc = new PVector(0, 0); 
        enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5f, 1)));
    }
}

public void draw(){
    // draw background image
    image(img, 0, 0, 640, 1136);
    if(welcomePage){
        PFont arial = loadFont("Bauhaus93-48.vlw");
        textFont(arial, 48);
        textAlign(CENTER);
        fill(255);
        text("SHOOT! SHOOT!", width / 2, height / 3);
        PFont bradly = loadFont("BradleyHandITC-48.vlw");
        textFont(bradly, 24);
        text("Press arrow up, down, left right to move", width / 2, height / 2);
        
        text("Press S to shoot", width / 2, height / 2 + 50);
        text("Press B to start", width / 2, height / 2 + 100);
        
    }
    else{
        if(alive){
            // enemies draw and update  
            for(int i = 0; i< enemies.size(); i++) {
                Enemy tempEnemy = enemies.get(i);
                tempEnemy.update();
                tempEnemy.detectBound();
                tempEnemy.drawMe();
                
                // detect collision between enemy and player
                if(player.hitCharacter(tempEnemy) && !player.invincible) {
                    player.decreaseHealth(1);
                    player.pos = new PVector(width / 2, height * 9 / 10);
                    // gives player 3 seconds invincible time after being attacked
                    player.invincible = true;
                    player.invincibleTime = millis();
                }
                // if enemy is dying, wait for 1 sec, and then remove from the list
                if(!tempEnemy.alive){  
                    int currentTime = millis();
                    if(currentTime - tempEnemy.deadTime > 1000){
                        enemies.remove(tempEnemy);
                        score += 10;
                        killedEnemy ++;  // count one killed enemy
                    }
                }
            }
            if(killedEnemy >= random(10, 20)) {
                PVector bPos = new PVector(width / 2, 0);
                PVector bVel = new PVector(0, random(15, 30));
                PVector bAcc = new PVector(0, 0);
                boss = new BossEnemy(bPos, bVel, bAcc, 1);
                killedEnemy = 0;
            }
            
            if(boss.totallyDied == true){   // produce enemy only boss is not on the screen
                // when there is an enemy died or disappeared, create a new enemy
                for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
                    PVector enemyPos = new PVector(random(0, width), 0);
                    PVector enemyVel = new PVector(random(-3, 3), random(0.1f, 3));// flow down vertically
                    PVector enemyAcc = new PVector(0, 0); 
                    enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5f, 1)));
                }
             }

             if(boss.pos.y != -1){
                if(boss.alive){
                    // boss shoots every 1 second, shooting 5 seconds, interval time is 0.3 sec
                int currentTime = millis();
                    if(currentTime - bossRestTime > 1000){
                        if(currentTime - bossShootTime < 5000){  // keep shooting
                             if(currentTime - bossShootInterval > 300){
                                    boss.shoot();
                                    bossShootInterval = currentTime;
                                }
                        }
                        else{  // stop shooting, begin count rest time
                            bossRestTime = currentTime;
                        }
                    }
                    else{  // boss is taking a break
                        bossShootTime = currentTime;
                    }
                    // if player hit the boss, player died
                 if(player.hitCharacter(boss) && !player.invincible){
                        player.decreaseHealth(1);
                        player.pos = new PVector(width / 2, height * 9 / 10);
                        // gives player 3 seconds invincible time after being attacked
                        player.invincible = true;
                        player.invincibleTime = millis();
                    }
                }
                    // if boss is died, wait for 3 sec, and then not draw boss
                else{  
                        int currentTime = millis();
                        if(currentTime - boss.deadTime > 3000){
                            boss.totallyDied = true;
                        }
                    }
                if(!boss.totallyDied){
                    boss.update();
                    boss.drawMe();
                    boss.trackBullets();
                }
            }

            // Control the plane
            if (up) player.move(upAcc);
            if (down) player.move(downAcc);
            if (left) player.move(leftAcc);
            if (right) player.move(rightAcc);
            if(shoot){
                // calculate the interval shoot time
                int currentTime = millis();
                // the bullet can't be shooted within shooting interval from last time shooting
                if(currentTime - shootTime > 300){
                    player.shoot();
                    shootTime = currentTime;
                }
            }
            
            
            // player movement and draw
            player.update();
            player.detectBound();
            player.drawMe();
            player.trackBullets();
            // if player is invincible, count invincible time
            if(player.invincible){
                int currentTime = millis();
                println("currentTime - invincibleTime = " + (currentTime - player.invincibleTime));
                if(currentTime - player.invincibleTime >= 3000){
                    player.invincible = false;
                }
            }
                
            // if player is out of health, die, and create a new player
            if(player.health <= 0){
                alive = false;
            }
            
            // display the score, health at right top corner at size 44
            PFont arial = loadFont("Arial-BoldMT-48.vlw");  // the font is stored in the "data" file
            textFont(arial, 24);
            textAlign(RIGHT);
            fill(0, 102, 154);
            text("health: " + player.health, 550, 50);
            text("score " + score, 550, 100);
            
        }
        else {
            // player is dead

            // remove everything
            for(int i = 0; i < enemies.size(); i++){
                enemies.remove(i);
            }
            PFont arial = loadFont("Arial-BoldMT-48.vlw");  // the font is stored in the "data" file
            textFont(arial, 48);
            textAlign(CENTER);
            fill(255);
            text("Oop, dead", width / 2, height / 3);
            text("score " + score, width / 2, height / 2);
            PFont bradly = loadFont("BradleyHandITC-48.vlw");
            textFont(bradly, 36);
            text("Press R to restart", width / 2, height * 2 / 3);
            if(restart){
                alive = true;
                PVector pos = new PVector(width/2, height * 9/ 10);
                PVector vel = new PVector(0, 0);
                PVector acc = new PVector(0, 0); 
                player = new Player(pos, vel, acc);
                score = 0;
                killedEnemy = 0;
                restart = false;
                boss = new BossEnemy();
                // enemy create, show up at top of the screen, move down
                for(int i = 0; i < NUM_ENEMY; i++){
                    PVector enemyPos = new PVector(random(0, width), 0);
                    PVector enemyVel = new PVector(random(-3, 3), random(1, 3));
                    PVector enemyAcc = new PVector(0, 0); 
                    enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5f, 1)));
                }
            }
        }
    }
}


public void keyPressed() {
    if(key == 'z' || key == 'Z'){
        shoot = true;
    }
    if(key == 'b' || key == 'B'){
        welcomePage = false;
    }
    if(key == 'r' ||key == 'R'){
        restart = true;
    }
    if (key == CODED) {
        if (keyCode == UP) up = true;
        if (keyCode == DOWN) down = true;
        if (keyCode == LEFT) left = true;
        if (keyCode == RIGHT) right = true;
    }
}

public void keyReleased() {
    if(key == 'z' || key == 'Z'){
        shoot = false;
    }
    if (key == CODED) {
        if (keyCode == UP) up = false;
        if (keyCode == DOWN) down = false;
        if (keyCode == LEFT) left = false;
        if (keyCode == RIGHT) right = false;
    }
}


class Player extends Character{
    int invincibleTime;
    boolean invincible;
    ArrayList<Projectile> bullets = new ArrayList<Projectile>();
    Player(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc); 
        health = 5;
        wid = 25;
        hei = 50;
        invincibleTime = 0;
        invincible = false;
        alive = true;
        colour = color(202, 209, 206);
    }
    
    public void drawMe(){
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(-PI / 2);
        super.drawMe();
        popMatrix();
    }
    
    public void detectBound(){
        super.detectBound();
        //if the player reaches the top or bottom edge of the screen, stop moving y axis
        if((pos.y - hei/2)< 0){
            pos.y = hei / 2;
        } 
        if ((pos.y + hei/2) > height){
            pos.y = height - hei/ 2;
        }
    }
    
    
    public void shoot(){
        PVector bulletePos = new PVector(pos.x, pos.y);
        PVector bulleteVel = new PVector(0, -8);
        bullets.add(new Projectile(bulletePos, bulleteVel, 1));
    }
    // track all the bullets
    public void trackBullets(){
        for(int i = 0; i < bullets.size(); i++){
            Projectile tempBullet = bullets.get(i);
            tempBullet.update();
            tempBullet.drawMe();
            // if bullet goes out of screen, remove it from bullet list
            if(tempBullet.detectBound()){
                bullets.remove(i);
            }
            // detect if bullet hits boss
            if(tempBullet.hitCharacter(Main.boss) && Main.boss.alive){
                Main.boss.decreaseHealth(1);
                bullets.remove(i); 
                if(Main.boss.health <= 0){
                    Main.boss.alive = false;
                    Main.boss.deadTime = millis();
                    Main.score += 100;
                }
            }
            // detect if bullet hits enemy
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempBullet.hitCharacter(tempEnemy) && tempEnemy.alive){
                        tempEnemy.decreaseHealth(1);
                        // if enemy is totally hitted, wait one 1s, and then removed
                        if(tempEnemy.health <= 0){
                            tempEnemy.alive = false;
                            tempEnemy.deadTime = millis();
                        }
                        bullets.remove(i);
                }
            }
        }
    }
}
class Projectile{
    PVector pos,vel;
    float scaleFactor;
    Projectile(PVector pos, PVector vel, float scaleFactor){
        this.pos = new PVector(pos.x, pos.y);
        this.vel = new PVector(vel.x, vel.y);
        this.scaleFactor = scaleFactor;
    }
    public void drawMe(){
         noFill(); 
        pushMatrix();
        translate(pos.x, pos.y);
        stroke(255);
        strokeWeight(3);
        scale(scaleFactor);
        line(0, 0, 0, -3);
        popMatrix();
        strokeWeight(1);
    }
    
    public void update(){
        pos.add(vel);
    }
    
    // if the bullets goes out of the screen
    public boolean detectBound(){
        if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height)
            return true;
        else
            return false;
    }
    
    public boolean hitCharacter(Character ch){
        if(abs(ch.pos.x - pos.x) < ch.wid/ 2 && abs(ch.pos.y - pos.y) < ch.hei/ 2){
            return true;
        }
        else{
            return false;
        }
    }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "playerPlane" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
