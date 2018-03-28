# Funcionamiento de run_analysis.R
Por: Fernanda Villeda
## Requisitos previos
El funcionamiento de run_analysis depende de los siguientes paquetes y variables. 
1. dplyr: para hacer algunas selecciones de columnas
2. data.table: para dar formato a los archivos leidos
3. reshape2: para organizar los datos de forma legible
4. path: para acceder a la carpeta de archivos
5. pathIn: Para acceder a los archivos dentro de las carpetas de train y test. 

## Merges the training and the test sets to create one data set.
La estructura de la informacion esta repartida en 70% de datos de entramiento(Train) y 30% de datos de prueba(Test). Cada carpeta contiene los siguientes archivos con su respectiva termincion indicativa. 
* subject: contiene la columna de los identificadores de los sujetos de investigación. 
* x: contiene los datos obtenidos para cada variable estudiada. 
* y: contiene el id de la actividad que el individuo realizaba en el momento de la lectura.

Para juntar los conjuntos, se construye primeramente la tabla **dtTrain** que contiene las columnas subject, activity y el conjunto de datos de x. Al leer cada archivo se asginaron nombres para evitar problemas de duplicidad en puntos siguientes. Y al final de combinan usando **cbind** debido a que solo necesitamos una combinacion simple. 
~~~
dtSubjectTrain <- read.table(file.path(pathIn, "train", "subject_train.txt"))
setnames(dtSubjectTrain,"V1","subject")
dtActivityTrain <- read.table(file.path(pathIn, "train", "Y_train.txt"))
setnames(dtActivityTrain,"V1","activity")
dtTrain <- read.table(file.path(pathIn, "train", "X_train.txt"))
dtTrain <- cbind(dtSubjectTrain,dtActivityTrain,dtTrain)
~~~
Despues se construye la tabla **dtTest** con el mismo codigo excepto que utilizaremos los archivos contenidos en la carpeta Test del fichero de datos del proyecto. Nuevamente se asignan nombres en cuanto se lee el archivo y por ultimo se combinan las columnas con la funcion **cbind** 
~~~
dtSubjectTest <- read.table(file.path(pathIn, "test", "subject_test.txt"))
setnames(dtSubjectTest,"V1","subject")
dtActivityTest <- read.table(file.path(pathIn, "test", "y_test.txt"))
setnames(dtActivityTest,"V1","activity")
dtTest <- read.table(file.path(pathIn, "test", "X_test.txt"))
dtTest <- cbind(dtSubjectTest,dtActivityTest,dtTest)
~~~
Por ultimo se construye el conjunto **dtTotal** que contendra los datos de ambos conjuntos. Utilizamos la funcion **rbind** para combinar por registros/filas. Observe que ambos conjuntos tienen el mismo numero de variables. En total se observan 10299 observaciones. 
~~~
dtTotal <- rbind(dtTrain,dtTest)
~~~

## Extracts only the measurements on the mean and standard deviation for each measurement.


## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
