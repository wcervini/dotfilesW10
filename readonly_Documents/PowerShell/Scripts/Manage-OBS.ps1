<#
.SYNOPSIS
    Gestor de perfiles y escenas para OBS Studio (Instalación Scoop).
#>
param(
    [string]$Proveedor,   
    [string]$Escenas,     
    [switch]$Backup,
    [switch]$Delete
)

# --- 1. CONFIGURACIÓN DE RUTAS ---
# Se define aquí arriba para que la lógica de ayuda pueda usar $baseDir
$baseDir = "C:\Users\Underghround\obs-config"
$persistPath = "$env:USERPROFILE\scoop\persist\obs-studio\config\obs-studio"
$obsExe = "$env:USERPROFILE\scoop\apps\obs-studio\current\bin\64bit\obs64.exe"

# --- 2. ALERTA DE ESTADO ---
# Verificamos si OBS está abierto para avisarte
if (Get-Process "obs64" -ErrorAction SilentlyContinue) {
    Write-Host "⚠️  ¡ATENCIÓN! OBS está abierto." -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "Los cambios podrían no guardarse o sobrescribirse al cerrar OBS.`n" -ForegroundColor Yellow
}

# --- 3. LÓGICA DE AYUDA (Se ejecuta si no hay parámetros) ---
if (-not $PSBoundParameters.Count) {
    Write-Host "`n--- 📺 GESTOR DE PERFILES OBS ---" -ForegroundColor Cyan
    Write-Host "Uso:" -ForegroundColor White
    Write-Host "  sobs -Proveedor <nombre> -Escenas <nombre> [-Backup| -Delete]`n" -ForegroundColor Gray

    if (Test-Path $baseDir) {
        # Listar Proveedores Detectados
        $proveedores = Get-ChildItem "$baseDir\config-*" -Directory -ErrorAction SilentlyContinue | ForEach-Object { $_.Name.Replace("config-","") }
        if ($proveedores) {
            Write-Host "Proveedores disponibles:" -ForegroundColor Yellow
            $proveedores | ForEach-Object { Write-Host "  • $_" }
        }

        # Listar Escenas Detectadas
        $scenesPath = Join-Path $baseDir "scenes"
        if (Test-Path $scenesPath) {
            $packsEscenas = Get-ChildItem $scenesPath -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
            if ($packsEscenas) {
                Write-Host "`nPacks de escenas disponibles:" -ForegroundColor Magenta
                $packsEscenas | ForEach-Object { Write-Host "  • $_" }
            }
        }
    } else {
        Write-Host "Error: No se encuentra la carpeta base en $baseDir" -ForegroundColor Red
    }

    Write-Host "`nEjemplo: " -NoNewline; Write-Host "sobs -Proveedor twitch -Escenas gaming" -ForegroundColor Green
    Write-Host "Para respaldar: " -NoNewline; Write-Host "sobs -Proveedor twitch -Backup`n" -ForegroundColor Red
    return 
}

# --- 4. LÓGICA DE RESPALDO (BACKUP) ---
if ($Backup) {
    if (-not $Proveedor -and -not $Escenas) {
        Write-Error "Debes especificar un nombre de -Proveedor o -Escenas para respaldar."
        exit
    }
    
#    Close-OBS

    if ($Proveedor) {
        $dest = Join-Path $baseDir "config-$Proveedor\basic\profiles"
        if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }
        Copy-Item -Path "$persistPath\basic\profiles\*" -Destination $dest -Recurse -Force
        Write-Host "Respaldo de perfiles para $Proveedor completado." -ForegroundColor Green
    }

    if ($Escenas) {
        $dest = Join-Path $baseDir "scenes\$Escenas\basic\scenes"
        if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }
        Copy-Item -Path "$persistPath\basic\scenes\*" -Destination $dest -Recurse -Force
        Write-Host "Respaldo de escenas '$Escenas' completado." -ForegroundColor Green
    }
    exit
}

# --- 5. LÓGICA DE CARGA (DEPLOY) ---
if ($Proveedor -or $Escenas) {

    # 1. Aplicar Proveedor
    if ($Proveedor) {
        $src = Join-Path $baseDir "config-$Proveedor\basic\profiles"
        if (Test-Path $src) {
            Remove-Item -Path "$persistPath\basic\profiles" -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -ItemType Directory -Force -Path "$persistPath\basic\profiles" | Out-Null
            Copy-Item -Path "$src\*" -Destination "$persistPath\basic\profiles" -Recurse -Force
            Write-Host "Aplicado Proveedor: $Proveedor" -ForegroundColor Cyan
        }
    }

    # 2. Aplicar Escenas
    if ($Escenas) {
        $src = Join-Path $baseDir "scenes\$Escenas\basic\scenes"
        if (Test-Path $src) {
            Remove-Item -Path "$persistPath\basic\scenes" -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -ItemType Directory -Force -Path "$persistPath\basic\scenes" | Out-Null
            Copy-Item -Path "$src\*" -Destination "$persistPath\basic\scenes" -Recurse -Force
            Write-Host "Aplicadas Escenas: $Escenas" -ForegroundColor Cyan
        }
    }

}
# 6 Logica de borrado de respaldo
if ($Delete) {
    if (-not $Proveedor -and -not $Escenas) {
        Write-Error "Especifica -Proveedor o -Escenas para eliminar su backup."
        exit 1
    }

    if ($Proveedor) {
        $path = Join-Path $baseDir "config-$Proveedor"
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force -Confirm:$false
            Write-Host "Backup de proveedor '$Proveedor' eliminado." -ForegroundColor Green
        } else {
            Write-Host "No existe backup de '$Proveedor'" -ForegroundColor Yellow
        }
    }

    if ($Escenas) {
        $path = Join-Path $baseDir "scenes\$Escenas"
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force -Confirm:$false
            Write-Host "Backup de escenas '$Escenas' eliminado." -ForegroundColor Green
        } else {
            Write-Host "No existe backup de escenas '$Escenas'" -ForegroundColor Yellow
        }
    }
    exit
}
