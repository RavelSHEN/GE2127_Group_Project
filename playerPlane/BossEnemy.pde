class BossEnemy extends Character{
    float angle;
    float speed;
    int deadTime;
    boolean totallyDied;
    ArrayList <Projectile> bossBullets = new ArrayList<Projectile>();
    BossEnemy(PVector pos, PVector vel, PVector acc, float scaleFactor){
        super(pos, vel, acc);
        alive = true;
        this.scaleFactor = scaleFactor;
        // the size of boss
        wid = 200;
        hei = 200;
        health = (int)random(8,12); 
        totallyDied = false;
        // boss moves in wavy movement
        speed = 40; 
        angle = 0; 
    }
  
    BossEnemy(){
        super();
        totallyDied = true;
    }
    void update(){
        super.update();
        angle += 0.04;
    }
  
    void shoot(){
    // boss bullete attract to player
        PVector bulletPos = new PVector(pos.x+ speed * cos(angle) , pos.y + hei / 2);
        float bulletAngle = atan2(Main.player.pos.y - bulletPos.y, Main.player.pos.x - bulletPos.x);
        PVector bulletVel = new PVector(8 * cos(bulletAngle), 8 * sin(bulletAngle));
        bossBullets.add(new Projectile(bulletPos, bulletVel, 2));
    }
  
    void trackBullets(){
        // bossbullet control
        for(int i = 0; i < bossBullets.size(); i++){
            Projectile temp = bossBullets.get(i);
            temp.update();
            temp.drawMe();
            if(temp.detectBound()){
            bossBullets.remove(temp);
            }
        }
        for(int i = 0; i < bossBullets.size(); i++){
            Projectile temp = bossBullets.get(i);
            // if boss bullet hits player
            if(temp.hitCharacter(Main.player) && !Main.player.invincible){
                Main.player.decreaseHealth(1);
                Main.player.pos = new PVector(width / 2, height * 9 / 10);
                Main.player.invincible = true;
                Main.player.invincibleTime = millis();
            }
        }
    }
    void drawMe(){
        pushMatrix();
        translate(pos.x + speed * cos(angle),pos.y);
         
        // head
        fill(87, 70, 165);  // blue
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        beginShape();
        vertex(-100, 0);
        bezierVertex(-20, -90, 20, -90, 100, 0);
        vertex(100, 0);
        endShape();

        // body
        fill(142, 134, 175);  // light blue
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        beginShape();
        vertex(-100, 0);
        vertex(100, 0);
        vertex(130, 20);
        vertex(-130, 20);
        endShape();
        fill(87, 70, 165);  // blue
        if(!alive)  fill(131, 131, 131);  // grey
        beginShape();
        vertex(-130, 20);
        vertex(-140, 50);
        vertex(140, 50);
        vertex(130, 20);
        endShape();
        // bottom
        fill(172, 79, 183);  // pink
        if(!alive)  fill(131, 131, 131);  // grey
        beginShape();
        vertex(-110, 50);
        vertex(-70, 90);
        bezierVertex(-50, 95, 50, 95, 70, 90);
        vertex(70, 90);
        vertex(110, 50);
        endShape();

        // windows
        fill(108, 93, 170);  // purple
        if(!alive)  fill(131, 131, 131);  // grey
        ellipse(-50, 70, 20, 20);
        ellipse(0, 70, 20, 20);
        ellipse(50, 70, 20, 20);

        // door
        fill(255);  // white
        stroke(227, 96, 245);  // pink
        if(!alive)  fill(131, 131, 131);  // grey
        strokeWeight(5);
        beginShape();
        vertex(-25, 0);
        vertex(-10, -25);
        vertex(10, -25);
        vertex(25, 0);
        endShape();

        // special windows
        fill(255, 238, 39);  // yellow
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        strokeWeight(5);
        beginShape();
        vertex(13, -30);
        vertex(50, -30);
        bezierVertex(55, -28, 58, 20, 13, -30);
        endShape();
        fill(255, 238, 39);  // yellow
        if(!alive)  fill(131, 131, 131);  // grey
        stroke(10);
        strokeWeight(5);
        beginShape();
        vertex(-13, -30);
        vertex(-50, -30);
        bezierVertex(-55, -28, -58, 20, -13, -30);
        endShape();

        strokeWeight(1);
        popMatrix();
    }
  
}
