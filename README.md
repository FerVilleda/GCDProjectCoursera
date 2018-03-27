# Getting and Cleaning Data Project 
Por: Fernanda Villeda

## Objetivo y descripcion del proyecto

El objetivo de este proyecto es aplicar los conocimientos aprendidos durante el curso Getting and Cleaning Data de Coursera. El conjunto de datos dado por los facilitadores, debe ser preparado y limpiado para ser utilizado en un analisis posterior. A continuacion se muestra un parrafo que explica el origen de los datos a utilizar. 
Los experimentos se llevaron a cabo con un grupo de 30 voluntarios dentro de un grupo de edad de 19-48 años. Cada persona realizó seis actividades (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) usando un teléfono inteligente (Samsung Galaxy S II) en la cintura. Usando su acelerómetro y giroscopio integrados, capturamos la aceleración lineal de 3 ejes y la velocidad angular de 3 ejes a una velocidad constante de 50Hz. Los experimentos han sido grabados en video para etiquetar los datos manualmente. El conjunto de datos obtenido se ha dividido aleatoriamente en dos conjuntos, donde el 70% de los voluntarios se seleccionó para generar los datos de entrenamiento y el 30% de los datos de prueba.

## Pasos para ejecutar el proyecto
1. Abre el archivo **run_analysis.R** que esta en la carpeta de este proyecto
2. Envia el directorio donde esta almacenado el script mencionado anteriormente a la variable **setwd** que se encuentra al inicio. 
3. ejecuta el script, este se encargara de cargar los paquetes necesarios para su ejecucion correcta. 

## Input y Output de la función
* Entrada: La funcion toma los archivos dentro del directorio "UCI HAR Dataset", esta carpeta se obtiene al descomprimir el archivo del siguiente link [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* Salida: Produce el archivo tidy_data.txt que contiene el conjunto de datos procesado y ordenado para posterior analisis. 

**Nota: el reporsitorio contiene un archivo (run_analysis.md) que describe el funcionamiento exacto de la funcion, ademas del archivo R de la misma.**
