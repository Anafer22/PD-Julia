# Módulo para cargar los datos de la matríz n del problema de TSP
module tsp_matriz_random
# Necesario para la generación de datos aleatorios y la semilla
using Random 
# El export hace que la funcion sea publica fuera del modulo
export tsp_matrix

# funcion principal que retorna la matriz de distancias simetrica y aleatoria
function tsp_matrix(semilla::Int; n_ciudades::Int = 5, rango_maximo::Int = 100)::Matrix{Int}
# Fijar la semilla aleatoria
    Random.seed!(semilla)

# Inicializar matriz de ceros
    matriz = zeros(Int, n_ciudades, n_ciudades)

"""En lugar de recorrer cada celda (i, j) de la matriz, esto solo recorre el triángulo superior, sin 
incluir la diagonal. Esto evita hacer trabajo doble (calcular C1->C2 y C2->C1) y evita la diagonal
(C1->C1)"""
    for i in 1:n_ciudades
        for j in (i + 1):n_ciudades

# Distancia entre 0 y rango_maximo (100)
            distancia = rand(0:rango_maximo)
# Matriz simétrica
            matriz[i, j] = distancia
            matriz[j, i] = distancia 
        end
    end
    return matriz
end
end #Fin del módulo