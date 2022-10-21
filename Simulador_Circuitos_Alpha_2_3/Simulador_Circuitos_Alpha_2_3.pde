  /*
|-------------------------------//-------------------------------|
|  Simulador de Circuitos - Alpha 2.3   (20/10/2022)             |
|  Proyecto Independiente                                        |
|                                                                |
|  Desarrolladores:                                              |
|                  - Juan David Maestre                          |
|                  - Sebastián Maldonado                         |
|                  - Jaime Vergara 
|                  - Yordi González
|-------------------------------//-------------------------------|
 
  Descripción de versión:
      
*/

//---------------------------------------------------------------------------\\
//                            |Variables Globales|                           \\
//---------------------------------------------------------------------------\\
import java.util.*;
import org.apache.commons.math3.linear.*;
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
