# Master-Detail

Aquí encontrareis un ejemplo de una vista Master-Detail, que se puede ver horizontalmente desplegado.
En este proyecto se utiliza: COCOAPOADS, SWIFTYJSON y ALAMOFIRE

1. Se pasan datos a través de Seague
2. La celda del TableView - master es cutomizada (CellPost.swift)
3. Se crean clases preparadas para recibir los datos de la API (ClassPosts ClassComments) en los contructores se puede pasar directamente el dictionary del json.
4. En DetailViewController se crean dos secciones y se vuelve a utilizar una tableview con celdas prediseñadas de subtitle y se las customiza on fly.
5. Se genera un request dinamico a la API, dependiendo que objeto se haya seleccionado de el Master.
6. Se pueden añadir commentarios desde la barra del navegador.

