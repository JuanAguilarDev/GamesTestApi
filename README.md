# Proyecto GamesApi

## Descripcion del proyecto
El proyecto tiene como finalidad el mostrar un listado de juegos mediante el cual el usuario podra acceder a un catologo de información sobre distintos
videjuegos, el usuario podra interactuar con la información del listado e incluso eliminar los elementos presentes.

### Características actuales

- Lista de videojuegos con vista en cuadrícula
- Vista de detalle para cada juego
- Permite editar la descripción de cada juego
- Persistencia local con SwiftData
- Carga de datos con Alamofire mediante el consumo de la API
- Permite eliminar los juegos almacenados
- Manejo de errores
- Permite filtrar juegos por categoria o género

### 🛠 TODO

- [ ] Crear un manejador de async images que impida el renderizado ocasional
- [ ] Agregar pantallas de loading cuando haya proceso mas complejos
- [ ] Optimizar el codigo en forma de variables para una mayor claridad
- [ ] Agregar una sección de perfil
- [ ] Agregar una paginación

## 📱 Tecnologías utilizadas

- [x] Swift 6
- [x] SwiftUI
- [x] MVVM Architecture
- [x] SwiftData
- [x] Async/Await
- [x] Xcode 16+
- [x] iOS 18+

### Dependencias (SPM)

- [x] Alamofire 5.10.2
- [x] Lottie 4.5.2

### Justificación de las tecnologias utilizadas

- **Swift 6**: Aprovechar de la mejor manera las nuevas funcionalidades de swift, principalmente la concurrencia (manejo de los hilos de la app) y los actores.
- **SwiftUI**: Utilizar el framework visual más reciente que nos ofrece swift para aprovechar sus virtudes.
- **MVVM Architecture**: Mejora la organización y visualización de la implementación del código, además de mantener la logica separada.
- **SwiftData**: Permite almacenar los datos de manera local de una forma más sencilla y permite una mejor manipulación de los datos.
- **Async/Await**: Permite manejar la lógica de red, I/O, y actualización de estado asincrónica de manera legible y mantenible, además de que ahorra problemas de concurrencia como data races y dead locks.
- **Xcode 16.2**: Una de las versiones actuales más estables para xcode.
- **iOS 18+**: Aprovechar las virtudes de la versión más reciente de iOS antes del lanzamiento del iOS26
- **Alamofire**: Realmente no tengo una justificación real sobre el uso de alamofire, simplemente quería volver a usarlo en una aplicación porque me parece más legible aunque sea de terceros.
- **Lottie**: Presentación de animaciones de manera sencilla.
- **SPM**: Es más rápido, más limpio, no requiere herramientas externas, y se mantiene por Apple.


## 📦 Estructura del proyecto
```text
GamesTestApi/
├── Coordinator/
├── Models/
├── Resources/
├── Shared/
├── Views/
├── WebServices/
├── Assets.xcassets
├── GamesTestApiApp.swift
└── GamesTestApiTests/
```

## 🧠 Arquitectura

El proyecto sigue una arquitectura **MVVM**:

- `Model`: Define las estructuras de datos.
- `ViewModel`: Maneja la lógica de negocio y estado.
- `View`: Interfaces de usuario construidas con SwiftUI.
- `Service`: Capa de red y persistencia (como API o SwiftData).

## ⚙️ Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tuusuario/GameCatalogApp.git
