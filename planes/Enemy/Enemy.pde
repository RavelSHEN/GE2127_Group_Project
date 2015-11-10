size(400,230);
smooth();
colorMode(RGB);

//back guns
fill(100);
rect(140,135,97,54);
rect(151,56,9,17);
rect(220,56,9,17);
rect(152,69,11,17);
rect(218,69,11,17);

//body--back
fill(150);
triangle(116,83,144,18,144,83);
triangle(261,82,235,16,235,82);

fill(160,184,4);//green
quad(101,89,152,70,152,176,101,192);
quad(278,89,228,70,228,176,278,192);//cutong

fill(166,203,47);//light green
rect(106,83,21,53);
rect(251,83,21,53);
fill(150);//gray
rect(106,112,35,30);
rect(238,112,35,30);

fill(160,184,4);//green
rect(141,23,15,107);
rect(224,22,15,107);
quad(144,13,152,17,135,50,127,46);
quad(226,16,234,12,250,46,243,50);
fill(100);
triangle(135,50,127,46,138,25);
triangle(243,50,250,46,240,24);//zhuazi

//wings-- up guns
fill(100);
rect(89,120,10,5);
rect(108,120,10,5);//l
rect(264,120,10,5);
rect(283,120,10,5);//r
bezier(86,122,89,105,98,105,101,122);
bezier(105,122,107,105,117,105,120,122);//l
bezier(262,122,265,105,273,105,277,122);
bezier(281,122,284,105,292,105,296,122);//r

//down-guns
rect(38,167,15,15);
rect(41,182,10,10);
rect(59,171,15,15);
rect(62,186,10,10);
rect(330,168,15,15);
rect(333,183,10,10);
rect(306,170,15,15);
rect(308,185,10,10);
fill(130);
rect(86,163,32,34);
rect(94,197,18,20);
rect(260,161,32,34);
rect(268,195,18,20);
fill(185,0,0);//red
rect(41,190,10,5,3);
rect(41,190,10,5,3);
rect(62,197,10,5,3);
rect(308,194,10,5,3);
rect(333,193,10,5,3);
rect(94,217,18,5,3);
rect(268,215,18,5,3);

//wings
fill(166,203,47);
beginShape();
vertex(8,124);
vertex(145,124);
vertex(145,170);
vertex(106,163);
vertex(97,164);
vertex(81,177);
vertex(16,164);
endShape(CLOSE);//l
beginShape();
vertex(370,124);
vertex(234,124);
vertex(234,170);
vertex(271,163);
vertex(285,164);
vertex(297,177);
vertex(366,164);
endShape(CLOSE);//r
fill(180);
rect(25,124,37,38);
rect(317,124,37,38);
fill(200);
ellipse(44,144,30,30);
ellipse(335,145,30,30);
fill(185,0,0);//red
ellipse(44,144,15,15);
ellipse(335,145,15,15);
fill(150);
ellipse(44,134,15,15);
ellipse(335,134,15,15);
fill(120,139,58);
ellipse(93,145,14,35);
ellipse(286,145,14,35);

//body
fill(176,180,33);
quad(157,84,179,75,179,143,157,143);
quad(224,84,200,75,200,143,224,143);
fill(178,214,64);
beginShape();
vertex(176,42);
vertex(180,42);
vertex(184,78);
vertex(181,80);
vertex(176,80);
vertex(173,78);
endShape(CLOSE);//l
beginShape();
vertex(199,42);
vertex(202,42);
vertex(206,78);
vertex(203,80);
vertex(199,80);
vertex(195,78);
endShape(CLOSE);

fill(178,214,64);//light green
rect(146,114,12,53,8);
rect(223,114,12,53,8);

beginShape();
vertex(185,70);
vertex(185,77);
vertex(181,81);
vertex(181,108);
vertex(198,108);
vertex(198,82);
vertex(194,77);
vertex(194,70);
endShape(CLOSE);//bottle
fill(0);//black
rect(177,164,27,30);
fill(120);
rect(181,108,17,30);
rect(186,109,8,52);

fill(178,214,64);
rect(184,160,12,38,8);
fill(160,184,4);//green
rect(145,186,41,23,10);
rect(193,186,41,23,10);

//mark
fill(0);
triangle(156,93,178,93,168,110);
fill(210);
ellipse(168,97,16,16);
fill(168,0,0);
beginShape();
vertex(166,94);
vertex(170,94);
vertex(169,96);
vertex(172,97);
vertex(167,104);
vertex(167,98);
vertex(164,99);
endShape(CLOSE);

fill(247,247,0);
triangle(262,86,254,99,271,99);
line(260,98,260,95);
line(260,95,265,95);
fill(168,0,0);
ellipse(263,92,3,3);

