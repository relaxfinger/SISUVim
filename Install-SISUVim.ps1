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
        & nvim --headless --cmd "set rtp^=$Root" -u (Join-Path $Root 'init.lua') '+lua require("lazy").sync({ wait = true })' '+qa'
    }

    if ($InstallVim) {
        if (-not (Get-Command lazygit -ErrorAction SilentlyContinue)) {
            Write-Warning 'LazyGit is optional but required for Vim <leader>gs. Install it with your system package manager.'
        }
    }
}

Write-Host 'SISUVim installation complete.'
