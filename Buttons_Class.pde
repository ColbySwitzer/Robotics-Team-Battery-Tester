class Button {
  int x, y, w, h;
  String label;
  boolean buttonClicked = false;

  Button(int x, int y, int width, int height, String label) {
    this.x = x;
    this.y = y;
    this.w = width;
    this.h =height;
    this.label = label;
  }

  void draw() {
    fill(200);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(label, x+w/2, y+h/2);
  }

  boolean isMouseOver() {
    return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h;
  }

  void mousePressed() {
    if (isMouseOver()) {
      buttonClicked = true;
    }
  }
}



class Switch {
  int x;
  int y;
  int width;
  int height;
  int sliderWidth;
  int sliderRadius;
  boolean on;

  Switch(int x, int y, int width, int height, int sliderWidth, int sliderRadius) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.sliderWidth = sliderWidth;
    this.sliderRadius = sliderRadius;
    this.on = false;
  }

  void draw() {
    // Draw the switch track
    fill(200);
    rect(x, y, width, height, 15);

    // Draw the switch slider
    fill(on ? color(56, 239, 125) : color(255, 99, 71));
    rect(
      on ? x + width - sliderWidth : x,
      y,
      sliderWidth,
      height,
      sliderRadius
      );

    // Draw the switch slider handle
    fill(255);
    ellipse(
      on ? x + width - sliderWidth + sliderRadius : x + sliderRadius,
      y + height / 2,
      sliderRadius * 2,
      sliderRadius * 2
      );

    // Draw the text inside the circles with black color
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(16);
    text("OFF", x + sliderRadius, y + height / 2);
    text("ON", x + width - sliderRadius, y + height / 2);
  }

  void mousePressed() {
    // Check if the mouse is inside the switch slider
    if (mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height) {
      // Toggle the switch state
      on = !on;
    }
  }
}
