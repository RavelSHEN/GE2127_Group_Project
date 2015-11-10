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

public class main extends PApplet {

/*
Fields:
    int posX; //x position of the object
    int posY; //y position of the object
    int velX = 0; //velocity of the object in direction of X
    int velY = 0; //velocity of the object in direction of Y
    int accX = 0; //acceleration of the object in direction of X
    int accY = 0; //acceleration of the object in direction of Y
    int attack; //define the basic attack
    int health; //blood volume /(health level) of the character
    float wid,hei; //the width and height of the object,used to detect the hitting
    boolean alive = true; //check if the character if alive
    int classOfObejct //define if the object is player or enemy, player for 0, enemy for 1

Methods:
    update();
    move();
    detectBound();
    decreaseHealth();
    hitObject();
*/

class BasicObject{
    //Common fields of the basic elements
    float damp = 0.8f; //TODO
    int posX; //x position of the object
    int posY; //y position of the object
    int velX = 0; //velocity of the object in direction of X
    int velY = 0; //velocity of the object in direction of Y
    int accX = 0; //acceleration of the object in direction of X
    int accY = 0; //acceleration of the object in direction of Y
    int attack; //define the basic attack
    int health; //blood volume /(health level) of the character
    float wid,hei; //the width and height of the object,used to detect the hitting
    boolean alive = true; //check if the character if alive
    int classOfObejct; //define if the object is player or enemy, player for 0, enemy for 1

    BasicObject(){
        posX = -1;
        posY = -1;
        velX = 0;
        velY = 0;
        accX = 0;
        accY = 0;
        classOfObejct = 0;
    }

    //constructor which defines the position, velocity and acceleration of the plane
    //pos, vel, acc defines the basic index of the plane
    //classOfObject defines if the object belongs to player or the enemy
    BasicObject(int posX,int posY,int velX,int velY, int accX, int accY, int classOfObejct){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.classOfObejct = classOfObejct;
    }

    //update the position of the plane.
    public void update(){
        velX *= damp;
        velY *= damp;
        posX += velX;
        posY += velY;
    }

    //keep change the velosity of the plane, it is damped above
    public void move(int accX,int accY){
        this.accX = accX;
        this.accY = accY;
        velX = velX + accX;
        velY = velY + accY;
    }

    //detect if the object is at the edge, if yes, for plane, it can not move, for bullet, demised
    public boolean detectBound(){
        if(posX < 10){
            posX = 10;
            velX = 0;
            accX = 0;
            return true;
        }
        else if(posX > width - 10){
            posX = width - 10;
            velX = 0;
            accX = 0;
            return true;
        }
        if(posY < 10){
            posY = 10;
            velY = 0;
            accY = 0;
            return true;
        }
        else if(posY > height - 10){
            posY = height - 10;
            velY = 0;
            accY = 0;
            return true;
        }
        return false;
    }

    //when the object get hitted, health decrease
    public void decreaseHealth(int lostBlood){
        health = health - lostBlood;
    }

    //detect if the object hit the other oppose objects. Hit objects of the same class is fine.
    public boolean hitObject(BasicObject oppose){
        if (oppose.classOfObejct != classOfObejct){
            if (abs(posX - oppose.posX) < (wid / 2 + oppose.wid/2) && abs(posY - oppose.posY) < (hei / 2 + oppose.hei/2)){
                return true;
            }
            else{
                return false;
            }
        }
        else{
            return false;
        }
    }

    public void dieout(int elapsedTime) {
        // animation
    }

}
class BossEnemy extends BasicObject{

/*
additional fields:
    int deadTime;
    float angle;
    float speed;
    boolean totallyDied;
    ArrayList <Bullet> bossBullets = new ArrayList <Bullet>(); //store the bullet of the boss

Methods:
    deawBoss();
    update();
    shoot();
    trackBullet();
*/

    int deadTime;
    int bossMoveTime = 0;
    float angle;
    float speed;
    int dir = 1;
    boolean totallyDied;
    ArrayList <Bullet> bossBullets = new ArrayList <Bullet>(); //store the bullet of the boss
    //constructor to create the boss
    BossEnemy(){
        super();
        totallyDied = true;
    }

