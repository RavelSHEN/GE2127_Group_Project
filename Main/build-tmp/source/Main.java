import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.spi.*; 
import ddf.minim.signals.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
import ddf.minim.effects.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Main extends PApplet {

//////////////////////////////////////////////////////////////
///////    GE2127 Computer-Aided Visual Design &     /////////
///////     Electronic Arts - Programing with        /////////
///////     Image, Audio, Animation & Interaction    /////////
///////                                              /////////
///////     Group Project Group 11                   /////////
///////     Call of Peace: Anti ISIS WAREFARE        /////////
///////                                              /////////
///////     SHEN Feng        52640117                /////////
///////     BO Haozhen       54381079                /////////
///////     YANG Siyue       54381055                /////////
///////     LIN Jianxiong    53062882                /////////
//////////////////////////////////////////////////////////////

//define the minim for audio playing elements






AudioPlayer playerBomb;
AudioPlayer playerShoot;
AudioPlayer playerExplode;
AudioPlayer playerFight;
AudioPlayer playerNervous;
AudioPlayer playerStory;
Minim storyAu;
Minim bombAu;
Minim shootAu;
Minim explodeAu;
Minim fightAu;
Minim nervousAu;


String a="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String peace="CALL of PEACE ";
PFont end_f;
int A=0;
int counter=0;
int t=80;
PImage[] p=new PImage[12];
int s=20;
int col,row;
int pcounter=0;
int charcount=0;
int[] X={0,0,0,0,0,0,0,0,0,0,0,0};
int[] Y={0,80,181,114,0,25,83,25,0,125,156,0};


int NUM_ENEMY = 7; //define the number of enemies
int speed = 2; //define the speed of objects
boolean up, down, left, right, shoot, useBomb; //define the control elements
boolean[] pages = {true,false}; //define the page control
boolean restart = false;  // restart game
static int score = 0;  //variable to record the score
boolean alive = true;  // if the player is alive
boolean bossKilled = false; //determine if the boss is killed
boolean bossBorn = false;  //determine if the boss appear
int bombing = 0; //define if currently the bomb is used
int currentPage = 0; //record the current page number
int flightType = 1; //record the plane choice of the player
int shootTime = 0;  // shoot interval time
int bossShootInterval = 0;  // boss shoot interval time
int bossShootTime = 0;  // boss shooting time
int bossRestTime = millis();  // boss resting time
int killedEnemy = 0;  // count the number of died enemy, boss appears every killed 30 enemies
int killedBoss = 0; //record the number of boss killed
static Player player; //player object
static BossEnemy boss; //boss object
static ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //enemy object
PImage img1;  // background image
PImage img2;  // background image 2
PImage introText; // the text image for introduction
int introTextY; //the position of introText
PImage[] explode = new PImage[20]; //images used for explode animation
PImage[] bomb = new PImage[30]; //images used for bomb animation
PFont Times; //font1
PFont Lucida; //font2
int bombX; //bomb's x position
int bombY; //bomb's y position
int bombCounter; //count the pasd imgae of bomb
int tmpframecount; //count the frame
int initialPosX; //initial position x
int initialPosY; //initial position y

//image elements for plane design
PImage usaf;
PImage ukf;
PImage syriaf;
PImage russiaf;
//font for plane selection
PFont select;
PFont feature;

//setup the game
public void setup(){
    size(600, 750);
    //load font and images into the program
    Times = loadFont("TimesNewRomanPS-BoldMT-60.vlw");
    Lucida = loadFont("LucidaBright-Demi-48.vlw");
    select = loadFont("SitkaBanner-Bold-48.vlw");
    feature = loadFont("LucidaSans-Demi-48.vlw");
    usaf = loadImage("usaf.jpg");
    ukf = loadImage("ukf.jpg");
    syriaf = loadImage("syriaf.jpg");
    russiaf = loadImage("russiaf.jpg");
    img1 = loadImage("welcome.jpg");
    img2 = loadImage("fight.jpg");
    introText = loadImage("introtext.png");
    //initialize the variables
    double coefficient = (double) width / (double) introText.width;
    introText.resize(width, (int) (coefficient * introText.height));
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
    println("----" + Main.boss.alive + "----");
    //load the audio
    bombAu = new Minim(this);
    playerBomb = bombAu.loadFile("bomb.mp3",1000);
    shootAu = new Minim(this);
    playerShoot = shootAu.loadFile("shoot.mp3",1000);
    explodeAu = new Minim(this);
    playerExplode = explodeAu.loadFile("explode.mp3",1000);
    fightAu = new Minim(this);
    playerFight = fightAu.loadFile("fight.mp3",1000);
    playerFight.setGain(-5);
    nervousAu = new Minim(this);
    playerNervous = nervousAu.loadFile("nervous.mp3",1000);
    playerNervous.setGain(10);
    storyAu = new Minim(this);
    playerStory = storyAu.loadFile("story.mp3",1000);
    playerStory.setGain(10);
    end_f = loadFont("Corbel-Bold-48.vlw");
    textFont(end_f);
    textAlign(CENTER);
    for(int i = 0; i < p.length; i++){
        p[i] = loadImage("end" + i + ".jpg");
    }

}

public void draw(){
    //background image
    image(img1, 0, 0, 600, 750);
    playerNervous.play();//start the background music
    //while currentPage == 0, display the welcome page
    if(0 == currentPage){
        textFont(Times, 60);
        fill(255);
        textAlign(RIGHT);
        text("CALL",width / 2 - 45, height / 3);
        textFont(Times, 24);
        textAlign(CENTER);
        text("OF",width/2 - 15,height/3);
        textFont(Times, 60);
        textAlign(LEFT);
        text("PEACE",width / 2 + 15, height / 3);
        textFont(Times, 30);
        textAlign(CENTER);
        text("ANTI-ISIS WAREFARE",width / 2, height/ 3 + 60);
        textFont(Lucida, 24);
        // the fading effect of instruction
        int currentTime = millis() / 100;
        if (currentTime % 13 == 0) {
            fill(255, 255, 255, 30);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 1) {
            fill(255, 255, 255, 40);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 2) {
            fill(255, 255, 255, 50);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 3) {
            fill(255, 255, 255, 60);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 4) {
            fill(255, 255, 255, 70);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 5) {
            fill(255, 255, 255, 80);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 6) {
            fill(255, 255, 255, 90);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 7) {
            fill(255, 255, 255, 95);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 8) {
            fill(255, 255, 255, 110);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 9) {
            fill(255, 255, 255, 120);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 10) {
            fill(255, 255, 255, 130);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 11) {
            fill(255, 255, 255, 140);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else if (currentTime % 13 == 12) {
            fill(255, 255, 255, 150);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
        else {
            fill(255, 255, 255);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
    }
    //if currentPage == 1, display the plane selecting page
    else if(1 == currentPage){
        interface1();
        title();
        feature(185,235);//usa
        strength2(214,226);//speed
        strength2(214,245);//agility
        strength3(214,265);//defence
        strength2(214,281);//air-air

        feature(475,235);//syria
        strength1(510,226);//speed
        strength3(510,245);//agility
        strength2(510,265);//defence
        strength3(510,281);//air-air

        feature(185,485);//russia
        strength3(214,475);//speed
        strength2(214,494);//agility
        strength2(214,513);//defence
        strength2(214,530);//air-air

        feature(475,485);//uk
        strength3(510,475);//speed
        strength1(510,494);//agility
        strength3(510,513);//defence
        strength2(510,530);//air-air

        pushMatrix();
        translate(5,120);
        scale(0.5f);
        usa();
        fill(255);
        star(50,300,2,5);
        star(61,292,2,5);
        star(32,290,2,5);
        star(49,274,2,5);
        star(26,309,2,5);
        star(251,300,2,5);
        star(237,286,2,5);
        star(269,290,2,5);
        star(276,304,2,5);
        star(253,272,2,5);
        popMatrix();

        pushMatrix();
        translate(295,120);
        scale(0.5f);
        syria();
        fill(0,122,61);
        star(121,180,3,7);
        star(177,180,3,7);
        popMatrix();

        pushMatrix();
        translate(5,390);
        scale(0.5f);
        russia();
        popMatrix();

        pushMatrix();
        translate(295,390);
        scale(0.5f);
        uk();
        popMatrix();

        image(usaf,155,145,100,60);
        image(syriaf,445,145,100,60);
        image(russiaf,155,400,100,60);
        image(ukf,445,400,100,60);
        drawSelector(flightType);
        // Player(posX, posY, velX, velY, accX, accY, attack, health, numOfBomb, sInterval)

        //setup the properties of different planes
        switch (flightType){
            case 1:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 2, 3, 300);
                break;
            case 2:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 4, 2, 400);
                break;
            case 3:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 3, 1, 3, 400);
                break;
            case 4:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 4, 1, 1, 200);
                break;
            default:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 2, 3, 300);
            break;
        }
    }
    //if currentPage == 2, display the background page
    else if (2 == currentPage){
        // String strText = "asdfasdfasdfasdfasdasdf";
        // println("strText: "+strText);
        playerNervous.close();
        playerStory.play();
        introTextY = constrain(introTextY, 0, introText.height - height);
        set(0, -introTextY, introText);
        introTextY = (frameCount - tmpframecount) / 3;
    }
    //draw the fighting page
    else if (3 == currentPage) {
        playerStory.close();
        playerFight.play();
        image(img2, 0, 0, 600,750);
        //check if the game should continue
        if(player.alive && !bossKilled){
            for(int i = 0; i < enemies.size(); i++) {
                Enemy tempEnemy = enemies.get(i);
                tempEnemy.update();
                tempEnemy.detectBound();
                tempEnemy.drawMe();
                // detect collision between enemy and player
                if(player.hitObject(tempEnemy) && !player.invincible) {
                    player.posX = initialPosX;
                    player.posY = initialPosY;
                    player.decreaseHealth(tempEnemy.getDamage());
                    player.invincible = true;
                    player.invincibleTime = millis();
                }
                //check if the enemies are alive, if not, remove it
                if(!tempEnemy.alive){
                    int currentTime = millis();
                    tempEnemy.dieout(currentTime - tempEnemy.deadTime);
                    if(currentTime - tempEnemy.deadTime < 100){
                        playerExplode.rewind();
                        playerExplode.play();
                    }
                    if(currentTime - tempEnemy.deadTime < 2500){
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
            //initiate enemies
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
            println("killedEnemy: "+killedEnemy);
            println("boss.posY: "+boss.posY);
            //generate the boss
            if((killedEnemy >= random(3, 5)) && (boss.posY == -1)) {
                println("----" + Main.boss.alive + "----");
                int bossPosX = (int)width / 2;
                int bossPosY = 0;
                int bossVelX = 1;
                int bossVelY = (int)random(20,30);
                int bossAccX = 0;
                int bossAccY = 0;
                boss = new BossEnemy(bossPosX,bossPosY,bossVelX,bossVelY,bossAccX,bossAccY);
                killedEnemy = 0;
            }
            //update position of boss while it is alive
            if(boss.posY != -1){
                if(!boss.totallyDied){
                    boss.update();
                    boss.drawBoss();
                    boss.trackBullets();
                }
                //control the action of boss
                if(boss.alive){
                    // boss shoots every 1 second, shooting 5 seconds, interval time is 0.3 sec
                    int currentTime = millis();
                    if(currentTime - bossRestTime > 1000){
                        if(currentTime - bossShootTime < 5000){  // keep shooting
                            if(currentTime - bossShootInterval > 300){
                                boss.shoot();
                                playerShoot.rewind();
                                playerShoot.play();
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
                    if(currentTime - boss.deadTime < 100){
                        playerExplode.rewind();
                        playerExplode.play();
                    }
                    if(currentTime - boss.deadTime < 3000){
                        boss.drawDeath(explode[(currentTime - boss.deadTime)/150]);
                    }
                    if(currentTime - boss.deadTime > 1500){
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
                playerShoot.rewind();
                playerShoot.play();
                int currentTime = millis();
                if(currentTime - shootTime > player.sInterval){
                    player.shoot();
                    shootTime = currentTime;
                }
            }
            //the effects of using bomb
            if ((useBomb) && (player.numOfBomb > 0) && (bombing == 0)) {
                player.numOfBomb--;
                playerBomb.rewind();
                playerBomb.play();
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
            //update the position of the player
            player.update();
            player.detectBound();
            player.drawMe(flightType, player.invincible);
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
            textFont(Times, 24);
            textAlign(RIGHT);
            fill(255);

            for (int i = 0; i < player.health; ++i) {
                drawHealth(0 + i * 45, 20);
            }
            for (int i = 0; i < player.numOfBomb; ++i) {
                drawBomb(28 + i * 45, 60);
            }
            fill(255, 255, 255);
            text("Score: " + score, 550, 40);
        }
        else if(player.alive && bossKilled){

            background(0);
            frameRate(45);
            if(counter==0){
                textSize(150);
                text(a.charAt(A)+"___",300,375);
                if(A==2){
                    text("C___",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==1){
                text("C"+a.charAt(A)+"__",300,375);
                if(A==1){
                    text("CA__",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==2){
                text("CA"+a.charAt(A)+"_",300,375);
                if(A==11){
                    text("CAL_",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==3){
                text("CAL"+a.charAt(A)+"",300,375);
                if(A==11){
                    text("CALL",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==4){
                if(pcounter==0){
                    end_change1();
                }else if(pcounter==1){
                    end_change();
                }else if(pcounter==2){
                    end_change();
                }else if(pcounter==3){
                    end_change();
                }else if(pcounter==4){
                    counter++;
                    A=0;
                }
            }else if(counter==5){
                textSize(150);
                fill(255);
                text(a.charAt(A)+"_",300,375);
                if(A==19){
                    text("O_",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==6){
                text("O"+a.charAt(A),300,375);
                if(A==5){
                    text("OF",300,375);
                    counter++;
                    t=80;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==7){
                if(pcounter==4){
                    end_change1();
                }else if(pcounter==5){
                    end_change();
                }else if(pcounter==6){
                    end_change();
                }else if(pcounter==7){
                    end_change();
                }else if(pcounter==8){
                    counter++;
                    t=80;
                }
            }else if(counter==8){
                textSize(150);
                fill(255);
                text(a.charAt(A)+"____",300,375);
                if(A==15){
                    text("P____",300,375);
                    counter++;
                    A=0;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==9){
                text("P"+a.charAt(A)+"___",300,375);
                if(A==4){
                    text("PE___",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==10){
                text("PE"+a.charAt(A)+"__",300,375);
                if(A==1){
                    text("PEA__",300,375);
                    counter++;
                    A=0;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==11){
                text("PEA"+a.charAt(A)+"_",300,375);
                if(A==2){
                    text("PEAC_",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==12){
                text("PEAC"+a.charAt(A),300,375);
                if(A==4){
                    text("PEACE",300,375);
                    counter++;
                }else{
                    A=(A+1)%a.length();
                }
            }else if(counter==13){
                if(pcounter==8){
                    end_change1();
                }else if(pcounter==9){
                    end_change();
                }else if(pcounter==10){
                    end_change();
                }else if(pcounter==11){
                    counter++;
                }
            }else if(counter==14){
                if(pcounter==11){
                    end_change2();
                }else if(pcounter==12){
                    counter++;
                }
            }else if(counter==15){
                pcounter=11;
                end_text();
            }

            for(int i = 0; i < enemies.size(); i++){
                enemies.remove(i);
            }

        }
        else {
            // player is dead
            for(int i = 0; i < enemies.size(); i++){
                enemies.remove(i);
            }
            textFont(Times, 48);
            textAlign(CENTER);
            fill(255);
            text("Oop, dead", width / 2, height / 3);
            text("score " + score, width / 2, height / 2);
            textFont(Lucida, 30);
            text("Press R to restart", width / 2, height * 2 / 3);
        }
        //if the current game ended and the player choose to restart
        if(restart){
            restart = false;
            pages[0] = false;
            pages[1] = true;
            currentPage = 1;
            // textFont(Lucida, 24);
            // textAlign(CENTER);
            // fill(255, 255, 255);
            // // print(currentPage);
            // alive = true;
            // player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 300);
            score = 0;
            killedEnemy = 0;
            bossKilled = false;
            // restart = false;
            boss = new BossEnemy();
            // // enemy create, show up at top of the screen, move down
            // for(int i = 0; i < NUM_ENEMY; i++){
            //     int enemyPosX = (int) random(0, width);
            //     int enemyPosY = 0;
            //     float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
            //     int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
            //     int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
            //     int enemyType = 0;
            //     // print(enemyVelX, enemyVelY, "\n");
            //     enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
            // }

        }
    }
}

public void end_text(){
  col=p[pcounter].width/s;
  row=p[pcounter].height/s;
  p[pcounter].loadPixels();
  for(int j=0;j<row;j++){
    for(int i=0;i<col;i++){
      int loc=i*s+j*s*p[pcounter].width;
      int c=p[pcounter].pixels[loc];
      float b=brightness(p[pcounter].pixels[loc]);
      float fontSize = 2*s * (b / 255);
      textSize(fontSize);
      int x=i*s;
      int y=j*s;
      fill(c);
      text(peace.charAt(charcount),x+X[pcounter],y+Y[pcounter]);
      charcount=(charcount+1)%peace.length();
    }
  }
}

public void end_change(){
  if(t<=90&&t>70){
    tint(100,100);
    image(p[pcounter],X[pcounter],Y[pcounter]);
    end_text();
    t++;
  }else if(t<=70&&t>60){
    s=5;
    end_text();
    t++;
  }else if(t<=60&&t>50){
    s=6;
    end_text();
    t++;
  }else if(t<=50&&t>40){
    s=8;
    end_text();
    t++;
  }else if(t<=40&&t>30){
    s=10;
    end_text();
    t++;
  }else if(t<=30&&t>20){
    s=12;
    end_text();
    t++;
  }else if(t<=20&&t>10){
    s=14;
    end_text();
    t++;
  }else if(t<=10&&t>=0){
    s=16;
    end_text();
    t++;
  }else{
    pcounter++;
    t=0;
  }
}

public void end_change1(){
  if(t<=90&&t>70){
    tint(50,50);
    image(p[pcounter],X[pcounter],Y[pcounter]);
    end_text();
    t--;
  }else if(t<=70&&t>60){
    s=5;
    end_text();
    t--;
  }else if(t<=60&&t>50){
    s=6;
    end_text();
    t--;
  }else if(t<=50&&t>40){
    s=8;
    end_text();
    t--;
  }else if(t<=40&&t>30){
    s=10;
    end_text();
    t--;
  }else if(t<=30&&t>20){
    s=12;
    end_text();
    t--;
  }else if(t<=20&&t>10){
    s=14;
    end_text();
    t--;
  }else if(t<=10&&t>=0){
    s=16;
    end_text();
    t--;
  }else{
    pcounter++;
    t=0;
  }
}

public void end_change2(){
  if(t<=90&&t>70){
    tint(120,120);
    image(p[pcounter],X[pcounter],Y[pcounter]);
    end_text();
    t++;
  }else if(t<=70&&t>60){
    s=7;
    end_text();
    t++;
  }else if(t<=60&&t>50){
    s=9;
    end_text();
    t++;
  }else if(t<=50&&t>40){
    s=12;
    end_text();
    t++;
  }else if(t<=40&&t>30){
    s=16;
    end_text();
    t++;
  }else if(t<=30&&t>20){
    s=20;
    end_text();
    t++;
  }else if(t<=20&&t>10){
    s=25;
    end_text();
    t++;
  }else if(t<=10&&t>=0){
    s=30;
    end_text();
    t++;
  }else{
    pcounter++;
    t=0;
  }
}


//function to draw the selector symbol in plane selection page
public void drawSelector(int x) {
    int currentTime = millis() / 100;
    noStroke();
    if (currentTime % 13 == 0) {
        fill(200, 200, 100, 30);
    }
    else if (currentTime % 13 == 1) {
        fill(200, 200, 100, 40);
    }
    else if (currentTime % 13 == 2) {
        fill(200, 200, 100, 50);
    }
    else if (currentTime % 13 == 3) {
        fill(200, 200, 100, 60);
    }
    else if (currentTime % 13 == 4) {
        fill(200, 200, 100, 70);
    }
    else if (currentTime % 13 == 5) {
        fill(200, 200, 100, 80);
    }
    else if (currentTime % 13 == 6) {
        fill(200, 200, 100, 90);
    }
    else if (currentTime % 13 == 7) {
        fill(200, 200, 100, 100);
    }
    else if (currentTime % 13 == 8) {
        fill(200, 200, 100, 110);
    }
    else if (currentTime % 13 == 9) {
        fill(200, 200, 100, 120);
    }
    else if (currentTime % 13 == 10) {
        fill(200, 200, 100, 130);
    }
    else if (currentTime % 13 == 11) {
        fill(200, 200, 100, 140);
    }
    else if (currentTime % 13 == 12) {
        fill(200, 200, 100, 150);
    }
    else {
        fill(255, 200, 100);
    }
    switch(x){
        case 1:
            beginShape();
            vertex(80, 330);
            vertex(50, 360);
            vertex(80, 350);
            vertex(110, 360);
            endShape();
            break;
        case 2:
            beginShape();
            vertex(370, 330);
            vertex(340, 360);
            vertex(370, 350);
            vertex(400, 360);
            endShape();
            break;
        case 3:
            beginShape();
            vertex(80, 600);
            vertex(50, 630);
            vertex(80, 620);
            vertex(110, 630);
            endShape();
            break;
        case 4:
            beginShape();
            vertex(370, 600);
            vertex(340, 630);
            vertex(370, 620);
            vertex(400, 630);
            endShape();
            break;
    }

}

//draw the left corner symbol for bomb
public void drawBomb(int x, int y) {
    pushMatrix();
    translate(x, y);
    scale(0.4f);
    smooth();
    fill(200);
    quad(10,21,53,21,53,55,10,55);
    fill(150);
    bezier(10,21,18,-4,45,-4,53,21);
    beginShape();
    vertex(3,65);
    vertex(7,95);
    vertex(22,81);
    vertex(40,81);
    vertex(54,95);
    vertex(59,65);
    vertex(49,60);
    vertex(12,60);
    endShape(CLOSE);
    fill(200);
    quad(10,55,53,55,42,77,20,77);
    quad(22,81,40,81,40,77,22,77);
    rect(29,65,3,30);
    fill(150);
    rect(29,58,3,7);
    fill(220);
    rect(10,45,43,10);
    for(int i=0; i<=6; i++){
        noStroke();
        fill(206,12,12);
        quad(13+6*i,46,16+6*i,46,13+6*i,55,10+6*i,55);
    }
    popMatrix();
}

//draw the left corner symbol for health
public void drawHealth(int x, int y) {
    pushMatrix();
    translate(x, y);
    scale(0.8f);
    smooth();
    noStroke();
    fill(0);
    beginShape();
    vertex(52, 17);
    bezierVertex(52, -5, 90, 5, 52, 40);
    vertex(52, 17);
    bezierVertex(52, -5, 10, 5, 52, 40);
    endShape();
    fill(255,0,0);
    beginShape();
    vertex(50, 15);
    bezierVertex(50, -5, 90, 5, 50, 40);
    vertex(50, 15);
    bezierVertex(50, -5, 10, 5, 50, 40);
    endShape();
    popMatrix();
}

//define the key press effect
public void keyPressed() {
    if (keyCode == ENTER){
        if (2 == currentPage) {
            currentPage = 3;
        }
        if (1 == currentPage) {
            tmpframecount = frameCount;
            currentPage = 2;
        }
        else if (0 == currentPage) {
            currentPage = 1;
        }
    }
    if (key == 'z' || key == 'Z') shoot = true;
    if (key == 'x' || key == 'X') useBomb = true;
    if (key == 'r' ||key == 'R') restart = true;
    if (currentPage == 1){
        if (keyCode == 49) flightType = 1;
        if (keyCode == 50) flightType = 2;
        if (keyCode == 51) flightType = 3;
        if (keyCode == 52) flightType = 4;
    }
    if (keyCode == UP) {
        up = true;
        changeFlightType(0);
    }
    if (keyCode == DOWN) {
        down = true;
        changeFlightType(1);
    }
    if (keyCode == LEFT) {
        left = true;
        changeFlightType(2);
    }
    if (keyCode == RIGHT) {
        right = true;
        changeFlightType(3);
    }
}

//define the effects of releasing the key
public void keyReleased() {
    if (key == 'z' || key == 'Z') shoot = false;
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
}

//define the effects while choosing to move the selector
public void changeFlightType(int x) {
    if (currentPage != 1) return;
    if (0 == x) {
        if (flightType == 3) flightType = 1;
        if (flightType == 4) flightType = 2;
    }
    if (1 == x) {
        if (flightType == 1) flightType = 3;
        if (flightType == 2) flightType = 4;
    }
    if (2 == x) {
        if (flightType == 2) flightType = 1;
        if (flightType == 4) flightType = 3;
    }
    if (3 == x) {
        if (flightType == 1) flightType = 2;
        if (flightType == 3) flightType = 4;
    }
}

//part of plane design
public void interface1(){
    noStroke();
    fill(10,100);//light gray
    rect(0,60,600,590);
    fill(220);//gray
    noStroke();
    beginShape();
    vertex(365,40);
    vertex(600,40);
    vertex(600,80);
    vertex(365,80);
    vertex(345,60);
    endShape(CLOSE);
    fill(19,70,100,100);//dark blue
    rect(0,110,600,215);
    rect(0,380,600,215);
}

//define the title of plane selection page
public void title(){
 textFont(select,30);
 fill(150);
 text("PLANE SELECT",482,72);
 fill(0);
 text("PLANE SELECT",480,70);
}

//Draw the feature of plane
public void feature(float x, float y){
  fill(150);
  textFont(feature,12);
  text("LETHAL",x,y);
  text("DEFENSE",x,y+18);
  text("BOMB",x,y+36);
  text("AGILITY",x,y+54);
}

//draw the selection page
public void strength1(float x, float y){
    noStroke();
   fill(80);
   rect(x+7,y,66,6);
   bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
   bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
   rect(x+7,y+1,13,3);//1st blue ba
   bezier(x+7,y+1,x+1,y+2.5f,x+1,y+3.5f,x+7,y+4);
}
public void strength2(float x, float y){
    noStroke();
    fill(80);
    rect(x+7,y,66,6);
    bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
    bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
    fill(20,178,226);
    rect(x+7,y+1,13,3);//1st blue bar
    bezier(x+7,y+1,x+1,y+2.5f,x+1,y+3.5f,x+7,y+4);
    rect(x+22,y+1,17,3);//2nd blue bar
}
public void strength3(float x, float y){
    noStroke();
    fill(80);
    rect(x+7,y,66,6);
    bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
    bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
    fill(20,178,226);
    rect(x+7,y+1,13,3);//1st blue bar
    bezier(x+7,y+1,x+1,y+2.5f,x+1,y+3.5f,x+7,y+4);
    rect(x+22,y+1,17,3);//2nd blue bar
    rect(x+41,y+1,17,3);//3rd blue bar
}

//draw the US plane
public void usa(){
    stroke(1);
    //back guns
    fill(0);
    rect(73,192,4,15);
    rect(224,192,4,15);
    rect(71,207,8,15);
    rect(222,207,8,15);
    rect(66,207,3,15);
    rect(232,207,3,17);
    rect(122,109,4,15);
    rect(175,110,4,15);
    rect(121,120,6,15);
    rect(174,120,6,15);
    rect(116,124,3,15);
    rect(182,124,3,15);

    //wings
    fill(1,0,74);//dark blue
    beginShape();
    vertex(14,286);
    vertex(61,236);
    vertex(88,308);
    vertex(51,334);
    vertex(14,313);
    endShape(CLOSE);
    beginShape();
    vertex(286,287);
    vertex(286,312);
    vertex(247,335);
    vertex(212,309);
    vertex(238,238);
    endShape(CLOSE);

    fill(200);//white
    beginShape();
    vertex(38,307);
    vertex(74,307);
    vertex(80,314);
    vertex(81,337);
    vertex(68,345);
    vertex(38,327);
    endShape(CLOSE);
    beginShape();
    vertex(219,316);
    vertex(226,308);
    vertex(262,308);
    vertex(262,326);
    vertex(231,345);
    vertex(219,336);
    endShape(CLOSE);

    fill(192,0,11);//red
    beginShape();
    vertex(96,191);
    vertex(61,230);
    vertex(60,269);
    vertex(96,312);
    vertex(101,300);
    vertex(100,247);
    vertex(112,232);
    vertex(132,232);
    vertex(131,186);
    endShape(CLOSE);
    beginShape();
    vertex(204,191);
    vertex(240,230);
    vertex(240,270);
    vertex(205,312);
    vertex(200,302);
    vertex(200,248);
    vertex(193,238);
    vertex(185,231);
    vertex(170,230);
    vertex(170,186);
    endShape(CLOSE);

    //white
    fill(200);
    beginShape();
    vertex(70,217);
    vertex(74,220);
    vertex(81,210);
    vertex(85,213);
    vertex(75,227);
    vertex(72,229);
    vertex(71,231);
    vertex(73,233);
    vertex(73,268);
    vertex(71,272);
    vertex(76,277);
    vertex(82,274);
    vertex(89,283);
    vertex(90,297);
    vertex(66,272);
    vertex(65,235);
    vertex(68,229);
    vertex(62,228);
    endShape(CLOSE);
    beginShape();
    vertex(228,217);
    vertex(225,218);
    vertex(218,211);
    vertex(215,213);
    vertex(223,227);
    vertex(226,226);
    vertex(230,230);
    vertex(227,233);
    vertex(228,270);
    vertex(229,272);
    vertex(223,276);
    vertex(218,276);
    vertex(210,283);
    vertex(211,296);
    vertex(235,273);
    vertex(234,233);
    vertex(232,228);
    vertex(237,227);
    endShape(CLOSE);

    //guns
    //white
    fill(200);
    beginShape();
    vertex(121,301);
    vertex(98,313);
    vertex(102,336);
    vertex(119,342);
    vertex(139,336);
    vertex(141,313);
    endShape(CLOSE);//l
    beginShape();
    vertex(159,312);
    vertex(162,336);
    vertex(180,342);
    vertex(200,336);
    vertex(202,313);
    vertex(180,302);
    endShape(CLOSE);

    //black
    fill(0);
    rect(105,315,30,30);
    rect(166,315,30,30);
    quad(105,344,109,355,131,355,135,344);
    quad(166,344,170,355,192,355,196,344);
    //green
    fill(0,0,67);
    rect(103,253,33,62);//l
    rect(164,252,33,62);//r
    //white
    fill(200);
    bezier(103,252,107,230,132,230,136,252);//l
    bezier(164,252,169,230,192,230,197,252);//r
    rect(103,280,33,25);//l
    rect(164,280,33,25);//r
    rect(104,319,33,26,3);//l
    rect(165,319,33,26,3);//r
    rect(115,310,7,28,8);//l
    rect(178,310,7,28,8);//r
    //green
    fill(0,0,67);
    rect(105,284,10,15);
    rect(124,284,10,15);
    rect(167,285,10,15);
    rect(185,284,10,15);

    //body-wings
    //green
    fill(0,0,67);//blue
    bezier(107,154,101,162,98,169,98,187);
    bezier(191,153,199,164,202,172,203,187);
    quad(107,154,98,186,98,223,107,224);
    quad(191,153,203,186,202,223,192,223);
    fill(192,0,11);//red
    quad(134,112,108,147,107,239,132,230);
    quad(165,112,192,147,193,239,168,230);
    //black
    fill(0);
    quad(130,122,130,142,111,164,111,147);
    quad(169,122,188,147,188,165,169,144);
    //white
    fill(200);
    beginShape();
    vertex(131,154);
    vertex(129,202);
    vertex(118,202);
    vertex(112,181);
    vertex(110,179);
    vertex(110,171);
    endShape(CLOSE);
    beginShape();
    vertex(170,154);
    vertex(190,172);
    vertex(190,182);
    vertex(188,181);
    vertex(182,201);
    vertex(172,201);
    endShape(CLOSE);

    //green
    fill(192,0,11);
    quad(134,193,166,193,154,342,146,342);
    fill(192,0,11);
    quad(142,180,159,180,152,352,148,352);
    //white
    fill(200);
    ellipse(150,374,6,50);

    //head
    fill(1,1,75);
    ellipse(149.5f,72,33,25);
    ellipse(149.5f,94,30,170);
    fill(0);
    ellipse(149.5f,94,20,160);
    fill(154,155,84);
    ellipse(149.5f,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5f,15);
  }

//draw the russia plane
public void russia(){
    stroke(1);
    //back guns
    fill(0);
    rect(73,192,4,15);
    rect(224,192,4,15);
    rect(71,207,8,15);
    rect(222,207,8,15);
    rect(66,207,3,15);
    rect(232,207,3,17);
    rect(122,109,4,15);
    rect(175,110,4,15);
    rect(121,120,6,15);
    rect(174,120,6,15);
    rect(116,124,3,15);
    rect(182,124,3,15);

    //wings
    fill(165,0,0);//gray
    beginShape();
    vertex(14,286);
    vertex(61,236);
    vertex(88,308);
    vertex(51,334);
    vertex(14,313);
    endShape(CLOSE);
    beginShape();
    vertex(286,287);
    vertex(286,312);
    vertex(247,335);
    vertex(212,309);
    vertex(238,238);
    endShape(CLOSE);

    fill(0);//black
    beginShape();
    vertex(38,307);
    vertex(74,307);
    vertex(80,314);
    vertex(81,337);
    vertex(68,345);
    vertex(38,327);
    endShape(CLOSE);
    beginShape();
    vertex(219,316);
    vertex(226,308);
    vertex(262,308);
    vertex(262,326);
    vertex(231,345);
    vertex(219,336);
    endShape(CLOSE);

    fill(18,39,148);//blue
    beginShape();
    vertex(96,191);
    vertex(61,230);
    vertex(60,269);
    vertex(96,312);
    vertex(101,300);
    vertex(100,247);
    vertex(112,232);
    vertex(132,232);
    vertex(131,186);
    endShape(CLOSE);
    beginShape();
    vertex(204,191);
    vertex(240,230);
    vertex(240,270);
    vertex(205,312);
    vertex(200,302);
    vertex(200,248);
    vertex(193,238);
    vertex(185,231);
    vertex(170,230);
    vertex(170,186);
    endShape(CLOSE);

    //white
    fill(200);
    beginShape();
    vertex(70,217);
    vertex(74,220);
    vertex(81,210);
    vertex(85,213);
    vertex(75,227);
    vertex(72,229);
    vertex(71,231);
    vertex(73,233);
    vertex(73,268);
    vertex(71,272);
    vertex(76,277);
    vertex(82,274);
    vertex(89,283);
    vertex(90,297);
    vertex(66,272);
    vertex(65,235);
    vertex(68,229);
    vertex(62,228);
    endShape(CLOSE);
    beginShape();
    vertex(228,217);
    vertex(225,218);
    vertex(218,211);
    vertex(215,213);
    vertex(223,227);
    vertex(226,226);
    vertex(230,230);
    vertex(227,233);
    vertex(228,270);
    vertex(229,272);
    vertex(223,276);
    vertex(218,276);
    vertex(210,283);
    vertex(211,296);
    vertex(235,273);
    vertex(234,233);
    vertex(232,228);
    vertex(237,227);
    endShape(CLOSE);

    //guns
    //red
    fill(194,24,11);
    beginShape();
    vertex(121,301);
    vertex(98,313);
    vertex(102,336);
    vertex(119,342);
    vertex(139,336);
    vertex(141,313);
    endShape(CLOSE);//l
    beginShape();
    vertex(159,312);
    vertex(162,336);
    vertex(180,342);
    vertex(200,336);
    vertex(202,313);
    vertex(180,302);
    endShape(CLOSE);

    //black
    fill(0);
    rect(105,315,30,30);
    rect(166,315,30,30);
    quad(105,344,109,355,131,355,135,344);
    quad(166,344,170,355,192,355,196,344);

    rect(103,253,33,62);//l
    rect(164,252,33,62);//r
    //white
    fill(200);
    bezier(103,252,107,230,132,230,136,252);//l
    bezier(164,252,169,230,192,230,197,252);//r

    rect(103,280,33,25);//l
    rect(164,280,33,25);//r
    rect(104,319,33,26,3);//l
    rect(165,319,33,26,3);//r
    fill(194,24,11);
    rect(115,310,7,28,8);//l
    rect(178,310,7,28,8);//r

    fill(194,24,11);
    rect(105,284,10,15);
    rect(124,284,10,15);
    rect(167,285,10,15);
    rect(185,284,10,15);

    //body-wings

    fill(0,0,67);//blue
    bezier(107,154,101,162,98,169,98,187);
    bezier(191,153,199,164,202,172,203,187);
    quad(107,154,98,186,98,223,107,224);
    quad(191,153,203,186,202,223,192,223);
    fill(192,0,11);//red
    quad(134,112,108,147,107,239,132,230);
    quad(165,112,192,147,193,239,168,230);
    //black
    fill(0);
    quad(130,122,130,142,111,164,111,147);
    quad(169,122,188,147,188,165,169,144);
    //white
    fill(200);
    beginShape();
    vertex(131,154);
    vertex(129,202);
    vertex(118,202);
    vertex(112,181);
    vertex(110,179);
    vertex(110,171);
    endShape(CLOSE);
    beginShape();
    vertex(170,154);
    vertex(190,172);
    vertex(190,182);
    vertex(188,181);
    vertex(182,201);
    vertex(172,201);
    endShape(CLOSE);

    fill(0);
    quad(134,193,166,193,154,342,146,342);
    fill(192,0,11);
    quad(142,180,159,180,152,352,148,352);
    //white
    fill(200);
    ellipse(150,374,6,50);

    //head
    fill(160,0,0);
    ellipse(149.5f,72,33,25);
    ellipse(149.5f,94,30,170);
    fill(0);
    ellipse(149.5f,94,20,160);
    fill(154,155,84);
    ellipse(149.5f,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5f,15);
}

//draw the syria plane
public void syria(){
    stroke(1);
    //back guns
    fill(0);
    rect(73,192,4,15);
    rect(224,192,4,15);
    rect(71,207,8,15);
    rect(222,207,8,15);
    rect(66,207,3,15);
    rect(232,207,3,17);
    rect(122,109,4,15);
    rect(175,110,4,15);
    rect(121,120,6,15);
    rect(174,120,6,15);
    rect(116,124,3,15);
    rect(182,124,3,15);

    //wings
    fill(206,17,38);//red
    beginShape();
    vertex(14,286);
    vertex(61,236);
    vertex(88,308);
    vertex(51,334);
    vertex(14,313);
    endShape(CLOSE);
    beginShape();
    vertex(286,287);
    vertex(286,312);
    vertex(247,335);
    vertex(212,309);
    vertex(238,238);
    endShape(CLOSE);

    fill(200);//white
    beginShape();
    vertex(38,307);
    vertex(74,307);
    vertex(80,314);
    vertex(81,337);
    vertex(68,345);
    vertex(38,327);
    endShape(CLOSE);
    beginShape();
    vertex(219,316);
    vertex(226,308);
    vertex(262,308);
    vertex(262,326);
    vertex(231,345);
    vertex(219,336);
    endShape(CLOSE);

    fill(0);//red
    beginShape();
    vertex(96,191);
    vertex(61,230);
    vertex(60,269);
    vertex(96,312);
    vertex(101,300);
    vertex(100,247);
    vertex(112,232);
    vertex(132,232);
    vertex(131,186);
    endShape(CLOSE);
    beginShape();
    vertex(204,191);
    vertex(240,230);
    vertex(240,270);
    vertex(205,312);
    vertex(200,302);
    vertex(200,248);
    vertex(193,238);
    vertex(185,231);
    vertex(170,230);
    vertex(170,186);
    endShape(CLOSE);

    //white
    fill(200);
    beginShape();
    vertex(70,217);
    vertex(74,220);
    vertex(81,210);
    vertex(85,213);
    vertex(75,227);
    vertex(72,229);
    vertex(71,231);
    vertex(73,233);
    vertex(73,268);
    vertex(71,272);
    vertex(76,277);
    vertex(82,274);
    vertex(89,283);
    vertex(90,297);
    vertex(66,272);
    vertex(65,235);
    vertex(68,229);
    vertex(62,228);
    endShape(CLOSE);
    beginShape();
    vertex(228,217);
    vertex(225,218);
    vertex(218,211);
    vertex(215,213);
    vertex(223,227);
    vertex(226,226);
    vertex(230,230);
    vertex(227,233);
    vertex(228,270);
    vertex(229,272);
    vertex(223,276);
    vertex(218,276);
    vertex(210,283);
    vertex(211,296);
    vertex(235,273);
    vertex(234,233);
    vertex(232,228);
    vertex(237,227);
    endShape(CLOSE);

    //guns
    //white
    fill(200);
    beginShape();
    vertex(121,301);
    vertex(98,313);
    vertex(102,336);
    vertex(119,342);
    vertex(139,336);
    vertex(141,313);
    endShape(CLOSE);//l
    beginShape();
    vertex(159,312);
    vertex(162,336);
    vertex(180,342);
    vertex(200,336);
    vertex(202,313);
    vertex(180,302);
    endShape(CLOSE);

    //black
    fill(0);
    rect(105,315,30,30);
    rect(166,315,30,30);
    quad(105,344,109,355,131,355,135,344);
    quad(166,344,170,355,192,355,196,344);
    //green
    fill(0,122,61);
    rect(103,253,33,62);//l
    rect(164,252,33,62);//r
    //white
    fill(200);
    bezier(103,252,107,230,132,230,136,252);//l
    bezier(164,252,169,230,192,230,197,252);//r
    rect(103,280,33,25);//l
    rect(164,280,33,25);//r
    rect(104,319,33,26,3);//l
    rect(165,319,33,26,3);//r
    rect(115,310,7,28,8);//l
    rect(178,310,7,28,8);//r
    //green
    fill(0,122,61);
    rect(105,284,10,15);
    rect(124,284,10,15);
    rect(167,285,10,15);
    rect(185,284,10,15);

    //body-wings

    fill(0,122,61);//green
    bezier(107,154,101,162,98,169,98,187);
    bezier(191,153,199,164,202,172,203,187);
    quad(107,154,98,186,98,223,107,224);
    quad(191,153,203,186,202,223,192,223);
    fill(206,17,38);//red
    quad(134,112,108,147,107,239,132,230);
    quad(165,112,192,147,193,239,168,230);
    //black
    fill(0);
    quad(130,122,130,142,111,164,111,147);
    quad(169,122,188,147,188,165,169,144);
    //white
    fill(200);
    beginShape();
    vertex(131,154);
    vertex(129,202);
    vertex(118,202);
    vertex(112,181);
    vertex(110,179);
    vertex(110,171);
    endShape(CLOSE);
    beginShape();
    vertex(170,154);
    vertex(190,172);
    vertex(190,182);
    vertex(188,181);
    vertex(182,201);
    vertex(172,201);
    endShape(CLOSE);

    fill(0);
    quad(134,193,166,193,154,342,146,342);
    fill(0);
    quad(142,180,159,180,152,352,148,352);
    //white
    fill(200);
    ellipse(150,374,6,50);

    //head

    fill(206,17,38);
    ellipse(149.5f,72,33,25);
    ellipse(149.5f,94,30,170);
    fill(0);
    ellipse(149.5f,94,20,160);
    fill(154,155,84);
    ellipse(149.5f,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5f,15);
}

//draw the UK plane
public void uk(){
    stroke(1);
    //back guns
    fill(0);
    rect(73,192,4,15);
    rect(224,192,4,15);
    rect(71,207,8,15);
    rect(222,207,8,15);
    rect(66,207,3,15);
    rect(232,207,3,17);
    rect(122,109,4,15);
    rect(175,110,4,15);
    rect(121,120,6,15);
    rect(174,120,6,15);
    rect(116,124,3,15);
    rect(182,124,3,15);

    //wings--england
    fill(1,0,74);//dark blue
    beginShape();
    vertex(14,286);
    vertex(61,236);
    vertex(88,308);
    vertex(51,334);
    vertex(14,313);
    endShape(CLOSE);
    beginShape();
    vertex(286,287);
    vertex(286,312);
    vertex(247,335);
    vertex(212,309);
    vertex(238,238);
    endShape(CLOSE);

    noStroke();
    fill(255);
    rect(15,286,74,20);
    rect(212,284,74,20);
    rect(48,248,20,74);
    rect(233,248,20,74);
    quad(26,272,35,260,83,312,72,320);
    quad(262,260,272,272,229,312,220,318);
    quad(25,318,38,328,85,278,75,263);
    quad(264,324,280,316,228,262,214,274);

    fill(207,20,43);
    rect(51,248,15,74);
    rect(235,247,15,74);
    rect(15,289,74,15);
    rect(211,286,74,15);

    stroke(1);
    fill(0);//white
    beginShape();
    vertex(38,307);
    vertex(74,307);
    vertex(80,314);
    vertex(81,337);
    vertex(68,345);
    vertex(38,327);
    endShape(CLOSE);
    beginShape();
    vertex(219,316);
    vertex(226,308);
    vertex(262,308);
    vertex(262,326);
    vertex(231,345);
    vertex(219,336);
    endShape(CLOSE);

    fill(0,36,125);//red
    beginShape();
    vertex(96,191);
    vertex(61,230);
    vertex(60,269);
    vertex(96,312);
    vertex(101,300);
    vertex(100,247);
    vertex(112,232);
    vertex(132,232);
    vertex(131,186);
    endShape(CLOSE);
    beginShape();
    vertex(204,191);
    vertex(240,230);
    vertex(240,270);
    vertex(205,312);
    vertex(200,302);
    vertex(200,248);
    vertex(193,238);
    vertex(185,231);
    vertex(170,230);
    vertex(170,186);
    endShape(CLOSE);

    //gray
    fill(200);
    beginShape();
    vertex(70,217);
    vertex(74,220);
    vertex(81,210);
    vertex(85,213);
    vertex(75,227);
    vertex(72,229);
    vertex(71,231);
    vertex(73,233);
    vertex(73,268);
    vertex(71,272);
    vertex(76,277);
    vertex(82,274);
    vertex(89,283);
    vertex(90,297);
    vertex(66,272);
    vertex(65,235);
    vertex(68,229);
    vertex(62,228);
    endShape(CLOSE);
    beginShape();
    vertex(228,217);
    vertex(225,218);
    vertex(218,211);
    vertex(215,213);
    vertex(223,227);
    vertex(226,226);
    vertex(230,230);
    vertex(227,233);
    vertex(228,270);
    vertex(229,272);
    vertex(223,276);
    vertex(218,276);
    vertex(210,283);
    vertex(211,296);
    vertex(235,273);
    vertex(234,233);
    vertex(232,228);
    vertex(237,227);
    endShape(CLOSE);

    //guns
    //white
    fill(200);
    beginShape();
    vertex(121,301);
    vertex(98,313);
    vertex(102,336);
    vertex(119,342);
    vertex(139,336);
    vertex(141,313);
    endShape(CLOSE);//l
    beginShape();
    vertex(159,312);
    vertex(162,336);
    vertex(180,342);
    vertex(200,336);
    vertex(202,313);
    vertex(180,302);
    endShape(CLOSE);

    //black
    fill(0);
    rect(105,315,30,30);
    rect(166,315,30,30);
    quad(105,344,109,355,131,355,135,344);
    quad(166,344,170,355,192,355,196,344);

    fill(207,20,43);
    rect(103,253,33,62);//l
    rect(164,252,33,62);//r

    fill(200);
    bezier(103,252,107,230,132,230,136,252);//l
    bezier(164,252,169,230,192,230,197,252);//r
    rect(103,280,33,25);//l
    rect(164,280,33,25);//r
    fill(0,36,125);
    rect(104,319,33,26,3);//l
    rect(165,319,33,26,3);//r
    fill(200);
    rect(115,310,7,28,8);//l
    rect(178,310,7,28,8);//r

    fill(0,0,67);
    rect(105,284,10,15);
    rect(124,284,10,15);
    rect(167,285,10,15);
    rect(185,284,10,15);

    //body-wings

    fill(0,0,67);//blue
    bezier(107,154,101,162,98,169,98,187);
    bezier(191,153,199,164,202,172,203,187);
    quad(107,154,98,186,98,223,107,224);
    quad(191,153,203,186,202,223,192,223);
    fill(0,36,125);//red
    quad(134,112,108,147,107,239,132,230);
    quad(165,112,192,147,193,239,168,230);
    //black
    fill(0);
    quad(130,122,130,142,111,164,111,147);
    quad(169,122,188,147,188,165,169,144);
    //white
    fill(200);
    beginShape();
    vertex(131,154);
    vertex(129,202);
    vertex(118,202);
    vertex(112,181);
    vertex(110,179);
    vertex(110,171);
    endShape(CLOSE);
    beginShape();
    vertex(170,154);
    vertex(190,172);
    vertex(190,182);
    vertex(188,181);
    vertex(182,201);
    vertex(172,201);
    endShape(CLOSE);


    fill(0,36,125);
    quad(134,193,166,193,154,342,146,342);
    fill(192,0,11);
    quad(142,180,159,180,152,352,148,352);
    //white
    fill(200);
    ellipse(150,374,6,50);

    //head

    fill(1,1,75);
    ellipse(149.5f,72,33,25);
    ellipse(149.5f,94,30,170);
    fill(0);
    ellipse(149.5f,94,20,160);
    fill(154,155,84);
    ellipse(149.5f,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5f,15);
}

//draw the stat on the plane
public void star(float x, float y, float r, float R) {
    float angle = TWO_PI / 5;
    float halfAngle = angle/2.0f;
    beginShape();
    noStroke();
    for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * r;
        float sy = y + sin(a) * r;
        vertex(sx, sy);
        sx = x + cos(a+halfAngle) * R;
        sy = y + sin(a+halfAngle) * R;
        vertex(sx, sy);
    }
    endShape(CLOSE);
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
    dieout();
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
    float wid = 2,hei = 2; //the width and height of the object,used to detect the hitting
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
/*
additional fields:
    int deadTime;
    float angle;
    float speed;
    boolean totallyDied;
    ArrayList <Bullet> bossBullets = new ArrayList <Bullet>(); //store the bullet of the boss

Methods:
    drawDeath();
    drawBoss();
    update();
    shoot();
    trackBullet();
*/

class BossEnemy extends BasicObject{

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
        wid = 380;
        hei = 230;
        health = 50;
        totallyDied = false;
        speed = 40;
        angle = 0;
    }


    public void drawDeath(PImage explodeImg){
        image(explodeImg,posX - wid/2,posY - hei/2,wid,wid);
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

        //draw the boss
    public void drawBoss(){
        pushMatrix();
        translate(posX, posY);
        translate(-wid/2, - hei/2);
        smooth();
        colorMode(RGB);

        //back guns
        fill(100);
        rect(140,135,97,54);
        rect(151,56,9,17);
        rect(220,56,9,17);
        rect(152,69,11,17);
        rect(218,69,11,17);

        //body--back
        fill(150);
        triangle(116,83,144,18,144,83);
        triangle(261,82,235,16,235,82);

        fill(160,184,4);//green
        quad(101,89,152,70,152,176,101,192);
        quad(278,89,228,70,228,176,278,192);//cutong

        fill(166,203,47);//light green
        rect(106,83,21,53);
        rect(251,83,21,53);
        fill(150);//gray
        rect(106,112,35,30);
        rect(238,112,35,30);

        fill(160,184,4);//green
        rect(141,23,15,107);
        rect(224,22,15,107);
        quad(144,13,152,17,135,50,127,46);
        quad(226,16,234,12,250,46,243,50);
        fill(100);
        triangle(135,50,127,46,138,25);
        triangle(243,50,250,46,240,24);//zhuazi

        //wings-- up guns
        fill(100);
        rect(89,120,10,5);
        rect(108,120,10,5);//l
        rect(264,120,10,5);
        rect(283,120,10,5);//r
        bezier(86,122,89,105,98,105,101,122);
        bezier(105,122,107,105,117,105,120,122);//l
        bezier(262,122,265,105,273,105,277,122);
        bezier(281,122,284,105,292,105,296,122);//r

        //down-guns
        rect(38,167,15,15);
        rect(41,182,10,10);
        rect(59,171,15,15);
        rect(62,186,10,10);
        rect(330,168,15,15);
        rect(333,183,10,10);
        rect(306,170,15,15);
        rect(308,185,10,10);
        fill(130);
        rect(86,163,32,34);
        rect(94,197,18,20);
        rect(260,161,32,34);
        rect(268,195,18,20);
        fill(185,0,0);//red
        rect(41,190,10,5,3);
        rect(41,190,10,5,3);
        rect(62,197,10,5,3);
        rect(308,194,10,5,3);
        rect(333,193,10,5,3);
        rect(94,217,18,5,3);
        rect(268,215,18,5,3);

        //wings
        fill(166,203,47);
        beginShape();
        vertex(8,124);
        vertex(145,124);
        vertex(145,170);
        vertex(106,163);
        vertex(97,164);
        vertex(81,177);
        vertex(16,164);
        endShape(CLOSE);//l
        beginShape();
        vertex(370,124);
        vertex(234,124);
        vertex(234,170);
        vertex(271,163);
        vertex(285,164);
        vertex(297,177);
        vertex(366,164);
        endShape(CLOSE);//r
        fill(180);
        rect(25,124,37,38);
        rect(317,124,37,38);
        fill(200);
        ellipse(44,144,30,30);
        ellipse(335,145,30,30);
        fill(185,0,0);//red
        ellipse(44,144,15,15);
        ellipse(335,145,15,15);
        fill(150);
        ellipse(44,134,15,15);
        ellipse(335,134,15,15);
        fill(120,139,58);
        ellipse(93,145,14,35);
        ellipse(286,145,14,35);

        //body
        fill(176,180,33);
        quad(157,84,179,75,179,143,157,143);
        quad(224,84,200,75,200,143,224,143);
        fill(178,214,64);
        beginShape();
        vertex(176,42);
        vertex(180,42);
        vertex(184,78);
        vertex(181,80);
        vertex(176,80);
        vertex(173,78);
        endShape(CLOSE);//l
        beginShape();
        vertex(199,42);
        vertex(202,42);
        vertex(206,78);
        vertex(203,80);
        vertex(199,80);
        vertex(195,78);
        endShape(CLOSE);

        fill(178,214,64);//light green
        rect(146,114,12,53,8);
        rect(223,114,12,53,8);

        beginShape();
        vertex(185,70);
        vertex(185,77);
        vertex(181,81);
        vertex(181,108);
        vertex(198,108);
        vertex(198,82);
        vertex(194,77);
        vertex(194,70);
        endShape(CLOSE);//bottle
        fill(0);//black
        rect(177,164,27,30);
        fill(120);
        rect(181,108,17,30);
        rect(186,109,8,52);

        fill(178,214,64);
        rect(184,160,12,38,8);
        fill(160,184,4);//green
        rect(145,186,41,23,10);
        rect(193,186,41,23,10);

        //mark
        fill(0);
        triangle(156,93,178,93,168,110);
        fill(210);
        ellipse(168,97,16,16);
        fill(168,0,0);
        beginShape();
        vertex(166,94);
        vertex(170,94);
        vertex(169,96);
        vertex(172,97);
        vertex(167,104);
        vertex(167,98);
        vertex(164,99);
        endShape(CLOSE);

        fill(247,247,0);
        triangle(262,86,254,99,271,99);
        line(260,98,260,95);
        line(260,95,265,95);
        fill(168,0,0);
        ellipse(263,92,3,3);
        popMatrix();
    }
}
/*
Methods:
    drawBullet():draw the bullet
    update(): update the position of the bullet
    detectBound();
    hitObject();
    drawHit();
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
            fill(255,100,30);
            ellipse(posX, posY, 6, 9);
            fill(255,153,51);
            ellipse(posX,posY, 4, 6);
            fill(255,255,100);
            ellipse(posX,posY, 2, 3);
            fill(255,255,200);
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
    //draw the hitting effects
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
    drawMe();
    update();
    detectBound();
    getDamage();
    drawdeath();
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
        classOfObejct = 1;
        scaleFactor = random(1,2);
        wid = 30*scaleFactor;
        hei = 40*scaleFactor;
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
        image(explodeImg,posX - wid/2*scaleFactor,posY- wid/2*scaleFactor,hei*scaleFactor,hei*scaleFactor);
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

    //check if the enemy is damaged
    public int getDamage() {
        //TODO
        return 1;
    }

    //draw the enemy
    public void drawMe(){
        pushMatrix();
        translate(posX, posY);
        translate(wid/2,hei/2);
        rotate(PI);
        scale(scaleFactor/10);
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

/*
Methods:
    drawMe():draw the player
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
        wid = 300/4;
        hei = 400/4;
        classOfObejct = 0;
        alive = true;
    }

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
        println("BEFORE Main.boss.health: "+Main.boss.health);
        int count = 0;
        if ((Main.boss.alive) && (Main.boss.posY != -1)){
            Main.boss.decreaseHealth(10);
            if(Main.boss.health <= 0){
                Main.boss.alive = false;
                Main.boss.deadTime = millis();
                Main.score += 100;
                bossKilled = true;
            }
        }
        println("AFTER Main.boss.health: "+Main.boss.health);
        //remove all bullets
        Main.boss.emptyBullets();
        //kill all the enemies
        for(int j = 0; j < Main.enemies.size(); j++){
            Enemy tempEnemy = Main.enemies.get(j);
            tempEnemy.alive = false;
            tempEnemy.deadTime = millis();
            count ++;
        }
        // fill(0,0,0);
        // rect(0,0,width,height);
        return count;
    }
    //draw the player
    public void drawMe(int type, boolean invincible){
        if (invincible) {
            int tmp = millis() / 100;
            if (tmp % 3 == 0) return;
        }
        pushMatrix();
        translate(posX,posY);
        translate( - wid/2, - hei/2);
        scale(0.25f);
        switch (type) {
            case 1:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(192,0,11);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,0,67);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings
                //green
                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(192,0,11);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                //green
                fill(192,0,11);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5f,72,33,25);
                ellipse(149.5f,94,30,170);
                fill(0);
                ellipse(149.5f,94,20,160);
                fill(154,155,84);
                ellipse(149.5f,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5f,15);
                star(50,300);
                star(61,292);
                star(32,290);
                star(49,274);
                star(26,309);
                star(251,300);
                star(237,286);
                star(269,290);
                star(276,304);
                star(253,272);
                println("NO");
                break;
            case 3:
                println("YES");
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(192,0,11);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,0,67);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings
                //green
                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(192,0,11);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                //green
                fill(192,0,11);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5f,72,33,25);
                ellipse(149.5f,94,30,170);
                fill(0);
                ellipse(149.5f,94,20,160);
                fill(154,155,84);
                ellipse(149.5f,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5f,15);

                break;
            case 4:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings--england
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                noStroke();
                fill(255);
                rect(15,286,74,20);
                rect(212,284,74,20);
                rect(48,248,20,74);
                rect(233,248,20,74);
                quad(26,272,35,260,83,312,72,320);
                quad(262,260,272,272,229,312,220,318);
                quad(25,318,38,328,85,278,75,263);
                quad(264,324,280,316,228,262,214,274);

                fill(207,20,43);
                rect(51,248,15,74);
                rect(235,247,15,74);
                rect(15,289,74,15);
                rect(211,286,74,15);

                stroke(1);
                fill(0);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(0,36,125);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //gray
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);

                fill(207,20,43);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r

                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                fill(0,36,125);
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                fill(200);
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r

                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings

                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(0,36,125);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);


                fill(0,36,125);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5f,72,33,25);
                ellipse(149.5f,94,30,170);
                fill(0);
                ellipse(149.5f,94,20,160);
                fill(154,155,84);
                ellipse(149.5f,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5f,15);
                break;

            case 2:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(206,17,38);//red
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(0);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,122,61);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,122,61);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings

                fill(0,122,61);//green
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(206,17,38);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                fill(0);
                quad(134,193,166,193,154,342,146,342);
                fill(0);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(206,17,38);
                ellipse(149.5f,72,33,25);
                ellipse(149.5f,94,30,170);
                fill(0);
                ellipse(149.5f,94,20,160);
                fill(154,155,84);
                ellipse(149.5f,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5f,15);
                star(121,180);
                star(177,180);
                break;

            default:
                break;

            }
        popMatrix();
    }

    public void star(float x, float y) {
        float angle = TWO_PI / 5;
        float halfAngle = angle/2.0f;
        beginShape();
        noStroke();
        for (float a = 0; a < TWO_PI; a += angle) {
            float sx = x + cos(a) * 2;
            float sy = y + sin(a) * 2;
            vertex(sx, sy);
            sx = x + cos(a+halfAngle) * 5;
            sy = y + sin(a+halfAngle) * 5;
            vertex(sx, sy);
        }
        endShape();
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
