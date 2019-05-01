$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '2.0.3'
# pattern for exe name
$exe_name = "kustomize_$($version)_windows_amd64.exe"
# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/v$($version)/$($exe_name)"

# use $ checksum [exe] -t=sha256
$version_checksum = '7D8BE317F58A245065E1EF57356631DA81B0DBAB40F5F7CFBE65B55D8D484B29'
$checksum_type = 'sha256'

# destination for exe
$fileLocation = join-path $toolsDir $exe_name

$getArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = $fileLocation
  url64bit      = $url
  checksum64    = $checksum
  checksumType64= $type
}

Get-ChocolateyWebFile @getArgs

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'kustomize*'
  fileType      = 'exe'
  silentArgs    = ""
  validExitCodes= @(0)
  file64        = $fileLocation
  checksum64    = $checksum
  checksumType64= $type
  destination   = $toolsDir
}

Install-ChocolateyInstallPackage @packageArgs

$binargs = @{
  name = 'kustomize'
  path = $fileLocation
}

Install-BinFile @binArgs
