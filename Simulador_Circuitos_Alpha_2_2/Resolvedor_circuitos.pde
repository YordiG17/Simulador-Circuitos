/*
|====================================================================|
*                      |Resolvedor de Circuitos|     
*                          (Clase estática)
* Descripción:                                                        
*   Clase utilizada para 
|====================================================================|
*/

public static class Resolvedor_circuitos {
  
  public static ArrayList<Circuito> obtenerMallas () {
    return null;
  }
  
  public static Circuito dijkstra (Circuito circuito, Nodo raiz) {
    //Circuito malla = new Circuito ();
    
    PriorityQueue<Nodo> cola = new PriorityQueue<Nodo>();
    
    ArrayList<Nodo> nodos = circuito.obtenerNodos();
    float[] distancia = new float [nodos.size()];
    Nodo[] previo = new Nodo [nodos.size()];
    
    ArrayList<Nodo> visitados = nodos;
    ArrayList<Nodo> no_visitados = new ArrayList<Nodo>();  
    
    for (int i = 0; i < nodos.size(); i++) {      
      if (nodos.get(i) == raiz) {
        cola.add(nodos.get(i));
        distancia[i] = 0;
        continue;
      }
        
      distancia[i] = 100;
      previo[i] = null;
      cola.add(nodos.get(i));
    }
    
    
    //Mientras no se vacíe la cola
    while (cola.size() > 0) {
      Nodo nodo = cola.remove();
      ArrayList<Nodo> vecinos = nodo.obtenerVecinos();
      
      for (Nodo n : vecinos) {
        if (visitados.contains(n))    //Si el nodo ya fue visitado
          continue;
          
        float temp = distancia[nodos.indexOf(n)] + 1;
        
        if (temp < distancia[nodos.indexOf(n)]) {
        }
      }
    }
    
    
    
    
    return null;
  }
  
}
