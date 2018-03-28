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
Leemos el archivo **features.txt** que contiene los nombres de las variables de los datos de x. Es decir las variables observadas, y asignamos nombres a las columnas para que sean facilmente identificables. 
~~~
dtFeatures <- read.table(file.path(pathIn, "features.txt"))
setnames(dtFeatures, names(dtFeatures), c("featureNum","featureName"))
~~~
Utilizando una expresion regular obtendremos las variables que contienen la palabra mean o std en el nombre, y las seleccionmos en **dtFeatures**. Obtenemos la columna que contiene el nombre y lo guardamos en un vector de nombre **features**
~~~
dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", dtFeatures$featureName),]
features <- dtFeatures[,2]
~~~
Seleccionamos y asignamos a la variable **dtMeanDevVar** los registros de dtTotal en las columnas que corresponden a features. Le asignamos los nombres correspondientes.  
~~~
dtMeanDevVar <- dtTotal[,features]
setnames(dtMeanDevVar,names(dtMeanDevVar),as.character(features))
~~~
Sacamos las columnas de subject y activity para unirlas al conjunto anterior. Obtenemos el conjunto **dtTotalVars**
~~~
dtIds <- select(dtTotal,subject,activity)
dtTotalVars <- cbind(dtIds,dtMeanDevVar)
~~~

## Uses descriptive activity names to name the activities in the data set
Para obtener los nombres de las actividades leemos el archivo **activity_labels.txt**, nuevamente asignamos nombres para evitar problemas y para hacer identificable el contenido del archivo. 
~~~
dtActNames <- read.table(file.path(pathIn, "activity_labels.txt"))
setnames(dtActNames,names(dtActNames),c("activityNum","activityName"))
~~~
Obtenemos las actividdes de la columna activity de **dtTotalVars** que es el data table que contiene lo hecho anteriormente. Obtenemos los niveles de **act_group** con ayuda de la columna 2 de **dtActNames**. Finalmente asignamos lo realizado a la columna **activity** para hacer que los id se identifiquen con el nombre correspondiente al ser reemplazados. 
~~~
act_group <- factor(dtTotalVars$activity)
levels(act_group) <- dtActNames[,2]
dtTotalVars$activity <- act_group
~~~

## Appropriately labels the data set with descriptive variable names
Este paso se realiza en el segundo punto de este manual. Se asginan los nombres de las variables al conjunto con ayuda del vector que obtuvimos al leer el archivo **features.txt** 
~~~
setnames(dtMeanDevVar,names(dtMeanDevVar),as.character(features))
~~~

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
