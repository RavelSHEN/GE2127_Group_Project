/*
Methods:
    drawPlayer():draw the player
    shoot():define the action of shoot
    trackBullet():check the bullet to decide if the bullet is hit the object
    useBomb(): use bomb to attack
*/
class Player extends BasicObject{
    int showMe = 0;
    int numOfBomb; //define the number of bomb
    boolean bombUsed = false; //check if currently the player is using bomb
    int bombTimeCounter = 1500; //count how long has the bomb be lasted
    boolean invincible; //check if current the plane is invincible
    int invincibleTime; //defines the time of invincible of the player
    ArrayList<Bullet> bullets = new ArrayList<Bullet>(); //store the information of bullets
    int sInterval; //shooting interval
    //constructor to define the basic characters of the player's plane
    //different kind of player plane can have different attackm, health or numOfBomb
    Player(int posX,int posY,int velX,int velY, int accX, int accY,int attack,int health, int numOfBomb, int sInterval){
        this.posX = posX;
        this.posY = posY;
        this.velX = velX;
        this.velY = velY;
        this.accX = accX;
        this.accY = accY;
        this.health = health;
        this.numOfBomb = numOfBomb;
        this.attack = attack;
        this.sInterval = sInterval;
        invincibleTime = 0;
        invincible = false;
        wid = 300/4;
        hei = 400/4;
        classOfObejct = 0;
        alive = true;
    }

    //while the player shoots, the bullets objects are generated and stored
    void shoot(){
        int bulletPosX = posX;
        int bulletPosY = posY;
        int bulletVelX = 0;
        int bulletVelY = -9;
        //add the new bullets to the array of bullets
        bullets.add(new Bullet(bulletPosX,bulletPosY,bulletVelX,bulletVelY,0,attack));
    }

    //track all the bullets. Cause 1 harm to enemy and boss
    void trackBullets(){
        for (int i = 0; i < bullets.size(); i++){
            Bullet tempBullet = bullets.get(i);
            //update the position of the bullets
            tempBullet.update();
            tempBullet.drawBullet();
            //check if the bullet hit the boundary, remove the bullet from the list of the bullet
            if(tempBullet.detectBound()){
                bullets.remove(i);
                continue;
            }
            //detect if the bullet hit the boss and cause the damage if yes
            if(tempBullet.hitObject(Main.boss) && Main.boss.alive){
                Main.boss.decreaseHealth(attack);
                tempBullet.drawHit();
                bullets.remove(i);
                if(Main.boss.health <= 0){
                    Main.boss.alive = false;
                    Main.boss.deadTime = millis();
                    Main.score += 100;
                }
            }
            //detect if the bullet hit the enemy and cause the damage if yes
            for(int j = 0; j < Main.enemies.size(); j++){
                Enemy tempEnemy = Main.enemies.get(j);
                if(tempBullet.hitObject(tempEnemy) && tempEnemy.alive){
                    tempBullet.drawHit();
                    tempEnemy.decreaseHealth(attack);
                    // if enemy is totally hitted, wait one 1s, and then removed
                    if(tempEnemy.health <= 0){
                        tempEnemy.alive = false;
                        tempEnemy.deadTime = millis();
                    }
                    bullets.remove(i);
                    break;
                }
            }
        }
    }

