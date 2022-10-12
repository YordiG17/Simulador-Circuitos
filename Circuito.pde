/*
|====================================================================|
*                             |Circuito|         
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public class Circuito {
  
  private ArrayList<Nodo> nodos;      //Lista de Nodos en el Circuito
  private ArrayList<Ramal> ramales;   //Lista de Ramales en el Circuito
  
  public Circuito () {
    this.nodos = new ArrayList<Nodo>();
    this.ramales = new ArrayList<Ramal>();    
  }
  
  //---------------------------------------------------------------------------\\
  //                        |Construcción del Circuito|                        \\
  //---------------------------------------------------------------------------\\
  
  //-------------------------|Agregar Nodo|-------------------------\\
  public void agregarNodo (Nodo nodo) {
    this.nodos.add(nodo);
  }
  
  //-------------------------|Agregar Ramal|-------------------------\\
  public void agregarRamal (Ramal ramal) {
    this.ramales.add(ramal);
  }
  
  //-------------------------|Eliminar Ramal|-------------------------\\
  public void eliminarRamal (Ramal ramal) {
    for (int i = 0; i < this.ramales.size(); i++) {
      if (ramal == this.ramales.get(i)) {
        eliminarNodo(this.ramales.get(i), this.ramales.get(i).obtenerNodo1());
        eliminarNodo(this.ramales.get(i), this.ramales.get(i).obtenerNodo2());
        this.ramales.remove(i);
        return;
      }
    }
  }
  
  //-------------------------|Eliminar Nodo|-------------------------\\
  private void eliminarNodo (Ramal ramal, Nodo nodo) {      
    if (nodo.obtenerRamales().size() > 1) {    //Si el Nodo tiene más ramales, no eliminarlo
      nodo.eliminarRamal(ramal);
      return;
    }
      
    for (int i = 0; i < this.nodos.size(); i++)
      if (nodo == this.nodos.get(i)) {
        this.nodos.remove(i);
        return;
      }
  }
  
  //---------------------------------------------------------------------------\\
  //                         |Obtención de Componentes|                        \\
  //---------------------------------------------------------------------------\\
  
  //-------------------------|Obtener Nodos|-------------------------\\
  public ArrayList<Nodo> obtenerNodos () {
    return this.nodos;
  }
  
  //-------------------------|Obtener Ramales|-------------------------\\
  public ArrayList<Ramal> obtenerRamales () {
    return this.ramales;
  }
  
  
  //---------------------------------------------------------------------------\\
  //                           |Utilidades Gráficas|                           \\
  //---------------------------------------------------------------------------\\
  
  //-------------------------|Visualización del Circuito|-------------------------\\
  public void visualizar (Motor_grafico motor) {
    //for (int i = 0; i < this.nodos.size(); i++)    //Mostrar todos los Nodos
      //this.nodos.get(i).mostrar(motor);
    
    for (int i = 0; i < this.ramales.size(); i++)  //Mostrar todos los Cables
      this.ramales.get(i).mostrar(motor);
  }
}
