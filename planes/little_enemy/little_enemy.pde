size(300,300);
smooth();
colorMode(RGB);

//wings
fill(188,188,188);//gray
beginShape();
vertex(150,107);
vertex(31,145);
vertex(31,174);
vertex(150,191);
vertex(269,174);
vertex(270,147);
endShape(CLOSE);

fill(112,69,134);
beginShape();
vertex(30,150);
vertex(149,120);
vertex(269,150);
vertex(269,168);
vertex(150,180);
vertex(30,168);
endShape(CLOSE);

fill(2,58,59);//red
ellipse(28,160,10,30);
ellipse(272,160,10,30);

//guns
fill(210);//light gray
beginShape();
vertex(111,95);
vertex(188,95);
vertex(192,186);
vertex(176,201);
vertex(121,201);
vertex(107,186);
endShape(CLOSE);
bezier(106,185,109,192,116,199,121,200);
bezier(177,200,183,200,191,192,192,186);

fill(54,93,169);
ellipse(126,91,30,40);
ellipse(174,91,30,40);

fill(2,58,59);
ellipse(126,91,20,20);
ellipse(174,91,20,20);

fill(54,93,169);
ellipse(134,226,10,12);
ellipse(165,227,10,12);

//body
fill(112,69,134);
quad(136,226,163,226,163,237,136,237);
bezier(163,237,157,241,142,241,136,237);

fill(87,234,85);
quad(125,110,173,110,173,215,125,215);
bezier(125,215,130,230,169,230,173,215);

fill(35,173,105);//body-gray
ellipse(150,113,47,181);

fill(50);//window
quad(139,67,161,67,166,106,134,107);
bezier(166,106,159,113,140,113,133,106);


line(149,119,150,160);
line(140,171,150,160);
line(159,171,150,160);
line(143,187,150,179);
line(156,187,150,179);

fill(0);
quad(146,240,146,261,153,261,153,240);
fill(188);
ellipse(150,266,70,10);
fill(0);
bezier(146,266,148,290,152,290,153,266);

