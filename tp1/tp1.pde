import processing.net.*; //<>//
import oscP5.*; 
OscP5 osc; 

// -- VARIABLES GLOBALES DE CALIBRACIÓN --
float Umbral_Amplitud = 25; 
float Umbral_Ruido = 280;

float minimaIntensidad = 55; //amplitud
float maximaIntensidad = 75; 

float minimaAltura = 20; // pitch, graves y agudos
float maximaAltura = 70; 

float MINIMO_TRAZO = 1;
float MAXIMO_TRAZO = 20;

float amortiguacion = 0.9; 

GestorSenial intensidad; //amp
GestorSenial altura; // pitch

//-- Estados
boolean haySonido = false;
boolean antesHabiaSonido = false;

//--Eventos de inicio y fin del sonido
boolean empezoElSonido = false; //momento preciso en que el sonido pasa por sobre umbral
boolean terminoElSonido = false;

float amp = 0;
float pitch = 0;
int ruido = 0;

boolean monitor = false;

float variacion = 2; //variación angular en grados

PImage[] fondos = new PImage [4];

ArrayList <Caminante> caminantes;

Paleta[] p;

void setup () {
  size(700, 950);

  osc = new OscP5 (this, 12345); //inicializo el objeto

  intensidad = new GestorSenial( minimaIntensidad, maximaIntensidad, amortiguacion ); 
  altura = new GestorSenial( minimaAltura, maximaAltura, amortiguacion );

  for (int i=0; i<fondos.length; i++) {
    fondos[i] = loadImage ("fondo"+i+".png");
  }

  p = new Paleta [4];

  p[0] = new Paleta("img0.jpg"); 
  p[1] = new Paleta("img1.jpg");
  p[2] = new Paleta("img2.jpg");
  p[3] = new Paleta("img3.jpg");

  caminantes = new ArrayList<Caminante>();

  image(fondos[0], 0, 0, width, height);
}

void draw() {  
  intensidad.actualizar( amp );
  altura.actualizar( pitch );

  //Estado
  haySonido = intensidad.filtradoNorm() > 0.2; //la señal filtrada y normalizada

  //Eventos de inicio y fin del sonido
  empezoElSonido = haySonido && !antesHabiaSonido; //momento preciso en que el sonido pasa por sobre umbral

  if (monitor) {
    intensidad.imprimir( 100, 100, 400, 200);
    altura.imprimir( 100, 350, 400, 200);
  }

  if ((empezoElSonido) && (ruido < Umbral_Ruido)) {
    for (int i =0; i<3; i++) {
      caminantes.add(new Caminante(p[3].darUnColor(), -4, random (height), 0)); //izquierda
      caminantes.add(new Caminante(p[3].darUnColor(), random (width), 1004, 270)); //abajo
      caminantes.add(new Caminante(p[3].darUnColor(), random (width), -5, 90)); //arriba
      caminantes.add(new Caminante(p[3].darUnColor(), 705, random(height), 180)); //derecha
    }
  }

  //estado de haber sonido
  if ( haySonido ) {
    for (Caminante c : caminantes) {
      c.actualizar( intensidad.filtradoNorm(), altura.derivadaNorm() ); //señal filtrada y ademas normalizada (mover está dentro de actualizar)
      c.dibujar();
      c.girar(altura.derivadaNorm()* variacion);
    }
  }

  if (ruido > Umbral_Ruido  ) {
     for (int i =0; i<4; i++) {
      int index = int (random(i, p.length));
      caminantes.add(new Caminante(p[index].darUnColor()));
     }
    
    int index = int (random(0, fondos.length));
    image(fondos[index], 0, 0, width, height);    

    for (Caminante c : caminantes) {
      c.borrarCaminantes(-4, random(height));
    }
    for (Caminante c : caminantes) {
      c.borrarCaminantes(random (width), 904);
    }
    for (Caminante c : caminantes) {
      c.borrarCaminantes(random (width), -4);
    }
    for (Caminante c : caminantes) {
      c.borrarCaminantes(704, random (height));
    }
  }
  antesHabiaSonido = haySonido;                                
}


//----Funciones de entrada----
void oscEvent( OscMessage m) {
  if (m.addrPattern().equals("/amp")) { 
    amp = m.get(0).floatValue();        
  } 
  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
  }
  if (m.addrPattern().equals("/ruido")) { 
    ruido = m.get(0).intValue();          
  }

  println (m);
}
