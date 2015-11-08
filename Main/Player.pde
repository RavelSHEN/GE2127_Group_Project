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
    int bombTimeCounter = 0; //count how long has the bomb be lasted
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
    void drawMe(PImage playerImg){
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
    void shoot(){
        int bulletPosX = posX;
        int bulletPosY = posY;
        int bulletVelX = 0;
        int bulletVelY = -9;
        //add the new bullets to the array of bullets
        bullets.add(new Bullet(bulletPosX,bulletPosY,bulletVelX,bulletVelY,0,attack));
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
    int useBomb(){
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
        //kill all the enemies
        for(int j = 0; j < Main.enemies.size(); j++){
            Main.enemies.remove(j);
            count ++;
        }
        fill(0,0,0);
        rect(0,0,width,height);
        return count;
    }
}