    BossEnemy(int posX,int posY,int velX,int velY, int accX, int accY){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        classOfObejct = 1;
        wid = 200;
        hei = 200;
        health = (int)random(15,20);
        totallyDied = false;
        speed = 40;
        angle = 0;
    }

    //draw the boss
    public void drawBoss(PImage bossImg){
        image(bossImg,posX-100, posY-100, 200,200);
    }

    public void drawDeath(PImage explodeImg){
        image(explodeImg,posX - 100,posY- 100,200,200);
    }

    //update the position of the boss.
    public void update(){
        if (bossMoveTime > 10){
            if(random(0,16) <= 8){
                dir = 1;
            }else{
                dir = -1;
            }
            velX *= dir;
            bossMoveTime = 0;
        }
        posY *= 0.8f;
        posX += velX;
        posY += velY;
        angle += 0.04f;
        bossMoveTime++;
    }

    //control the shoot of the boss
    public void shoot(){
        // boss bullete attract to player
        int bulletPosX = PApplet.parseInt(posX + (speed * cos(angle)));
        int bulletPosY = (int)(posY + hei / 2);
        float bulletAngle = atan2(Main.player.posY - bulletPosY, Main.player.posX - bulletPosX);
        int bulletVelX = (int)(8 * cos(bulletAngle));
        int bulletVelY = (int)(8 * sin(bulletAngle));
        bossBullets.add(new Bullet(bulletPosX,bulletPosY,bulletVelX,bulletVelY,1,attack));
    }

    //track the bullets of the boss, check if the bullet hit the object
    public void trackBullets(){
        // bossbullet control, if it hit the bound, remove the bullet
        for(int i = 0; i < bossBullets.size(); i++){
            Bullet tempBullet = bossBullets.get(i);
            tempBullet.update();
            tempBullet.drawBullet();
            // print (tempBullet.posX, tempBullet.posY,'\n');
            if(tempBullet.detectBound()){
                bossBullets.remove(i);
                continue;
            }

            if(tempBullet.hitObject(Main.player) && !Main.player.invincible){
                Main.player.decreaseHealth(1);
                Main.player.posX = width / 2;
                Main.player.posY = height * 9 / 10;
                Main.player.invincible = true;
                Main.player.invincibleTime = millis();
            }

        }
    }

    //when player use bomb, remove all the exsiting bullets
    public void emptyBullets() {
        for(int i = 0; i < bossBullets.size(); i++){
            Bullet tempBullet = bossBullets.get(i);
            bossBullets.remove(i);
        }
    }
}
/*
Methods:
    drawBullet():draw the bullet
    update(): update the position of the bullet
    detectBound();
    hitObject();
*/

class Bullet extends BasicObject{
    //constructor to define the bullet
    Bullet(int posX,int posY,int velX,int velY,int classOfObejct,int attack){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.classOfObejct = classOfObejct;
        this.attack = attack;
    }

    //draw the bullet on the canvas
    public void drawBullet(){
        if (classOfObejct == 0){
            colorMode(RGB,255,255,255);
            noStroke();
            fill(255,0,0);
            ellipse(posX, posY, 6, 6);
            fill(255,153,51);
            ellipse(posX,posY, 4, 4);
            fill(255,255,0);
            ellipse(posX,posY, 2, 2);
            fill(255,255,102);
            ellipse(posX,posY, 1, 1);
            stroke(1);
        }
        else{
            colorMode(RGB,255,255,255);
            noStroke();
            fill(51,153,255);
            ellipse(posX, posY, 8, 8);
            fill(102,178,255);
            ellipse(posX,posY, 6, 6);
            fill(204,229,255);
            ellipse(posX,posY, 4, 4);
            fill(255,255,255);
            ellipse(posX,posY, 2, 2);
            stroke(1);
        }
    }

    //update the position of the bullet
    public void update(){
        posX += velX;
        posY += velY;
    }

