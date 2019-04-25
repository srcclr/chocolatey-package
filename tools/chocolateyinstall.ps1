
$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.srcclr.com/srcclr-3.2.4-windows.zip"
$url64      = "https://download.srcclr.com/srcclr-$Env:chocolateyPackageVersion-windows.zip"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  url64bit       = $url64

  softwareName   = 'srcclr*'

  checksum       = '5ce02e0c1eb47661a4699d3ccdf44a171a95c84db74550f41ab1f2bdea9993fa'
  checksumType   = 'sha256'

  checksum64     = '1677072902986ed52209861a49fdfa9016d1406a2456cd41c453a7c9c99a8cd5'
  checksumType64 = 'sha256'

  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$installDir = Join-Path $toolsDir "srcclr-$Env:chocolateyPackageVersion"

Install-ChocolateyPath (Join-Path $installDir 'bin')

$files = get-childitem $installDir -include *.exe -recurse

foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
