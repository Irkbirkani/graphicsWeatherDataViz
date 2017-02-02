   Table wu1416;
   int ColNum = 2;
   int dewColNum = 4;
   String mode;
   int tempDefMin, defMin, defMax;
   int mouseIdx;
   boolean entered = false;
   int viz = 0;
   
   
   
  void setup() {
    size(1200,800); 
    wu1416 = loadTable("wu14_16.csv");
    defMin = 0;
    defMax = wu1416.getRowCount();
  }
  
  
  void draw() {
   background(0); 
   bars();
  }
  
  
  void bars() {    
    mouseIdx = floor(map(mouseX, 0,width, defMin, defMax));
    
    if (viz == 0) {
      strokeWeight(width/defMax);
      for(int i = defMin; i < defMax; i++){
        float x = map(i, defMin,defMax, 0, width);
        float h = map(wu1416.getFloat(i,ColNum), 0, max(wu1416.getFloatColumn(ColNum)), 0,height); 
        
        color c = lerpColor(color(0,0,255), color(255,0,0),wu1416.getFloat(i,ColNum)/100);
        stroke(c);
        
        if(i== mouseIdx){
         stroke(255);
         line(x,height,x,0);
        }
        
        line(x,height, x,height-h);
      }
      stroke(255);
      int lineMouseX;
      if (mouseX < width - 100){
        lineMouseX = mouseX;
      } else {
       lineMouseX = mouseX - 90; 
      }
      text((wu1416.getString(mouseIdx,0) + "," + wu1416.getString(mouseIdx,ColNum)), lineMouseX,50);
      if (ColNum == 1) {
        mode = "High Temperatures F";
      } else if (ColNum == 2) {
        mode = "Mean Temperatures F";
      } else mode = "Low Temperatures F";
      text(mode,10,20);
  } else {
    for(int i = defMin; i < defMax; i++) {
      
    }
    
    
    
  }
    text("Hold Enter for help",10,35);
  }  
  
  void keyPressed() {
   if (key == CODED) {
    if (keyCode == UP) {
     if ((ColNum + 1) % 3 == 0){
          ColNum = 1; 
       } else {
          ColNum = (ColNum + 1) % 3;
       }  
      } else if((ColNum - 1) % 3 == 0){
          ColNum = 3; 
       } else {
          ColNum = (ColNum - 1) % 3;
       } 
     } else if (keyCode == 'R') {
        defMin = 0;
        defMax = wu1416.getRowCount();
       } else if(keyCode == ENTER) {
         stroke(255);
         text("Up/Down arrows to change modes.", (width/2) - 100, (height/2) - 100);
         text("Click and drag to select an area to zoom in on.", (width/2) - 100, (height/2) - 75);
         text("The 'r' key resets the graph.", (width/2) - 100, (height/2) - 50);
         text("The 's' key switches visualizations.", (width/2) - 100, (height/2) - 25);
         
       }
  
   } 
   
   void mousePressed() {
     if(pmouseX != mouseX && defMax > 10) {
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