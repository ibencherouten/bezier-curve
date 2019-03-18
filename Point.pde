public class Point{
  public float x, y;
  
  public Point(){ x = 0; y = 0; }
  
  public Point(float x, float y){
    this.x = x; this.y = y;
  }
  
  public Point(Point p){
    x = p.x; y = p.y;
  }
  
  float getDistance(Point b){
    return (float)Math.sqrt((x-b.x)*(x-b.x) + (y-b.y)*(y-b.y));
  }
  
  public boolean equals(Point p){
    if(p.x != x) return false;
    if(p.y != y) return false;
    return true;
  }
  
  public void setPoint(float x, float y){
    this.x = x; this.y = y;
  }
  
  public String toString(){
    return "("+x+", "+y+")";
  }
}