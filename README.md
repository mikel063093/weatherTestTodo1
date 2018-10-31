# Weather iOS TEST
Basado en la arquitectura CleanSwift, para un desacople de dependencias.

# Environment
Cocoapods version 1.5.3
Swift 4.3
Xcode 10.0

## Capas

| Capa | Descripción |
| ------ | ------ |
| model | permite el acceso y gestion a los datos ya sean locales(Realm) o externos(Api rest)
| presenter | contiene las clases de logica del negocio, permitiendo separar la vista de la logica |
| ui | contiene las clases de vista
| event | contiene los mensajes  a transmitir entre los diferentes servicios de la app
| bus | permite enviar los eventos a diferentes componentes de la app

# Librerias usadas

- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftEntryKit](https://github.com/huri000/SwiftEntryKitt)
- [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)


