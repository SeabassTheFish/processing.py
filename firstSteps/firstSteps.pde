String gameMode = "menu";
color black = color(0, 0, 0);
color white = color(255, 255, 255);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color yellow = color(255, 255, 0);
color purple = color(100, 0, 100);
color magenta = color(255, 0, 255);
color pink = color(255, 100, 255);
color cyan = color(0, 255, 255);
color orange = color(255, 100, 0);
color grey = color(200, 200, 200);

int teaTime = 0;
int modeTime = 0;

Boolean modeChanging = false;

String[] games = {"platformer", "match-three"};

void setup() {
  size(1000, 900);
  surface.setResizable(true);
  fill(255, 0, 0);
}

class Particle {
  color c;
  float x;
  float y;
  float w;
  float h;
  String type;
  float vx;
  float vy;
  int fadeTime;
  int timeAlive = 0;
  float angMomentum;
  int a;
  
  Particle(float x, float y, float w, float h, color c, String type, float vx, float vy, int fadeTime, float angMomentum) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.type = type;
    this.vx = vx;
    this.vy = vy;
    this.fadeTime = fadeTime;
    this.angMomentum = angMomentum;
  }
  
  void display() {
    switch (this.type) {
      case "rect":
        fill(this.c);
        rect(this.x, this.y, this.w, this.h);
        break;
      case "ellipse":
        fill(this.c);
        ellipse(this.x, this.y, this.w, this.h);
        break;
    }
  }
  
  void run() {
    
    ++timeAlive;
  }
}

class Button {
  color c;
  float x;
  float y;
  float w;
  float h;
  float a;
  String shape;
  String text;
  boolean pressed;
  color tc;
  boolean hover;
  boolean clicked;
  String action;
  int textSize;
  float fFactor;
  String coolThing;
  

  Button(float x, float y, float w, float h, color c, String shape, String text, color tc, String action, int textSize, float floatFactor, String coolThing) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.shape = shape;
    this.text = text;
    this.pressed = false;
    this.tc = tc;
    this.hover = false;
    this.clicked = false;
    this.action = action;
    this.textSize = textSize;
    this.fFactor = floatFactor;
    this.coolThing = coolThing;
    
    if (this.coolThing == "fade") {
      this.a = 0;
    } else {
      this.a = 255;
    }
  }

  void display() {
    stroke(black, this.a);
    fill(this.c, this.a);
    switch (this.shape) {
    case "rect":
      rectMode(CENTER);
      if (!this.hover) {
        fill(black, this.a);
        rect(this.x + (this.w/10), this.y + (this.h/10), this.w, this.h);
      }
      fill(this.c, this.a);
      rect(this.x, this.y, this.w, this.h);
      textAlign(CENTER, CENTER);
      fill(this.tc);
      textSize(this.textSize);
      text(this.text, this.x, this.y);
      break;
    case "ellipse":
      if (!this.hover) {
        fill(black);
        ellipse(this.x + (this.w/10), this.y + (this.h/10), this.w, this.h);
      }
      fill(this.c);
      ellipse(this.x, this.y, this.w, this.h);
      textAlign(CENTER, CENTER);
      fill(this.tc);
      textSize(this.textSize);
      text(this.text, this.x, this.y);
      break;
    case "hex":
      if (!this.hover) {
        fill(black);
        beginShape();
        vertex(this.x - this.w/3 + this.w/10, this.y - this.h/2 + this.h/10);
        vertex(this.x + this.w/3 + this.w/10, this.y - this.h/2 + this.h/10);
        vertex(this.x + this.w/2 + this.w/10, this.y + this.h/10);
        vertex(this.x + this.w/3 + this.w/10, this.y + this.h/2 + this.h/10);
        vertex(this.x - this.w/3 + this.w/10, this.y + this.h/2 + this.h/10);
        vertex(this.x - this.w/2 + this.w/10, this.y + this.h/10);
        endShape(CLOSE);
      }
      fill(this.c);
      beginShape();
      vertex(this.x - this.w/3, this.y - this.h/2);
      vertex(this.x + this.w/3, this.y - this.h/2);
      vertex(this.x + this.w/2, this.y);
      vertex(this.x + this.w/3, this.y + this.h/2);
      vertex(this.x - this.w/3, this.y + this.h/2);
      vertex(this.x - this.w/2, this.y);
      endShape(CLOSE);
      textAlign(CENTER, CENTER);
      fill(this.tc);
      textSize(this.textSize);
      text(this.text, this.x, this.y);
      break;
    case "triangle":
      if (!this.hover) {
        fill(black);
        triangle(this.x - this.w/2 + this.w/10, this.y - this.h/2 + this.h/10, this.x + this.w/2 + this.w/10, this.y - this.h/2 + this.h/10, this.x + this.w/10, this.y + this.h/2 + this.h/10);
      }
      fill(this.c);
      triangle(this.x - this.w/2, this.y - this.h/2, this.x + this.w/2, this.y - this.h/2, this.x, this.y + this.h/2);
      textAlign(CENTER, CENTER);
      fill(this.tc);
      textSize(this.textSize);
      text(this.text, this.x, this.y);
      break;        
    case "-triangle":
      if (!this.hover) {
        fill(black);
        triangle(this.x + this.w/2 + this.w/10, this.y + this.h/2 + this.h/10, this.x - this.w/2 + this.w/10, this.y + this.h/2 + this.h/10, this.x + this.w/10, this.y - this.h/2 + this.h/10);
      }
      fill(this.c);
      triangle(this.x + this.w/2, this.y + this.h/2, this.x - this.w/2, this.y + this.h/2, this.x, this.y - this.h/2);
      textAlign(CENTER, CENTER);
      fill(this.tc);
      textSize(this.textSize);
      text(this.text, this.x, this.y);
      break;
    }
    if (mouseX <= this.x + this.w/2 && mouseX >= this.x - this.w/2 && mouseY <= this.y + this.h/2 && mouseY >= this.y - this.h/2) {
      this.hover = true;
    } else {
      this.hover = false;
    }
    if (this.hover && mousePressed) {
      this.clicked = true;
    } else {
      this.clicked = false;
    }
  }

  void run() {
    this.display();
    this.floater();
    if (this.clicked) {
      modeChanging = true;
      gameMode = this.action;
    }
    if (this.coolThing == "fade") {
      this.a += 5;
    }
    if (modeChanging) {
      this.modeChange();
    }
  }

  void floater() {
    this.y += this.fFactor*sin(0.05*modeTime);
  }
  
  void modeChange() {
    if (this.coolThing == "fade") {
      this.a = 0;
    }
    modeTime = 0;
    modeChanging = false;
  }
}

Button game = new Button(500, 300, 175, 175, grey, "rect", "Games", black, "games", 30, 0.5, "fade");
Button shop = new Button(350, 550, 175, 175, grey, "rect", "Shop", black, "shop", 30, 0.5, "fade");
Button settings = new Button(650, 550, 175, 175, grey, "rect", "Settings", black, "settings", 30, 0.5, "fade");
Button shopBack = new Button(100, 100, 75, 50, grey, "rect", "Back", black, "menu", 30, 0, "none");

void draw() {
  background(white);
  if (gameMode == "menu") {
    fill(green);
    ellipse(500, 1000, 30*teaTime, 30*teaTime);
    game.run();
    shop.run();
    settings.run();
  } // TODO
  if (gameMode == "games") {
    fill(black);
    textSize(50);
  } // TODO
  if (gameMode == "settings") {
  } // TODO
  if (gameMode == "shop") {
    
    shopBack.run();
  } // TODO

  ++teaTime;
  ++modeTime;
}