    //decide if the bullet goes out the screen
    public boolean detectBound(){
        if(posX < 0 || posX > width || posY < 0 || posY > height){
            return true;
        }
        else{
            return false;
        }
    }

    public void drawHit(){
        image(explode[5],posX,posY,10,10);
    }
    //decide if the bullet hit the object
    public boolean hitObject(BasicObject obj){
        if(abs(obj.posX - posX) < obj.wid/ 2 && abs(obj.posY - posY) < obj.hei/ 2){
            return true;
        }
        else{
            return false;
        }
    }
}
/*
additional fields:
    int deadTime;
    int dir; //control the direction of the movement of the enemy
    float angle;//control the direction of the movement of the enemy

Methods:
    deawEnemy();
    update();
    detectBound();
*/

class Enemy extends BasicObject{
    int deadTime;
    int dir = 1;
    float angle;
    float scaleFactor;
    int explodeCount = 0;
    Enemy(int posX,int posY,int velX,int velY, int accX, int accY){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.classOfObejct = 1;
        scaleFactor = random(1,2);
        wid = 30*scaleFactor;
        hei = 30*scaleFactor;
        alive = true;
        angle = PI / 4;
        float randomHealth = random(1,3);
        if(randomHealth < 1.5f){
            health = 1;
        }else if(randomHealth < 2.5f){
            health = 2;
        }else{
            health = 3;
        }
    }

    public void drawDeath(PImage explodeImg){
        image(explodeImg,posX - 15*scaleFactor,posY- 15*scaleFactor,30*scaleFactor,30*scaleFactor);
    }
    //update the postion of the enemy
    public void update(){
        // random move
        if(alive){
            posX += velX * cos(angle);
            posY += velY * sin(PI/4);
            angle += 0.04f*dir;
            if(random(0, 16) < 8){
                dir *= -1;
            }
        }
    }

    //detect if the enemy hit the up/down boundary, if yes, remove
    public boolean detectBound(){
        // super.detectBound();
        if(posY > height || posY < 0){
            Main.enemies.remove(this);
            return true;
        }
        return false;

    }

    public int getDamage() {
        //TODO
        return 1;
    }

