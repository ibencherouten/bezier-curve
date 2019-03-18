import java.util.Arrays;

public class Bezier{
  public Vector<Point> points;
  protected Vector<Point> bline;
  protected int resolution;
  
  
  
  public Bezier(){
    points = new Vector<Point>();
    bline = new Vector<Point>();
    resolution = 100;
    
    
  }
  
  public Bezier(Point[] points){
    this.points = new Vector<Point>();
    this.points.addAll(Arrays.asList(points));
    bline = new Vector<Point>();
    resolution = 100;
    
    update();
  }
  
  public void setResolution(int r){ 
    resolution = r;
    update();
  }
  
  public int getResolution(){ 
    return resolution;
  }
  
  public void addPoint(Point p){
    points.add(p);
    update();
  }
  
  protected Point getMiddlePoint(Point a, Point b, float percent){
    Point middle = new Point();
    middle.x = a.x * (1-percent) + b.x * percent;
    middle.y = a.y * (1-percent) + b.y * percent;
    return middle;
  }
  
  protected Point getBlinePoint(float percent){
    Vector<Point> ps = new Vector<Point>();
    for (Point e : points) ps.add(new Point(e));
    
    while(ps.size()>1){
      for(int i=0; i<ps.size()-1; i++){
        ps.set(i, getMiddlePoint(ps.get(i), ps.get(i+1), percent));
      }
      
      ps.remove(ps.lastElement());
    }
    
    if(ps.size() == 0) return null;
    Point blp = ps.firstElement();
    return blp;
  }
  
  protected void update(){
    bline.clear();
    
    for(int i = 0; i<=resolution; i++){
      Point newBlinePoint = getBlinePoint((float)i/resolution);
      if(newBlinePoint != null) bline.add(newBlinePoint);
    }
  }
  
  
}