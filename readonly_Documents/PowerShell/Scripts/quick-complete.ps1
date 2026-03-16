# ========== MOTOR DE AUTOCOMPLETADO (RUST) ==========
$RustCompleter = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    
    # Intentamos ejecutar el binario de Rust
    $exePath = "$HOME\bin\quick-complete.exe"
    if (Test-Path $exePath) {
        $results = & $exePath $commandName $wordToComplete
        foreach ($line in $results) {
            [System.Management.Automation.CompletionResult]::new($line, $line, 'ParameterName', $line)
        }
    }
}

function Add-RustComplete {
    param([string]$CmdName)
    if (Get-Command $CmdName -ErrorAction SilentlyContinue) {
        Register-ArgumentCompleter -Native -CommandName $CmdName -ScriptBlock $RustCompleter
    }
}

# Registrar aplicaciones automáticamente
$myApps = @("eza", "ls", "git", "gh", "chezmoi", "cargo", "pnpm", "npm", "dots", "scoop")
foreach ($app in $myApps) {
    Add-RustComplete $app
}
# Definimos el array con tu lista para usarlo en el autocompletado
$myEnvDirs = @(
    "ALLUSERSPROFILE", "APPDATA", "BUN_INSTALL", "COMMONPROGRAMFILES", "COMPUTERNAME", 
    "LOCALAPPDATA", "PROGRAMDATA", "PROGRAMFILES", "PROGRAMFILES(X86)", "PUBLIC", 
    "TEMP", "TMP", "USERPROFILE", "PWSH_DIR", "PWSH_DIR_SCRIPTS", "PNPM_HOME", 
    "NVM_HOME", "WEZTERM_CONFIG_DIR"
)

function gcd {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Name
    )
    
    # Buscamos el valor de la variable de entorno
    $target = Get-Content "env:$Name" -ErrorAction SilentlyContinue
    
    if ($target -and (Test-Path $target)) {
        Set-Location $target
        Write-Host "📂 Navegando a: $target" -ForegroundColor Cyan
    } else {
        Write-Warning "La variable '$Name' no apunta a una ruta válida o está vacía."
    }
}

# Registro del autocompletado para que aparezca la tabla al dar al TAB
Register-ArgumentCompleter -CommandName 'gcd' -ParameterName 'Name' -ScriptBlock {
    param($wordToComplete)
    $myEnvDirs | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', "Ir a `$env:$_")
    }
}

# Forzar el menú visual para una mejor experiencia con las banderas de Rust
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete


