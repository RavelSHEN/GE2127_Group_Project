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
static ArrayList<Enemy> enemies = new ArrayList<Enemy>();
PImage img;  // background image

int initialPosX = width / 2;
int initialPosY = height * 9 / 10;
void setup(){
    size(600, 800);
    img = loadImage("space.jpg");
    player = new Player(initialPosX, initialPosY, 0, 0, 0, 0);
    boss = new BossEnemy();
    for(int i = 0; i < NUM_ENEMY; i++){
        int enemyPosX = random(0, width);
        int enemyPosY = 0;
        int enemyVelX = random(-3, 3)
        int enemyVelY = random(1, 3);
        int enemyType = 0;
        enemies.add(new Enemy(enemyPosX, enemyPosY, enemyVelX, enemyVelY, 0, 0, enemyType));
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
                if(player.hitCharacter(tempEnemy) && !player.invincible) {
                    player.decreaseHealth(tempEnemy.getDamage());
                    player.invincible = true;
                    player.invincibleTime = millis();
                }

                if(!tempEnemy.alive){  
                    // int currentTime = millis();
                    // if(currentTime - tempEnemy.deadTime > 1000){
                    //     enemies.remove(tempEnemy);
                    //     score += 10;
                    //     killedEnemy ++;  // count one killed enemy
                    // }
                    tempEnemy.dieout();
                }
            }
            if(killedEnemy >= random(10, 20)) {
                PVector bPos = new PVector(width / 2, 0);
                PVector bVel = new PVector(0, random(15, 30));
                PVector bAcc = new PVector(0, 0);
                boss = new BossEnemy(bPos, bVel, bAcc, 1);
                killedEnemy = 0;
            }
            
            if(boss.totallyDied == true){
                // produce enemy only boss is not on the screen
                // when there is an enemy died or disappeared, create a new enemy
                for(int i = 0; i < (NUM_ENEMY- enemies.size()); i++){
                    PVector enemyPos = new PVector(random(0, width), 0);
                    PVector enemyVel = new PVector(random(-3, 3), random(0.1, 3));// flow down vertically
                    PVector enemyAcc = new PVector(0, 0); 
                    enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5, 1)));
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
            if (shoot){
                int currentTime = millis();
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
                player = new Player(initialPosX, initialPosY, 0, 0, 0, 0);
                score = 0;
                killedEnemy = 0;
                restart = false;
                boss = new BossEnemy();
                // enemy create, show up at top of the screen, move down
                for(int i = 0; i < NUM_ENEMY; i++){
                    PVector enemyPos = new PVector(random(0, width), 0);
                    PVector enemyVel = new PVector(random(-3, 3), random(1, 3));
                    PVector enemyAcc = new PVector(0, 0); 
                    enemies.add(new Enemy(enemyPos, enemyVel, enemyAcc, random(0.5, 1)));
                }
            }
        }
    }
}


void keyPressed() {
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

void keyReleased() {
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


