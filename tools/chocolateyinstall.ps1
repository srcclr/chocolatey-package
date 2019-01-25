
$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://download.srcclr.com/srcclr-$Env:chocolateyPackageVersion-windows.zip"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'srcclr*'

  checksum      = '8ec1b01337b5ad9c32386b182e5ab2c23daf75df9ae12bb50c90c7f02b553f60'
  checksumType  = 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs

$installDir = Join-Path $toolsDir "srcclr-$Env:chocolateyPackageVersion"

Install-ChocolateyPath (Join-Path $installDir 'bin')

$files = get-childitem $installDir -include *.exe -recurse

foreach ($file in $files) {
  New-Item "$file.ignore" -type file -force | Out-Null
}
