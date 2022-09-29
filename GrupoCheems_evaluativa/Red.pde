class Red extends FBox {
  Boolean goingRight;
  Red (float _w, float _h) {
    super(_w, _h); //llama al constructor de fbox directamente
  }

  void inicializar(float _x, float _y) {
    setPosition(_x, _y);
    setName("red"); //nombre para diferenciar cuando hagamos colisiones entre objetos
    setStatic(false);
    setRotatable(false);
    setGrabbable(false);
  }

  void actualizar() {
   if (getX() > width - 115)
    {
      goingRight = false; // si es mayor a 80 que vaya a la izquierda
    }  else if (getX() < 115) 
    {
      goingRight = true;
    }
    if (goingRight)
    {
      setVelocity(150, getVelocityY());
    } else
    {
      setVelocity(-150, getVelocityY());
    }
  }
}
