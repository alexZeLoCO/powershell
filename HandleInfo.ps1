# ------------------ Descripción general del cometido del script -----------------
#
# El objetivo de este script es generar un fichero informativo que liste todos los
# procesos ordendos por el número de handles abiertos. El listado se organiza
# en tres tramos. En el primer tramo se imprimen los procesos entre 0 y 100 handles,
# en el segundo tramo, entre 101 y 1000 handles, y en el tercer tramo los
# que utilizan más de 1000.
# El nombre del fichero en el que se genera el informe es introducido por
# consola.
# El fichero generado se almacena en el directorio C:\Temp. Si este directorio no
# existe, se aborta la ejecución del script.
# --------------------------------------------------------------------------------
# Comprobación de la existencia del directorio C:\Temp. Si este directorio no
# existe se envía un mensaje a la consola indicado el problema y se aborta la
# ejecución del script


# Solicitar el nombre del fichero de salida y cargarlo en la variable $Fichero

$Fichero = Read-Host "Introduce el archivo de salida"

# Generación de una línea en blanco en la consola

Write-Host

# Guardar en el array $Procesos todos los procesos en ejecución
# ordenados por su número de handles

$procesos = Get-Process | sort -Property Handles

# Creación del fichero informativo
######## Procesos entre 0 y 100 ########
# Escribir en el fichero el intervalo de procesos

Add-Content $Fichero -Value "######### Procesos entre 0 y 100 handles #########"
Add-Content $Fichero -Value " "

# Escribir en el fichero una cabecera apropiada para la tabla de procesos

Add-Content $Fichero -Value (“{0, -25} {1, -25} {2, 25}” -f “ID”, “Nombre”, “Handles”)
Add-Content $Fichero -Value "==================================================";

# Escribir en el fichero informativo los procesos cuyo Nº de handles se encuentre
# entre 0 y 100. Para ello, se utilizará un bucle foreach.
# Dentro del cuerpo del bucle se generará en la variable $Linea la información
# correspondiente a cada proceso. Se utilizará formateo extendido de cadenas
# para formatear cada línea apropiadamente.


foreach($proceso in $procesos){

    if ($proceso.HandleCount -lt 100){

        $a = $proceso.id
        $b = $proceso.Name
        $c = $proceso.HandleCount 

        $linea = (‘{0, -20} {1,-20} {2, 25}’ –f $a, $b, $c)

        Add-Content $Fichero -Value $linea

    }

}

Add-Content $Fichero -Value " "
              
#Universidad de Oviedo / Dpto. de Informática 8
######## Procesos entre 101 y 1000 ########
# Escribir en el fichero el intervalo de procesos

Add-Content $Fichero -Value "######### Procesos entre 100 y 1000 handles #########"
Add-Content $Fichero -Value " "

# Escribir en el fichero una cabecera apropiada para la tabla de procesos

Add-Content $Fichero -Value (“{0, -25} {1, -25} {2, 25}” -f “ID”, “Nombre”, “Handles”)
Add-Content $Fichero -Value "==================================================";


# Escribir en el fichero informativo los procesos cuyo Nº de handles se encuentre
# entre 101 y 1000.



foreach($proceso in $procesos){

    if ($proceso.HandleCount -gt 100 -and $proceso.HandleCount -lt 1000){


        $a = $proceso.id
        $b = $proceso.Name
        $c = $proceso.HandleCount 

        $linea = (‘{0, -20} {1,-20} {2, 25}’ –f $a, $b, $c)

        Add-Content $Fichero -Value $linea

    }

}

Add-Content $Fichero -Value " "



######## Procesos con más de 1000 handles ########




# Escribir en el fichero el intervalo de procesos

Add-Content $Fichero -Value "######### Procesos con más de 1000 handles #########"

Add-Content $Fichero -Value " "

# Escribir en el fichero una cabecera apropiada para la tabla de procesos

Add-Content $Fichero -Value (“{0, -25} {1, -25} {2, 25}” -f “ID”, “Nombre”, “Handles”)
Add-Content $Fichero -Value "==================================================";


# Escribir en el fichero informativo los procesos cuyo Nº de handles sea mayor de 1000

foreach($proceso in $procesos){

    if ($proceso.HandleCount -gt 1000){

        $a = $proceso.id
        $b = $proceso.Name
        $c = $proceso.HandleCount 

        $linea = (‘{0, -20} {1,-20} {2, 25}’ –f $a, $b, $c)

        Add-Content $Fichero -Value $linea

    }

}