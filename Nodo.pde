/*
|====================================================================|
*                               |Nodo|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Nodo {
  private String nombre;              //Nombre del Nodo
  private int pos_x, pos_y;         //Posición del Nodo en el plano
  private ArrayList<Ramal> ramales;   //Ramales que conecta el Nodo
  
  public Nodo (String nombre, int x, int y) {
    this.ramales = new ArrayList<Ramal>();
    this.nombre = nombre;
    this.pos_x = x;
    this.pos_y = y;
  }
  
  //-------------------------|Agregar Ramal|-------------------------\\
  public void agregarRamal (Ramal ramal) {
    this.ramales.add(ramal);
  }
  
  //-------------------------|Eliminar Ramal|-------------------------\\
  public void eliminarRamal (Ramal ramal) {
    for (int i = 0; i < this.ramales.size(); i++)    //Eliminar Ramal a Eliminar
      if (ramal == this.ramales.get(i)) {
        println(this.ramales.get(i));
        this.ramales.remove(i);
        return;
      }
  }
  
  //-------------------------|Mostrar Nodo|-------------------------\\
  public void mostrar (Motor_grafico motor) {
    motor.mostrar("Nodo", this.pos_x - 50, this.pos_y - 50, 100, 100);
  }
  
  //-------------------------|Mostrar Nodo Seleccionado|-------------------------\\
  public void mostrarAreaSeleccion (int rad, Motor_grafico motor) {
    motor.mostrarCirculo(this.pos_x, this.pos_y, rad);
  }
  
  //-------------------------|Siguiente Nodo|-------------------------\\
  public Nodo siguiente (Ramal ramal) {
    return ramal.siguienteNodo(this);
  }
  
  //-------------------------|Obtener Ramales|-------------------------\\
  public ArrayList<Ramal> obtenerRamales () {
    return this.ramales;
  }
  
  //-------------------------|Obtener Posición en X|-------------------------\\
  public int obtenerPosX () {
    return this.pos_x;
  }
  
  //-------------------------|Obtener Posición en Y|-------------------------\\
  public int obtenerPosY () {
    return this.pos_y;
  }
  
  //-------------------------|Modificar Posiciones|-------------------------\\
  public void modificarPos (int x, int y) {
    this.pos_x = x;
    this.pos_y = y;
  }
  
  //-------------------------|Obtener Nombre|-------------------------\\
  public String obtenerNombre () {
    return this.nombre;
  }
}