    //use bomb, which killded all the enemies and cause huge harm to boss
    //while bomb buttom pressed, bombUsed is set to true
    int useBomb(){
        //do harm while the animation start
        //cause harm to the boss
        println("BEFORE Main.boss.health: "+Main.boss.health);
        int count = 0;
        if ((Main.boss.alive) && (Main.boss.posY != -1)){
            Main.boss.decreaseHealth(10);
            if(Main.boss.health <= 0){
                Main.boss.alive = false;
                Main.boss.deadTime = millis();
                Main.score += 100;
                bossKilled = true;
            }
        }
        println("AFTER Main.boss.health: "+Main.boss.health);
        //remove all bullets
        Main.boss.emptyBullets();
        //kill all the enemies
        for(int j = 0; j < Main.enemies.size(); j++){
            Enemy tempEnemy = Main.enemies.get(j);
            tempEnemy.alive = false;
            tempEnemy.deadTime = millis();
            count ++;
        }
        // fill(0,0,0);
        // rect(0,0,width,height);
        return count;
    }
        //draw the player
    void drawMe(int type, boolean invincible){
        if (invincible) {
            int tmp = millis() / 100;
            if (tmp % 3 == 0) return;
        }
        pushMatrix();
        translate(posX,posY);
        translate( - wid/2, - hei/2);
        scale(0.25);
        switch (type) {
            case 1:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(192,0,11);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,0,67);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings
                //green
                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(192,0,11);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                //green
                fill(192,0,11);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5,72,33,25);
                ellipse(149.5,94,30,170);
                fill(0);
                ellipse(149.5,94,20,160);
                fill(154,155,84);
                ellipse(149.5,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5,15);
                star(50,300);
                star(61,292);
                star(32,290);
                star(49,274);
                star(26,309);
                star(251,300);
                star(237,286);
                star(269,290);
                star(276,304);
                star(253,272);
                println("NO");
                break;
            case 3:
                println("YES");
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(192,0,11);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,0,67);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings
                //green
                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(192,0,11);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                //green
                fill(192,0,11);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5,72,33,25);
                ellipse(149.5,94,30,170);
                fill(0);
                ellipse(149.5,94,20,160);
                fill(154,155,84);
                ellipse(149.5,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5,15);

                break;
            case 4:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings--england
                fill(1,0,74);//dark blue
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                noStroke();
                fill(255);
                rect(15,286,74,20);
                rect(212,284,74,20);
                rect(48,248,20,74);
                rect(233,248,20,74);
                quad(26,272,35,260,83,312,72,320);
                quad(262,260,272,272,229,312,220,318);
                quad(25,318,38,328,85,278,75,263);
                quad(264,324,280,316,228,262,214,274);

                fill(207,20,43);
                rect(51,248,15,74);
                rect(235,247,15,74);
                rect(15,289,74,15);
                rect(211,286,74,15);

                stroke(1);
                fill(0);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(0,36,125);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //gray
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);

                fill(207,20,43);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r

                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                fill(0,36,125);
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                fill(200);
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r

                fill(0,0,67);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings

                fill(0,0,67);//blue
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(0,36,125);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);


                fill(0,36,125);
                quad(134,193,166,193,154,342,146,342);
                fill(192,0,11);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(1,1,75);
                ellipse(149.5,72,33,25);
                ellipse(149.5,94,30,170);
                fill(0);
                ellipse(149.5,94,20,160);
                fill(154,155,84);
                ellipse(149.5,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5,15);
                break;

            case 2:
                stroke(1);
                //back guns
                fill(0);
                rect(73,192,4,15);
                rect(224,192,4,15);
                rect(71,207,8,15);
                rect(222,207,8,15);
                rect(66,207,3,15);
                rect(232,207,3,17);
                rect(122,109,4,15);
                rect(175,110,4,15);
                rect(121,120,6,15);
                rect(174,120,6,15);
                rect(116,124,3,15);
                rect(182,124,3,15);

                //wings
                fill(206,17,38);//red
                beginShape();
                vertex(14,286);
                vertex(61,236);
                vertex(88,308);
                vertex(51,334);
                vertex(14,313);
                endShape(CLOSE);
                beginShape();
                vertex(286,287);
                vertex(286,312);
                vertex(247,335);
                vertex(212,309);
                vertex(238,238);
                endShape(CLOSE);

                fill(200);//white
                beginShape();
                vertex(38,307);
                vertex(74,307);
                vertex(80,314);
                vertex(81,337);
                vertex(68,345);
                vertex(38,327);
                endShape(CLOSE);
                beginShape();
                vertex(219,316);
                vertex(226,308);
                vertex(262,308);
                vertex(262,326);
                vertex(231,345);
                vertex(219,336);
                endShape(CLOSE);

                fill(0);//red
                beginShape();
                vertex(96,191);
                vertex(61,230);
                vertex(60,269);
                vertex(96,312);
                vertex(101,300);
                vertex(100,247);
                vertex(112,232);
                vertex(132,232);
                vertex(131,186);
                endShape(CLOSE);
                beginShape();
                vertex(204,191);
                vertex(240,230);
                vertex(240,270);
                vertex(205,312);
                vertex(200,302);
                vertex(200,248);
                vertex(193,238);
                vertex(185,231);
                vertex(170,230);
                vertex(170,186);
                endShape(CLOSE);

                //white
                fill(200);
                beginShape();
                vertex(70,217);
                vertex(74,220);
                vertex(81,210);
                vertex(85,213);
                vertex(75,227);
                vertex(72,229);
                vertex(71,231);
                vertex(73,233);
                vertex(73,268);
                vertex(71,272);
                vertex(76,277);
                vertex(82,274);
                vertex(89,283);
                vertex(90,297);
                vertex(66,272);
                vertex(65,235);
                vertex(68,229);
                vertex(62,228);
                endShape(CLOSE);
                beginShape();
                vertex(228,217);
                vertex(225,218);
                vertex(218,211);
                vertex(215,213);
                vertex(223,227);
                vertex(226,226);
                vertex(230,230);
                vertex(227,233);
                vertex(228,270);
                vertex(229,272);
                vertex(223,276);
                vertex(218,276);
                vertex(210,283);
                vertex(211,296);
                vertex(235,273);
                vertex(234,233);
                vertex(232,228);
                vertex(237,227);
                endShape(CLOSE);

                //guns
                //white
                fill(200);
                beginShape();
                vertex(121,301);
                vertex(98,313);
                vertex(102,336);
                vertex(119,342);
                vertex(139,336);
                vertex(141,313);
                endShape(CLOSE);//l
                beginShape();
                vertex(159,312);
                vertex(162,336);
                vertex(180,342);
                vertex(200,336);
                vertex(202,313);
                vertex(180,302);
                endShape(CLOSE);

                //black
                fill(0);
                rect(105,315,30,30);
                rect(166,315,30,30);
                quad(105,344,109,355,131,355,135,344);
                quad(166,344,170,355,192,355,196,344);
                //green
                fill(0,122,61);
                rect(103,253,33,62);//l
                rect(164,252,33,62);//r
                //white
                fill(200);
                bezier(103,252,107,230,132,230,136,252);//l
                bezier(164,252,169,230,192,230,197,252);//r
                rect(103,280,33,25);//l
                rect(164,280,33,25);//r
                rect(104,319,33,26,3);//l
                rect(165,319,33,26,3);//r
                rect(115,310,7,28,8);//l
                rect(178,310,7,28,8);//r
                //green
                fill(0,122,61);
                rect(105,284,10,15);
                rect(124,284,10,15);
                rect(167,285,10,15);
                rect(185,284,10,15);

                //body-wings

                fill(0,122,61);//green
                bezier(107,154,101,162,98,169,98,187);
                bezier(191,153,199,164,202,172,203,187);
                quad(107,154,98,186,98,223,107,224);
                quad(191,153,203,186,202,223,192,223);
                fill(206,17,38);//red
                quad(134,112,108,147,107,239,132,230);
                quad(165,112,192,147,193,239,168,230);
                //black
                fill(0);
                quad(130,122,130,142,111,164,111,147);
                quad(169,122,188,147,188,165,169,144);
                //white
                fill(200);
                beginShape();
                vertex(131,154);
                vertex(129,202);
                vertex(118,202);
                vertex(112,181);
                vertex(110,179);
                vertex(110,171);
                endShape(CLOSE);
                beginShape();
                vertex(170,154);
                vertex(190,172);
                vertex(190,182);
                vertex(188,181);
                vertex(182,201);
                vertex(172,201);
                endShape(CLOSE);

                fill(0);
                quad(134,193,166,193,154,342,146,342);
                fill(0);
                quad(142,180,159,180,152,352,148,352);
                //white
                fill(200);
                ellipse(150,374,6,50);

                //head

                fill(206,17,38);
                ellipse(149.5,72,33,25);
                ellipse(149.5,94,30,170);
                fill(0);
                ellipse(149.5,94,20,160);
                fill(154,155,84);
                ellipse(149.5,94,17,77);
                strokeWeight(2);
                line(143,74,158,74);
                line(142,104,158,104);
                strokeWeight(1);
                fill(200);
                bezier(143,15,147,2,153,2,155.5,15);
                star(121,180);
                star(177,180);
                break;

            default:
                break;

            }
        popMatrix();
    }

    void star(float x, float y) {
        float angle = TWO_PI / 5;
        float halfAngle = angle/2.0;
        beginShape();
        noStroke();
        for (float a = 0; a < TWO_PI; a += angle) {
            float sx = x + cos(a) * 2;
            float sy = y + sin(a) * 2;
            vertex(sx, sy);
            sx = x + cos(a+halfAngle) * 5;
            sy = y + sin(a+halfAngle) * 5;
            vertex(sx, sy);
        }
        endShape();
    }

}
