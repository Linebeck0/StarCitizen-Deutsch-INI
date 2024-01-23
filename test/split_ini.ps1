$inputfile = 'global.ini'
$outputTrimmed = 'global_trimmed.ini'
$outputFiles = 'psOut'
$z = 0

if (Test-Path $outputTrimmed) {
Remove-Item $outputTrimmed
}
if (Test-Path $outputFiles) {
Remove-Item $outputFiles -Recurse -Force
}
New-Item -Path $outputFiles -ItemType Directory
New-Item -Path $outputTrimmed -ItemType File
foreach($line in Get-Content $inputfile) {
   $tmp = $line.split("=")
   $key = $tmp[0]
   $($key.Trim()+'=') | Out-File -Encoding utf8 -FilePath $outputTrimmed -Append
   $file = $key.split('`_')
   $fileName = ''
   if ($file.Length -eq  1) {
      $fileName = $outputFiles + '\' + "global.ini" 
   }
   elseif ($file[0].Length -le 2) {
   $fileName = $outputFiles + '\' + $file[0] + '_' + $file[1]+'.ini'
   }
   else {
      $fileName = $outputFiles + '\' + $file[0]+'.ini'
   }
   $line | Out-File -Encoding utf8 -FilePath $fileName -Append 
   $z = $z + 1
}
Write-Host "$z Zeilen verarbeitet"
