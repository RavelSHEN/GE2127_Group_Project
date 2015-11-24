import ddf.minim.*;
AudioPlayer playerHit;
AudioPlayer playerShoot;
AudioPlayer playerExplode;
AudioPlayer playerFight;
AudioPlayer playerNervous;
AudioPlayer playerStory;
Minim storyAu;
Minim hitAu;
Minim shootAu;
Minim explodeAu;
Minim fightAu;
Minim nervousAu;
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
boolean bossBorn = false;
int bombing = 0;
int currentPage = 0;
int flightType = 1;
int shootTime = 0;  // shoot interval time
int bossShootInterval = 0;  // boss shoot interval time
int bossShootTime = 0;  // boss shooting time
int bossRestTime = millis();  // boss resting time
int killedEnemy = 0;  // count the number of died enemy, boss appears every killed 30 enemies
int killedBoss = 0;
static Player player;
static BossEnemy boss;
static ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage img1;  // background image
PImage img2;
PImage introText;
int introTextY;
PImage[] explode = new PImage[20];
PImage[] bomb = new PImage[30];
PFont Times;
PFont Lucida;
int bombX;
int bombY;
int bombCounter;
int tmpframecount;
int initialPosX;
int initialPosY;


PImage usaf;
PImage ukf;
PImage syriaf;
PImage russiaf;
PFont select;
PFont feature;

void setup(){
    size(600, 750);
    select = loadFont("SitkaBanner-Bold-48.vlw");
    feature = loadFont("LucidaSans-Demi-48.vlw");
    usaf = loadImage("usaf.jpg");
    ukf = loadImage("ukf.jpg");
    syriaf = loadImage("syriaf.jpg");
    russiaf = loadImage("russiaf.jpg");
    img1 = loadImage("welcome.jpg");
    img2 = loadImage("fight.jpg");
    introText = loadImage("introtext.png");
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
    Times = loadFont("TimesNewRomanPS-BoldMT-60.vlw");
    Lucida = loadFont("LucidaBright-Demi-48.vlw");
    println("----" + Main.boss.alive + "----");
    hitAu = new Minim(this);
    playerHit = hitAu.loadFile("dang.au",1000);
    shootAu = new Minim(this);
    playerShoot = shootAu.loadFile("fire.au",1000);
    explodeAu = new Minim(this);
    playerExplode = explodeAu.loadFile("explode.au",1000);
    fightAu = new Minim(this);
    playerFight = fightAu.loadFile("fight.mp3",1000);
    playerFight.setGain(-5);
    nervousAu = new Minim(this);
    playerNervous = nervousAu.loadFile("nervous.mp3",1000);
    playerNervous.setGain(20);
    storyAu = new Minim(this);
    playerStory = storyAu.loadFile("story.mp3",1000);
    playerStory.setGain(10);

}

