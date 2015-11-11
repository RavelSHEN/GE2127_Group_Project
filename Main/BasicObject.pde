/*
Fields:
    int posX; //x position of the object
    int posY; //y position of the object
    int velX = 0; //velocity of the object in direction of X
    int velY = 0; //velocity of the object in direction of Y
    int accX = 0; //acceleration of the object in direction of X
    int accY = 0; //acceleration of the object in direction of Y
    int attack; //define the basic attack
    int health; //blood volume /(health level) of the character
    float wid,hei; //the width and height of the object,used to detect the hitting
    boolean alive = true; //check if the character if alive
    int classOfObejct //define if the object is player or enemy, player for 0, enemy for 1

Methods:
    update();
    move();
    detectBound();
    decreaseHealth();
    hitObject();
*/

class BasicObject{
    //Common fields of the basic elements
    float damp = 0.8; //TODO
    int posX; //x position of the object
    int posY; //y position of the object
    int velX = 0; //velocity of the object in direction of X
    int velY = 0; //velocity of the object in direction of Y
    int accX = 0; //acceleration of the object in direction of X
    int accY = 0; //acceleration of the object in direction of Y
    int attack; //define the basic attack
    int health; //blood volume /(health level) of the character
    float wid = 2,hei = 2; //the width and height of the object,used to detect the hitting
    boolean alive = true; //check if the character if alive
    int classOfObejct; //define if the object is player or enemy, player for 0, enemy for 1

    BasicObject(){
        posX = -1;
        posY = -1;
        velX = 0;
        velY = 0;
        accX = 0;
        accY = 0;
        classOfObejct = 0;
    }

    //constructor which defines the position, velocity and acceleration of the plane
    //pos, vel, acc defines the basic index of the plane
    //classOfObject defines if the object belongs to player or the enemy
    BasicObject(int posX,int posY,int velX,int velY, int accX, int accY, int classOfObejct){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.classOfObejct = classOfObejct;
    }

    //update the position of the plane.
    void update(){
        velX *= damp;
        velY *= damp;
        posX += velX;
        posY += velY;
    }

    //keep change the velosity of the plane, it is damped above
    void move(int accX,int accY){
        this.accX = accX;
        this.accY = accY;
        velX = velX + accX;
        velY = velY + accY;
    }

    //detect if the object is at the edge, if yes, for plane, it can not move, for bullet, demised
    boolean detectBound(){
        if(posX < 10){
            posX = 10;
            velX = 0;
            accX = 0;
            return true;
        }
        else if(posX > width - 10){
            posX = width - 10;
            velX = 0;
            accX = 0;
            return true;
        }
        if(posY < 10){
            posY = 10;
            velY = 0;
            accY = 0;
            return true;
        }
        else if(posY > height - 10){
            posY = height - 10;
            velY = 0;
            accY = 0;
            return true;
        }
        return false;
    }

    //when the object get hitted, health decrease
    void decreaseHealth(int lostBlood){
        health = health - lostBlood;
    }

    //detect if the object hit the other oppose objects. Hit objects of the same class is fine.
    boolean hitObject(BasicObject oppose){
        if (oppose.classOfObejct != classOfObejct){
            if (abs(posX - oppose.posX) < (wid / 2 + oppose.wid/2) && abs(posY - oppose.posY) < (hei / 2 + oppose.hei/2)){
                return true;
            }
            else{
                return false;
            }
        }
        else{
            return false;
        }
    }

    void dieout(int elapsedTime) {
        // animation
    }

}
