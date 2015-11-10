void setup(){
  size(300,400);
  background(255);
}

void draw(){
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
  
  fill(30);                             //left 1 wing
  beginShape();
  vertex(93,148);//
  vertex(15,274);
  vertex(12,289);////
  vertex(26,273);
  vertex(89,186);//
  endShape();
  
  beginShape();                         //right 1 wing
  vertex(207,148);//
  vertex(290,274);
  vertex(288,289);
  vertex(274,273);
  vertex(211,186);//
  endShape();
  
  fill(220);
  beginShape();                         //left 2 wing
  vertex(12,289);////
  vertex(26,273);
  vertex(89,186);
  vertex(98,217);
  vertex(109,224);//
  vertex(24,299);
  vertex(12,289);
  endShape();
  
  beginShape();                         //right 2 wing
  vertex(288,289);////
  vertex(274,273);
  vertex(211,186);
  vertex(202,217);
  vertex(191,224);//
  vertex(276,299);
  vertex(288,289);
  endShape();
  
  fill(30);  
  beginShape();                            //left 1 tail
  vertex(118,226);
  vertex(111,233);
  vertex(106,262);
  vertex(143,244);
  vertex(141,230);
  endShape();
  
  beginShape();                            //right 1 tail
  vertex(182,226);
  vertex(189,233);
  vertex(194,262);
  vertex(157,244);
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
  vertex(141,230);
  vertex(140,216);
  vertex(147,194);
  vertex(153,194);
  vertex(160,216);
  vertex(159,230);
  vertex(157,244);
  vertex(150,257);
  vertex(143,244);
  vertex(141,230);
  endShape();
  
  fill(130);
  beginShape();
  vertex(150,229);
  vertex(157,244);
  vertex(150,257);
  vertex(143,244);
  vertex(150,229);
  endShape();
  line(150,194,150,229);
  
  beginShape();
  vertex(121,252);
  vertex(137,273);
  vertex(163,273);
  vertex(179,252);
  vertex(157,244);
  vertex(150,257);
  vertex(143,244);
  vertex(121,252);
  endShape();
  
  fill(227,88,18);
  ellipse(142,273,10,6);
  ellipse(158,273,10,6);
  line(137,247,137,258);
  line(137,258,146,267);
  line(146,267,154,267);
  line(163,247,163,258);
  line(163,258,154,267);
  
  beginShape();
  vertex(117,258);
  vertex(114,280);
  vertex(114,298);
  vertex(116,301);
  vertex(122,298);
  vertex(124,282);
  vertex(135,272);
  vertex(122,255);
  vertex(116,258);
  endShape();
  
  beginShape();
  vertex(183,258);
  vertex(186,280);
  vertex(186,298);
  vertex(184,301);
  vertex(178,298);
  vertex(176,282);
  vertex(165,272);
  vertex(178,255);
  vertex(184,258);
  endShape();
}