    public void drawMe(){
        pushMatrix();
        translate(posX-100, posY-100);
        rotate(PI/2);
        scale(scaleFactor);
        smooth();
          strokeWeight(1);
          beginShape();
          fill(50);
          vertex(150,15);
          vertex(147,16);
          vertex(145,18);
          vertex(137,27);
          vertex(130,43);
          vertex(126,80);
          vertex(135,86);
          vertex(139,46);
          vertex(147,26);
          vertex(153,26);
          vertex(161,46);
          vertex(165,86);
          vertex(174,80);
          vertex(170,43);
          vertex(163,27);
          vertex(155,18);
          vertex(153,16);
          vertex(150,15);
          endShape();

          strokeWeight(3);
          fill(200);
          beginShape();
          vertex(135,86);
          vertex(139,46);
          vertex(147,26);
          vertex(153,26);
          vertex(161,46);
          vertex(165,86);
          vertex(157,96);
          vertex(143,96);
          vertex(135,86);
          endShape();

          beginShape();
          vertex(139,46);
          vertex(146,53);
          vertex(154,53);
          vertex(161,46);
          endShape();
          line(146,53,143,96);
          line(154,53,157,96);

          fill(30);                             //left 1 wing
          beginShape();
          vertex(93,148);//
          vertex(15,335);
          vertex(19,353);////
          vertex(39,329);
          vertex(36,323);////
          vertex(95,211);//
          vertex(89,186);
          vertex(93,148);
          endShape();

          beginShape();                         //right 1 wing
          vertex(207,148);//
          vertex(285,335);
          vertex(281,353);////
          vertex(261,329);
          vertex(264,323);////
          vertex(205,211);//
          vertex(211,186);
          vertex(207,148);
          endShape();

          fill(220);
          beginShape();                         //left 2 wing
          vertex(109,240);////
          vertex(26,370);
          vertex(19,353);////
          vertex(39,329);
          vertex(36,323);////
          vertex(95,211);//
          vertex(137,214);
          vertex(109,240);
          endShape();

          beginShape();                         //right 2 wing
          vertex(191,240);////
          vertex(274,370);
          vertex(281,353);////
          vertex(261,329);
          vertex(264,323);////
          vertex(205,211);//
          vertex(163,214);
          vertex(191,240);
          endShape();

          fill(35);
          strokeWeight(1);
          beginShape();
          vertex(150,155);
          vertex(123,116);
          vertex(126,80);
          vertex(135,86);
          vertex(143,96);
          vertex(157,96);
          vertex(165,86);
          vertex(174,80);
          vertex(177,116);
          vertex(150,155);
          endShape();

          fill(30);
          beginShape();
          vertex(125,90);
          vertex(110,97);
          vertex(93,148);
          vertex(98,151);
          vertex(103,131);
          vertex(109,133);
          vertex(115,114);
          vertex(123,110);
          endShape();

          beginShape();
          vertex(175,90);
          vertex(190,97);
          vertex(207,148);
          vertex(202,151);
          vertex(197,131);
          vertex(191,133);
          vertex(185,114);
          vertex(177,110);
          endShape();

          fill(50);
          beginShape();
          vertex(93,148);//
          vertex(89,186);//
          vertex(98,217);
          vertex(109,224);//
          vertex(141,230);
          vertex(140,216);
          vertex(147,194);
          vertex(150,194);
          vertex(150,155);
          vertex(123,116);
          vertex(123,110);
          vertex(115,114);
          vertex(109,133);
          vertex(103,131);
          vertex(98,151);
          vertex(93,148);
          endShape();

          beginShape();
          vertex(207,148);//
          vertex(211,186);//
          vertex(202,217);
          vertex(191,224);//
          vertex(159,230);
          vertex(160,216);
          vertex(153,194);
          vertex(150,194);
          vertex(150,155);
          vertex(177,116);
          vertex(177,110);
          vertex(185,114);
          vertex(191,133);
          vertex(197,131);
          vertex(202,151);
          vertex(207,148);
          endShape();



          fill(30);
          beginShape();                            //left 1 tail
          vertex(118,226);
          vertex(111,233);
          vertex(106,284);
          vertex(143,244+12);
          vertex(141,230);
          endShape();

          beginShape();                            //right 1 tail
          vertex(182,226);
          vertex(189,233);
          vertex(194,284);
          vertex(157,244+12);
          vertex(159,230);
          endShape();

          fill(230);                               //left 2 tail
          beginShape();
          vertex(128,229);
          vertex(125,234);
          vertex(127,252);
          vertex(143,244);
          vertex(141,230);
          endShape();

          beginShape();                           //right 2 tail
          vertex(172,229);
          vertex(175,234);
          vertex(173,252);
          vertex(157,244);
          vertex(159,230);
          endShape();

          fill(150);
          strokeWeight(2);
          beginShape();
          vertex(141,230+12);
          vertex(140,216+12);
          vertex(147,194);
          vertex(153,194);
          vertex(160,216+12);
          vertex(159,230+12);
          vertex(157,244+12);
          vertex(150,257+12);
          vertex(143,244+12);
          vertex(141,230+12);
          endShape();

          fill(130);
          beginShape();
          vertex(150,229+12);
          vertex(157,244+12);
          vertex(150,257+12);
          vertex(143,244+12);
          vertex(150,229+12);
          endShape();
          line(150,194+12,150,229+12);

          beginShape();
          vertex(121,252+12);
          vertex(137,273+12);
          vertex(163,273+12);
          vertex(179,252+12);
          vertex(157,244+12);
          vertex(150,257+12);
          vertex(143,244+12);
          vertex(121,252+12);
          endShape();

          fill(227,88,18);
          ellipse(142,273+12,10,6);
          ellipse(158,273+12,10,6);
          line(137,247+12,137,258+12);
          line(137,258+12,146,267+12);
          line(146,267+12,154,267+12);
          line(163,247+12,163,258+12);
          line(163,258+12,154,267+12);

          beginShape();
          vertex(117,258+12+12);
          vertex(114,280+12+12);
          vertex(114,298+12+12);
          vertex(116,301+12+12);
          vertex(122,298+12+12);
          vertex(124,282+12+12);
          vertex(135,272+12);
          vertex(122,255+12);
          vertex(116,258+12+12);
          endShape();

          beginShape();
          vertex(183,258+12+12);
          vertex(186,280+12+12);
          vertex(186,298+12+12);
          vertex(184,301+12+12);
          vertex(178,298+12+12);
          vertex(176,282+12+12);
          vertex(165,272+12);
          vertex(178,255+12);
          vertex(184,258+12+12);
          endShape();
          popMatrix();

    }
}

int NUM_ENEMY = 7;
int speed = 2;
boolean up, down, left, right, shoot, useBomb;
// boolean welcomePage = true;  // welcome page
// boolean selectionPage = false;
boolean[] pages = {true,false};
boolean restart = false;  // restart game
static int score = 0;
boolean alive = true;  // if the player is alive
boolean bossKilled = false;
int bombing = 0;
int currentPage = 0;
int flightType;
int shootTime = 0;  // shoot interval time
int bossShootInterval = 0;  // boss shoot interval time
int bossShootTime = 0;  // boss shooting time
int bossRestTime = millis();  // boss resting time
int killedEnemy = 0;  // count the number of died enemy, boss appears every killed 30 enemies
int killedBoss = 0;
static Player player;
static BossEnemy boss;
static ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage img;  // background image
PImage[] explode = new PImage[20];
PImage[] bomb = new PImage[30];
int bombX;
int bombY;
int bombCounter;
PImage bossImg;
PImage enemyImg;
PImage playerImg;


int initialPosX;
int initialPosY;
public void setup(){
    size(600, 750);
    img = loadImage("space.jpg");
    initialPosX = width / 2;
    initialPosY = height * 9 / 10;
    boss = new BossEnemy();
    player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 200);
    for (int i = 0; i < NUM_ENEMY; i++){
        int enemyPosX = (int) random(0, width);
        int enemyPosY = 0;
        float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
        int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
        int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
        int enemyType = 0;
        // print(enemyVelX, enemyVelY, "\n");
        enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
    }
    for (int i = 0; i < 20; i ++){
        explode[i] = loadImage("explode" + i + ".png");
    }
    for (int i = 1; i < 29; ++i) {
        bomb[i] = loadImage("Bomb" + i + ".png");
    }
    bossImg = loadImage("boss.png");
    enemyImg = loadImage("enemy.png");
    playerImg = loadImage("player.png");
}

