# Configuración Global del Agente OpenCode

**Documento de referencia para configuración de agente - Walter Cervini**

*Fecha de creación: 8 de marzo de 2025*  
*Última actualización: 8 de marzo de 2025*  
*Idioma de comunicación: Español (forzado)*

---

## 👤 Información del Usuario

### Datos Personales
- **Nombre completo**: Walter Cervini
- **Correo electrónico**: wcervini@gmail.com
- **GitHub**: https://github.com/wcervini
- **Repositorio actual**: https://github.com/wcervini/entorno-opencode.git

### Ubicación del Sistema
- **Directorio actual**: `C:\Users\Underghround\entorno\`
- **Configuración OpenCode**: `C:\Users\Underghround\.config\opencode\`

---

## 💻 Información del Sistema

### Hardware y Sistema Operativo
- **Nombre del equipo**: DESKTOP-M7QB1SP
- **Sistema operativo**: Microsoft Windows 10 Pro
- **Versión del sistema**: 10.0.19045 N/D Compilación 19045
- **Procesador**: Intel64 Family 6 Model 79 Stepping 1 GenuineIntel ~2401 Mhz
- **Memoria RAM**: 49.057 MB
- **Arquitectura**: x64-based PC
- **Directorio Windows**: C:\WINDOWS

### Lenguajes de Programación Instalados
- **Python**: 3.14.3 (Ubicación: C:\Users\Underghround\scoop\apps\python\current)
- **Node.js**: v24.14.0 (Ubicación: C:\Users\Underghround\AppData\Local\fnm_multishells)
- **Go**: Instalado (gestor gopass presente)
- **Rust**: Instalado (cargo presente)
- **Lua**: Instalado
- **Nim**: Instalado
- **Zig**: Instalado

### Herramientas de Desarrollo
#### Editores/IDEs Disponibles
- **Neovim**: Configurado en C:\Users\Underghround\neovim
- **Cursor**: Instalado
- **JetBrains IDEs**: JetBrainsMono-NF y herramientas JetBrains

#### Gestores de Paquetes
- **Scoop**: Gestor principal (C:\Users\Underghround\scoop)
- **npm**: Para Node.js
- **pnpm**: Alternativa npm
- **cargo**: Gestor de Rust
- **luarocks**: Gestor de Lua

#### Control de Versiones
- **Git**: version 2.53.0.windows.1
- **Ubicación**: C:\Users\Underghround\scoop\apps\git\current

---

## 🤖 Configuración OpenCode

### Proveedor de Modelos de IA
```json
{
  "provider": "ollama",
  "name": "Ollama (local)",
  "npm": "@ai-sdk/openai-compatible",
  "options": {
    "baseURL": "http://localhost:11434/v1"
  }
}
```

### Modelos Configurados
- **qwen2.5-coder:latest**: Modelo principal configurado
  - **Temperatura**: 0.7
  - **Máximo de tokens**: 500
  - **Top P**: 0.9

### Servicios MCP (Model Context Protocol)
#### Context7
- **Tipo**: remote
- **URL**: https://mcp.context7.com/mcp
- **Estado**: habilitado

#### Chrome DevTools
- **Tipo**: local
- **Comando**: ["npx", "-y", "chrome-devtools-mcp@latest"]

### Configuración de Tema
- **Tema**: Catppuccin

---

## 🔧 Workflow Git

### Conventional Commits
Estándar adoptado para todos los commits:

```bash
feat:     agregar nueva funcionalidad
fix:      corregir bug
BREAKING: cambio incompatible
docs:     actualizar documentación
style:    cambios de formato
refactor: reestructurar código
test:     añadir pruebas
chore:    tareas de mantenimiento
```

### Versionado SemVer
Automatizado con `standard-version`:
- **MAJOR**: Cambios incompatibles
- **MINOR**: Nuevas funcionalidades compatibles
- **PATCH**: Correcciones de bugs

### Validación Manual
**Estrategia adoptada:** Validación manual en lugar de automatizada
- Pre-commit hooks básicos
- Validación manual con scripts npm
- Checklist pre-release

### Scripts de Validación
(Implementar en package.json)
```json
{
  "scripts": {
    "validate-commit": "commitlint",
    "release": "standard-version",
    "version-check": "node scripts/version-check.js"
  }
}
```

---

## 📱 Redes Sociales

### Plataformas Activas
- **TikTok**: https://www.tiktok.com/@underghround
- **YouTube**: 
  - @waltercervini
  - @justtecnobyte
  - @linspec6328
- **X/Twitter**: @v0lp
- **Instagram**: https://www.instagram.com/underghround/
- **Twitch**: https://www.twitch.tv/underghround

### Presencia Digital
**Nombre de usuario consistente**: @underghround en múltiples plataformas

---

## 📝 Documentación

### Estructura del README.md (Bilingüe)
```markdown
# English Version
- Project Overview
- Installation & Usage
- Contributing Guidelines

# Versión en Español
- Descripción del Proyecto
- Instalación y Uso
- Guías de Contribución
```

### Licencia MIT
```text
MIT License

Copyright (c) 2025 Walter Cervini

Permission is hereby granted...
```

### Archivos de Configuración
#### package.json Actual
```json
{
  "name": "entorno-opencode",
  "version": "0.1.0",
  "description": "Repositorio para gestionar comandos y configuraciones de OpenCode",
  "scripts": {
    "version": "standard-version"
  }
}
```

#### Configuración OpenCode (opencode.json)
```json
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "Catppuccin",
  "plugin": ["opencode-gemini-auth@latest"]
}
```

---

## 🚀 Workflow de Desarrollo

### Estructura de Branching (GitHub Flow)
- **main**: Rama principal estable
- **feature/**: Ramas para nuevas funcionalidades
- **hotfix/**: Ramas para correcciones críticas

### Proceso de Release
1. Desarrollo en ramas feature
2. Pull request a main
3. Validación manual
4. Release automático con standard-version
5. Actualización automática de CHANGELOG.md

### Validación Pre-Release
- [ ] Verificar Conventional Commits
- [ ] Confirmar tests pasan
- [ ] Revisar documentación
- [ ] Validar breaking changes

---

## 📊 Dependencias Instaladas

### Gestor Scoop (C:\Users\Underghround\scoop\apps)
```
7zip, git, python, nodejs, neovim, rust, go, lua, zig, nim,
podman, wezterm, starship, zoxide, ripgrep, fzf, lazygit, gh,
obs-studio, vlc, vivaldi, curl, bat, fd, tree-sitter, sed
```

### NPM Globales
```
corepack@0.34.6
neovim@5.4.0
npm@11.9.0
prettier@3.8.1
```

---

## 🎯 Próximos Pasos

### Implementaciones Pendientes
1. Configurar commitlint para validación
2. Crear scripts de validación manual
3. Implementar CHANGELOG.md automático
4. Configurar hooks git pre-commit

### Mejoras Futuras
- Integración con más servicios MCP
- Automatización de pruebas
- Documentación más extensa
- Integración cross-platform

---

## 📞 Contacto

**Walter Cervini**  
Email: wcervini@gmail.com  
GitHub: https://github.com/wcervini

*Este documento se actualiza automáticamente con cambios en la configuración del sistema.*