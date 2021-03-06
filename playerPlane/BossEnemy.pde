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

class BossEnemy extends BasicObject{
    int deadTime;
    float angle;
    float speed;
    boolean totallyDied;
    ArrayList <Bullet> bossBullets = new ArrayList <Bullet>(); //store the bullet of the boss
    //constructor to create the boss
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
    void drawBoss(){
        ellipse(posX,posY, 50,50);
    }

    //update the position of the boss.
    void update(){
        super.update();
        angle += 0.04;
    }

    //control the shoot of the boss
    void shoot(){
        // boss bullete attract to player
        int bulletPosX = posX + speed * cos(angle);
        int bulletPosY = posY + (hei / 2);
        float bulletAngle = atan2(Main.playerY - bulletPosY, Main.playerX - bulletPosX);
        int bulletVelX = 8 * cos(bulletAngle);
        int bulletVelY = 8 * sin(bulletAngle);
        bossBullets.add(new Bullet(bulletPosX, bulletPosY, bulletVelX, bulletVelY, 1));
    }

    //track the bullets of the boss, check if the bullet hit the object
    void trackBullets(){
        // bossbullet control, if it hit the bound, remove the bullet
        for(int i = 0; i < bossBullets.size(); i++){
            Bullet temp = bossBullets.get(i);
            temp.update();
            temp.drawBullet();
            if(temp.detectBound()){
                bossBullets.remove(temp);
            }
        }
        //check if boss bullet hits player
        for(int i = 0; i < bossBullets.size(); i++){
            Bullet temp = bossBullets.get(i);
            if(temp.hitCharacter(Main.player) && !Main.player.invincible){
                Main.player.decreaseHealth(1);
                Main.player.posX = width / 2;
                Main.player.posY = height * 9 / 10;
                Main.player.invincible = true;
                Main.player.invincibleTime = millis();
            }
        }
    }
}