public void draw(){
    //TODO: Change the background image
    image(img, 0, 0, 640, 1136);
    if(0 == currentPage){
        //TODO: Re-design the WelcomePage
        PFont arial = loadFont("Bauhaus93-48.vlw");
        textFont(arial, 48);
        textAlign(CENTER);
        fill(255);
        text("SHOOT! SHOOT!", width / 2, height / 3);
        PFont bradly = loadFont("BradleyHandITC-48.vlw");
        textFont(bradly, 24);
        text("Press ENTER to continue", width / 2, height / 2);
    }
    else if(1 == currentPage){
        PFont bradly = loadFont("BradleyHandITC-48.vlw");
        textFont(bradly, 24);
        text("Press 1,2,3,4 to select your plane", width / 2, height / 3);
        text("Press arrow up, down, left right to move", width / 2, height / 2);
        text("Press Z to shoot", width / 2, height / 2 + 50);
        text("Press X to use bomb", width / 2, height / 2 + 100);
        text("Press ENTER to start", width / 2, height / 2 + 150);
        // Player(posX, posY, velX, velY, accX, accY, attack, health, numOfBomb, sInterval)
        switch (flightType){
            case 1:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 1, 1, 400);
                break;
            case 2:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 2, 1, 400);
                break;
            case 3:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 2, 400);
                break;
            case 4:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 200);
                break;
            default:
            break;
        }
    }
    else{
        if(player.alive && !bossKilled){
            for(int i = 0; i < enemies.size(); i++) {
                Enemy tempEnemy = enemies.get(i);
                tempEnemy.update();
                tempEnemy.detectBound();
                tempEnemy.drawMe();

                // detect collision between enemy and player
                if(player.hitObject(tempEnemy) && !player.invincible) {
                    player.decreaseHealth(tempEnemy.getDamage());
                    player.invincible = true;
                    player.invincibleTime = millis();
                }

                if(!tempEnemy.alive){
                    int currentTime = millis();
                    tempEnemy.dieout(currentTime - tempEnemy.deadTime);
                    if(currentTime - tempEnemy.deadTime < 2000){
                        tempEnemy.drawDeath(explode[(currentTime - tempEnemy.deadTime)/100]);
                    }
                    if(currentTime - tempEnemy.deadTime > 1000){
                        enemies.remove(tempEnemy);
                        score += 10;
                        if(boss.totallyDied){
                            killedEnemy ++;  // count one killed enemy
                        }
                    }
                }
            }
            if (bombing == 0) {
                for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
                    int enemyPosX = (int) random(0, width);
                    int enemyPosY = 0;
                    float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
                    int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
                    int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
                    int enemyType = 0;
                    enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
                }
            }
            // if(boss.totallyDied == true){
            //     // produce enemy only boss is not on the screen
            //     // when there is an enemy died or disappeared, create a new enemy
            //     for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
            //         PVector enemyPos = new PVector(random(0, width), 0);
            //         PVector enemyVel = new PVector(random(-3, 3), random(0.1, 3));// flow down vertically
            //         PVector enemyAcc = new PVector(0, 0);
            //         enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5, 1)));
            //     }
            //  }

            if(killedEnemy >= random(3, 5)) {
                int bossPosX = (int)width / 2;
                int bossPosY = 0;
                int bossVelX = 1;
                int bossVelY = (int)random(20,30);
                int bossAccX = 0;
                int bossAccY = 0;
                boss = new BossEnemy(bossPosX,bossPosY,bossVelX,bossVelY,bossAccX,bossAccY);
                killedEnemy = 0;
            }

            if(boss.posY != -1){
                if(!boss.totallyDied){
                    boss.update();
                    boss.drawBoss(bossImg);
                    boss.trackBullets();
                }

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
                    if(player.hitObject(boss) && !player.invincible){
                        player.decreaseHealth(1);
                        player.posX = width / 2;
                        player.posY = height * 9 / 10;
                        // gives player 3 seconds invincible time after being attacked
                        player.invincible = true;
                        player.invincibleTime = millis();
                    }
                }
                // if boss is died, wait for 3 sec, and then not draw boss
                else{
                    int currentTime = millis();
                    if(currentTime - boss.deadTime < 3000){
                        boss.drawDeath(explode[(currentTime - boss.deadTime)/150]);
                    }
                    if(currentTime - boss.deadTime > 500){
                        boss.totallyDied = true;
                        bossKilled = true;
                    }
                }
            }

            // Control the plane
            if (up) player.move(0, -speed);
            if (down) player.move(0, speed);
            if (left) player.move(-speed, 0);
            if (right) player.move(speed, 0);
            if (shoot){
                int currentTime = millis();
                if(currentTime - shootTime > player.sInterval){
                    player.shoot();
                    shootTime = currentTime;
                }
            }
            if ((useBomb) && (player.numOfBomb > 0) && (bombing == 0)) {
                player.numOfBomb--;
                bombing = 1;
                bombCounter = millis();
                bombX = player.posX;
                bombY = player.posY;
                useBomb = false;
            }

            if (bombing == 2) {
                boss.emptyBullets();
                int currentTime = millis();
                int currentStage = (currentTime - bombCounter) / 100 + 1;
                if (currentStage > 28) {
                    bombing = 0;
                }
                else {
                    // println("currentStage: "+currentStage);
                    image(bomb[currentStage], bombX - 350, bombY - 350, 700, 700);
                }

            }

            if (bombing == 1) {
                int currentTime = millis();
                int currentStage = (currentTime - bombCounter) / 100 + 1;
                if (currentStage < 10) {
                    // println("currentStage: "+currentStage);
                    image(bomb[currentStage], bombX - 350, bombY - 350, 700, 700);
                }
                else {
                    bombing = 2;
                    killedEnemy = killedEnemy + player.useBomb();
                }
            }




            player.update();
            player.detectBound();
            player.drawMe(playerImg);
            player.trackBullets();
            // if player is invincible, count invincible time
            if(player.invincible){
                int currentTime = millis();
                // println("currentTime - invincibleTime = " + (currentTime - player.invincibleTime));
                if(currentTime - player.invincibleTime >= 3000){
                    player.invincible = false;
                }
            }

            // if player is out of health, die, and create a new player
            if(player.health <= 0){
                player.alive = false;
            }

            // display the score, health at right top corner at size 44
            PFont arial = loadFont("Arial-BoldMT-48.vlw");  // the font is stored in the "data" file
            textFont(arial, 24);
            textAlign(RIGHT);
            fill(0, 102, 154);
            text("Bomb: " + player.numOfBomb, 550,50);
            text("health: " + player.health, 550, 100);
            text("score " + score, 550, 150);

        }
        else if(player.alive && bossKilled){
            for(int i = 0; i < enemies.size(); i++){
                enemies.remove(i);
            }
            PFont arial = loadFont("Arial-BoldMT-48.vlw");  // the font is stored in the "data" file
            textFont(arial, 48);
            textAlign(CENTER);
            fill(255);
            text("Yes! You Win", width / 2, height / 3);
            text("score " + score, width / 2, height / 2);
            PFont bradly = loadFont("BradleyHandITC-48.vlw");
            textFont(bradly, 36);
            text("Press R to restart", width / 2, height * 2 / 3);
        }
        else {
            // player is dead
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
        }
        if(restart){
            restart = false;
            pages[0] = false;
            pages[1] = true;
            currentPage = 1;
            PFont bradly = loadFont("BradleyHandITC-48.vlw");
            textFont(bradly, 24);
            textAlign(CENTER);
            fill(255, 255, 255);
            // print(currentPage);
            alive = true;
            player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 300);
            score = 0;
            killedEnemy = 0;
            bossKilled = false;
            restart = false;
            boss = new BossEnemy();
            // enemy create, show up at top of the screen, move down
            for(int i = 0; i < NUM_ENEMY; i++){
                int enemyPosX = (int) random(0, width);
                int enemyPosY = 0;
                float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
                int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
                int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
                int enemyType = 0;
                // print(enemyVelX, enemyVelY, "\n");
                 enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
            }
        }
    }
}


