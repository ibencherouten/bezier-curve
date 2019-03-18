import java.util.Vector;

BezierGUI bezier;

void setup(){
  
  size(800, 600);
  fill(0);
  //textSize(32);

  bezier = new BezierGUI();
  
  surface.setResizable(true);
}

void draw(){
  background(255);
  text("resolution: "+bezier.getResolution(), 10, 10);
  text("construction at: " +bezier.getConstructRatio()*100 +"%", 10, 25);
  bezier.draw();
  //System.out.println(bezier.points.size());
}

void drawLine(Point a, Point b){
  line(a.x, a.y, b.x, b.y);
}


void mouseClicked(){
  bezier.mouseClicked();
  
}

void mousePressed(){
   bezier.mousePressed(); 
   
}

void mouseDragged(){
  bezier.mouseDragged();
  
}

void mouseReleased(){
  bezier.mouseReleased();
  
}

void mouseMoved(){
  bezier.setResolution(int((float)mouseY/height*100));
  bezier.setConstructRatio((float)mouseX/width);
  
}