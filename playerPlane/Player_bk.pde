class Player extends Character{
    int invincibleTime;
    boolean invincible;
    ArrayList<Projectile> bullets = new ArrayList<Projectile>();
    Player(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        health = 5;
        wid = 25;
        hei = 50;
        invincibleTime = 0;
        invincible = false;
        alive = true;
        colour = color(202, 209, 206);
    }

    void drawMe(){
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(-PI / 2);
        super.drawMe();
        popMatrix();

    }

    void detectBound(){
        super.detectBound();
        //if the player reaches the top or bottom edge of the screen, stop moving y axis
        if((pos.y - hei/2)< 0){
            pos.y = hei / 2;
        }
        if ((pos.y + hei/2) > height){
            pos.y = height - hei/ 2;
        }
    }


    void shoot(){
        PVector bulletePos = new PVector(pos.x, pos.y);
        PVector bulleteVel = new PVector(0, -8);
        bullets.add(new Projectile(bulletePos, bulleteVel, 1));
    }
    // track all the bullets
    void trackBullets(){
        for(int i = 0; i < bullets.size(); i++){
            Projectile tempBullet = bullets.get(i);
            tempBullet.update();
            tempBullet.drawMe();
            // if bullet goes out of screen, remove it from bullet list
            if(tempBullet.detectBound()){
                bullets.remove(i);
            }
            // detect if bullet hits boss
            if(tempBullet.hitCharacter(Main.boss) && Main.boss.alive){
                Main.boss.decreaseHealth(1);
                bullets.remove(i);
                if(Main.boss.health <= 0){
                    Main.boss.alive = false;
                    Main.boss.deadTime = millis();
                    Main.score += 100;
                }
            }
            // detect if bullet hits enemy
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempBullet.hitCharacter(tempEnemy) && tempEnemy.alive){
                        tempEnemy.decreaseHealth(1);
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
}
