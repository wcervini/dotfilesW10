# ========== INICIALIZACIÓN ==========
function ayuda {
    Write-Host "😏 Use el comando 'ayuda' para más info 💥"
    Write-Host "📂 nvim:   $env:nvim_config" -ForegroundColor Cyan
    Write-Host "💾 data:   $env:nvim_data"   -ForegroundColor Cyan
    Write-Host "`nComandos disponibles:"       -ForegroundColor Yellow

    $cmds = @(
        "nvconfig   - Editar configuración Neovim",
        "nvplugins  - Editar plugins",
        "nvclean    - Limpiar plugins",
        "cleannv    - Limpiar caché",
        "nvsize     - Ver tamaño",
        "nvlunar    - Switch to LunarVim config",
        "nvlazy     - Switch to LazyVim config",
        "nvchad     - Switch to NvChad config",
        "nvastro    - Switch to AstroNvim config",
        "nvkick     - Switch to Kickstart config",
        "----------------------------------------",
        " Otros comandos útiles:",
        "----------------------------------------",
        "nvcd       - Cambia al directorio de nvim",
        "nvprofile  - Cambia al directorio de perfil powershell",
        "nvd        - Cambia al directorio de datos de nvim",
        "cvenv      - Crea un entorno virtual en el proyecto actual",
        "venvactivate - Activa el entorno virtual .venv",
        "proyectos  - Cambia al directorio D:\\proyectos",
        "nvwezterm  - Cambia al directorio D:\\proyectos si existe wezterm"
        "venvdeactivate - Activa el entorno virtual .venv usando UV",
        "envls - Muestra las variables de entorno actuales",
        "envcd - Accede al directorio de la variable de entorno"


    )

    $cmds | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }

    Write-Host "`n"
}

