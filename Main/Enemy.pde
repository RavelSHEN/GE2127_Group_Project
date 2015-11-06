/*
additional fields:
    int deadTime;
    int dir; //control the direction of the movement of the enemy
    float angle;//control the direction of the movement of the enemy

Methods:
    deawEnemy();
    update();
    detectBound();
*/

class Enemy extends BasicObject{
    int deadTime;
    int dir = 1;
    float angle;
    float scaleFactor;
    Enemy(int posX,int posY,int velX,int velY, int accX, int accY){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.classOfObejct = 1;
        scaleFactor = random(1,2);
        wid = 15*scaleFactor;
        hei = 15*scaleFactor;
        alive = true;
        angle = PI / 4;
        float randomHealth = random(1,3);
        if(randomHealth < 1.5){
            health = 1;
        }else if(randomHealth < 2.5){
            health = 2;
        }else{
            health = 3;
        }
    }

    void drawMe(){
        ellipse(posX,posY,15*scaleFactor,15*scaleFactor);
    }

    //update the postion of the enemy
    void update(){
        // random move
        if(alive){
            posX += velX * cos(angle);
            posY += velY * sin(PI/4);
            angle += 0.04*dir;
            if(random(0, 16) < 8){
                dir *= -1;
            }
        }
    }

    //detect if the enemy hit the up/down boundary, if yes, remove
    boolean detectBound(){
        // super.detectBound();
        if(posY > height || posY < 0){
            Main.enemies.remove(this);
            return true;
        }
        return false;

    }

    int getDamage() {
        //TODO
        return 1;
    }
}

