$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# release version of kustomize: https://github.com/kubernetes-sigs/kustomize/releases
$version = '2.0.2'
# pattern for exe name
$exe_name = "kustomize_$($version)_windows_amd64.exe"
# only 64bit url
$url = "https://github.com/kubernetes-sigs/kustomize/releases/download/v$($version)/$($exe_name)"

# use $ checksum [exe] -t=sha256
$version_checksum = '84FC39886F4B25A01A84C675F4ED52FEB0405062879554E7289169035D1F73C0'
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
  file64          = $fileLocation
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
