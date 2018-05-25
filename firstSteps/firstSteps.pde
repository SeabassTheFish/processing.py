import java.util.*;
import java.io.File;
import java.io.IOException;

int width;
int height;

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
color alpha = color(0, 0, 255, 0);

int teaTime = 0;
int modeTime = 0;

Boolean modeChanging = false;

String[] games = {"platformer", "match-three"};

int[] theGraphic = new int[64];

color[] testPalette = {grey, black};

color[] worldPalette = {black, orange, green};


Button testButton;

Fountain testFountain;

Player testPlayer;

Blast testBlast;

Block testBlock;

int[] parseBitmap(String[] input, int width, int height, int[] output) {
  for (int i = 0; i < width; ++i) {
    for (int j = 0; j < height; ++j) {
      output[j*8 + i] = (int(split(input[j], " ")))[i];
    }
  }
  return output;
}

void setup() {
  size(1000, 900);
  width = 1000;
  height = 900;
  surface.setResizable(true);
  fill(255, 0, 0);
  String[] scannedTestGraphic = loadStrings("testGraphics/testGraphic.txt");
  theGraphic = parseBitmap(scannedTestGraphic, 8, 8, theGraphic);
  
  testButton = new Button(width/2, height/3, width*1/8, height*1/6, grey, "rect", "Test", black, "test", 30, 0.5, "fade");
  
  testPlayer = new Player(width*2/5, height*5/9, width/10, height/9, testPalette, theGraphic);
  
  testFountain = new Fountain(600, 500, 10, 10, grey, "rect");
  
  testBlast = new Blast(700, 600, 10, 10, grey, "ellipse");
  
  testBlock = new Block(700, 300, 50, 50, "portal");
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

  Particle(float _x, float _y, float _w, float _h, color _c, String _type, float _vx, float _vy, int _fadeTime) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    type = _type;
    vx = _vx;
    vy = _vy;
    fadeTime = _fadeTime;
    done = false;
  }

  public void display() {
    stroke(black, a);
    switch (type) {
    case "rect":
      fill(c, a);
      rect(x, y, w, h);
      break;
    case "ellipse":
      fill(c, a);
      ellipse(x, y, w, h);
      break;
    }
  }

  public Boolean run() {
    display();
    x += vx;
    y += vy;
    vy += 0.1;
    if (timeAlive <= fadeTime) {
      a -= 100/fadeTime;
    }
    ++timeAlive;
    if (timeAlive > fadeTime) {
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
  float vx;
  float vy;
  color[] palette;
  int[] graphic;
  int[] displayModes = new int[16];
  Boolean onBlock;

  Player(float _x, float _y, float _w, float _h, color[] _palette, int[] _graphic) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    vx = 0;
    vy = 0;
    onBlock = true;
    palette = _palette;
    graphic = _graphic;
  }
  // TODO

  void display() {
    for (int i = 0; i < graphic.length; ++i) {
      stroke(palette[graphic[i]]);
      fill(palette[graphic[i]]);
      rect(x + i%8*(w/8), y + floor(i/8)*(h/8), w/8, h/8);
    }
  }
  
  void run() {
    display();
    char theKeyPressed;
    if (keyPressed) {
      theKeyPressed = key;
      if (theKeyPressed == 'w') {
        if (onBlock) {
          vy -= 20;
        }
      }
      if (theKeyPressed == 'a') {
        vx -= 3;
      }
      if (theKeyPressed == 'd') {
        vx += 3;
      }
    } else if (!keyPressed) {
      theKeyPressed = '`';
    }
    if (!onBlock) {
      vy += 5;
    }
    x += vx;
    y += vy;
    vx -= (vx != 0 ? (vx < 0 ? -1 : 1) : 0);
    
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

public class Block extends Actor {
  String type;
  Boolean deadly;
  
  Block(float _x, float _y, float _w, float _h, String _type) {
    super(_x, _y, _w, _h);
    deadly = false;
    type = _type;
  }
  
  void display() {
    switch (type) {
      case ("spike^"): 
        fill(worldPalette[0]);
        triangle(x + w/2, y, x, y + h, x + w, y + h);
        deadly = true;
        break;
      case ("spikeV"): 
        fill(worldPalette[0]);
        triangle(x + w/2, y + h, x, y, x + w, y);
        deadly = true;
        break;
      case ("spike>"):
        fill(worldPalette[0]);
        triangle(x, y, x, y + h, x + h, y + h/2);
        deadly = true;
        break;
      case ("spike<"):
        fill(worldPalette[0]);
        triangle(x + w, y, x + w, y + h, x, y + h/2);
        deadly = true;
        break;
      case ("brick"):
        fill(worldPalette[0]);
        rect(x, y, w, h);
        break;
      case ("lava"):
        fill(worldPalette[1]);
        rect(x, y, w, h);
        deadly = true;
        break;
      case ("portal"):
        fill(worldPalette[2]);
        rect(x, y, w, h);
        deadly = true;
        break;
    } // TODO
  }
  
}

public class Fountain extends Actor {
  Set<Particle> particles;
  color c;
  String shape;

  Fountain(float _x, float _y, float _w, float _h, color _c, String _shape) {
    super(_x, _y, _w, _h);
    
    particles = new HashSet<Particle>();
    c = _c;
    shape = _shape;
  }

  void run() {
    // add a new particle to the fountain
    particles.add(new Particle(x, y, w, h, c, shape, random(-3, 3), -2, 100));
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

public class Blast extends Actor {
  Set<Particle> particles;
  color c;
  String shape;
  Blast(float _x, float _y, float _w, float _h, color _c, String _shape) {
    super(_x, _y, _w, _h);
    
    particles = new HashSet<Particle>();
    c = _c;
    shape = _shape;
    
    for (int i = 0; i < 50; ++i) {
      particles.add(new Particle(x, y, w, h, c, shape, random(-3, 3), random(-5, 0), 100));
    }
  }
  
  void run() {
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


  Button(float _x, float _y, float _w, float _h, color _c, String _shape, String _text, color _tc, String _action, int _textSize, float _floatFactor, String _coolThing) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    shape = _shape;
    text = _text;
    pressed = false;
    tc = _tc;
    hover = false;
    clicked = false;
    action = _action;
    textSize = _textSize;
    fFactor = _floatFactor;
    coolThing = _coolThing;

    if (coolThing == "fade") {
      a = 0;
    } else {
      a = 255;
    }
  }

  public void display() {
    stroke(black, a);
    fill(c, a);
    switch (shape) {
    case "rect":
      rectMode(CENTER);
      if (!hover) {
        fill(black, a);
        rect(x + (w/10), y + (h/10), w, h);
      }
      fill(c, a);
      rect(x, y, w, h);
      textAlign(CENTER, CENTER);
      fill(tc);
      textSize(textSize);
      text(text, x, y);
      break;
    case "ellipse":
      if (!hover) {
        fill(black);
        ellipse(x + (w/10), y + (h/10), w, h);
      }
      fill(c);
      ellipse(x, y, w, h);
      textAlign(CENTER, CENTER);
      fill(tc);
      textSize(textSize);
      text(text, x, y);
      break;
    case "hex":
      if (!hover) {
        fill(black);
        beginShape();
        vertex(x - w/3 + w/10, y - h/2 + h/10);
        vertex(x + w/3 + w/10, y - h/2 + h/10);
        vertex(x + w/2 + w/10, y + h/10);
        vertex(x + w/3 + w/10, y + h/2 + h/10);
        vertex(x - w/3 + w/10, y + h/2 + h/10);
        vertex(x - w/2 + w/10, y + h/10);
        endShape(CLOSE);
      }
      fill(c);
      beginShape();
      vertex(x - w/3, y - h/2);
      vertex(x + w/3, y - h/2);
      vertex(x + w/2, y);
      vertex(x + w/3, y + h/2);
      vertex(x - w/3, y + h/2);
      vertex(x - w/2, y);
      endShape(CLOSE);
      textAlign(CENTER, CENTER);
      fill(tc);
      textSize(textSize);
      text(text, x, y);
      break;
    case "triangle":
      if (!hover) {
        fill(black);
        triangle(x - w/2 + w/10, y - h/2 + h/10, x + w/2 + w/10, y - h/2 + h/10, x + w/10, y + h/2 + h/10);
      }
      fill(c);
      triangle(x - w/2, y - h/2, x + w/2, y - h/2, x, y + h/2);
      textAlign(CENTER, CENTER);
      fill(tc);
      textSize(textSize);
      text(text, x, y);
      break;        
    case "-triangle":
      if (!hover) {
        fill(black);
        triangle(x + w/2 + w/10, y + h/2 + h/10, x - w/2 + w/10, y + h/2 + h/10, x + w/10, y - h/2 + h/10);
      }
      fill(c);
      triangle(x + w/2, y + h/2, x - w/2, y + h/2, x, y - h/2);
      textAlign(CENTER, CENTER);
      fill(tc);
      textSize(textSize);
      text(text, x, y);
      break;
    }
    if (mouseX <= x + w/2 && mouseX >= x - w/2 && mouseY <= y + h/2 && mouseY >= y - h/2) {
      hover = true;
    } else {
      hover = false;
    }
    if (hover && mousePressed) {
      clicked = true;
    } else {
      clicked = false;
    }
  }

  public void run() {
    display();
    floater();
    if (clicked) {
      modeChanging = true;
      gameMode = action;
    }
    if (coolThing == "fade") {
      a += 5;
    }
    if (modeChanging) {
      modeChange();
    }
  }

  public void floater() {
    y += fFactor*sin(0.05*modeTime);
  }

  public void modeChange() {
    if (coolThing == "fade") {
      a = 0;
    }
    modeTime = 0;
    modeChanging = false;
  }
}



void draw() {
  background(white);
  if (gameMode == "menu") {
    fill(green);
    ellipse(500, 1000, 30*teaTime, 30*teaTime);
    testButton.run();
    testFountain.run();
    testPlayer.run();
    if (teaTime > 20) {
      testBlast.run();
    }
    testBlock.display();
  } // TODO
  if (gameMode == "game") {
    fill(black);
    textSize(50);
    text("Foo", 400, 400);
  } // TODO
  if (gameMode == "settings") {
  } // TODO
  if (gameMode == "shop") {
  } // TODO

  ++teaTime;
  ++modeTime;
}
