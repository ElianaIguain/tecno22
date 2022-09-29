import fisica.*;
FWorld mundo;

//---------------------sonido
import ddf.minim.*;

Minim minim;
AudioPlayer musicaPrevia, musicaJuego, musicaGanar, musicaPerder, sonidoRebote;
int tiempoParaLoop1, tiempoParaLoop2, tiempoParaLoopGanar, tiempoParaLoopPerder;
//---------------------------
/////////////////////////////
//--------------------fuentes
PFont fuente1;
//---------------------------
/////////////////////////////
float x, y;
float angle, vel;

Red r;

Personaje chem1, chem2, chem3;

ArrayList <Plataforma> plataformas;

int maxImages = 2;
int imageIndex = 0;
PImage[] nubes = new PImage [maxImages];

PImage Cheemsimg, red, fondo, fondito, nube, nube0, imagenPantalla1, imagenPantalla2, imagenPantalla3, imagenPantallaGanar, imagenPantallaPerder, hijoFantasma, esposaFantasma, rayos;

String pantalla;

int tiempoParaCaida;
/////////////////////////////
//------------------fantasmas
int subidaFantasma1, subidaFantasma2, subidaFantasma3;
boolean fantasma1, fantasma2, fantasma3;
/////////////////////////////
//---------------temporizador
int temporizador;
int temporizadorParaDibujo;
Tiempo tiempo;
int limiteDeTiempo;
//---------------------------
/////////////////////////////
//-------------------contador
int contador;
int contactoCaer;
//---------------------------
/////////////////////////////


void setup() {
  Fisica.init(this);
  mundo= new FWorld();
  mundo.setEdges();

  size(800, 650);
  pantalla = "pantalla1";

  imagenPantalla1 = loadImage("pantalla1.jpg");
  imagenPantalla2 = loadImage("pantalla2.jpg");
  imagenPantalla3 = loadImage("pantalla3.jpg");
  imagenPantallaGanar = loadImage("pantallaGanar.jpg");
  imagenPantallaPerder = loadImage("pantallaPerder.jpg");
  nube0 = loadImage("nube0.png");
  fondo = loadImage("fondo.jpg");
  fondito = loadImage("fondito.jpg");
  hijoFantasma = loadImage("fantasma hijo.png");
  esposaFantasma = loadImage("esposa fantasma.png");
  subidaFantasma1 = height-30 ;
  subidaFantasma2 = height-30 ;
  subidaFantasma3 = height-30 ;
  fantasma1=false;
  fantasma2=false;
  fantasma3=false;
  rayos = loadImage("rayos.png");

  minim = new Minim(this);
  musicaJuego = minim.loadFile("sonido juego.mp3");
  musicaPrevia = minim.loadFile("sonido intermedio.mp3");
  musicaGanar = minim.loadFile("sonido ganar.mp3");
  musicaPerder = minim.loadFile("sonido perder.mp3");
  sonidoRebote = minim.loadFile("rebote.mp3");
  tiempoParaLoop1=0;
  tiempoParaLoop2=0;
  tiempoParaLoopGanar=0;
  tiempoParaLoopPerder=0;


  /////////////////////////////////////////////////////////CONTADOR
  contador=0;
  contactoCaer=0;
  /////////////////////////////////////////////////////////////////


  //////////////////////////////////////////////////////////FUENTES
  fuente1 = loadFont("KellySlab-Regular-48.vlw");
  /////////////////////////////////////////////////////////////////


  tiempoParaCaida = 0;



  ////////////////////////////////////////////BOMBERITOS CON SU RED
  red = loadImage("red.png");

  r = new Red (140, 70); //140/2 es 70 y yo hago que venga y vuelva con el valor 80
  r.attachImage(red);
  r.setRestitution(0.001);
  r.inicializar(100, 550);
  mundo.add(r);
  /////////////////////////////////////////////////////////////////



  //////////////////////////////////////////////////////PLATAFORMAS
  plataformas = new ArrayList <Plataforma> ();

  //arriba
  for (int i = 0; i<4; i++) {
    Plataforma p = new Plataforma(100, 16);
    p.inicializar(100+(200*i), 250, false, true);
    p.setName("p");
    mundo.add(p);
    plataformas.add(p);
  }

  //medio
  for (int i = 0; i < 3; i++) {
    Plataforma nubeGris= new Plataforma(100, 16);
    nubeGris.inicializar(230 + (i * 175), 370, false, false);
    nubeGris.setName("Gris");
    mundo.add(nubeGris);
    plataformas.add(nubeGris);
  }
  //abajo
  for (int i = 0; i<4; i++) {
    Plataforma p3 = new Plataforma(100, 16);
    p3.inicializar(100+(200*i), 500, false, true);
    p3.setName("p3");
    plataformas.add(p3);
    mundo.add(p3);
  }



  Plataforma piso = new Plataforma(width, 10);
  piso.inicializar(width / 2, height - 1, true, false);
  piso.setStatic(true);
  piso.setName("piso");
  mundo.add(piso);


  /////////////////////////////////////////////////////////////////



  /////////////////////////////////////////////////////TEMPORIZADOR
  tiempo = new Tiempo();
  temporizadorParaDibujo=1500; //si cambian temporizador cambien este
  temporizador=1500;
  limiteDeTiempo=0;

  /////////////////////////////////////////////////////////////////
  textFont(fuente1);
  vel=1;
}




