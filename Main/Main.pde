int NUM_ENEMY = 7;
int speed = 2;
// accelerations controled by keyboard
PVector upAcc = new PVector(0, -speed);
PVector downAcc = new PVector(0, speed);
PVector leftAcc = new PVector(-speed, 0);
PVector rightAcc = new PVector(speed, 0);
boolean up, down, left, right, shoot, useBomb;
boolean welcomePage = true;  // welcome page
boolean restart = false;  // restart game
static int score = 0;
boolean alive = true;  // if the player is alive
boolean bossKilled = false;
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

int initialPosX;
int initialPosY;
void setup(){
    size(600, 750);
    img = loadImage("space.jpg");
    initialPosX = width / 2;
    initialPosY = height * 9 / 10;
    player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 1);
    boss = new BossEnemy();
    for(int i = 0; i < NUM_ENEMY; i++){
        int enemyPosX = (int) random(0, width);
        int enemyPosY = 0;
        float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
        int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
        int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
        int enemyType = 0;
        print(enemyVelX, enemyVelY, "\n");
        enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
    }
}

void draw(){
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
        text("Press A to shoot", width / 2, height / 2 + 50);
        text("Press S to start", width / 2, height / 2 + 100);
    }
    else{
        if(alive && !bossKilled){
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
                        if(boss.totallyDied){
                            killedEnemy ++;  // count one killed enemy
                        }
                    }
                }
            }

            for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
                int enemyPosX = (int) random(0, width);
                int enemyPosY = 0;
                float enemyAngle = atan2(player.posY - enemyPosY, player.posX - enemyPosX);
                int enemyVelX = (int)(4 * cos(enemyAngle) + random(-1,1));
                int enemyVelY = (int)(4 * sin(enemyAngle) + random(-1,1));
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

            if(killedEnemy >= random(3, 5)) {
                int bossPosX = (int)width / 2;
                int bossPosY = 0;
                int bossVelX = 0;
                int bossVelY = (int)random(10,20);
                int bossAccX = 0;
                int bossAccY = 0;
                boss = new BossEnemy(bossPosX,bossPosY,bossVelX,bossVelY,bossAccX,bossAccY);
                killedEnemy = 0;
            }

            if(boss.posY != -1){
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
                    if(currentTime - boss.deadTime > 500){
                        boss.totallyDied = true;
                        bossKilled = true;
                    }
                }
                if(!boss.totallyDied){
                    boss.update();
                    boss.drawBoss();
                    boss.trackBullets();
                }
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
            if (useBomb){

                killedEnemy = player.useBomb();
                useBomb = false;
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
        else if(alive && bossKilled){
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
            alive = true;
            player = new Player(initialPosX, initialPosY, 0, 0, 0, 0, 1, 1, 1, 1);
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
                print(enemyVelX, enemyVelY, "\n");
                 enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0));
            }
        }
    }
}


void keyPressed() {
    if(key == 'a' || key == 'A'){
        shoot = true;
    }
    if(key == 's' || key == 'S'){
        welcomePage = false;
    }
    if(key == 'b' || key == 'B'){
        useBomb = true;
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

void keyReleased() {
    if(key == 'a' || key == 'A'){
        shoot = false;
    }
    if (key == CODED) {
        if (keyCode == UP) up = false;
        if (keyCode == DOWN) down = false;
        if (keyCode == LEFT) left = false;
        if (keyCode == RIGHT) right = false;
    }
}


