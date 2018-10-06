// Perlin Noise Terrain
// Coding Train  Challenege #11
// @cartertrafton

int cols, rows;
int scale = 20;
int w = 2000;
int h = 1600;

float flying = 0;  // Variable for tracking simulated flight movement over terrain

float[][] terrain;

void setup() 
{
  size(1500, 1000, P3D); 
  cols = w / scale;
  rows = h / scale;
  terrain = new float[cols][rows];
  
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  
  translate(width/2, height/2+50);    
  rotateX(PI/3);            // Rotate view of plane
  translate(-w/2, -h/2);    // Translate to allow visibility
  
  float yoffset = flying;      // Ever time draw loop occurs, view is moved, simulating flight
  for (int y = 0; y < rows; y++) {  
    //float xoffset = 0;    // No x movement
    //float xoffset = map(mouseX * 0.4, 0, width, -10, 10);  // X movement corresponds to mouseX
    float xoffset = 10 * sin(flying / 6);    // X movement is in sin wave pattern
    //float xoffset = map(mouseX * 0.4, 0, width, -10, 10) * sin(flying / 2);  // Additional x movement pattern

    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoffset,yoffset), 0, 1, -100, 100);  // Perline noise function 
      xoffset += 0.2;
    }
    yoffset += 0.2;
  }
  flying -= 0.1;    // Increment for flight 


  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP); 
    for (int x = 0; x < cols; x++) {
      vertex(x*scale, y*scale, terrain[x][y]);  // Create a vertice for the triangle strip at point y
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]); // Create second vertex at y+1
    }
    endShape();
  }
  
  
  
}
