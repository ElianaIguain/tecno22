PImage fondo;

ArrayList <Caminante> caminantes;   //IZQ
ArrayList <Caminante1> caminantes1; //ABA
ArrayList <Caminante2> caminantes2; //ARR
ArrayList <Caminante3> caminantes3; //DER

Dir_y_Vel miVelocidadYDireccion;

GestorDeInteraccion g;

Paleta[] p;

void setup () {
  fondo = loadImage("fondo.png");
  
  size(600, 800);

  miVelocidadYDireccion = new Dir_y_Vel();

  g = new GestorDeInteraccion();

  p = new Paleta [4];

  p[0] = new Paleta("img0.jpg"); // paletas diferentes
  p[1] = new Paleta("img1.jpg");
  p[2] = new Paleta("img2.jpg");
  p[3] = new Paleta("img3.jpg");

  caminantes = new ArrayList<Caminante>();
  caminantes1 = new ArrayList<Caminante1>();
  caminantes2 = new ArrayList<Caminante2>();
  caminantes3 = new ArrayList<Caminante3>();

  background(fondo);
}

void draw() {
  g.actualizar();

  miVelocidadYDireccion.calcularTodo (mouseX, mouseY);

  //Para usarlo, simplemente se le pregunta al objet por alguno de los valores. En la medida que los necesitemos

  //miVelocidadYDireccion.velocidad();
  //miVelocidadYDireccion.direccionX();
  //miVelocidadYDireccion.direccionY();
  //miVelocidadYDireccion.direccionPolar();

  if (g.izquierda) {
    println("izquierda");
    for (int i =0; i<2; i++) {
      caminantes.add(new Caminante(p[0].darUnColor()));
    }
  }

  if (g.abajo) {
    println("abajo");
    for (int i =0; i<2; i++) {
      caminantes1.add(new Caminante1(p[0].darUnColor()));
    }
  }

  if (g.arriba) {
    println("arriba");
    for (int i =0; i<2; i++) {
      caminantes2.add(new Caminante2(p[0].darUnColor()));
    }
  }

  if (g.derecha) {
    println("derecha");
    for (int i =0; i<2; i++) {
      caminantes3.add(new Caminante3(p[0].darUnColor()));
    }
  }

  /* if (g.movGrande) {
   background(255, 0, 0);
   } else if (g.movPeque) {
   background(0, 255, 0);
   }*/

  for (Caminante c : caminantes) {
    c.mover();
    c.dibujar();
  }
  for (Caminante1 c : caminantes1) {
    c.mover();
    c.dibujar();
  }
  for (Caminante2 c : caminantes2) {
    c.mover();
    c.dibujar();
  }
  for (Caminante3 c : caminantes3) {
    c.mover();
    c.dibujar();
  }
}
