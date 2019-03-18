public class BezierGUI extends Bezier{
  private Point selectedPoint;
  private boolean locked;
  private float radius;
  
  private Vector<Vector<Point>> construction;
  private float constructRatio;
  
  public BezierGUI(){
    super();
    radius = 5;
    selectedPoint = null;
    locked = false;
    
    construction = new Vector<Vector<Point>>();
    constructRatio =1.0;
  }
  
  public BezierGUI(Point[] points){
    super(points);
    radius = 5;
    selectedPoint = null;
    locked = false;
    
    construction = new Vector<Vector<Point>>();
    constructRatio = 0.0;
  }
  
  public void setConstructRatio(float ratio){
    buildConstruction(ratio);
    constructRatio = ratio;
  }
  
  public float getConstructRatio(){ return constructRatio; }
  
  private Point getHoveredPoint(){
    for(int i=0; i<points.size(); i++)
      if(points.get(i).getDistance(new Point(mouseX, mouseY)) <= radius)
        return points.get(i);
    return null;
  }
  
  private void buildConstruction(float percent){
    if(percent == constructRatio) return;
    construction = new Vector<Vector<Point>>();
    
    Vector<Point> ps = new Vector<Point>();
    for (Point e : points) ps.add(new Point(e));
    
    Vector<Point> currentVector = new Vector<Point>();
    construction.add(currentVector);
    
    for(int i=0; i<ps.size()-1; i++){
      currentVector.add(getMiddlePoint(ps.get(i), ps.get(i+1), percent));
    }
    
    Vector<Point> previousVector;
    
    while(currentVector.size()>1){
      previousVector = currentVector;
      currentVector = new Vector<Point>();
      construction.add(currentVector);
      
      for(int i=0; i<previousVector.size()-1; i++){
        currentVector.add(getMiddlePoint(previousVector.get(i), previousVector.get(i+1), percent));
      }
    }
    
  }
  
  public void draw(){
    strokeWeight(3);
    stroke(255, 0, 0);
    for(int i=0; i<bline.size()-1; i++){
       drawLine(bline.get(i), bline.get(i+1));
    }
    stroke(0);
    strokeWeight(1);
    //draw construction
    //stroke(0, 0, 255);
    stroke(0, 0, 255, 200);
    for(int i=0; i<construction.size()-1; i++){
      Vector<Point> iter = construction.get(i);
      for(int j=0; j<iter.size()-1; j++){
        drawLine(iter.get(j), iter.get(j+1));
      }
    }
    stroke(255, 0, 0);
    fill(255, 0, 0);
    if(construction.size()>0)
    //System.out.println(construction.size());
    if(construction.lastElement() != null && construction.lastElement().size()>0){
      drawDesc(construction.lastElement().firstElement());
    }
    fill(0);
    stroke(0);
    
    for(int i=0; i<points.size(); i++) drawDesc(points.get(i));
    for(int i=0; i<points.size()-1; i++) drawLine(points.get(i), points.get(i+1));
    
  }
  
  void drawDesc(Point a){
    ellipse(a.x, a.y, radius*2, radius*2);
  }
  
  public void mouseClicked(){
    addPoint(new Point(mouseX, mouseY));
    buildConstruction(constructRatio+0.001);
  }
  
  
  public void mousePressed(){
    Point hoveredPoint = getHoveredPoint();
    if(hoveredPoint != null){
      selectedPoint = hoveredPoint;
      locked = true;
    }else{
      locked = false;
    }
  }
  
  public void mouseDragged() {
    if(locked){
      if(selectedPoint != null) selectedPoint.setPoint(mouseX, mouseY);
      update();
      buildConstruction(constructRatio+0.001);
      constructRatio = (float)mouseX/width;
    }
  }
  
  void mouseReleased() {
    selectedPoint = null;
    locked = false;
  }
}