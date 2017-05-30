# Master-Detail

Aquí encontrareis un ejemplo de una vista Master-Detail, que se puede ver horizontalmente desplegado.  
En este proyecto se utiliza: COCOAPOADS, SWIFTYJSON y ALAMOFIRE

1. Se pasan datos a través de Seague
2. La celda de las TableView - master y detail es cutomizada (CellPost.swift)
3. Se crean clases preparadas para recibir los datos de la API (ClassPosts ClassComments) y en sus contructores se puede pasar directamente el dictionary del objeto json.
4. En DetailViewController se crean dos secciones de tabla y se customiza la celda on fly.
5. Se genera un request dinamico a la API, dependiendo que objeto se haya seleccionado de el Master.
6. Se pueden añadir commentarios desde la barra del navegador.
7. Tambien hay pequeños arreglos visuales como: stacks / en Master se intente reducir un 50% el tamaño de la letra para que quepa el titulo, pero me habria gustado dedicarle más tiempo a estos aspectos a pesar de no ser solicitados. 
edit:  
+1 animación, autolayout y colores
