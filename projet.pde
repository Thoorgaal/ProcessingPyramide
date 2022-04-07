 ArrayList<PShape> ShapeTable;
 
int scale = 1;
 
void setup(){
  noLoop();
  ShapeTable = new ArrayList<PShape>();
  
  background(255,255,255);
  size(1080,720,P3D);
  ShapeTable.add(cube(6,100,0,0));
  
  
}

PShape cube(int r, int red, int green, int blue){
  PShape cube = createShape();
  beginShape();
  fill(red,green,blue);
   box(r);
  
  endShape();
  return cube;
}

polynome p = new polynome(new int[]{1,-2,3});

class polynome{
  private ArrayList<Integer> corps;
  public polynome(int[] c){
    this.corps = new ArrayList<Integer>();
    for(int i = 0;i<c.length;i++){
      this.corps.add(c[i]);
    }
  }
   public int calcul(int x ){
    
     int b = 0;
    for(int i = 0; i< this.corps.size(); i++){
      b+= this.corps.get(i)*pow(x,i+1);
    }
    return b;
  }
  public String toString(){
    String b ="";
    for(int i = 0; i<this.corps.size();i++){
      int a = this.corps.get(i);
      if(i==0){
        if(a!=1 && a != 0)b+= Integer.toString(a) + "X + ";
        else if(a==1) b+= "X + ";
      }
      if(i<this.corps.size() -1){
       if(a!=1 && a!=0) b+=  Integer.toString(a) + "X^" + Integer.toString(i) + " + "  ;
       else if(a == 1)  b+= "X^" + Integer.toString(i) + " + "  ;
      }
      else{
        if(a!=0 && a!=1)b+=  Integer.toString(this.corps.get(i)) + "X^" + Integer.toString(i);
        else if(a==1) b+="X^" + Integer.toString(i);
      }
  }
  return b;
  }
}

int sd(int a){
  int b =1;
  float s = sqrt(a);
  for(int i =2; i<=s;i++){  
    if(a%i == 0 && i != s){
      b+=i;
      b += a/i;
    }else if (a%i == 0){
      b+=i;
    }
  }
  return b+a;
}

int[] getColor(int i){
  i = p.calcul(i);
  int x = sd(i);
  if(x==1){
    return new int[]{0,0,0};
  }
  if(x == i+1){
    System.out.println(i);
    return new int[]{88,214,141};
  }else if(x== 2*i){
      return new int[]{  203, 67, 53 };
  }
  else if(x > 2*i){
   return new int[]{ 155, 89, 182 };
  }
  return new int[]{ 231, 76, 60 };
}


void drawICube(int i, int r,int count){
  pushMatrix();
  
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2]);
    count++;
    shape(c);
    if(j!=i-1){
      translate(r,0);
    }
  }
  translate(0,-r);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2]);
    count++;
    shape(c);
    if(j!=i-1){
      translate(0,-r);
    
    }
  }
  translate(-r,0);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2]);
    count++;
    shape(c);
    if(j!=i-1){
      translate(-r,0);
    
    }
  }
  translate(0,r);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2]);
    count++;
    shape(c);
    if(j!=i-1){
      translate(0,r);
    
    }
  }
  
  popMatrix();
}
void draw2DPyramide(int c, int r,int count){
  pushMatrix();
  if(c==0){
    int[]  couleur = getColor(count);
    PShape cube = cube(r,couleur[0],couleur[1],couleur[2]);
    count++;
    shape(cube);
  }
  for(int i = 0; i<c;i++){
    drawICube(i,r,count);
  }
  popMatrix();
}
void draw3DPyramide(int c, int r,int count){
  pushMatrix();
  count++;
  cube(r,0,0,0);
  translate(r/2,r/2,-r);
  for(int i = 2;i<c+2;i++){
    draw2DPyramide(i,r,count);
    translate(-r/2,r/2,-r);
  }
  
  popMatrix();
}


void draw(){
  background(255);
  pushMatrix();
  fill(0,0,0);
  textSize(20);
  text(p.toString(),20,40);
  popMatrix();
  
  translate(width/2,height/2);
  rotateX(PI/2);
  rotateZ(PI/4);
  //rotateY(PI/4);
  int count = 1;
  draw3DPyramide(10,20,count);
  
    System.out.println(sd(28));
  
  
  
 
}
