$path = $args[0]
$ext = [IO.Path]::GetExtension($path).ToLower()
if ($ext -in '.png','.jpg','.jpeg','.gif','.webp','.bmp') {
    wezterm imgcat $path
} else {
    bat --color=always --style=numbers --line-range=:500 $path
}

