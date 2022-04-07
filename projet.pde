 import java.util.Scanner;
 
 
PGraphics pg = new PGraphics();;
PShape pyramide = new PShape();
int scale = 1;
String typeInt =((Object)scale).getClass().getSimpleName();
int degree = 0;
boolean enter  = false;
String nombre = "";
boolean positif = true;
int sizeP = 6;
int sizeC = 20;
boolean mode = true; 
PFont police;
void setup(){
  //noLoop();
  
  
  background(255,255,255);
  size(1080,720,P3D);
  police = loadFont("ArialMT-48.vlw");
  
  
}
public enum ModeNombre{
PREMIER,PARFAIT,ABONDANT,DEGENERE,UN;
  public int[] getC(){
    switch(this){
      case PREMIER:
        return new int[]{255,0,0};
      case PARFAIT:
        return new int[]{  0,255,0};
       case ABONDANT:
         return new int[]{ 0,0,255};
         
      case DEGENERE:
       return new int[]{ 227,34,163};
      case UN:
         return new int[]{0,0,0};
      default:
        return new int[]{0,0,0};
        
    }
  }
}


PShape cube(int r, int red, int green, int blue,int i){
  PShape cube = createShape();
  beginShape();
  fill(red,green,blue);
   box(r);
   pushMatrix();
   translate(25*r,r);
    pg = createGraphics(r,r);
  pg.beginDraw();
 
  pg.background(0,0,0,-200);
  pg.textSize(60);
  pg.textFont(police);
  pg.fill(0,0,0);
  pg.text("BITE",10,0);
  pg.endDraw();
  popMatrix();
  endShape();
  
  return cube;
}

polynome p = new polynome(new int[]{0,1,0});

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
      int bound = i-this.corps.size()+1;
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
      b+= this.corps.get(i)*pow(x,i);
    }
    return b;
  }
  private  String getMonome(int i, int a){
    if(i==0){
      if(a==0){
        return "";
      }else {
        return Integer.toString(a);
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
  ModeNombre m;
  i = p.calcul(i);
  int x = sd(i);
  if(x==1){
    m = ModeNombre.UN;
  }
  if(x == i+1){
    m = ModeNombre.PREMIER;
  }else if(x== 2*i){
      m = ModeNombre.PARFAIT;
  }
  else if(x < 2*i){
   m = ModeNombre.DEGENERE;
  }else{
    m = ModeNombre.ABONDANT;
  }
  return m.getC();
}


void drawICube(int i, int r,int count){
  pushMatrix();
  
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2],count);
    count++;
    shape(c);
    if(j!=i-1){
      translate(r,0);
    }
  }
  translate(0,-r);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2],count);
    count++;
    shape(c);
    if(j!=i-1){
      translate(0,-r);
    
    }
  }
  translate(-r,0);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2],count);
    count++;
    shape(c);
    if(j!=i-1){
      translate(-r,0);
    
    }
  }
  translate(0,r);
  for(int j = 0; j<i;j++){
    int[]  couleur = getColor(count);
    PShape c = cube(r,couleur[0],couleur[1],couleur[2],count);
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
    PShape cube = cube(r,couleur[0],couleur[1],couleur[2],count);
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
  cube(r,90,46,46,1);
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
  text("degrée sélectionnée (changer avec droite et gauche) : " + Integer.toString(degree),20,80);
  text("entrée : " + String.valueOf(enter),20,110);
  if(positif){
    text("signe (cliquer sur + ou -) : +",20,130);
  }else{
    text("signe (cliquer sur + ou -) : -",20,130);
  }
  if(mode){
    text("mode : taillePyramide (cliquer sur m) ",20,150);
  }else{
    text("mode : tailleCube (cliquer sur m)",20,150);
  }
  popMatrix();
  
  translate(width/2,height/2);
  rotateX(frameCount/60.0);
  //rotateX(PI/2);
  //rotateZ(PI/4);
 
  rotateZ(frameCount/60.0);
  int count = 1;
   image(pg,0,0);
  
  draw3DPyramide(sizeP,sizeC,count);

  
  //cube(40,255,255,255,5);
  
 
  
    
  
  
  
 
}

void keyPressed() {

 
  //controle pyramide et sa taille  
  if(key!=CODED){
    if(keyCode == 59){
      if(mode){
        mode = false;
      }else{
        mode = true;
      }
    }
    if(keyCode == 139){
      positif = true;
    }
    if(keyCode == 140){
        positif = false;
      }
    if(!enter){
      for(int i = 0;i<10;i++){
        if(keyCode == 128 +i){
          if(positif)p.setMonome(degree,i);
          else p.setMonome(degree,0-i);
        }
      }
      if(keyCode == 10){
          enter = true;
      }
    }else{
      for(int i = 0;i<10;i++){
        if(keyCode == 128 +i){
          nombre += Integer.toString(i);
        }
      }
      if(keyCode == 10){
        enter = false;
        if(positif&&nombre!="")p.setMonome(degree,Integer.parseInt(nombre));
        else if(!positif && nombre!="") p.setMonome(degree,0-Integer.parseInt(nombre));
        nombre ="";
      }
      
    }
  
    
    
  }
  
  else{
    
    if(keyCode == LEFT){
      if(degree>0)degree--;
    }if(keyCode == RIGHT){
      degree++;
    }
    if(keyCode == UP){
      if(mode)sizeP++;
      else sizeC++;
    }
    if(keyCode==DOWN){
      if(mode && sizeP>0)sizeP--;
      else if(!mode && sizeC>0)sizeC--;
    }
    
  }
  
  
}
