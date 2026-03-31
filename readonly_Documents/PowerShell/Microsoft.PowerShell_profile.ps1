# === $PROFILE optimizado (Todas las funciones + Motor Rust) ===

$env:EDITOR = "nvim"
$env:GIT_EDITOR = "nvim"

# Inicialización de Starship
Invoke-Expression (& 'C:\Users\Underghround\.cargo\bin\starship.exe' init powershell --print-full-init | Out-String)
Write-Host "😏 Use el comando ayuda para mas info 💥" -ForegroundColor Magenta

# ========== FUNCIONES NEOVIM & NAVEGACIÓN ==========
$env:nvim_config = "$env:LOCALAPPDATA\nvim"
$env:nvim_data   = "$env:LOCALAPPDATA\nvim-data"

function nvwezterm {
    $weztermPath = "$env:USERPROFILE\scoop\apps\wezterm\current"
    if (Test-Path $weztermPath) { Set-Location -Path $weztermPath }
    else { Write-Warning "La carpeta 'wezterm' no se encuentra." }
}

function proyectos {
    Set-Location -Path "D:\"
    if (Test-Path "$PWD\proyectos") { Set-Location -Path "$PWD\proyectos" }
    else { Write-Warning "La carpeta 'proyectos' no se encuentra en D:\" }
}

function nvcd { cd $env:nvim_config }
function nvd { cd $env:nvim_data }
function nvprofile { cd (Split-Path $PROFILE) }
function nvconfig { nvim $env:nvim_config\init.lua }

# ========== FUNCIONES PYTHON & DEV (RECUPERADAS) ==========
function cvenv {
    uv venv
    Write-Host "✅ Entorno virtual .venv creado." -ForegroundColor Cyan
}

function venvactivate {
    if (Test-Path ".\.venv\Scripts\Activate.ps1") {
        & ".\.venv\Scripts\Activate.ps1"
    } else {
        Write-Error "No se encontró el entorno .venv."
    }
}

function Init-Precommit {
    if (!(Test-Path ".pre-commit-config.yaml")) {
        "repos:`n  - repo: https://github.com/pre-commit/pre-commit-hooks`n    rev: v4.4.0`n    hooks:`n      - id: trailing-whitespace`n      - id: end-of-file-fixer" | Out-File .pre-commit-config.yaml
        Write-Host "📄 Archivo .pre-commit-config.yaml creado." -ForegroundColor Cyan
    }
    pre-commit install
    Write-Host "🚀 Pre-commit instalado correctamente." -ForegroundColor Green
}

# ========== CONFIGURACIÓN PSREADLINE (MENU VISUAL) ==========
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete # Crucial para quick-complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Smart completado para 'nv '
Set-PSReadLineKeyHandler -Key Ctrl+º -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('nv ')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
}

# ========== CARGA DE ENTORNO Y SCRIPTS EXTERNOS ==========
#fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

# Aquí cargamos tus otros archivos (Alias.ps1, Ayuda.ps1, Dots.ps1, etc.)
$script_dir = Join-Path (Split-Path $PROFILE) "Scripts"
$scripts_to_load = @("Alias.ps1", "Ayuda.ps1", "quick-complete.ps1")

foreach ($script in $scripts_to_load) {
    $full_path = Join-Path $script_dir $script
    if (Test-Path $full_path) { . $full_path }
}

#Invoke-Expression -Command "& `"C:\Users\Underghround\scoop\apps\powertoys\current\install-context.ps1`""
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
