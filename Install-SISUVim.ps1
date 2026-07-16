[CmdletBinding()]
param(
    [switch]$Vim,
    [switch]$Neovim,
    [switch]$WithPackages,
    [switch]$WhatIf
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$InstallVim = -not $Neovim
$InstallNeovim = -not $Vim
$Timestamp = (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ')

function Invoke-SISUAction {
    param([scriptblock]$Action, [string]$Description)
    if ($WhatIf) {
        Write-Host "What if: $Description"
    } else {
        & $Action
    }
}

function New-SISUSymlink {
    param([string]$Source, [string]$Target)

    $Parent = Split-Path -Parent $Target
    Invoke-SISUAction { New-Item -ItemType Directory -Force -Path $Parent | Out-Null } "create $Parent"

    if (Test-Path -LiteralPath $Target) {
        $Item = Get-Item -LiteralPath $Target -Force
        if ($Item.LinkType -and $Item.Target -eq $Source) {
            Write-Host "Already linked: $Target"
            return
        }

        $Backup = "$Target.sisuvim-backup-$Timestamp"
        Write-Host "Backing up $Target -> $Backup"
        Invoke-SISUAction { Move-Item -LiteralPath $Target -Destination $Backup } "move $Target to $Backup"
    }

    Write-Host "Linking $Target -> $Source"
    Invoke-SISUAction { New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null } "link $Target to $Source"
}

if ($InstallNeovim) {
    New-SISUSymlink -Source $Root -Target (Join-Path $env:LOCALAPPDATA 'nvim')
}

if ($InstallVim) {
    New-SISUSymlink -Source (Join-Path $Root 'vimrc') -Target (Join-Path $HOME '_vimrc')
}

if ($WithPackages) {
    if ($InstallNeovim) {
        if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
            throw 'Neovim is required to install Neovim packages.'
        }
        & nvim --clean --headless --cmd "set rtp^=$Root" --cmd 'let g:sisuvim_install_packages=1' -u (Join-Path $Root 'init.lua') '+qa'
    }

    if ($InstallVim) {
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            throw 'git is required to install Vim packages.'
        }
        $PackagePath = Join-Path $HOME 'vimfiles\pack\sisuvim\start\vim-fugitive'
        if (-not (Test-Path -LiteralPath $PackagePath)) {
            git clone --filter=blob:none --no-checkout https://github.com/tpope/vim-fugitive $PackagePath
        }
        git -C $PackagePath fetch --depth=1 origin 3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0
        git -C $PackagePath checkout --detach 3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0
    }
}

Write-Host 'SISUVim installation complete.'
