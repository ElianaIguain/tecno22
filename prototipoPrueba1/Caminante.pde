class Caminante {
  //IZQUIERDA
  float x, y;
  float vel;
  float dir;
  float tam;
  color c;

  Caminante (color c_) {
    x = -1;
    y = random (800);
    tam = 10;
    vel = 1; 
    dir = radians ( random (30));
    c = c_;
  }

  void dibujar() {
    fill(c);
    noStroke();
    ellipse(x, y, tam, tam);
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

    //  x = x+vel*cos(radians(dir));
    //  y = y+vel*sin(radians(dir));
    
     if (g.movGrande) {
     // variacion= random(-10, 10);
      vel=2.5;
    } else if (g.movPeque) {
     // variacion= random(-10,10);
      vel=0.5;
    }
  }
  
  

 /* void cambiarDireccion() {
    dir = radians (random (90));
  }*/
}
