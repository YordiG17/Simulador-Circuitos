  /*
|-------------------------------//-------------------------------|
|  Simulador de Circuitos - Alpha 2.1   (14/10/2022)             |
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
Interfaz interfaz;


void setup() {
  fullScreen();
  interfaz =  new Interfaz(width, height);
  interfaz.inicializarMotor();
}


void draw() {
  interfaz.visualizar(mouseX, mouseY);
}

//---------------------------------------------------------------------------\\
//                            |Eventos del Ratón|                            \\
//---------------------------------------------------------------------------\\
void mousePressed() {
  if (mouseButton == LEFT)
    interfaz.clickIzquierdo(mouseX, mouseY);
  
  if (mouseButton == RIGHT)
    interfaz.clickDerecho(mouseX, mouseY);
}

//---------------------------------------------------------------------------\\
//                           |Eventos del Teclado|                           \\
//---------------------------------------------------------------------------\\
void keyPressed() {
  interfaz.presionarTecla(key);
}
