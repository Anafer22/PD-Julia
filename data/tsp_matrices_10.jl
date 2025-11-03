# Módulo para cargar los datos de la matríz del problema TSP-10.
module tsp_matrices_10
# El export hace que la funcion sea publica fuera del modulo
export tsp10_matrix

# Retorna la matriz de distancias fijas en una matriz simétrica para 10 ciudades.
function tsp10_matrix()::Matrix{Int} #Funcion que retorna una matriz de enteros
    return [
    # C1  C2  C3  C4  C5  C6  C7  C8  C9  C10
      0   12  29  22  13  25  17  28  33  21 ; # C1
      12   0  19  30  25  16  28  14  24  18 ; # C2
      29  19   0  15  28  27  14  20  23  17 ; # C3
      22  30  15   0  26  19  23  18  21  31 ; # C4
      13  25  28  26   0  12  19  22  27  16 ; # C5
      25  16  27  19  12   0  22  18  24  20 ; # C6
      17  28  14  23  19  22   0  16  20  25 ; # C7
      28  14  20  18  22  18  16   0  19  21 ; # C8
      33  24  23  21  27  24  20  19   0  23 ; # C9
      21  18  17  31  16  20  25  21  23   0  # C10
    ] #Matriz de la tabla de las 10 ciudades 
end
end #Fin del módulo