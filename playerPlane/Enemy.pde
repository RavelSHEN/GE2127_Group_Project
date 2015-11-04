class Enemy extends Character{
    int deadTime;
    int dir = 1;
    float angle;
    Enemy(PVector pos, PVector vel, PVector acc, float scaleFactor){
        super(pos, vel, acc);
        this.scaleFactor = scaleFactor;
        this.wid = 25;
        this.hei = 50;
        colour = color(random(92, 252), random(92, 252), random(92, 252));
        alive = true;
        angle = PI / 4;
        float randomHealth = random(2,3);
        if(randomHealth < 2.5){
            health = 2;
        }
        else{
            health = 3;
        }
    }

    void drawMe(){
        pushMatrix();
        translate(pos.x, pos.y);
        rotate(PI / 2);
        if(!alive){
            colour = color(147, 147, 147);  // grey
        }
        scale(scaleFactor);
        super.drawMe();
        popMatrix();
    }

    void update(){
        // random move
        if(alive){
            pos.x += vel.x * cos(angle);
            pos.y += vel.y * sin(angle);
            angle += 0.04 * dir;
            if(random(0, 16) < 8){
                dir *= -1;
            }
        } 
    }

    void detectBound(){
        super.detectBound();
        // if enemy reaches the bottom of the scrren, disappear and removed from enemies arraylist
        if (pos.y > height || pos.y < 0){
            Main.enemies.remove(this);
        }
    }
    
}
