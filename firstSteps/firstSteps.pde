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

void setup() {
  size(600, 600);
  surface.setResizable(true);
  fill(255, 0, 0);
}

class Button {
  color c;
  float x;
  float y;
  float w;
  float h;
  String shape;
  String text;
  boolean pressed;
  color tc;
  boolean hover;
  
  Button(float x, float y, float w, float h, color c, String shape, String text, color tc) {
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
  }
  
  void display() {
    fill(this.c);
    switch (this.shape) {
      case "rect":
        rectMode(CENTER);
        if (!this.hover) {
          fill(black);
          rect(this.x + (this.w/10), this.y + (this.h/10), this.w, this.h);
        }
        fill(this.c);
        rect(this.x, this.y, this.w, this.h);
        textAlign(CENTER, CENTER);
        fill(this.tc);
        textSize(10);
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
        textSize(10);
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
        textSize(10);
        text(this.text, this.x, this.y);
        break;
      case "triangle":
        if (!this.hover) {
          fill(black);
          triangle(this.x - this.w/2 + this.w/10, this.y - this.h/2 + this.h/10, this.x + this.w/2 + this.w/10, this.y - this.h/2 + this.h/10, this.x + this.w/10, this.y + this.h/2 + this.h/10);
        }
        fill(this.c);
        triangle(this.x - this.w/2, this.y - this.h/2, this.x + this.w/2, this.y - this.h/2, this.x, this.y + this.h/2);
        break;        
      case "-triangle":
        if (!this.hover) {
          fill(black);
          triangle(this.x + this.w/2 + this.w/10, this.y + this.h/2 + this.h/10, this.x - this.w/2 + this.w/10, this.y + this.h/2 + this.h/10, this.x + this.w/10, this.y - this.h/2 + this.h/10);
        }
        fill(this.c);
        triangle(this.x + this.w/2, this.y + this.h/2, this.x - this.w/2, this.y + this.h/2, this.x, this.y - this.h/2);
        break;
    }
    if (mouseX <= this.x + this.w/2 && mouseX >= this.x - this.w/2 && mouseY <= this.y + this.h/2 && mouseY >= this.y - this.h/2) {
      this.hover = true;
    } else {
      this.hover = false;
    }
  }
}

Button testButton = new Button(width/2, height/2, 50, 50, green, "-triangle", "Hey There", orange);
void draw() {
  background(white);
  if (gameMode == "menu") {
    testButton.display();
  } //TODO
  else if (gameMode == "game") {} //TODO
}
