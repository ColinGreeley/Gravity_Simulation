
float Gravity = .0001; //0.0001 default //
//float Gravity = .000001; //0.0001 default //

class particle {
  PVector position, speed;
  int mass, size, test = 0;
  particle(int x, int y, int m, int s) {
    position = new PVector(x, y);
    mass = m;
    size = s;
    speed = new PVector(0, 0);
    float xDiff = width/2 - position.x;
    float yDiff = height/2 - position.y;
    float theta = atan(yDiff/(xDiff+0.00000001));
    float rad = sqrt(pow(xDiff, 2) + pow(yDiff, 2));
    float force = (rad/rad + 100);
    //float force = (rad+500)/rad + 8;
    if      (xDiff > 0 && yDiff > 0) {
        speed.y -= force * cos(theta);
        speed.x += force * sin(theta);
      }
      else if (xDiff > 0 && yDiff < 0) {
        speed.y -= force * cos(theta);
        speed.x += force * sin(theta);
      }
      else if (xDiff < 0 && yDiff < 0) {
        speed.y += force * cos(theta);
        speed.x -= force * sin(theta);
      }
      else if (xDiff < 0 && yDiff > 0) {
        speed.y += force * cos(theta);
        speed.x -= force * sin(theta);
      }
  }
  particle(int x, int y, int m, int s, int t) {
    position = new PVector(x, y);
    mass = m;
    size = s;
    speed = new PVector(0, 0);
    test = t;
  }
  void draw_self() {
    float c = (abs(speed.x)+abs(speed.y))/3;
    fill(255, 255-c, 255-c);
    stroke(255, 255-c, 255-c);
    ellipse(position.x, position.y, size, size);
  }
  void gravity() {
    float xDiff, yDiff, theta, force = 0;
    for (int i = 0; i < pList.size(); i++) {
    if (i == pList.size()-1) {
      xDiff = pList.get(i).position.x - position.x;
      yDiff = pList.get(i).position.y - position.y;
      force = (Gravity * pList.get(i).mass * mass) / (xDiff * xDiff + yDiff * yDiff);
      theta = atan(yDiff/(xDiff+0.00000001));
      if      (xDiff > size && yDiff > size) {
        speed.x += force * cos(theta);
        speed.y += force * sin(theta);
      }
      else if (xDiff > size && yDiff < -size) {
        speed.x += force * cos(theta);
        speed.y += force * sin(theta);
      }
      else if (xDiff < -size && yDiff < -size) {
        speed.x -= force * cos(theta);
        speed.y -= force * sin(theta);
      }
      else if (xDiff < -size && yDiff > size) {
        speed.x -= force * cos(theta);
        speed.y -= force * sin(theta);
      }
      
      else if (xDiff > size && yDiff <= size) {
        speed.x += force * cos(theta);
      }
      else if (xDiff < -size && yDiff <= size) {
        speed.x -= force * cos(theta);
      }
      else if (xDiff <= size && yDiff < -size) {
        speed.y += force * sin(theta);
      }
      else if (xDiff <= size && yDiff > size) {
        speed.y += force * sin(theta);
      }
    }}
  }
  void update() {
    if (test == 0) {
      position.x += speed.x/mass;
      position.y += speed.y/mass;
    }
  }
}


int listSize = 3000;
ArrayList<particle> pList = new ArrayList<particle>();

void setup() {
  size(1200, 800);
  background(0);
  PVector center = new PVector(width/2, height/2);;
  int xt = 10000, yt = 10000, rad = height/2;
  for (int i = 0; i < listSize; i++) {
    xt = yt = 10000;
    while(sqrt((pow(xt, 2) + pow(yt, 2))) > rad) {
      xt = (int)random(-height/2, height/2);
      yt = (int)random(-height/2, height/2);
    }
    pList.add(new particle(xt + (int)center.x, yt + (int)center.y, (int)random(50, 70), (int)random(1, 3)));
  }
  //pList.add(new particle(500, 500, 700, 3));
  //pList.add(new particle(520, 520, 700, 3));
  pList.add(new particle(width/2, height/2, 10000000, 20, 1));
  fill(255, 255, 200);
  stroke(255, 255, 255);
}

void draw() {
  background(0, 0, 40);
  for (int i = 0; i < pList.size(); i++) {
    if (i == pList.size()-1) {
      fill(0, 0, 40);
      pList.get(i).draw_self();
      pList.get(i).gravity();
      pList.get(i).update();
      fill(255, 255, 200);
    }
    else{
    pList.get(i).draw_self();
    pList.get(i).gravity();
    pList.get(i).update();
    }
  }
  //clean();
}

void mousePressed() {
  pList.add(new particle(mouseX, mouseY, 5000, (int)random(2, 4)));
}

void clean() {
    for (int i = 0; i < pList.size(); i++) {
      if (pList.get(i).position.x < 0 || pList.get(i).position.x > width || 
          pList.get(i).position.y < 0 || pList.get(i).position.y > height) {
          pList.remove(i);  
      }
    }
  }