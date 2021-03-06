void setup(){
  size(300,400);
  smooth();
  colorMode(RGB);
}

void draw(){
  player1( );
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
  
}

  void player1(){
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
  endShape(CLOSE);
}
