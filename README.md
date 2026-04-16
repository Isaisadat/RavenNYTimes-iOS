# RavenNYTimes

Aplicación iOS desarrollada en SwiftUI que consume artículos de la API de The New York Times.

---

## Descripción

Esta aplicación muestra una lista de artículos obtenidos desde una API.
También guarda la información localmente para poder mostrar contenido cuando no hay conexión a internet.

El proyecto está estructurado utilizando **arquitectura limpia (Clean Architecture)** junto con el patrón **MVVM**, lo que permite una mejor organización del código, escalabilidad y facilidad para realizar pruebas.

---

## Características

* Consumo de API
* Persistencia local con Core Data
* Soporte sin internet
* Arquitectura limpia (Clean Architecture)
* Patrón MVVM
* Interfaz en SwiftUI

---

## Instalación

1. Clona el repositorio
2. Abre el proyecto en Xcode
3. Ejecuta la app en simulador o dispositivo

---

## Configuración

Agrega tu API Key de NYTimes en el proyecto:

```swift id="cfg1"
let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
```

---

## Funcionamiento

* Si hay internet: obtiene datos de la API y los guarda
* Si no hay internet: muestra los datos guardados
* Si no hay datos: muestra un error

---

## Autor

Isaí Abraham
