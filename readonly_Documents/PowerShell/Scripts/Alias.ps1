# ========== ALIASES PRINCIPALES ==========
# Alias global para que 'vi' siempre abra nvim (correcto así, sin -u)
Set-Alias -Name nv -Value nvim -Option AllScope -Scope Global -Force
Set-Alias -Name vim -Value nvim -Option AllScope -Scope Global -Force
Set-Alias -Name vi -Value nvim -Option AllScope -Scope Global -Force
Set-Alias -Name sobs "$HOME\Documents\PowerShell\Scripts\Manage-OBS.ps1"
Set-Alias -Name cz -Value chezmoi -Option AllScope -Scope Global -Force
Set-Alias -Name .. -Value eza -Option Allscope -Scope Global -Force
# ========== PSEUDO-ALIASES CON ARGUMENTOS ==========
# Estos funcionan como alias pero aceptan argumentos
function cme { chezmoi edit $args}
function apply{ . $PROFILE}
function ls { eza --icons $args }
function ll { eza --icons -l --git $args }
function la { eza --icons -a $args }
function grep { Select-String @args }
function cat { Get-Content @args }
function which { Get-Command @args | Select-Object -ExpandProperty Source }
function czadd { chezmoi add @args }
function envcd {
    param([string]$name)
    if (Test-Path "env:\$name") {
        Set-Location (Get-ChildItem "env:\$name").Value
    } else {
        Write-Warning "La variable de entorno '$name' no existe."
    }
}

function cmcd{
    cd $(cz source-path)
}

# ALias para git
#
function gsta{ git status}
function glg { git log }
function gpu { git push origin main }
function gcom { git commit }
function gadd { git add @args }




function fv {
    $previewCommand = '
        $f = "{}"
        if ($f -match "\.(png|jpg|jpeg|gif|webp)$") {
            wezterm imgcat --width 100% $f
        } else {
            bat --color=always --style=numbers --line-range=:500 $f
        }
    '
    # Ejecutamos fzf forzando a que el comando de preview pase por powershell
    fzf --preview "powershell -NoProfile -Command $previewCommand" --preview-window="right:60%"
}

function vconvert($file) {
    # 1. Forzamos a que PowerShell reconozca el archivo y sus propiedades
    $item = Get-Item $file
    $nombre = $item.BaseName
    $ruta = $item.DirectoryName

    # 2. Ejecutamos ffmpeg con optimización de hilos
    # -threads 0: Usa todos los núcleos disponibles (tus 14 núcleos / 28 hilos)
    # -preset faster: Acelera la codificación aprovechando la potencia de tu CPU
    ffmpeg -i $item.FullName -threads 0 -c:v libx264 -crf 18 -preset faster -c:a aac "$ruta\$nombre.mp4"
}