public void keyPressed() {
    if (keyCode == ENTER){
        // if(currentPage < pages.length){
        //     pages[currentPage] = false;
        //     if(currentPage < pages.length-1){
        //         pages[currentPage + 1] = true;
        //     }
        //     currentPage ++;
        // }
        if (1 == currentPage) {
            currentPage = 2;
        }
        else if (0 == currentPage) {
            currentPage = 1;
        }

    }
    if (key == 'z' || key == 'Z') shoot = true;
    if (key == 'x' || key == 'X') useBomb = true;
    if (key == 'r' ||key == 'R') restart = true;
    if (keyCode == 49) flightType = 1;
    if (keyCode == 50) flightType = 2;
    if (keyCode == 51) flightType = 3;
    if (keyCode == 52) flightType = 4;
    if (keyCode == UP) up = true;
    if (keyCode == DOWN) down = true;
    if (keyCode == LEFT) left = true;
    if (keyCode == RIGHT) right = true;
}

public void keyReleased() {
    if (key == 'z' || key == 'Z') shoot = false;
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
}


/*
Methods:
    drawPlayer():draw the player
    shoot():define the action of shoot
    trackBullet():check the bullet to decide if the bullet is hit the object
    useBomb(): use bomb to attack
*/
class Player extends BasicObject{
    int showMe = 0;
    int numOfBomb; //define the number of bomb
    boolean bombUsed = false; //check if currently the player is using bomb
    int bombTimeCounter = 1500; //count how long has the bomb be lasted
    boolean invincible; //check if current the plane is invincible
    int invincibleTime; //defines the time of invincible of the player
    ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //store the information of bullets
    int sInterval; //shooting interval
    //constructor to define the basic characters of the player's plane
    //different kind of player plane can have different attackm, health or numOfBomb
    Player(int posX,int posY,int velX,int velY, int accX, int accY,int attack,int health, int numOfBomb, int sInterval){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.health = health;
        this.numOfBomb = numOfBomb;
        this.attack = attack;
        this.sInterval = sInterval;
        invincibleTime = 0;
        invincible = false;
        wid = 30;
        hei = 60;
        classOfObejct = 0;
        alive = true;
    }

