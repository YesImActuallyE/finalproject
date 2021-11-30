Particle [] explosion = new Particle [100];

PImage cannonImg;
PImage baseImg;
int explosionParticles = 100;
int numStar = 1000;
int maxBullets = 20;
boolean keyRight = false;
boolean keyLeft = false;
float death;
float gunbaseX;
float gunbaseY;
float guntipX;  
float guntipY;
float gunAng;
float gunLength;
float angNum = 0.05;
float bSpeed = 10;
float baseOffset;
float originX;
float originY;
boolean[] explosionTrigger = new boolean[explosionParticles];
boolean[] bulletAlive = new boolean[maxBullets];
float[] Pexplosion = new float[explosionParticles];
float[] bX = new float[maxBullets];
float[] bY = new float[maxBullets];
float[] bDX = new float[maxBullets];
float[] bDY = new float[maxBullets];
float[] starX = new float[numStar];
float[] starY = new float[numStar];
float[] speed = new float[numStar];
float[] pX = new float[explosionParticles];
float[] pY = new float[explosionParticles];
float[] pANG = new float[explosionParticles];
//float[] originX = new float[explosionParticles];
//float[] originY = new float[explosionParticles];

void setup(){
  size(800,800,P3D);
  cannonImg = loadImage("rtype.png");
  baseImg = loadImage("base.png");
  gunLength = cannonImg.height;
  gunbaseX = 400;
  gunbaseY = 778;
  guntipX = 400;
  guntipY = 600;
  baseOffset = 10;
  originX = 400;
  originY = 400;
  for(int i = 0; i<maxBullets; i++){
    bulletAlive[i] = false;
  } 
  for(int i = 0; i<numStar;i++){
    starX[i] = random(0, width);
    starY[i] = random(0, height);
    speed[i] = random(1, 5);
  }
   smooth ();
 
 for (int i=0; i<explosion.length; i++) {
   explosion [i] = new Particle ();
 }
}

void keyPressed(){
  if(keyCode==RIGHT) keyRight = true;
  if(keyCode==LEFT) keyLeft = true;
  if(keyCode==CONTROL){
    spawnBullet(guntipX,guntipY,gunAng);
    for (int i=0; i<maxBullets; i++){
      if(bX[i]==originX&&bY[i]==originY);    
        for (int exp=0; i<explosion.length; i++)
          explosion[exp].particleUpdate();
    //if(bX=originX&&bY=originY);
    }
   }
  }


  
void keyReleased(){
  if(keyCode==RIGHT) keyRight = false;
  if(keyCode==LEFT) keyLeft = false;
}

void draw(){ 
  guntipX=gunbaseX+sin(gunAng)*gunLength;
  guntipY=gunbaseY-cos(gunAng)*gunLength;
  moveGun();
  updateBullets();
  background(0);
  drawBullets();
  drawBaseRotatedSprite(gunbaseX,gunbaseY,gunAng,cannonImg);
  image(baseImg,gunbaseX-baseImg.width/2,gunbaseY-baseImg.height/2+baseOffset);
  starField(starX,starY,speed);
  fill(255,0,0);
  rect(originX,originY,50,50);
  
  //explosion(explosionParticles,pX,pY,pANG,explosionTrigger,originX,originY);
  

  //line(gunbaseX,gunbaseY,guntipX,guntipY);
}

void moveGun(){
  if(keyRight && gunAng<HALF_PI){
    gunAng+=angNum;
  }
  if(keyLeft && gunAng>-HALF_PI){
    gunAng-=angNum;
  }
}

void spawnBullet(float x,float y, float ang){
  for(int i = 0; i<maxBullets; i++){
    if(bulletAlive[i]==false){
      bDX[i]=sin(ang)*bSpeed;
      bDY[i]=cos(ang)*bSpeed;
      bX[i] = x;
      bY[i] = y;
      bulletAlive[i] = true;
      break;
    }
  }
}

void drawBullets(){
  for(int i = 0; i<maxBullets; i++){
    if(bulletAlive[i]==true){
      fill(0);
      ellipse(bX[i],bY[i],20,20);
    }
  }
}
void updateBullets(){
  for(int i = 0; i<maxBullets; i++){
    if(bulletAlive[i]==true){
      bX[i] += bDX[i];
      bY[i] -= bDY[i];
      //bounds check
      if(bY[i]>800 || bY[i]<0 || bX[i]>800 || bX[i]<0) bulletAlive[i]=false;
    }
  }
}

void drawBaseRotatedSprite(float x, float y, float angle, PImage img){
  noStroke();
  beginShape();
  texture(img);
  float imgW = img.width;
  float imgH = img.height;
  float imgW2 = imgW / 2;
  float imgH2 = imgH / 2;
  float sinImgW2 = sin(angle)*imgW2;
  float cosImgW2 = cos(angle)*imgW2;
  float sinImgH = sin(angle)*imgH;
  float cosImgH = cos(angle)*imgH;
  
  
  vertex(x-cosImgW2+sinImgH, y-cosImgH-sinImgW2, 0, 0);
  vertex(x+cosImgW2+sinImgH, y-cosImgH+sinImgW2, imgW, 0);
  vertex(x+cosImgW2-sinImgW2, y+cosImgW2+sinImgW2, imgW, imgH);
  vertex(x-cosImgW2-sinImgW2, y+cosImgW2-sinImgW2, 0, imgH);
  endShape();  
}

void starField(float x[], float y[], float speed[]){
  stroke(255);
  strokeWeight(5);
    for(int i = 0; i<100; i++){
    point(x[i], y[i]);
  
    x[i] = x[i] - speed[i];
    if(x[i] < 0) {
      x[i] = width;
    }
  }
}

class Particle {
 
  float x;
  float y;
  
  float velX;
  float velY;

  
  Particle () {
    x = originX;
    y = originY;
    
    velX = random (-10,10);
    velY = random (-10,10);
    
   
  }
  
void particleUpdate () {
    
    x+=velX;
    y+=velY;
    
    fill (255);
    ellipse (x,y,10,10);
  }
}
