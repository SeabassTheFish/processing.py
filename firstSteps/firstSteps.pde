import java.util.*;
import java.io.File;
import java.io.IOException;

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

public class Particle {
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
  int a = 100;
  Boolean done = false;

  Particle(float x, float y, float w, float h, color c, String type, float vx, float vy, int fadeTime) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.type = type;
    this.vx = vx;
    this.vy = vy;
    this.fadeTime = fadeTime;
    this.done = false;
  }

  public void display() {
    stroke(black, a);
    switch (this.type) {
    case "rect":
      fill(this.c, a);
      rect(this.x, this.y, this.w, this.h);
      break;
    case "ellipse":
      fill(this.c, a);
      ellipse(this.x, this.y, this.w, this.h);
      break;
    }
  }

  public Boolean run() {
    this.display();
    this.x += this.vx;
    this.y += this.vy;
    this.vy += 0.1;
    if (this.timeAlive <= this.fadeTime) {
      this.a -= 100/this.fadeTime;
    }
    ++this.timeAlive;
    if (this.timeAlive > this.fadeTime) {
      return false;
    }
    return true;
  }
}

public class Player {
  float x;
  float y;
  float w;
  float h;
  color[] palette = new color[256];
  int[] graphic = new int[65536];
  int[] displayModes = new int[16];

  Player(float x, float y, float w, float h, color[] palette, int[] graphic) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.palette = palette;
    this.graphic = graphic;
    
  }
  // TODO
  void display() {
    for (int i : graphic) {
      fill(palette[graphic[i]]);
      rect(x + i%256*(w/256), y + floor(i/256)*(h/256), w/256, h/256); 
    }
  }
}

public class Actor {
  float x;
  float y;
  float w;
  float h;

  Actor(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  // TODO
}

public class Fountain extends Actor {
  Set<Particle> particles;
  
  Fountain(float _x, float _y, float _w, float _h) {
    super(_x, _y, _w, _h);
    particles = new HashSet<Particle>();
  }
    
  public void run() {
    // add a new particle to the fountain
    particles.add(new Particle(x, y, 10, 20, black, "ellipse", random(-3, 3), -2, 100));
    // runs all particles
    Set<Particle> removal = new HashSet<Particle>();
    for (Particle particle : particles) {
      if (!particle.run()) {
        removal.add(particle);
      }
    }
    for (Particle particle : removal) {
      particles.remove(particle);
    }
  }
}

public class Button {
  color c;
  float x;
  float y;
  float w;
  float h;
  float a = 100;
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

  public void display() {
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

  public void run() {
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

  public void floater() {
    this.y += this.fFactor*sin(0.05*modeTime);
  }

  public void modeChange() {
    if (this.coolThing == "fade") {
      this.a = 0;
    }
    modeTime = 0;
    modeChanging = false;
  }
}

Button game = new Button(500, 300, 175, 175, grey, "rect", "Game", black, "game", 30, 0.5, "fade");
Button shop = new Button(350, 550, 175, 175, grey, "rect", "Shop", black, "shop", 30, 0.5, "fade");
Button settings = new Button(650, 550, 175, 175, grey, "rect", "Settings", black, "settings", 30, 0.5, "fade");
Button shopBack = new Button(100, 100, 75, 50, grey, "rect", "Back", black, "menu", 30, 0, "none");

color[] testPalette = {black, white, red};


int[] testGraphic = {0, 1, 0, 1, 0, 2, 0, 1, 0, 2, 0, 1, 0, 2, 0, 1, 0, 2};

Player testPlayer = new Player(400, 400, 500, 500, testPalette, testGraphic);

void draw() {
  background(white);
  if (gameMode == "menu") {
    fill(green);
    ellipse(500, 1000, 30*teaTime, 30*teaTime);
    game.run();
    shop.run();
    settings.run();
    testPlayer.display();
  } // TODO
  if (gameMode == "game") {
    fill(black);
    textSize(50);
    text("Foo", 400, 400);
  } // TODO
  if (gameMode == "settings") {
  } // TODO
  if (gameMode == "shop") {

    shopBack.run();
  } // TODO

  ++teaTime;
  ++modeTime;
}
