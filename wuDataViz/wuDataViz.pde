Table wu1416;
int ColNum = 2;
int dewColNum = 4;
String mode;
int tempDefMin, defMin, defMax;
int mouseIdx;
boolean entered = false;
int viz = 0;
float x, h;
color c;



void setup() {
  size(1200, 800); 
  wu1416 = loadTable("wu14_16.csv");
  defMin = 0;
  defMax = wu1416.getRowCount();
}


void draw() {
  background(0); 
  bars();
}


void bars() {    
  mouseIdx = floor(map(mouseX, 0, width, defMin, defMax));

  if (viz == 0) {
    strokeWeight(width/defMax);
    for (int i = defMin; i < defMax; i++) {
      x = map(i, defMin, defMax, 0, width);
      h = map(wu1416.getFloat(i, ColNum), 0, max(wu1416.getFloatColumn(ColNum)), 0, height); 

      c = lerpColor(color(0, 0, 255), color(255, 0, 0), wu1416.getFloat(i, ColNum)/100);
      stroke(c);

      if (i== mouseIdx) {
        stroke(255);
        line(x, height, x, 0);
      }

      line(x, height, x, height-h);
    }
    stroke(255);
    int lineMouseX;
    if (mouseX < width - 100) {
      lineMouseX = mouseX;
    } else {
      lineMouseX = mouseX - 90;
    }
    //textSize(20);
    text((wu1416.getString(mouseIdx, 0) + "," + wu1416.getString(mouseIdx, ColNum)), lineMouseX, 50);
    if (ColNum == 1) {
      mode = "High Temperatures F";
    } else if (ColNum == 2) {
      mode = "Mean Temperatures F";
    } else mode = "Low Temperatures F";
    text(mode, 10, 20);
  } else {
    if (ColNum == 1) {
      mode = "High Temperatures F & High Dew Point";
    } else if (ColNum == 2) {
      mode = "Mean Temperatures & Mean Dew Point F";
    } else mode = "Low Temperatures F & Low Dew Point";
    text(mode, 10, 20);

    for (int i = defMin; i < defMax; i++) {
      
      mouseIdx = floor(map(mouseX, 0, width, min(wu1416.getFloatColumn(ColNum)), max(wu1416.getFloatColumn(ColNum))));
      
      x = map(wu1416.getFloat(i, ColNum), min(wu1416.getFloatColumn(ColNum)), max(wu1416.getFloatColumn(ColNum)), 100, width-100);
      h = map(wu1416.getFloat(i, dewColNum), min(wu1416.getFloatColumn(dewColNum)), max(wu1416.getFloatColumn(dewColNum)), 100, height-100);
      c = lerpColor(color(0, 0, 255), color(255, 0, 0), wu1416.getFloat(i, ColNum)/100);

      rectMode(CENTER);
      fill(c);
      stroke(0);
      ellipse(x, h, 50, 50);
  
      if (i == mouseIdx) {
       fill(255);
       ellipse(x, h, 150, 150);
       fill(0);
       text((wu1416.getString(mouseIdx, 0) + ", \n" + wu1416.getString(mouseIdx, ColNum) + ", \n" + wu1416.getString(mouseIdx, dewColNum)), x+10, h+10);
       }
    }
  }
  //textSize(25);
  fill(255);
  text("Hold Enter for help", 10, 40);
}  

void keyPressed() {
  if (keyCode == UP) {
    if ((ColNum + 1) % 3 == 0) {
      ColNum = 1;
    } else {
      ColNum = (ColNum + 1) % 3;
    }
  } else if (keyCode == DOWN) {
    if ((ColNum - 1) % 3 == 0) {
      ColNum = 3;
    } else {
      ColNum = (ColNum - 1) % 3;
    }
  } else if (keyCode == 'R') {
    defMin = 0;
    defMax = wu1416.getRowCount();
  } else if (keyCode == ENTER) {
    stroke(255);
    text("Up/Down arrows to change modes.", (width/2) - 100, (height/2) - 100);
    text("Click and drag to select an area to zoom in on.", (width/2) - 100, (height/2) - 75);
    text("The 'r' key resets the graph.", (width/2) - 100, (height/2) - 50);
    text("The 's' key switches visualizations.", (width/2) - 100, (height/2) - 25);
  } else if (keyCode == 'S') {
    if (viz == 0) {
      viz = 1;
    } else {
      viz = 0;
    }
  }
} 

void mousePressed() {
  if (pmouseX != mouseX && defMax > 10) {
    tempDefMin = mouseIdx;
  }
}

void mouseReleased() {
  if (defMax > 10) {
    defMin = tempDefMin;
    defMax = mouseIdx;
  } else {
    defMin = tempDefMin;
    defMax = tempDefMin+10;
  }
}