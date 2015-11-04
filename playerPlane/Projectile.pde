class Projectile{
    PVector pos,vel;
    float scaleFactor;
    Projectile(PVector pos, PVector vel, float scaleFactor){
        this.pos = new PVector(pos.x, pos.y);
        this.vel = new PVector(vel.x, vel.y);
        this.scaleFactor = scaleFactor;
    }
    void drawMe(){
         noFill(); 
        pushMatrix();
        translate(pos.x, pos.y);
        stroke(255);
        strokeWeight(3);
        scale(scaleFactor);
        line(0, 0, 0, -3);
        popMatrix();
        strokeWeight(1);
    }
    
    void update(){
        pos.add(vel);
    }
    
    // if the bullets goes out of the screen
    boolean detectBound(){
        if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height)
            return true;
        else
            return false;
    }
    
    boolean hitCharacter(Character ch){
        if(abs(ch.pos.x - pos.x) < ch.wid/ 2 && abs(ch.pos.y - pos.y) < ch.hei/ 2){
            return true;
        }
        else{
            return false;
        }
    }

}
