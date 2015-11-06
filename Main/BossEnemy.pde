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
        int bulletPosX = int(posX + (speed * cos(angle)));
        int bulletPosY = (int)(posY + hei / 2);
        float bulletAngle = atan2(Main.player.posY - bulletPosY, Main.player.posX - bulletPosX);
        int bulletVelX = (int)(8 * cos(bulletAngle));
        int bulletVelY = (int)(8 * sin(bulletAngle));
        bossBullets.add(new Bullet(bulletPosX,bulletPosY,bulletVelX,bulletVelY,1,attack));
    }

    //track the bullets of the boss, check if the bullet hit the object
    void trackBullets(){
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
