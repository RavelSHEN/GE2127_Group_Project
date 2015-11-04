class Character{

    //fields
    PVector pos, vel, acc;  // position, velocity, and acceleration
    int health;  // health of the object
    float wid, hei;  // width and height of the object
    float scaleFactor;  // size of the object
    float damp = 0.8;  // constant damping factor
    boolean alive;  // check if the character is alive
    int colour;  // color of the character
    // define position, velocity and acceleration of airplane
    Character(PVector pos, PVector vel, PVector acc){
        this.pos = new PVector(pos.x, pos.y);
        this.vel = new PVector(vel.x, vel.y);
        this.acc = new PVector(acc.x, acc.y);
        
    }
    Character(){
        pos = new PVector(-1,-1);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
    }
    // the look of characters
    void drawMe(){
        //rocket fin 1
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,3);
        bezierVertex(10,12,-10,15,-25,15);
        vertex(-25,13);
        bezierVertex(-20,13,-18,10,-18,5);
        vertex(-16,5);
        bezierVertex(-12,7,-12,8,-6,10);
        bezierVertex(-5,10,0,8,10,4);
        endShape();
         
        //rocket fin 2
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,-3);
        bezierVertex(10,-12,-10,-15,-25,-15);
        vertex(-25,-13);
        bezierVertex(-20,-13,-18,-10,-18,-5);
        vertex(-16,-5);
        bezierVertex(-12,-7,-12,-8,-6,-10);
        bezierVertex(-5,-10,0,-8,10,-4);
        endShape(CLOSE);
        
         
        //rocket bell
        fill(colour);
        stroke(10);
        beginShape();
        vertex(-20,3);
        bezierVertex(-20,5,-25,5,-27,6);
        vertex(-27,-6);
        bezierVertex(-25,-5,-20,-5,-20,-3);
        endShape(CLOSE);
 
        //rocket body
        fill(colour);
        stroke(10);
        beginShape();
        vertex(30,0);
        bezierVertex(20,8,0,8,-20,7);
        bezierVertex(-20,5,-20,-5,-20,-7);
        bezierVertex(0,-8,20,-8,30,0);
        endShape(CLOSE);
         
        //doors & windows
        fill(colour);
        stroke(10);
        ellipseMode(CENTER);
        ellipse(4,4.5,7,3);
        line(5,5,7.5,5);
        fill(100);
        stroke(10);
        ellipse(18,2,4,2);
        ellipse(18,-2,4,2);
         
        //rocket fin top
        fill(colour);
        stroke(10);
        beginShape();
        vertex(10,0);
        vertex(7,1);
        vertex(-25,1);
        vertex(-25,-1);
        vertex(7,-1);
        endShape(CLOSE);
 
    }
    void update() {
        vel.mult(damp);
        os.add(vel);
    }
    
    void move(PVector acc){
        this.acc = acc;
        vel.add(acc);
    }

    // detect if this character hits the other
    boolean hitCharacter(Character other){
        // ditect distance between objects
        if(abs(other.pos.x - pos.x) < (wid / 2 + other.wid / 2) && abs(other.pos.y - pos.y) < (hei / 2 + other.hei / 2)){
            return true;
        }
        else {
            return false;
        }
    }
    // calculate health
    void decreaseHealth(int lostHealth){
        health = health - lostHealth;
    }
    
    // when character reaches the left or right edge of the screen, wrap around
    void detectBound(){
        if(pos.x <0){
            pos.x = width;
        }
        else if(pos.x > width){
            pos.x = 0;
        }
    }
}
