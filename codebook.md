# Codebook
Fue generado de manera simultanea con run_analysis.R.

## Variables 
Nombre | Descripcion
-- | --
path|  Directorio donde esta la funcion y la carpeta de archivos. 
pathIn| directorio actual + "UCI HAR Dataset". Para acceder sin cambiar el directorio actual a las carpetas Train y Test.
dtSubjectTrain | Contiene los datos dentro del archivo subject_train.txt
dtActivityTrain | Contiene los datos dentro del archivo y_train.txt
dtTrain | Contiene los archivos almacenados en X_train.txt y posteriormente la union entre las columnas de dtSubjectTrain, dtActivityTrain y dtTrain. 
dtSubjectTest | Contiene los datos dentro del archivo subject_test.txt
dtActivityTest | Contiene los datos dentro del archivo y_test.txt
dtTest | Contiene los archivos almacenados en X_test.txt y posteriormente la union entre las columnas de dtSubjectTest, dtActivityTest y dtTest. 
dtTotal | Contiene la combinacion de las tablas dtTrain y dtTest para hacer el conjunto total. 
dtFeatures | Contiene los nombres de las variables, del archivo features.txt. Posteriormente se minimiza a las variables que contienen mean y std. 
features | Contiene la columna de nombres de la varibles dtFeatures
dtMeanDevVar | Contiene la seleccion de registros en las columnas que indica la varible features. 
dtIds | Contiene la union entre las columnas subject y activity.
dtTotalVars | contiene el data frame Total al juntar dtIds y dtMeanDevVar
dtActNames | Contiene los nombres de las actividades y sus id. Informacion del archivo activity_labels.txt
act_group | Contiene los factores de la columna activity de la variable dtTotalVars
dtBase | Contiene el data frame a fundir. Es decir el resultante de todas las operaciones anteriores. 
dtTidy | Contiene el data frame resultante de ordenar dtBase con las variables subject activity y de obtener el mean de cada agrupacion. 

# dtTidy
Es el conjunto resultante del analisis. Se genera con el codigo contenido en la ultima parte de **run_analysis.R**.
~~~
dtTidy <- dcast(dtBase, subject + activity ~ variable, mean)
names(dtTidy)[-c(1:2)] <- paste("mean of" , names(dtTidy)[-c(1:2)] )
write.table(dtTidy, "tidy_dataSet.txt", sep = ",")
~~~
A continuacion se muestra una parte de la estructura. 
~~~
str(dtTidy)
~~~
~~~

'data.frame':	180 obs. of  68 variables:
 $ subject                            : int  1 1 1 1 1 1 2 2 2 2 ...
 $ activity                           : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ mean of tBodyAcc-mean()-X          : num  -0.187 -0.149 -0.226 -0.935 -0.979 ...
 $ mean of tBodyAcc-mean()-Y          : num  -0.0624 -0.0406 -0.1553 -0.9235 -0.9758 ...
 $ mean of tBodyAcc-mean()-Z          : num  -0.351 -0.319 -0.264 -0.952 -0.983 ...
 $ mean of tBodyAcc-std()-X           : num  0.405 0.388 0.373 -0.181 -0.295 ...
 $ mean of tBodyAcc-std()-Y           : num  0.238 -0.365 0.3671 0.0895 0.0784 
~~~


