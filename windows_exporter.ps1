$file = 'windows_exporter-0.15.0-amd64.msi'
$link = "https://github.com/prometheus-community/windows_exporter/releases/download/v0.15.0/$file"
$soft_name = 'windows_exporter'

#$find = Get-WmiObject -Class Win32_Product -Filter "Name = `'$soft_name`'"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$tmp = "$env:TEMP\$file"
$client = New-Object System.Net.WebClient
$client.DownloadFile($link, $tmp)
msiexec /L* $env:TEMP\$file"_install_log" /i $tmp /qn ENABLED_COLLECTORS="cpu,memory,cs,logical_disk,net,os,system"
del $tmp
Invoke-WebRequest -UseBasicParsing -Uri http://localhost:9182
#} else {
#    echo "ERROR: $soft_name is already installed."
#    echo $find
#    exit 1
#}

#exit 0