class Caminante {
  float x, y; //<>//
  float t;
  float dir;
  float vel;
  color c;
  float variacionAngular;

  Caminante (color c_, float x_, float y_, float dir_) {
    dir = radians (dir_);
    x = x_;
    y = y_;
    t = 10;
    vel = 15;
    c = c_;
  }
  
  Caminante (color c_) {
    c = c_;
  }

  void borrarCaminantes(float x_, float y_) {
    x = x_;
    y = y_;
    c = color (255, 0, 0, 0);
  }

  void dibujar() {
    fill(c);
    noStroke();
    ellipse(x, y, t, t);
  }

  void girar(float valor) {
    variacionAngular = radians (valor);
  }

  void mover() {
    //pasar la velocidad y dirección a Coord. Cartesianas
    float dx = vel * cos( dir );
    float dy = vel * sin( dir );

    x += dx;
    y += dy;

  }
  
  void actualizar( float intensidadEntrada, float derivadaAltura ) {

    float variacion = derivadaAltura * radians(3);

    dir += variacion;

    t = map(intensidadEntrada, 0, 1, MINIMO_TRAZO, MAXIMO_TRAZO );
    vel = t*0.2;

    mover();
  }

}
