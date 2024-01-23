$inputfile = 'test\global_trimmed.ini'
$output = 'test\global_merged.ini'
$inputFiles = 'test\psOut'
$z = 0
$temp=Get-Content -Encoding UTF8 -Path $inputfile
$trimmed=@()
$s=get-date
$temp | Foreach{
    $elements=$_.split("=")
    $trimmed+= ,@($elements[0],$elements[1])
}
$(New-TimeSpan -Start $s -End $(get-date)).TotalSeconds
#$trimmed.Count
$temp=Get-Content -Path $inputFiles\*.ini
$merged=@()
$temp | Foreach{
    $elements=$_.split("=")
    $merged+= ,@($elements[0],$elements[1])
}
$(New-TimeSpan -Start $s -End $(get-date)).TotalSeconds
#$merged.Count
#$sortedList.Item()
$sortedList=@()
for ($i=0; $i -lt $trimmed.Count; $i++) {
    for ($j=0; $i -lt $merged.Count; $i++) {
        if ($trimmed.Item($i)[0] -eq $merged.Item($j)[0]){
        $sortedList.Add(@($trimmed.Item($i)[0],$merged.Item($i)[1]))
        }
    }
}
$(New-TimeSpan -Start $s -End $(get-date)).TotalSeconds

for ($i=0; $i -lt $sortedList.Count; $i++) {
$sortedList.item($i)[0]+'=' +$sortedList.item($i)[1] | Out-File -Encoding utf8 -FilePath global-merged.ini
}
$(New-TimeSpan -Start $s -End $(get-date)).TotalSeconds