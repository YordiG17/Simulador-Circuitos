  /*
|-------------------------------//-------------------------------|
|  Simulador de Circuitos - Alpha 2.0   (13/10/2022)             |
|  Proyecto Independiente                                        |
|                                                                |
|  Desarrolladores:                                              |
|-------------------------------//-------------------------------|
 
  Descripción de versión:
      
*/

//---------------------------------------------------------------------------\\
//                            |Variables Globales|                           \\
//---------------------------------------------------------------------------\\
import java.util.ArrayList;
Interfaz interfaz = new Interfaz();
Circuito circuito = new Circuito();


void setup() {
  fullScreen();
  interfaz.motor.inicializar();
  Nodo nodo1 = new Nodo("a", 1000, 1000);
  Nodo nodo2 = new Nodo("b", 2000, 1000);
  Nodo nodo3 = new Nodo("c", 1000, 2000);
  Nodo nodo4 = new Nodo("d", 2000, 2000);
  
  circuito.agregarNodo(nodo1);
  circuito.agregarNodo(nodo2);
  circuito.agregarNodo(nodo3);
  circuito.agregarNodo(nodo4);
  circuito.agregarRamal(new Ramal(nodo1, nodo2));
  circuito.agregarRamal(new Ramal(nodo2, nodo4));
  circuito.agregarRamal(new Ramal(nodo4, nodo3));
  circuito.agregarRamal(new Ramal(nodo3, nodo1));
}


void draw() {
  interfaz.mostrarAreaTrabajo(circuito);
  interfaz.detectarSeleccion(mouseX, mouseY, circuito);
  interfaz.mostrarVistaPrevia(mouseX, mouseY, circuito);
}

//---------------------------------------------------------------------------\\
//                            |Eventos del Ratón|                            \\
//---------------------------------------------------------------------------\\
void mousePressed() {
  if (mouseButton == LEFT)
    interfaz.armarCircuito(mouseX, mouseY, circuito);
  
  if (mouseButton == RIGHT)
    interfaz.cambiarOrientacion();
}

//---------------------------------------------------------------------------\\
//                           |Eventos del Teclado|                           \\
//---------------------------------------------------------------------------\\
void keyPressed() {
  interfaz.motor.mover();
  interfaz.seleccionarModo(key);
}
