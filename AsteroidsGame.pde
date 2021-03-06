boolean wIsPressed = false;
boolean aIsPressed = false;
boolean dIsPressed = false;
boolean spaceIsPressed = false;
Star [] s= new Star[150];
SpaceShip a = new SpaceShip();
ArrayList <Asteroids> b = new ArrayList <Asteroids>();
ArrayList <Bullets> c = new ArrayList <Bullets>();
boolean cDestroyed = false;
public void setup() 
{
  background(0);
  size(600,600);
  for(int i=0;i<=10;i++)
  {
    b.add(i,new Asteroids());
  }
  for(int i=0; i<s.length; i++)
  {
    s[i]=new Star();
  }
}
public void draw() 
{
  background(0);
  for(int i=0; i<s.length; i++)
  {
    s[i].show();
  }
  a.show();
  a.move();
  if(wIsPressed == true)
  {
    a.accelerate(0.1);
  }
  if(aIsPressed == true)
  {
    a.rotate(-5);
  }
  if(dIsPressed == true)
  {
    a.rotate(5);
  }
  if(keyPressed==true && key== 'f')
  {
    a.setX((int)(Math.random()*600));
    a.setY((int)(Math.random()*600));
    a.setDirectionX(0);
    a.setDirectionY(0);
    a.setPointDirection((int)(Math.random()*360));
  }
  for(int i = 0; i < c.size(); i++) 
  {
    if(c.get(i).getX() < 5 || c.get(i).getX() > 555)
    {
      c.remove(i);
    }
    else if(c.get(i).getY() < 5 || c.get(i).getY() > 555)
    {
      c.remove(i);
    }
    else
    {
      c.get(i).shoot();
      c.get(i).show();
      c.get(i).move();
    }
  }
  for(int i=0; i<b.size();i++)
  {
    b.get(i).move();
    b.get(i).show();
    for(int j=0; j<c.size();j++)
    {
      if(dist(c.get(j).getX(), c.get(j).getY(), b.get(i).getX(), b.get(i).getY())<25)
      {
        b.remove(i);
        cDestroyed = true;
      }
    }
    if(cDestroyed == true)
    {
      c.remove(i);
      cDestroyed = false;
    }
  }
}
class SpaceShip extends Floater  
{ 
  public void setX(int x) {myCenterX=x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY=y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX=x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return myPointDirection;}
  public SpaceShip()
  {
    corners=4;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -8;
    yCorners[0] = -8;
    xCorners[1] = 16;
    yCorners[1] = 0;
    xCorners[2] = -8;
    yCorners[2] = 8;
    xCorners[3] = -2;
    yCorners[3] = 0;
    myColor=255;
    myCenterX=300;
    myCenterY=300;
    myDirectionX=0;
    myDirectionY=0;
    myPointDirection=270;
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()
  {             
    fill(myColor);   
    stroke(myColor);           
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
public void keyPressed()
{
  if (key== ' ')
  {
    c.add(new Bullets(a));
  }
  if(key== 'w')
  {
    wIsPressed=true;
  }
  else if(key== 'd')
  {
    dIsPressed=true;
  }
  else if(key== 'a')
  {
    aIsPressed=true;
  }
}
public void keyReleased()
{
  if( key== 'w')
  {
    wIsPressed=false;
  }
  else if(key== 'd')
  {
    dIsPressed=false;
  }
  else if(key== 'a')
  {
    aIsPressed=false;
  }
}
class Star
{
  int x,y;
  Star()
  {
    x=(int)(Math.random()*601);
    y=(int)(Math.random()*601);
  }
  void show()
  {
    fill(255);
    ellipse(x,y,2,2);
  }
}
class Asteroids extends Floater
{
  public void setX(int x) {myCenterX=x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY=y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX=x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY=y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection=degrees;}
  public double getPointDirection() {return myPointDirection;}
  private int rotationSpeed;
  public Asteroids()
  {
    myDirectionX=Math.random()*5-2;
    myDirectionY=Math.random()*5-2;
    corners=6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = (int)(myCenterX)+28;
    yCorners[0] = (int)(myCenterY);
    xCorners[1] = (int)(myCenterX)+(int)(28*Math.cos(Math.PI/3));
    yCorners[1] = (int)(myCenterY)+(int)(28*Math.sin(Math.PI/3));
    xCorners[2] = (int)(myCenterX)-(int)(28*Math.cos(Math.PI/3));
    yCorners[2] = (int)(myCenterY)+(int)(28*Math.sin(Math.PI/3));
    xCorners[3] = (int)(myCenterX)-28;
    yCorners[3] = (int)(myCenterY);
    xCorners[4] = (int)(myCenterX)-(int)(28*Math.cos(Math.PI/3));
    yCorners[4] = (int)(myCenterY)-(int)(28*Math.sin(Math.PI/3));
    xCorners[5] = (int)(myCenterX)+(int)(28*Math.cos(Math.PI/3));
    yCorners[5] = (int)(myCenterY)-(int)(28*Math.sin(Math.PI/3));
    myColor=255;
    myCenterX=(int)(Math.random()*601);
    myCenterY=(int)(Math.random()*601);
    myPointDirection=270;
    rotationSpeed = (int)((Math.random()*5)-2);
  }
  public void move ()
  { 
    myPointDirection+=rotationSpeed;     
    super.move();
  }
  public void show()
  {
    super.show();
  }
}
class Bullets extends Floater
{
  Bullets(SpaceShip theShip)
  {
    myCenterX=a.getX();
    myCenterY=a.getY();
    myPointDirection=a.getPointDirection();
    myDirectionX=a.getDirectionX();
    myDirectionY=a.getDirectionY();
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)(myCenterX);}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)(myCenterY);}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void show()
  {
    fill(0,0,255);
    ellipse((int)myCenterX,(int)myCenterY,10,10);
  }
  public void shoot()
  {
    myDirectionX = 5*Math.cos(myPointDirection*Math.PI/180) + a.getDirectionX();
    myDirectionY = 5*Math.sin(myPointDirection*Math.PI/180) + a.getDirectionY();
  }
}
