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
        fill(255,255,255);
        ellipse(posX,posY,5,5);
    }

    //update the position of the bullet
    void update(){
        posX += velX;
        posY += velY;
    }

    //decide if the bullet goes out the screen
    boolean detectBound(){
        if(posX < 1 || posX > width - 1 || posY < 1 || posY > height - 1){
            return true;
        }
        else{
            return false;
        }
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
