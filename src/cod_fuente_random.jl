# Módulo encargado de implementar programación dinámica (Held-Karp) para resolver el TSP con datos random.
module cod_fuente_random

# El export hace que la funcion sea publica fuera del modulo
export tsp_mat_random

""" La función tsp_mat_random resuelve el problema de TSP, matriz_n es la matriz de distancias NxN
y retorna una tupla que contiene el costo total minimo y la ruta óptima que es el vector
de indices de las ciudades.
"""

#ME GUIE DEL CODIGO ANTERIOR cod_fuente.jl PARA HACER ESTE CODIGO CON DATOS RANDOM
function tsp_mat_random(distancia_matriz::Matrix{Int})
    # Obtiene el numero de las ciudades, ya que pide el tamaño de la primera dimension (las filas)
    n  = size(distancia_matriz, 1)
    
""" Creamos un "cuaderno" de memoizacion (esto quiere decir que guardas o escribes lo que ya sabes 
por si te lo vuelven a preguntar y no tener que volver a calcularlo y hacer mas lento el codigo)
Donde Tuple{Int, Int}, es (ciudad_actual, mascara_visitados) y Tuple{Float64, Int} es el
(costo_minimo, siguiente_ciudad_optima). Usamos Float64 para el costo_minimo poder inicializarlo
con el valor Inf (infinito). 
"""
    memo = Dict{Tuple{Int, Int}, Tuple{Float64, Int}}()
    
"""Funcion interna la cual se encarga de tomar la ciudad actual (ciudad_u) y la mascara de las ciudades ya
 visitadas (ciudades_visitadas). Esta funcion calcula el costo minimo desde ciudad_u hasta ciudades_visitadas. """
    function tsp_recursive(u::Int, mascara::Int)

""" Si las ciudades_visitadas es igual a todos los bits encendidos (1 << n) - 1, crea una secuencia binaria de unos 
para n bits. Si hemos visitado todas las ciudades, regresa a casa y retorna el costo de ciudad_u a 1"""
        if mascara == (1 << n) - 1
            # Regresamos a la ciudad inicial (ciudad 1)
            return (distancia_matriz[u, 1], 1)
        end

""" Revisamos la memoizacion (PD), si ya hemos resuelto (ciudad_u, ciudades_visitadas) antes, devolvemos lo que ya
tenemos guardado"""
        if haskey(memo, (u, mascara))
            return memo[(u, mascara)]
        end
"""Paso recursivo, si no ha pasado la memoizacion, iniciamos la busqueda del costo minimo y la siguiente 
ciudad optima"""
        min_cost = Inf
        m_p_ciudad = -1

""" Inicia el ciclo para probar cada ciudad v (1 a n) como la siguiente ciudad a visitar desde ciudad_u """
        for v in 1:n
# Revisar si la ciudad 'v' NO ha sido visitada, si no ha sido visitada
            if (mascara & (1 << (v - 1))) == 0
# Crear una nueva máscara que es igual a la mascara antigua pero con el bit v encendido
                nueva_mascara = mascara | (1 << (v - 1))
                
""" Recursion, llama a la función de nuevo, y calcula el costo minimo si estoy en v y he visitado las
ciudades n_c_visitada"""
                (costo_desde_v, _) = tsp_recursive(v, nueva_mascara)
#Calcula el costo total de ir a ciudad_u a v  y + el costo desde v hasta el final  
                total_cost = distancia_matriz[u, v] + costo_desde_v

"""Compara el costo total con el costo minimo actual que teniamos, si es mejor, actualiza el costo minimo 
y guardamos en v como la siguiente ciudad optima"""
                if total_cost < min_cost
                    min_cost = total_cost
                    m_p_ciudad = v
                end
            end
        end

# Guardamos en el memo y retornamos
        memo[(u, mascara)] = (min_cost, m_p_ciudad)
        return (min_cost, m_p_ciudad)
    end

# Fin de la función recursiva
    ciudad_inicial = 1
# Máscara inicial: solo hemos visitado la ciudad C1
    mascara_inicial = (1 << (ciudad_inicial - 1))
    
#Inicia la recursion donde calculamos el costo total empezando desde la ciudad 1 (C1), esto llena el memo.
    (total_cost, _) = tsp_recursive(ciudad_inicial, mascara_inicial)

# Ahora que el memo esta lleno, reconstruimos la ruta optima siguiendo las decisiones guardadas en el memo 
    path = [ciudad_inicial]
    ciudad_actual = ciudad_inicial
    mascara = mascara_inicial

# Repetimos n veces hasta que la ruta tenga ya n ciudades. 
    while length(path) < n

# Obtenemos la siguiente ciudad optima desde el estado (ciudad_actual, ciudades_visitadas)
        (_, siguiente_ciudad) = memo[(ciudad_actual, mascara)]
        push!(path, siguiente_ciudad)

# Actualiza el estado para la siguiente iteracion, encendiendo el bit de la ciudad visitada
        mascara |= (1 << (siguiente_ciudad - 1))
        ciudad_actual = siguiente_ciudad
    end
# Añadir el regreso a la ciudad inicial para cerrar el ciclo
    push!(path, ciudad_inicial)

# Retornar el costo total (Int) y la ruta completa obtenida
    return (Int(round(total_cost)), path)
end
end