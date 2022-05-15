class Caminante2 {
  //arriba
  float x, y;
  float t;
  float dir;
  float vel;
  color c;

  Caminante2(color c_) {
    x= random(0, 600);
    y= -8;
    t= 10;
    vel = 1;
    dir = random(180, 360);
    c = c_;
  }


  void dibujar() {
    fill(c);
    noStroke();
    ellipse (x, y, t, t);
  }

  void mover() {
    float variacionAngular = radians( random(-10, 10)  );

    dir += variacionAngular; // dir = dir + variacionAngular;

    //pasar la velocidad y dirección a Coord. Cartesianas
    float dx = vel * cos( dir );
    float dy = vel * sin( dir );

    //le sumo el movimiento a la posición
    x = x + dx; //nx
    y = y + dy; //ny

    if (g.movGrande) {
      // variacion= random(80, 100);
      vel=2.5;
    } else if (g.movPeque) {
      // variacion= random(50, 100);
      vel=0.5;
    }
  }

  /* void cambiarDireccion() {
   dir= random(0, 360);
   }*/
}
