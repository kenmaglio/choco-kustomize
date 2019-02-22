$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = join-path $toolsDir 'kustomize_2.0.1_windows_amd64.exe'

$packageArgs = @{ 
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'kustomize*'
  fileType      = 'exe'
  silentArgs    = ""
  validExitCodes= @(0)
  url64bit      = "https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.1/kustomize_2.0.1_windows_amd64.exe"
  checksum64    = 'C0CE46C0C81BB7EE4B13128A3152E17B73FDE586057AE8C85EDDFA3134D28371'
  checksumType64= 'sha256'
  destination   = $toolsDir
}

Install-ChocolateyPackage @packageArgs

$binargs = @{
  name = 'kustomize'
  path = $fileLocation
}

Install-BinFile @binArgs