void draw() {

  ///////////////////////////////////////SONIDO
  if (pantalla == "pantalla1" ||pantalla == "pantalla2"||pantalla == "pantalla3") {
    musicaPrevia.play();
    if (tiempoParaLoop2 >= 1720) {
      musicaPrevia.loop();
      tiempoParaLoop2=0;
    }
    tiempoParaLoop2= tiempoParaLoop2 +1;
  } else if (pantalla == "juego") {
    musicaPrevia.pause();
    musicaJuego.play();

    if (tiempoParaLoop1>=3240) {
      musicaJuego.loop();
      tiempoParaLoop1=0;
    }
    tiempoParaLoop1= tiempoParaLoop1 +1;
  } else if (pantalla == "pantallaGanar") {
    musicaJuego.pause();
    musicaGanar.play();
    if (tiempoParaLoopGanar >=2210) {
      musicaGanar.loop();
      tiempoParaLoopGanar=0;
    }
    tiempoParaLoopGanar= tiempoParaLoopGanar+1;
    
  } else if (pantalla == "pantallaPerder") {
    musicaJuego.pause();
    musicaPerder.play();
    if (tiempoParaLoopPerder >=1412) {
      musicaPerder.loop();
      tiempoParaLoopPerder=0;
    }
    tiempoParaLoopPerder= tiempoParaLoopPerder+1;
    
  }
  ///////////////////////////////////////SONIDO^^^^^


  ///////////////////////////////////////PANTALLAS

  if (pantalla == "pantalla1") {
    pushStyle();
    pushMatrix();
    image(imagenPantalla1, 0, 0, width, height);  
    translate(400, 359);
    if (keyPressed) {
      rotate (radians(angle));
      angle = angle + vel;
      if (angle>90) {
        pantalla = "pantalla2";
        angle=0;
      }
    } 
    imageMode(CENTER);
    image(nube0, 0, 0);
    popMatrix();
    popStyle();
  } else  if (pantalla == "pantalla2") {
    pushMatrix();
    pushStyle();
    image(imagenPantalla2, 0, 0, width, height);
    translate(400, 359);
    if (keyPressed) {
      rotate (radians(angle));
      angle = angle + vel;
      if (angle>90) {
        pantalla = "pantalla3";
        angle=0;
      }
    } 
    imageMode(CENTER);
    image(nube0, 0, 0); 
    popStyle();
    popMatrix();
  } else  if (pantalla == "pantalla3") {
    pushMatrix();
    pushStyle();
    image(imagenPantalla3, 0, 0, width, height); 
    translate(400, 359);
    if (keyPressed) {
      rotate (radians(angle));
      angle = angle + vel;
      if (angle>90) {
        pantalla = "juego";
        angle=0;
      }
    } 
    imageMode(CENTER);
    image(nube0, 0, 0);
    popMatrix();
    popStyle();
  } 

  if (pantalla == "juego") {
    image(fondo, 0, 0, width, height);

    mundo.step();
    mundo.draw();

    //////////////////////////////////////////////CHEEMSITOS QUE CAEN
    //________________________________

    /*if (temporizador==300) {
     chem1 = new Personaje (40, 80);
     chem1.inicializar(random(150, width-150), -30);
     //chem1.setName("chem1");
     mundo.add(chem1);
     }*/
    println("frame"+frameCount);
    println("pantalla"+pantalla);


    if ( tiempoParaCaida == 50 && pantalla == "juego" ) {
      chem1 = new Personaje (40, 80);
      chem1.inicializarHijo(random(150, width-150), -30);
      chem1.setName("chem1");
      mundo.add(chem1);
    }

    if ( tiempoParaCaida == 350 && pantalla == "juego" ) {
      chem2 = new Personaje (40, 80);
      chem2.inicializarHijo(random(150, width-150), -30);
      chem2.setName("chem2");
      mundo.add(chem2);
    }

    if ( tiempoParaCaida == 750 && pantalla == "juego") {
      chem3 = new Personaje (40, 80);
      chem3.inicializarEsposa(random(150, width-150), -30);
      chem3.setName("chem3");
      mundo.add(chem3);
    } 

    /*if ( frameCount%1600==0 ) {
     chem2 = new Personaje (40, 80);
     chem2.inicializar(random(150, width-150), -30);
     chem2.setName("chem2");
     mundo.add(chem2);
     }*/
    /*if ( frameCount%900==0 ) {
     chem3 = new Personaje (40, 80);
     chem3.inicializar(random(150, width-150), -30);
     chem3.setName("chem3");
     mundo.add(chem3);
     }*/
    /////////////////////////////////////////////////////////////////


    // llamo al metodo girar para todas las plataformas
    for (int i = 0; i < plataformas.size(); i++)
    {
      plataformas.get(i).girar();
    }



    ////// piso del mario xd

    for (int i = 0; i < width; i+=100)
    {
      image(loadImage("plataforma.png"), i, height - 5);
    }

    /////
    r.actualizar();

    tiempoParaCaida= tiempoParaCaida +1;

    //println(tiempoParaCaida);

    //////////////////////////////////
    //________________________puntaje
    pushStyle();
    textAlign(RIGHT);
    textSize(30);
    fill(0);
    text("" +contador, 735, 50);
    text("/3", 770, 50);
    popStyle();
    //--------------------------------
    //////////////////////////////////
    //------------------------contador
    if (contactoCaer >= 3 && contador < 3) {
      pantalla="pantallaPerder";
    }
    if (contador==3) {
      pantalla="pantallaGanar";
    }
    //--------------------------------
    //////////////////////////////////
    //--------------------temporizador
    tiempo.dibujar();
    if (temporizador<=limiteDeTiempo) {
      pantalla="pantallaPerder";
    }
    temporizador= temporizador-1;
    println(temporizador);

    //-------------------------------
    //////////////////////////////////
    //-----------------------fantasmas
    if (fantasma1==true) {
      image(hijoFantasma, width/2, subidaFantasma1);
      subidaFantasma1=subidaFantasma1 - 5;
    }
    if (fantasma2==true) {
      image(hijoFantasma, width/2, subidaFantasma2);
      subidaFantasma2=subidaFantasma2 - 5;
    }
    if (fantasma3==true) {
      image(esposaFantasma, width/2, subidaFantasma3);
      subidaFantasma3=subidaFantasma3 - 5;
    }

    //-------------------------------
    /////////////////////////////////
    //--------------pantallas finales
  } else  if (pantalla == "pantallaGanar") {
    pushStyle();
    image(imagenPantallaGanar, 0, 0, width, height);
    translate(330, 570);
    if (keyPressed) {
      rotate (radians(angle));
      angle = angle + vel;
      if (angle>90) {
        reiniciar();
        angle=0;
      }
    } 
    image(nube0, 0, 0, 140, 40);
    popStyle();
  } else  if (pantalla == "pantallaPerder") {
    pushStyle();
    image(imagenPantallaPerder, 0, 0, width, height);
    translate(330, 570);
    if (keyPressed) {
      rotate (radians(angle));
      angle = angle + vel;
      if (angle>90) {
        reiniciar();
        angle=0;
      }
    } 
    image(nube0, 0, 0, 140, 40);
    popStyle();
  }
  //-------------------------------
  /////////////////////////////////

  /////////////////////////////////
  //--------------letras por plataforma
  if (pantalla=="juego") {
    text("q", 90, 290);
    text("w", 285, 290);
    text("e", 490, 290);
    text("r", 690, 290);

    text("a", 220, 420);
    text("s", 395, 420);
    text("d", 570, 420);

    text("z", 90, 540);
    text("x", 285, 540);
    text("c", 490, 540);
    text("v", 690, 540);
  }
  println(pantalla);
}




