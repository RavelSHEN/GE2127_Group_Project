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

public class Main extends PApplet {

int NUM_ENEMY = 7;
int speed = 2;
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
static ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage img;  // background image

int initialPosX;
int initialPosY;
public void setup(){
    size(600, 800);
    img = loadImage("space.jpg");
    initialPosX = width / 2;
    initialPosY = height * 9 / 10;
    player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 1);
    boss = new BossEnemy();
    for(int i = 0; i < NUM_ENEMY; i++){
        int enemyPosX = (int) random(0, width);
        int enemyPosY = 0;
        int enemyVelX = (int) random(-4, 4);
        int enemyVelY = (int) random(2, 4);
        int enemyType = 0;
        print(enemyVelX, enemyVelY, "\n");
        enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
    }
}

public void draw(){
    //TODO: Change the background image
    image(img, 0, 0, 640, 1136);
    if(welcomePage){
        //TODO: Re-design the WelcomePage
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
                    if(currentTime - tempEnemy.deadTime > 1000){
                        enemies.remove(tempEnemy);
                        score += 10;
                        killedEnemy ++;  // count one killed enemy
                    }
                }
            }

            for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
                int enemyPosX = (int) random(0, width);
                int enemyPosY = 0;
                int enemyVelX = (int) random(-4, 4);
                int enemyVelY = (int) random(2, 4);
                int enemyType = 0;
                print(enemyVelX, enemyVelY, "\n");
                enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
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

            if(killedEnemy >= random(2, 5)) {
                int bossPosX = (int)width / 2;
                int bossPosY = 0;
                int bossVelX = 0;
                int bossVelY = (int)random(15,30);
                int bossAccX = 0;
                int bossAccY = 0;
                boss = new BossEnemy(bossPosX,bossPosY,bossVelX,bossVelY,bossAccX,bossAccY);
                // killedEnemy = 0;
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
                    if(currentTime - boss.deadTime > 3000){
                        boss.totallyDied = true;
                    }
                }

                if(!boss.totallyDied){
                    boss.update();
                    boss.drawBoss();
                    boss.trackBullets();
                }


            // Control the plane
            if (up) player.move(0, -speed);
            if (down) player.move(0, speed);
            if (left) player.move(-speed, 0);
            if (right) player.move(speed, 0);
            if (shoot){
                int currentTime = millis();
                //TODO
                if(currentTime - shootTime > 300){
                    player.shoot();
                    shootTime = currentTime;
                }
            }


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
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 1);
                score = 0;
                killedEnemy = 0;
                restart = false;
                // boss = new BossEnemy();
                // // enemy create, show up at top of the screen, move down
                // for(int i = 0; i < NUM_ENEMY; i++){
                //     PVector enemyPos = new PVector(random(0, width), 0);
                //     PVector enemyVel = new PVector(random(-3, 3), random(1, 3));
                //     PVector enemyAcc = new PVector(0, 0);
                //     enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5, 1)));
                // }
            }
        }
    }
}


public void keyPressed() {
    if(key == 's' || key == 'S'){
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
    if(key == 's' || key == 'S'){
        shoot = false;
    }
    if (key == CODED) {
        if (keyCode == UP) up = false;
        if (keyCode == DOWN) down = false;
        if (keyCode == LEFT) left = false;
        if (keyCode == RIGHT) right = false;
    }
}


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
    float angle;
    float speed;
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
        health = (int)random(30,50);
        totallyDied = false;
        speed = 40;
        angle = 0;
    }

    //draw the boss
    public void drawBoss(){
        ellipse(posX,posY, 50,50);
    }

    //update the position of the boss.
    public void update(){
        super.update();
        angle += 0.04f;
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
            print (tempBullet.posX, tempBullet.posY,'\n');
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
        fill(255,255,255);
        ellipse(posX,posY,5,5);
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
    Enemy(int posX,int posY,int velX,int velY, int accX, int accY){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.classOfObejct = 1;
        wid = 25;
        hei = 50;
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

    public void drawMe(){
        ellipse(posX,posY,15,15);
    }

    //update the postion of the enemy
    public void update(){
        // random move
        if(alive){
            posX += velX * cos(angle);
            posY += velY * sin(angle);
            // angle += 0.04 * dir;
            // if(random(0, 2) < 1){
            //     dir *= -1;
            // }
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
}
/*
Methods:
    drawPlayer():draw the player
    shoot():define the action of shoot
    trackBullet():check the bullet to decide if the bullet is hit the object
    useBomb(): use bomb to attack
*/

class Player extends BasicObject{
    int numOfBomb; //define the number of bomb
    boolean bombUsed = false; //check if currently the player is using bomb
    int bombTimeCounter = 0; //count how long has the bomb be lasted
    boolean invincible; //check if current the plane is invincible
    int invincibleTime; //defines the time of invincible of the player
    ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //store the information of bullets
    float sInterval; //shooting interval

    //constructor to define the basic characters of the player's plane
    //different kind of player plane can have different attackm, health or numOfBomb
    Player(int posX,int posY,int velX,int velY, int accX, int accY,int attack,int health, int numOfBomb, float sInterval){
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
        wid = 25;
        hei = 50;
        classOfObejct = 0;
        alive = true;
    }

    //draw the player
    public void drawMe(){
        ellipse(posX,posY,20,20);
    };

    //while the player shoots, the bullets objects are generated and stored
    public void shoot(){
        int bulletPosX = posX;
        int bulletPosY = posY;
        int bulletVelX = 0;
        int bulletVelY = -8;
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
            // if(tempBullet.hitObject(Main.boss) && Main.boss.alive){
            //     Main.boss.decreaseHealth(attack);
            //     bullets.remove(i);
            //     if(Main.boss.health <= 0){
            //         Main.boss.alive = false;
            //         Main.boss.deadTime = millis();
            //         Main.score += 100;
            //     }
            // }
            //detect if the bullet hit the enemy and cause the damage if yes
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempBullet.hitObject(tempEnemy) && tempEnemy.alive){
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
    public void useBomb(){
        //do harm while the animation start
        if (bombTimeCounter == 5){
            //cause harm to the boss
            if (Main.boss.alive){
                Main.boss.decreaseHealth(10);
                if(Main.boss.health <= 0){
                    Main.boss.alive = false;
                    Main.boss.deadTime = millis();
                    Main.score += 100;
                }
            }
            //kill all the enemies
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempEnemy.alive){
                    tempEnemy.decreaseHealth(tempEnemy.health);
                    if(tempEnemy.health <= 0){
                        tempEnemy.alive = false;
                        tempEnemy.deadTime = millis();
                    }
                }
            }
        }
        //animation of using bomb
        colorMode(RGB,255,255,255,100);
        fill(255,255,255,100-abs(100 - bombTimeCounter*20));
        rect(0,0,width,height);
        //while the bomb animation ended, set bombUsed to false
        if(bombTimeCounter == 10){
            bombUsed = false;
            bombTimeCounter = 0;
            numOfBomb --;
        }else{
            bombTimeCounter ++;
        }
    }


}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
