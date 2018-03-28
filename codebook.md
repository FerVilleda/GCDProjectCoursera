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




