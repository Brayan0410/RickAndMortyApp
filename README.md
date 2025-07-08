# Rick and Morty Explorer

Aplicación iOS nativa construida como prueba técnica. Permite explorar personajes de Rick and Morty, ver sus detalles, gestionar favoritos, acceder a ubicaciones en mapa y proteger el acceso mediante biometría.

---

## 🚀 Funcionalidades

- 🔎 Listado de personajes con scroll infinito y búsqueda
- 🧬 Filtros por estado, especie y nombre
- 👤 Vista de detalle con episodios donde aparece
- ❤️ Gestión de favoritos con persistencia local
- 🔐 Acceso a favoritos mediante Face ID / Touch ID
- 🗺 Mapa interactivo con ubicaciones simuladas
- 🌐 Consumo de API pública de Rick and Morty
- ✅ Pruebas unitarias con mocks
- 📱 Soporte para múltiples tamaños de pantalla

---

## 🛠 Arquitectura

- **MVVM + Clean Architecture**
- Inyección de dependencias con **Swinject**
- Módulos separados por `Data`, `Domain`, `Presentation`
- Manejo de errores robusto y logging básico
- Persistencia simple con `UserDefaults` (favoritos y vistos)
- Pruebas unitarias (`XCTest`) con repositorios simulados

---

## 📦 Dependencias

- `Swinject`: inyección de dependencias
- `MapKit`: mapa nativo
- `LocalAuthentication`: biometría
- `Combine` / `async-await`: para flujos reactivos