void contactStarted(FContact contacto) {


  FBody _body1 = contacto.getBody1();
  FBody _body2 = contacto.getBody2();

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //--------------------------------------------------------------contacto chems con RED
  if ((_body1.getName() == "chem1" && _body2.getName() == "red")
    || (_body2.getName() == "chem1" && _body1.getName() == "red"))
  {
    if (chem1.visible)
    {
      chem1.atrapa();
      mundo.remove(chem1);
      contactoCaer=contactoCaer+1;
    }
  }

  if ((_body1.getName() == "chem2" && _body2.getName() == "red")
    || (_body2.getName() == "chem2" && _body1.getName() == "red"))
  {
    if (chem2.visible)
    {
      chem2.atrapa();
      mundo.remove(chem2);
      contactoCaer=contactoCaer+1;
    }
  }

  if ((_body1.getName() == "chem3" && _body2.getName() == "red")
    || (_body2.getName() == "chem3" && _body1.getName() == "red"))
  {
    if (chem3.visible)
    {
      chem3.atrapa();
      mundo.remove(chem3);
      contactoCaer=contactoCaer+1;
    }
  }
  //--------------------------------------------------------------
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //--------------------------------------------------------------contacto chems con PISO
  if ((_body1.getName() == "chem1" && _body2.getName() == "piso")
    || (_body2.getName() == "chem1" && _body1.getName() == "piso"))
  {
    if (chem1.visible)
    {
      chem1.explota();
      mundo.remove(chem1);
      contactoCaer=contactoCaer+1;
      fantasma1=true;
    }
  }

  if ((_body1.getName() == "chem2" && _body2.getName() == "piso")
    || (_body2.getName() == "chem2" && _body1.getName() == "piso"))
  {
    if (chem2.visible)
    {
      chem2.explota();
      mundo.remove(chem2);
      contactoCaer=contactoCaer+1;
      fantasma2=true;
    }
  }

  if ((_body1.getName() == "chem3" && _body2.getName() == "piso")
    || (_body2.getName() == "chem3" && _body1.getName() == "piso"))
  {
    if (chem3.visible)
    {
      chem3.explota();
      mundo.remove(chem3);
      contactoCaer=contactoCaer+1;
      fantasma3=true;
    }
  }  
  //--------------------------------------------------------------
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //--------------------------------------------------------------contacto chems con NUBE GRIS


  if ((_body1.getName() == "chem1" && _body2.getName() == "Gris")
    || (_body2.getName() == "chem1" && _body1.getName() == "Gris"))
  {
    if (chem1.visible)
    {
      image(rayos, 0, 0);
      chem1.electrocutar();
    }
  } 

  if ((_body1.getName() == "chem2" && _body2.getName() == "Gris")
    || (_body2.getName() == "chem2" && _body1.getName() == "Gris"))
  {
    if (chem2.visible)
    {
      image(rayos, 0, 0);
      chem2.electrocutar();
    }
  }

  if ((_body1.getName() == "chem3" && _body2.getName() == "Gris")
    || (_body2.getName() == "chem3" && _body1.getName() == "Gris"))
  {
    if (chem3.visible)
    {
      image(rayos, 0, 0);
      chem3.electrocutar();
    }
  }
  //--------------------------------------------------------------
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //--------------------------------------------------------------contacto chems con NUBE ROSA



  if ((_body1.getName() == "chem1" && _body2.getName() == "p")
    || (_body2.getName() == "chem1" && _body1.getName() == "p"))
  {
    if (chem1.visible)
    {

      chem1.reboteNormal();
    }
  }

  if ((_body1.getName() == "chem2" && _body2.getName() == "p")
    || (_body2.getName() == "chem2" && _body1.getName() == "p"))
  {
    if (chem2.visible)
    {

      chem2.reboteNormal();
    }
  }

  if ((_body1.getName() == "chem3" && _body2.getName() == "p")
    || (_body2.getName() == "chem3" && _body1.getName() == "p"))
  {
    if (chem3.visible)
    {

      chem3.reboteNormal();
    }
  }
//------------------------------p3


 if ((_body1.getName() == "chem1" && _body2.getName() == "p3")
    || (_body2.getName() == "chem1" && _body1.getName() == "p3"))
  {
    if (chem1.visible)
    {

      chem1.reboteNormal();
    }
  }

  if ((_body1.getName() == "chem2" && _body2.getName() == "p3")
    || (_body2.getName() == "chem2" && _body1.getName() == "p3"))
  {
    if (chem2.visible)
    {

      chem2.reboteNormal();
    }
  }

  if ((_body1.getName() == "chem3" && _body2.getName() == "p3")
    || (_body2.getName() == "chem3" && _body1.getName() == "p3"))
  {
    if (chem3.visible)
    {

      chem3.reboteNormal();
    }
  }


  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
}



