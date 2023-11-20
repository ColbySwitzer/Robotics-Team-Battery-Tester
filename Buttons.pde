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
}
