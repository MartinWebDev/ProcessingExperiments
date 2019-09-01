int gameWidth = 600;
int gameHeight = 900;

Enemy enemy;

void settings() {
    size(gameWidth, gameHeight);
}

void setup() {
    enemy = new Enemy(gameWidth / 2, 20);
}

void draw() {
    background(50);
    
    enemy.render();
}
