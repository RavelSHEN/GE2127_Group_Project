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
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
AudioPlayer playerBomb;
AudioPlayer playerShoot;
AudioPlayer playerExplode;
AudioPlayer playerFight;
AudioPlayer playerNervous;
AudioPlayer playerStory;
AudioPlayer playerWin;
Minim storyAu;
Minim bombAu;
Minim shootAu;
Minim explodeAu;
Minim fightAu;
Minim nervousAu;
Minim winAu;


String a="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String peace="call of peace";
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
void setup(){
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
    winAu = new Minim(this);
    playerWin = winAu.loadFile("win.mp3",1000);
    playerWin.setGain(10);
    end_f = loadFont("Corbel-Bold-48.vlw");
    textFont(end_f);
    textAlign(CENTER);
    for(int i = 0; i < p.length; i++){
        p[i] = loadImage("end" + i + ".jpg");
    }

}

void draw(){
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
        scale(0.5);
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
        scale(0.5);
        syria();
        fill(0,122,61);
        star(121,180,3,7);
        star(177,180,3,7);
        popMatrix();

        pushMatrix();
        translate(5,390);
        scale(0.5);
        russia();
        popMatrix();

        pushMatrix();
        translate(295,390);
        scale(0.5);
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
                    deadAnimation(boss.deadTime);
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
            playerFight.close();
            playerWin.play();
            if (false) {
                // deadAnimation(boss.deadTime);
            }
            else {
                textAlign(CENTER);
                background(0);
                frameRate(24);
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
            }


            // for(int i = 0; i < enemies.size(); i++){
            //     enemies.remove(i);
            // }

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
void deadAnimation(int x) {
    int currentTime = (millis() - x) / 5;
    println("currentTime: "+currentTime);
    fill(0, 0, 0, currentTime);
    rect(0, 0, width, height);

}
void end_text(){
  col=p[pcounter].width/s;
  row=p[pcounter].height/s;
  p[pcounter].loadPixels();
  for(int j=0;j<row;j++){
    for(int i=0;i<col;i++){
      int loc=i*s+j*s*p[pcounter].width;
      color c=p[pcounter].pixels[loc];
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

void end_change(){
  if(t<=90&&t>70){
    tint(170,170);
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

void end_change1(){
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

void end_change2(){
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
void drawSelector(int x) {
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
void drawBomb(int x, int y) {
    pushMatrix();
    translate(x, y);
    scale(0.4);
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
void drawHealth(int x, int y) {
    pushMatrix();
    translate(x, y);
    scale(0.8);
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
void keyPressed() {
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
void keyReleased() {
    if (key == 'z' || key == 'Z') shoot = false;
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
}

//define the effects while choosing to move the selector
void changeFlightType(int x) {
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
void interface1(){
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
void title(){
 textFont(select,30);
 fill(150);
 text("PLANE SELECT",482,72);
 fill(0);
 text("PLANE SELECT",480,70);
}

//Draw the feature of plane
void feature(float x, float y){
  fill(150);
  textFont(feature,12);
  text("LETHAL",x,y);
  text("DEFENSE",x,y+18);
  text("BOMB",x,y+36);
  text("AGILITY",x,y+54);
}

//draw the selection page
void strength1(float x, float y){
    noStroke();
   fill(80);
   rect(x+7,y,66,6);
   bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
   bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
   rect(x+7,y+1,13,3);//1st blue ba
   bezier(x+7,y+1,x+1,y+2.5,x+1,y+3.5,x+7,y+4);
}
void strength2(float x, float y){
    noStroke();
    fill(80);
    rect(x+7,y,66,6);
    bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
    bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
    fill(20,178,226);
    rect(x+7,y+1,13,3);//1st blue bar
    bezier(x+7,y+1,x+1,y+2.5,x+1,y+3.5,x+7,y+4);
    rect(x+22,y+1,17,3);//2nd blue bar
}
void strength3(float x, float y){
    noStroke();
    fill(80);
    rect(x+7,y,66,6);
    bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
    bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);
    fill(20,178,226);
    rect(x+7,y+1,13,3);//1st blue bar
    bezier(x+7,y+1,x+1,y+2.5,x+1,y+3.5,x+7,y+4);
    rect(x+22,y+1,17,3);//2nd blue bar
    rect(x+41,y+1,17,3);//3rd blue bar
}

//draw the US plane
void usa(){
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
    ellipse(149.5,72,33,25);
    ellipse(149.5,94,30,170);
    fill(0);
    ellipse(149.5,94,20,160);
    fill(154,155,84);
    ellipse(149.5,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5,15);
  }

//draw the russia plane
void russia(){
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
    ellipse(149.5,72,33,25);
    ellipse(149.5,94,30,170);
    fill(0);
    ellipse(149.5,94,20,160);
    fill(154,155,84);
    ellipse(149.5,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5,15);
}

//draw the syria plane
void syria(){
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
    ellipse(149.5,72,33,25);
    ellipse(149.5,94,30,170);
    fill(0);
    ellipse(149.5,94,20,160);
    fill(154,155,84);
    ellipse(149.5,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5,15);
}

//draw the UK plane
void uk(){
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
    ellipse(149.5,72,33,25);
    ellipse(149.5,94,30,170);
    fill(0);
    ellipse(149.5,94,20,160);
    fill(154,155,84);
    ellipse(149.5,94,17,77);
    strokeWeight(2);
    line(143,74,158,74);
    line(142,104,158,104);
    strokeWeight(1);
    fill(200);
    bezier(143,15,147,2,153,2,155.5,15);
}

//draw the stat on the plane
void star(float x, float y, float r, float R) {
    float angle = TWO_PI / 5;
    float halfAngle = angle/2.0;
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