void keyPressed() {

  if (pantalla == "juego") {
    if (key == 'q' || key == 'Q') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(0).j=true;
      }
    }
    if (key == 'w' || key == 'W') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(1).j=true;
      }
    }
    if (key == 'e' || key == 'E') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(2).j=true;
      }
    }
    if (key == 'r' || key == 'R') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(3).j=true;
      }
    }
    if (key == 'a' || key == 'A') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(4).j=true;
      }
    }
    if (key == 's' || key == 'S') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(5).j=true;
      }
    }
    if (key == 'd' || key == 'D') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(6).j=true;
      }
    }
    if (key == 'z' || key == 'Z') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(7).j=true;
      }
    }
    if (key == 'x' || key == 'X') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(8).j=true;
      }
    }
    if (key == 'c' || key == 'C') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(9).j=true;
      }
    }
    if (key == 'v' || key == 'V') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(10).j=true;
      }
    }
  }
}

void keyReleased()
{
  if (pantalla == "juego")
  {
    if (key == 'q' || key == 'Q') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(0).j=false;
      }
    }
    if (key == 'w' || key == 'W') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(1).j=false;
      }
    }
    if (key == 'e' || key == 'E') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(2).j=false;
      }
    }
    if (key == 'r' || key == 'R') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(3).j=false;
      }
    }
    if (key == 'a' || key == 'A') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(4).j=false;
      }
    }
    if (key == 's' || key == 'S') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(5).j=false;
      }
    }
    if (key == 'd' || key == 'D') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(6).j=false;
      }
    }
    if (key == 'z' || key == 'Z') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(7).j=false;
      }
    }
    if (key == 'x' || key == 'X') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(8).j=false;
      }
    }
    if (key == 'c' || key == 'C') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(9).j=false;
      }
    }
    if (key == 'v' || key == 'V') {
      for (int i = 0; i < plataformas.size(); i++)
      {
        plataformas.get(10).j=false;
      }
    }
  }
}


void reiniciar() {
  pantalla= "pantalla1";
  //tiempo
  temporizadorParaDibujo=1500; //si cambian temporizador cambien este
  temporizador=1500;
  limiteDeTiempo=0; 
  tiempoParaLoop1=0;
  tiempoParaLoop2=0;
  tiempoParaCaida = 0;
  //contadores
  contador=0;
  contactoCaer=0;
  //para que vuelvan a caer
  mundo.remove(chem1);
  mundo.remove(chem2);
  mundo.remove(chem3);
  //fantasma
  subidaFantasma1 = height-30 ;
  subidaFantasma2 = height-30 ;
  subidaFantasma3 = height-30 ;
  fantasma1=false;
  fantasma2=false;
  fantasma3=false;
  //música
  musicaPrevia.pause();
  musicaJuego.pause();
  musicaPerder.pause();
  musicaGanar.pause();

  musicaPrevia.rewind();
  musicaJuego.rewind();
  musicaPerder.rewind();
  musicaGanar.rewind();
}
