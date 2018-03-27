##Requisitos previos, se cargan e instalan paquetes necesarios para el tratamiento de los datos
library(dplyr)
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
##Variables para entrar a las carpetas de contenido de los datos. Es importante mandar el directorio
##actual en la carpeta donde se encuentran los datos y el script run_analysis.R
path <- getwd()
pathIn <- file.path(path, "UCI HAR Dataset")

############################################# 1 #####################################################
##Leer los conjuntos de Subject, Activity y Data para la carpeta Train. 
##Se asignan nombres a las columnas para evitar problemas de duplicidad.
##Se combinan las columnas para crear el conjunto de datos de entranamiento
dtSubjectTrain <- read.table(file.path(pathIn, "train", "subject_train.txt"))
setnames(dtSubjectTrain,"V1","subject")
dtActivityTrain <- read.table(file.path(pathIn, "train", "Y_train.txt"))
setnames(dtActivityTrain,"V1","activity")
dtTrain <- read.table(file.path(pathIn, "train", "X_train.txt"))
dtTrain <- cbind(dtSubjectTrain,dtActivityTrain,dtTrain)

##Leer los conjuntos de Subject, Activity y Data para la carpeta Test
##Se asignan nombres a las columnas para evitar problemas de duplicidad.
##Se combinan las columnas para crear el conjunto de datos de prueba.
dtSubjectTest <- read.table(file.path(pathIn, "test", "subject_test.txt"))
setnames(dtSubjectTest,"V1","subject")
dtActivityTest <- read.table(file.path(pathIn, "test", "y_test.txt"))
setnames(dtActivityTest,"V1","activity")
dtTest <- read.table(file.path(pathIn, "test", "X_test.txt"))
dtTest <- cbind(dtSubjectTest,dtActivityTest,dtTest)

##Se crea el conjunto total al combinar los conjuntos creados anteriormente,
##ambos tienen el mismo numero de columnas, por lo que se realiza con rbind
dtTotal <- rbind(dtTrain,dtTest)

############################################# 2 #####################################################
##Leemos el archivo que contiene el nombre de las variables
##Extraemos los  registros que contienen las plabras mean y std y seleccionamos la columna de nombres
##Creamos un nuevo conjunto donde seleccionaremos del conjunto total los que corresponden a las variables
dtFeatures <- read.table(file.path(pathIn, "features.txt"))
setnames(dtFeatures, names(dtFeatures), c("featureNum","featureName"))
dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", dtFeatures$featureName),]
features <- dtFeatures[,2]
dtMeanDevVar <- dtTotal[,features]


############################################# 4 #####################################################
##Ponemos al conjunto creado el nombre de las variables que obtuvimos
##Obtenemos las 2 columnas faltantes, Subject y activity con selec y hacemos la combinacion con cbind
setnames(dtMeanDevVar,names(dtMeanDevVar),as.character(features))
dtIds <- select(dtTotal,subject,activity)
dtTotalVars <- cbind(dtIds,dtMeanDevVar)


############################################# 3 #####################################################
##Obtenemos los nombres de las actividades del archivo activity_labels.txt
##Nombramos el data set obtenido para facilitar la identificacion de las columnas. 
##Obtenemos los factores de la columna activity, para despues reemplazarlos en la misma con el nombre
##equivalente al numero
dtActNames <- read.table(file.path(pathIn, "activity_labels.txt"))
setnames(dtActNames,names(dtActNames),c("activityNum","activityName"))
act_group <- factor(dtTotalVars$activity)
levels(act_group) <- dtActNames[,2]
dtTotalVars$activity <- act_group


############################################# 5 #####################################################
dtBase <- melt(dtTotalVars,(id.vars=c("subject","activity")))
dtTidy <- dcast(dtBase, subject + activity ~ variable, mean)
names(dtTidy)[-c(1:2)] <- paste("mean of" , names(dtTidy)[-c(1:2)] )
write.table(dtTidy, "tidy_data.txt", sep = ",")