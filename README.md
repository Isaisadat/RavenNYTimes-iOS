# RavenNYTimes

Aplicación iOS desarrollada en SwiftUI que consume artículos de la API de The New York Times.

---

## Descripción

RavenNYTimes es una aplicación que muestra una lista de artículos obtenidos desde la API de NYTimes. La app implementa persistencia local para permitir el acceso a la información incluso sin conexión a internet.

El proyecto está estructurado utilizando **Clean Architecture** junto con el patrón **MVVM**, con el objetivo de mantener una clara separación de responsabilidades, facilitar la escalabilidad y permitir la integración de pruebas de manera sencilla.

---

## Características

* Consumo de API (NYTimes)
* Persistencia local con Core Data
* Soporte offline (offline-first)
* Arquitectura limpia (Clean Architecture)
* Patrón MVVM
* Interfaz desarrollada con SwiftUI

---

## Arquitectura

La aplicación sigue un enfoque basado en capas:

* **Presentation:** SwiftUI Views + ViewModels
* **Domain:** Use Cases
* **Data:** Repository, API Service y Core Data

Flujo de datos:

View → ViewModel → UseCase → Repository → API / Core Data

---

## Requisitos

* Xcode 14.2 o superior
* iOS 15.6 o superior

---

## Instalación

1. Clona el repositorio
2. Abre el proyecto en Xcode
3. Ejecuta la aplicación en simulador o dispositivo físico

---

## Configuración

Agrega tu API Key de NYTimes en el proyecto:

```swift id="cfg2"
let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
```

---

## Funcionamiento

* Con conexión a internet:

  * Se consumen los datos desde la API
  * Se almacenan en Core Data

* Sin conexión a internet:

  * Se muestran los datos almacenados localmente

* Sin conexión y sin datos:

  * Se muestra un estado de error controlado

---

## Decisiones Técnicas

* Se utilizó **MVVM** para desacoplar la lógica de presentación de la UI
* Se implementó **Clean Architecture** para facilitar escalabilidad y mantenimiento
* Se empleó **Core Data** para soportar un enfoque offline-first
* Se utilizó un **Repository Pattern** para abstraer las fuentes de datos

---

## Mejoras Futuras

* Implementar paginación
* Agregar búsqueda de artículos
* Incorporar favoritos
* Mejorar estrategia de cache (expiración de datos)
* Añadir pruebas unitarias adicionales

---

## Autor

Isaí Abraham
