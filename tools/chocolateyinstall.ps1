
$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.srcclr.com/srcclr-$Env:chocolateyPackageVersion-windows.zip"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url

  softwareName  = 'srcclr*'

  checksum      = '5EDD6395B14E27C9578791EB2F86248BD7E799CAECFC4D3A9A7DC3E057A3D025'
  checksumType  = 'sha256'
  checksum64    = $checksum
  checksumType64= $checksumType

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$installDir = Join-Path $toolsDir "srcclr-$Env:chocolateyPackageVersion"

Install-ChocolateyPath (Join-Path $installDir 'bin')

$files = get-childitem $installDir -include *.exe -recurse

foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
