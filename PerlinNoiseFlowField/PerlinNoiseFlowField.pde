// Perlin noise flow field
float xOff, yOff, xOffInit;

void setup() {
    size(800, 600);
    
    pixelDensity(1);
    
    xOffInit = 0;
    xOff = 0;
    yOff = 0;
}

void draw() {
    background(0);
    
    loadPixels();
    
    xOff = xOffInit;
    
    for (int x = 0; x < width; x++) {
        yOff = 0.0;
        for (int y = 0; y < height; y++) {
            // TODO: Try to map the variety of depth to the current position relative to screen width
            //float detail = map(mouseX, 0, width, 0.1, 0.6);
            //noiseDetail(4, detail);
            
            // Get new grey value
            float  grey = noise(xOff, yOff) * 255;
            
            // Color the pixel at the index
            pixels[x + y * width] = color(grey);
            
            yOff += 0.01;
        }
        xOff += 0.01;
    }
    
    //xOffInit += 0.1;
    
    updatePixels();
}