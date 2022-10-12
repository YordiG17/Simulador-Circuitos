  /*
|-------------------------------//-------------------------------|
|  Simulador de Circuitos - Alpha 1.0   (10/10/2022)             |
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
  Nodo nodo1 = new Nodo("a", 1000, 0);
  Nodo nodo2 = new Nodo("b", 1000, 1000);
  Nodo nodo3 = new Nodo("c", 2000, 2000);
  
  circuito.agregarNodo(nodo1);
  circuito.agregarNodo(nodo2);
  circuito.agregarNodo(nodo3);
  circuito.agregarRamal(new Ramal(nodo1, nodo2));
  circuito.agregarRamal(new Ramal(nodo2, nodo3));
  circuito.agregarRamal(new Ramal(nodo1, nodo3));
}


void draw() {
  interfaz.mostrarAreaTrabajo();
  circuito.visualizar(interfaz.motor);
  interfaz.detectarSeleccion(mouseX, mouseY, 100, circuito);
}

//---------------------------------------------------------------------------\\
//                            |Eventos del Ratón|                            \\
//---------------------------------------------------------------------------\\
void mousePressed() {
  interfaz.armarCircuito(mouseX, mouseY, circuito);
}

//---------------------------------------------------------------------------\\
//                           |Eventos del Teclado|                           \\
//---------------------------------------------------------------------------\\
void keyPressed() {
  interfaz.motor.mover();
  interfaz.seleccionarModo(key);
}
