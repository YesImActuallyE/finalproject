int explosionParticles = 100;
int numStar = 1000;
int maxBullets = 20;
//Declaring variables(Traver)
int planeXSpeed[];
float xCoor[];
float yCoor[];
int bomb[];
int bombYspeed[];
int level[];
int score[];
//Declaring variables(Teague)
PImage cannonImg;
PImage baseImg;
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
float velX;
float velY;
float y;
float x;   
//float originX;
//float originY;
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
  //setting up turret(Teague)
  size(800,800,P3D);
  cannonImg = loadImage("rtype.png");
  baseImg = loadImage("base.png");
  gunLength = cannonImg.height;
  gunbaseX = 400;
  gunbaseY = 778;
  guntipX = 400;
  guntipY = 600;
  baseOffset = 10;
  for(int i = 0; i<maxBullets; i++){
    bulletAlive[i] = false;
  } 
  for(int i = 0; i<numStar;i++){
    starX[i] = random(0, width);
    starY[i] = random(0, height);
    speed[i] = random(1, 5);
  }
   smooth ();

    //Initializing variables to make planes and make the planes move (Traver)
   xCoor=new float[5];
   yCoor=new float[5];
   planeXSpeed=new int[5];
   bomb=new int[5];
  bombYspeed=new int[5];
  for(int i=0;i<planeXSpeed.length;i++){
    //Filling the variables of the plane randomly(Traver)
    planeXSpeed[i]=int(random(5,15));
    xCoor[i]=int(random(1,369));
    yCoor[i]=int(random(1,369));
    bomb[i]=int(random(100,369));
   bombYspeed[i]=int(random(1,5));  
   } 
  }
void keyPressed(){
  if(keyCode==RIGHT) keyRight = true;
  if(keyCode==LEFT) keyLeft = true;
  if(keyCode==CONTROL){
    spawnBullet(guntipX,guntipY,gunAng);
   // if(bX=originX&&bY=originY);
    }
   }
 


  
void keyReleased(){
  if(keyCode==RIGHT) keyRight = false;
  if(keyCode==LEFT) keyLeft = false;
}

void draw(){ 
  //planes and bullets and explosion(teague)
  guntipX=gunbaseX+sin(gunAng)*gunLength;
  guntipY=gunbaseY-cos(gunAng)*gunLength;
  moveGun();
  updateBullets();
  background(0);
  drawBullets();
  drawBaseRotatedSprite(gunbaseX,gunbaseY,gunAng,cannonImg);
  image(baseImg,gunbaseX-baseImg.width/2,gunbaseY-baseImg.height/2+baseOffset);
  starField(starX,starY,speed);

  
  //explosion(explosionParticles,pX,pY,pANG,explosionTrigger,originX,originY);
  

  //line(gunbaseX,gunbaseY,guntipX,guntipY);
   for(int i=0;i<planeXSpeed.length;i++){ 
    fill(6, 138, 61);
     rect(xCoor[i],yCoor[i],30,30);
         xCoor[i]+=planeXSpeed[i];
        if(xCoor[i]>=1100||xCoor[i]<=-300){
      planeXSpeed[i]*=-1;
     //Bombs dropping (Traver)
   } for(int x=0;x<bombYspeed.length;x++){ 
     fill(0);
     ellipse(xCoor[x],bomb[x],10,10);
     bomb[x]+=bombYspeed[x];
     if(bomb[i]>8000){
       bomb[i]=0;
  /*}if(bX[i]=<xCoor[i]-15&&bX[i]>=xCoor+15&&bX[i]=<yCoor[i]-15&&bX[i]>=yCoor+15){
       score+=1;
     }if(score>=5){
    level++;
   }if(level++){
     if(bomb[i]>8000-i*1000){
       bomb[i]=0;
     }*/
   }
   }
   }
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



  
void drawExplosion(){
 if(keyCode==CONTROL)
  for(int i = 0; i<maxBullets; i++){
   if(bX[i]==xCoor[i]&&bY[i]==yCoor[i]){
     updateExplosion(xCoor,yCoor);
   }
 }
}

void updateExplosion(float x[],float y[]){
      for (int i=0; i<Pexplosion.length; i++)
        particleUpdate();
}

void particleUpdate (){
  for(int i = 0; i<5; i++){x+=xCoor[i]; y+=yCoor[i];}
  velX = random (-10,10);
  velY = random (-10,10);
  x+=velX;
  y+=velY;
  fill (255);
  ellipse (x,y,10,10);
}







 
