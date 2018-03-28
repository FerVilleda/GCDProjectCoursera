path: Directorio donde esta la funcion y la carpeta de archivos. 
pathIn: directorio actual + "UCI HAR Dataset". Para acceder sin cambiar el directorio actual a las carpetas Train y Test. 
dtSubjectTrain: Contiene los datos dentro del archivo subject_train.txt
dtActivityTrain: Contiene los datos dentro del archivo subject_test.txt
dtTrain: Contiene los archivos almacenados en X_train.txt y posteriormente la union entre las columnas de dtSubjectTrain, dtActivityTrain y dtTrain. 
