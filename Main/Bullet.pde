/*
Methods:
    drawBullet():draw the bullet
    update(): update the position of the bullet
    detectBound();
    hitObject();
*/

class Bullet extends BasicObject{
    //constructor to define the bullet
    Bullet(int posX,int posY,int velX,int velY,int classOfObejct,int attack){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.classOfObejct = classOfObejct;
        this.attack = attack;

    }

    //draw the bullet on the canvas
    void drawBullet(){
        if (classOfObejct == 0){
            colorMode(RGB,255,255,255);
            noStroke();
            fill(255,0,0);
            ellipse(posX, posY, 6, 6);
            fill(255,153,51);
            ellipse(posX,posY, 4, 4);
            fill(255,255,0);
            ellipse(posX,posY, 2, 2);
            fill(255,255,102);
            ellipse(posX,posY, 1, 1);
            stroke(1);
        }
        else{
            colorMode(RGB,255,255,255);
            noStroke();
            fill(51,153,255);
            ellipse(posX, posY, 8, 8);
            fill(102,178,255);
            ellipse(posX,posY, 6, 6);
            fill(204,229,255);
            ellipse(posX,posY, 4, 4);
            fill(255,255,255);
            ellipse(posX,posY, 2, 2);
            stroke(1);
        }
    }

    //update the position of the bullet
    void update(){
        posX += velX;
        posY += velY;
    }

    //decide if the bullet goes out the screen
    boolean detectBound(){
        if(posX < 0 || posX > width || posY < 0 || posY > height){
            return true;
        }
        else{
            return false;
        }
    }

    void drawHit(){
        image(explode[5],posX,posY,10,10);
    }
    //decide if the bullet hit the object
    boolean hitObject(BasicObject obj){
        if(abs(obj.posX - posX) < obj.wid/ 2 && abs(obj.posY - posY) < obj.hei/ 2){
            return true;
        }
        else{
            return false;
        }
    }
}
