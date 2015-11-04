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
    void drawPlayer(){
        ellispe(posX,posY,20,20);
    };

    //while the player shoots, the bullets objects are generated and stored
    void shoot(){
        bulletPosX = posX;
        bulletPosY = posY;
        bulletVelX = 0;
        bulletVelY = -8;
        //add the new bullets to the array of bullets
        bullets.add(new Bullet(bulletePosX,bulletPosY,bulletVelX,bulletVelY,0,attack));
    }

    //track all the bullets. Cause 1 harm to enemy and boss
    void trackBullets(){
        for (int i = 0; i < bullets.size(); i++){
            Bullet tempBullet = bullets.get(i);
            //update the position of the bullets
            tempBullet.update();
            tempBullet.drawBullet();
            //check if the bullet hit the boundary, remove the bullet from the list of the bullet
            if(tempBullet.detectBound()){
                bullets.remove(i);
            }
            //detect if the bullet hit the boss and cause the damage if yes
            if(tempBullet.hitObject(Main.boss) && Main.boss.alive){
                Main.boss.decreaseHealth(attack);
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
                if(tempBullet.hitCharacter(tempEnemy) && tempEnemy.alive){
                    tempEnemy.decreaseHealth(attack);
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

    //use bomb, which killded all the enemies and cause huge harm to boss
    //while bomb buttom pressed, bombUsed is set to true
    void useBomb(){
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
                if(tempBullet.hitObject(tempEnemy) && tempEnemy.alive){
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
        fill(255,255,255,100-abs(100 - i*20));
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