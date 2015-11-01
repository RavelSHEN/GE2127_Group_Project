import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class playerPlane extends PApplet {

int bombTimeCounter = 0; //count the time passed since the bomb boo!!!!
boolean bombShoted = false; //check if the bomb is shoted
int numberOfEnemy; //number of normal enemy
int numOfBoss; //number of boss. Normally is 0, while boss appear, become 1.
playerPlane player = new playerPlane(500,500,100,100,3,3,3);

public void setup(){
    size(displayWidth,displayHeight);
}

public void draw(){
    player.drawPlayer();
}

class playerPlane{
    //define the basic parameters of the players planes
    int playerX; //x position of plane
    int playerY; //y position of plane
    int bloodVol; //blood volume of the player's plane
    int basicAttack; //the basic harm caused by attacktion
    int numOfBomb; //the number of bomb owned by the player. Default value is 3.
    int numOfLife; //the player defaultly have 3 life.
    int maxWalkSpeed=3; //\u6700\u5927\u8d70\u901f
    float walkAccelx=0; //x\u8d70\u8def\u52a0\u901f\u5ea6
    float walkAccelxtmp=0; //x\u8d70\u8def\u52a0\u901f\u5ea6temp
    float walkSpeedx=0; //x\u521d\u8d70\u901f
    float walkAccely=0; //y\u8d70\u8def\u52a0\u901f\u5ea6
    float walkAccelytmp=0; //y\u8d70\u8def\u52a0\u901f\u5ea6temp
    float walkSpeedy=0; //y\u521d\u8d70\u901f

    //draw the player's plane

    playerPlane(int x, int y, int hp, int attack, int bomb, int life, int maxSpeed){
        playerX = x;
        playerY = y;
        bloodVol = hp;
        basicAttack = attack;
        numOfBomb = bomb;
        numOfLife = life;
        maxWalkSpeed = maxSpeed;
    }

    public void drawPlayer(){
        rectMode(CENTER);
        fill(255,255,255);
        rect(x,y, 5,5);
    }

    //clear the small enemy, cause 200 harm to the boss, decrease the num of bomb by 1, lead to the animimation
    public void useBomb(){
        numOfBomb --;
        if (bombTimeCounter == 10){
            if(numOfBoss != 0){
                boss.bloodVol -= 200;
            }
            numOfNormalEnemy = 0;
        }
        colorMode(RGB,255,255,255,100);
        fill(255,255,255,100-Math.abs(100 - i*10));
        rect(0,0,width,height);
        if(bombTimeCounter == 20){
            bombShoted = false;
            bombTimeCounter = 0;
        }else{
            bombTimeCounter ++;
        }
    }

    //The player is killed. Life num -1. check if still have life
    public void destroyed(){
        numOfLife --;
        //animation of destroy
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "playerPlane" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
