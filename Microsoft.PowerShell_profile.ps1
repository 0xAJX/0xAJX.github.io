function prompt {
    # Current directory
    $currentPath = Split-Path (Get-Location) -Leaf

    # Detect Git branch (if inside repo)
    $branch = ""
    if (Test-Path .git) {
        try {
            $branch = git rev-parse --abbrev-ref HEAD 2>$null
        } catch {}
    }

    # ── Define Colors (using truecolor escape codes)
    $gold    = "`e[38;2;255;215;0m"     # gold
    $golden  = "`e[38;2;218;165;32m"
    $purple  = "`e[38;2;198;120;221m"   # first arrow
    $blue    = "`e[38;2;97;175;239m"    # second arrow / git:
    $cyan    = "`e[38;2;102;217;239m"   # folder name
    $red     = "`e[38;2;224;108;117m"   # branch name
    $green   = "`e[38;2;80;250;123m"    # time
    $gray    = "`e[38;2;150;150;150m"   # subtle git label
    $pink    = "`e[38;2;255;105;180m"
    $reset   = "`e[0m"

    # Current time
    $time = (Get-Date).ToString("HH:mm")

    # Arrows
    $promptSymbol = "$purple❯$pink❯$reset"

    # Git info
    $gitPart = ""
    if ($branch) {
        $gitPart = "$gray git:$reset($red$branch$reset)$reset "
    }

    # Compose final line
    "$promptSymbol $cyan$currentPath$reset $gitPart$green$time$reset $gold$ "
}
