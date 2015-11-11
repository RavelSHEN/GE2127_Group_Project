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
    int explodeCount = 0;
    Enemy(int posX,int posY,int velX,int velY, int accX, int accY){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        classOfObejct = 1;
        scaleFactor = random(1,2);
        wid = 30*scaleFactor;
        hei = 40*scaleFactor;
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

    void drawDeath(PImage explodeImg){
        image(explodeImg,posX - wid/2*scaleFactor,posY- wid/2*scaleFactor,hei*scaleFactor,hei*scaleFactor);
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

    void drawMe(){
        pushMatrix();
        translate(posX, posY);
        translate(wid/2,hei/2);
        rotate(PI);
        scale(scaleFactor/10);
        smooth();
              strokeWeight(1);
              beginShape();
              fill(50);
              vertex(150,15);
              vertex(147,16);
              vertex(145,18);
              vertex(137,27);
              vertex(130,43);
              vertex(126,80);
              vertex(135,86);
              vertex(139,46);
              vertex(147,26);
              vertex(153,26);
              vertex(161,46);
              vertex(165,86);
              vertex(174,80);
              vertex(170,43);
              vertex(163,27);
              vertex(155,18);
              vertex(153,16);
              vertex(150,15);
              endShape();

              strokeWeight(3);
              fill(200);
              beginShape();
              vertex(135,86);
              vertex(139,46);
              vertex(147,26);
              vertex(153,26);
              vertex(161,46);
              vertex(165,86);
              vertex(157,96);
              vertex(143,96);
              vertex(135,86);
              endShape();

              beginShape();
              vertex(139,46);
              vertex(146,53);
              vertex(154,53);
              vertex(161,46);
              endShape();
              line(146,53,143,96);
              line(154,53,157,96);

              fill(30);                             //left 1 wing
              beginShape();
              vertex(93,148);//
              vertex(15,335);
              vertex(19,353);////
              vertex(39,329);
              vertex(36,323);////
              vertex(95,211);//
              vertex(89,186);
              vertex(93,148);
              endShape();

              beginShape();                         //right 1 wing
              vertex(207,148);//
              vertex(285,335);
              vertex(281,353);////
              vertex(261,329);
              vertex(264,323);////
              vertex(205,211);//
              vertex(211,186);
              vertex(207,148);
              endShape();

              fill(220);
              beginShape();                         //left 2 wing
              vertex(109,240);////
              vertex(26,370);
              vertex(19,353);////
              vertex(39,329);
              vertex(36,323);////
              vertex(95,211);//
              vertex(137,214);
              vertex(109,240);
              endShape();

              beginShape();                         //right 2 wing
              vertex(191,240);////
              vertex(274,370);
              vertex(281,353);////
              vertex(261,329);
              vertex(264,323);////
              vertex(205,211);//
              vertex(163,214);
              vertex(191,240);
              endShape();

              fill(35);
              strokeWeight(1);
              beginShape();
              vertex(150,155);
              vertex(123,116);
              vertex(126,80);
              vertex(135,86);
              vertex(143,96);
              vertex(157,96);
              vertex(165,86);
              vertex(174,80);
              vertex(177,116);
              vertex(150,155);
              endShape();

              fill(30);
              beginShape();
              vertex(125,90);
              vertex(110,97);
              vertex(93,148);
              vertex(98,151);
              vertex(103,131);
              vertex(109,133);
              vertex(115,114);
              vertex(123,110);
              endShape();

              beginShape();
              vertex(175,90);
              vertex(190,97);
              vertex(207,148);
              vertex(202,151);
              vertex(197,131);
              vertex(191,133);
              vertex(185,114);
              vertex(177,110);
              endShape();

              fill(50);
              beginShape();
              vertex(93,148);//
              vertex(89,186);//
              vertex(98,217);
              vertex(109,224);//
              vertex(141,230);
              vertex(140,216);
              vertex(147,194);
              vertex(150,194);
              vertex(150,155);
              vertex(123,116);
              vertex(123,110);
              vertex(115,114);
              vertex(109,133);
              vertex(103,131);
              vertex(98,151);
              vertex(93,148);
              endShape();

              beginShape();
              vertex(207,148);//
              vertex(211,186);//
              vertex(202,217);
              vertex(191,224);//
              vertex(159,230);
              vertex(160,216);
              vertex(153,194);
              vertex(150,194);
              vertex(150,155);
              vertex(177,116);
              vertex(177,110);
              vertex(185,114);
              vertex(191,133);
              vertex(197,131);
              vertex(202,151);
              vertex(207,148);
              endShape();



              fill(30);
              beginShape();                            //left 1 tail
              vertex(118,226);
              vertex(111,233);
              vertex(106,284);
              vertex(143,244+12);
              vertex(141,230);
              endShape();

              beginShape();                            //right 1 tail
              vertex(182,226);
              vertex(189,233);
              vertex(194,284);
              vertex(157,244+12);
              vertex(159,230);
              endShape();

              fill(230);                               //left 2 tail
              beginShape();
              vertex(128,229);
              vertex(125,234);
              vertex(127,252);
              vertex(143,244);
              vertex(141,230);
              endShape();

              beginShape();                           //right 2 tail
              vertex(172,229);
              vertex(175,234);
              vertex(173,252);
              vertex(157,244);
              vertex(159,230);
              endShape();

              fill(150);
              strokeWeight(2);
              beginShape();
              vertex(141,230+12);
              vertex(140,216+12);
              vertex(147,194);
              vertex(153,194);
              vertex(160,216+12);
              vertex(159,230+12);
              vertex(157,244+12);
              vertex(150,257+12);
              vertex(143,244+12);
              vertex(141,230+12);
              endShape();

              fill(130);
              beginShape();
              vertex(150,229+12);
              vertex(157,244+12);
              vertex(150,257+12);
              vertex(143,244+12);
              vertex(150,229+12);
              endShape();
              line(150,194+12,150,229+12);

              beginShape();
              vertex(121,252+12);
              vertex(137,273+12);
              vertex(163,273+12);
              vertex(179,252+12);
              vertex(157,244+12);
              vertex(150,257+12);
              vertex(143,244+12);
              vertex(121,252+12);
              endShape();

              fill(227,88,18);
              ellipse(142,273+12,10,6);
              ellipse(158,273+12,10,6);
              line(137,247+12,137,258+12);
              line(137,258+12,146,267+12);
              line(146,267+12,154,267+12);
              line(163,247+12,163,258+12);
              line(163,258+12,154,267+12);

              beginShape();
              vertex(117,258+12+12);
              vertex(114,280+12+12);
              vertex(114,298+12+12);
              vertex(116,301+12+12);
              vertex(122,298+12+12);
              vertex(124,282+12+12);
              vertex(135,272+12);
              vertex(122,255+12);
              vertex(116,258+12+12);
              endShape();

              beginShape();
              vertex(183,258+12+12);
              vertex(186,280+12+12);
              vertex(186,298+12+12);
              vertex(184,301+12+12);
              vertex(178,298+12+12);
              vertex(176,282+12+12);
              vertex(165,272+12);
              vertex(178,255+12);
              vertex(184,258+12+12);
              endShape();
              popMatrix();

    }
}