    //draw the player
    public void drawMe(PImage playerImg){
        fill(200,200,200);
        if (invincible) {
            if (((millis() - invincibleTime) / 200) % 2 == 1) {
                image(playerImg,posX-15,posY-15,30,60);
                // ellipse(posX,posY,20,20);
            }
        }
        else {
            showMe = 0;
            image(playerImg,posX-15,posY-15,30,60);
            // ellipse(posX,posY,20,20);
        }
    };

    //while the player shoots, the bullets objects are generated and stored
    public void shoot(){
        int bulletPosX = posX;
        int bulletPosY = posY;
        int bulletVelX = 0;
        int bulletVelY = -9;
        //add the new bullets to the array of bullets
        bullets.add(new Bullet(bulletPosX,bulletPosY,bulletVelX,bulletVelY,0,attack));
    }

    //track all the bullets. Cause 1 harm to enemy and boss
    public void trackBullets(){
        for (int i = 0; i < bullets.size(); i++){
            Bullet tempBullet = bullets.get(i);
            //update the position of the bullets
            tempBullet.update();
            tempBullet.drawBullet();
            //check if the bullet hit the boundary, remove the bullet from the list of the bullet
            if(tempBullet.detectBound()){
                bullets.remove(i);
                continue;
            }
            //detect if the bullet hit the boss and cause the damage if yes
            if(tempBullet.hitObject(Main.boss) && Main.boss.alive){
                Main.boss.decreaseHealth(attack);
                tempBullet.drawHit();
                bullets.remove(i);
                if(Main.boss.health <= 0){
                    Main.boss.alive = false;
                    Main.boss.deadTime = millis();
                    Main.score += 100;
                }
            }
            //detect if the bullet hit the enemy and cause the damage if yes
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempBullet.hitObject(tempEnemy) && tempEnemy.alive){
                    tempBullet.drawHit();
                    tempEnemy.decreaseHealth(attack);
                    // if enemy is totally hitted, wait one 1s, and then removed
                    if(tempEnemy.health <= 0){
                        tempEnemy.alive = false;
                        tempEnemy.deadTime = millis();
                    }
                    bullets.remove(i);
                    break;
                }
            }
        }
    }

    //use bomb, which killded all the enemies and cause huge harm to boss
    //while bomb buttom pressed, bombUsed is set to true
    public int useBomb(){
        //do harm while the animation start
        //cause harm to the boss
        int count = 0;
        if (Main.boss.alive){
            Main.boss.decreaseHealth(10);
            if(Main.boss.health <= 0){
                Main.boss.alive = false;
                Main.boss.deadTime = millis();
                Main.score += 100;
            }
        }
        //remove all bullets
        Main.boss.emptyBullets();
        //kill all the enemies
        for(int j = 0; j < Main.enemies.size(); j++){
            println("j: "+j);
            Enemy tempEnemy = Main.enemies.get(j);
            tempEnemy.alive = false;
            tempEnemy.deadTime = millis();
            count ++;
        }
        // fill(0,0,0);
        // rect(0,0,width,height);
        return count;
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
