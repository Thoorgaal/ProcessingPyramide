 import java.util.Scanner;
 
 
 ArrayList<PShape> ShapeTable;
  
int scale = 1;
String typeInt =((Object)scale).getClass().getSimpleName();
int degree = 0;

 
void setup(){
  //noLoop();
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

polynome p = new polynome(new int[]{1,0,3});

class polynome{
  private ArrayList<Integer> corps;
  public polynome(int[] c){
    this.corps = new ArrayList<Integer>();
    for(int i = 0;i<c.length;i++){
      this.corps.add(c[i]);
    }
  }
  public void setMonome(int i,int x){
    if(i<this.corps.size()){
      this.corps.set(i,x);
    }else{
      int bound = i-this.corps.size();
      for(int j = 0; j<bound;j++){
        if(j==bound-1){
          this.corps.add(x);
        }else{
          this.corps.add(0);
       }
      }
    }
  }
   public int calcul(int x ){
    
     int b = 0;
    for(int i = 0; i< this.corps.size(); i++){
      b+= this.corps.get(i)*pow(x,i+1);
    }
    return b;
  }
  private  String getMonome(int i, int a){
    if(i==0){
      if(a==0){
        return "";
      }else {
        return Integer.toString(abs(a));
      }
    }else{
      if(a == 0){
        return "";
      }else if(a==1){
        return "X^" + Integer.toString(i);
      }else{
        return Integer.toString(abs(a)) + "X^" + Integer.toString(i);
      }
    }
  }
  private String getOp(int a){
    if(a<0){
      return "-";
    }else if(a>0){
      return "+";
    }else{
      return "";
    }
  }
  public String toString(){
    String b ="";
    int a = this.corps.get(0);
    for(int i =0; i<this.corps.size();i++){
      
      b+=this.getMonome(i,a);
      if(i<this.corps.size()-1){
        a = this.corps.get(i+1);
        b+= this.getOp(a);
      }
    }
  return b;
  }
  public int degre(){
    return this.corps.size() -1;
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
  text("degrée sélectionné : " + Integer.toString(degree),20,80);
  popMatrix();
  
  translate(width/2,height/2);
  //rotateX(frameCount/6.0);
  rotateX(PI/2);
  rotateZ(PI/4);
  //rotateY(PI/4);
  int count = 1;
  draw3DPyramide(10,20,count);
  

    
  
  
  
 
}

void keyPressed() {
  if(key!=CODED){
    System.out.println(typeInt);
    
    if(((Object) keyCode).getClass().getSimpleName() == typeInt){
        print(keyCode);
        p.setMonome(degree,keyCode);
      }
  }
  else{
    
    if(keyCode == LEFT){
      if(degree>0)degree--;
    }if(keyCode == RIGHT){
      degree++;
    }
    
  }
  
}