void draw(){
    //TODO: Change the background image
    image(img1, 0, 0, 600, 750);
    playerNervous.play();
    if(0 == currentPage){

        //TODO: Re-design the WelcomePage
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
        else {
            fill(255, 255, 255);
            text("Press ENTER to Continue", width / 2, height *2 / 3);
        }
    }
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
        // println("flightType: "+flightType);

        // textFont(Lucida, 24);
        // text("Press 1,2,3,4 to select your plane", width / 2, height / 3);
        // text("Press arrow up, down, left right to move", width / 2, height / 2);
        // text("Press Z to shoot", width / 2, height / 2 + 50);
        // text("Press X to use bomb", width / 2, height / 2 + 100);
        // text("Press ENTER to start", width / 2, height / 2 + 150);
        // Player(posX, posY, velX, velY, accX, accY, attack, health, numOfBomb, sInterval)
        switch (flightType){
            case 1:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 3, 3, 400);
                break;
            case 2:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 2, 1, 400);
                break;
            case 3:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 2, 400);
                break;
            case 4:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 5, 1, 100, 200);
                break;
            default:
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 2, 1, 1, 400);
            break;
        }
    }
    else if (2 == currentPage){
        // String strText = "asdfasdfasdfasdfasdasdf";
        // println("strText: "+strText);
        playerNervous.close();
        playerStory.play();
        introTextY = constrain(introTextY, 0, introText.height - height);
        set(0, -introTextY, introText);
        introTextY = (frameCount - tmpframecount) / 3;
    }
    else{
        playerStory.close();
        playerFight.play();
        image(img2, 0, 0, 600,750);
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

            println("killedEnemy: "+killedEnemy);
            println("boss.posY: "+boss.posY);
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

            if(boss.posY != -1){
                if(!boss.totallyDied){
                    boss.update();
                    boss.drawBoss();
                    boss.trackBullets();
                }

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
            for(int i = 0; i < enemies.size(); i++){
                enemies.remove(i);
            }
            textFont(Times, 48);
            textAlign(CENTER);
            fill(255);
            text("Yes! You Win", width / 2, height / 3);
            text("score " + score, width / 2, height / 2);
            textFont(Lucida, 30);
            text("Press R to restart", width / 2, height * 2 / 3);
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

void drawSelector(int x) {
    switch(x){
        case 1:
            stroke(100,80,50);
            for (int i = 0; i < 30; i ++){
                fill(200+i*10,200+i*10,200+i*10);
                triangle(80, 330, 50+i, 360, 110-i, 360);
            }
            break;
        case 2:
            stroke(100,80,50);
            for (int i = 0; i < 30; i ++){
                fill(200+i*10,200+i*10,200+i*10);
                triangle(370, 330, 340+i, 360, 400-i, 360);
            }
            break;
        case 3:
            stroke(100,80,50);
            for (int i = 0; i < 30; i ++){
                fill(200+i*10,200+i*10,200+i*10);
                triangle(80, 600, 50+i, 630, 110-i, 630);
            }
            break;
        case 4:
            stroke(100,80,50);
            for (int i = 0; i < 30; i ++){
                fill(200+i*10,200+i*10,200+i*10);
                triangle(370, 600, 340+i, 630, 400-i, 630);
            }
            break;
    }

}

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

void keyPressed() {
    if (keyCode == ENTER){
        // if(currentPage < pages.length){
        //     pages[currentPage] = false;
        //     if(currentPage < pages.length-1){
        //         pages[currentPage + 1] = true;
        //     }
        //     currentPage ++;
        // }
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

void keyReleased() {
    if (key == 'z' || key == 'Z') shoot = false;
    if (keyCode == UP) up = false;
    if (keyCode == DOWN) down = false;
    if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
}

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

void interface1(){
  noStroke();
  fill(20,38,48,100);
  rect(0,0,600,750);
  fill(19,58,89,100);
  rect(0,60,600,600);
  fill(220);//gray
  noStroke();
  beginShape();
  vertex(365,40);
  vertex(600,40);
  vertex(600,80);
  vertex(365,80);
  vertex(345,60);
  endShape(CLOSE);
  fill(10,100);//light gray
  rect(0,110,600,515);
  fill(19,70,100,100);//dark blue
  rect(0,110,600,215);
  rect(0,380,600,215);
}

void title(){
 textFont(select,30);
 fill(150);
 text("PLANE SELECT",482,72);
 fill(0);
 text("PLANE SELECT",480,70);
}

void feature(float x, float y){
  fill(150);
  textFont(feature,12);
  text("LETHAL",x,y);
  text("DEFENSE",x,y+18);
  text("BOMB",x,y+36);
  text("AGILITY",x,y+54);
}

void strength1(float x, float y){
  noStroke();
  fill(80);
  rect(x+7,y,66,6);
  bezier(x+7,y,x,y+1,x,y+5,x+7,y+6);
  bezier(x+73,y,x+80,y+1,x+80,y+5,x+73,y+6);

  fill(126,154,80);//1st green bar
  rect(x+7,y+1,13,3);
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

  fill(126,154,80);//2nd green bar
  rect(x+22,y+1,17,3);

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

  fill(126,154,80);//3rd green bar
  rect(x+41,y+1,17,3);
}

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



