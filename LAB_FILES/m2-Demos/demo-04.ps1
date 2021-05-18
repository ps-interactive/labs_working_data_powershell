# PowerShell objects can be converted to HTML using ConvertTo-Html
get-service bits | ConvertTo-Html

# To export the HTML data out of the shell, use the out file command
get-service bits | ConvertTo-Html | out-file C:\docs\bits.html
Invoke-Item C:\docs\bits.html

# You can select certain properties during the convertion, the -As parameter will format the result as either a list or table, and you can modify the title of the HTML
get-service bits | ConvertTo-Html -Property Name,CanShutdown,StartType -As List -Title MyFancyReport | out-file C:\docs\bits.html

# Pre content and Post content will come before and after the body of the HTML
$PreContent = "$env:ComputerName Report"
$PostContent = "<p>created by @mattallford on $(Get-Date)</p>"
get-service bits | ConvertTo-Html -Property Name,CanShutdown,StartType -As List -Title MyFancyReport -PreContent $PreContent -PostContent $PostContent | out-file C:\docs\bits.html

# The main purpose of this example is to show the -Fragment parameter when getting different data results, and then combining them all together in a single report
$ComputerName = "<h1> $env:ComputerName Report</h1>"
$Services = get-service b* | ConvertTo-Html -Property Name,CanShutdown,StartType,status -Fragment -PreContent "<h2>B* Service Status:</h2>"
$Disk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -Property DeviceId,Size,FreeSpace -Fragment -PreContent "<h2> Computer Disk Info:</h2>"
$MyReport = ConvertTo-Html -Body "$ComputerName $Services $Disk" -Title MyFancyReport -PostContent "<p>created by @mattallford on $(Get-Date)</p>"
$myreport | Out-File C:\Docs\report.html
Invoke-Item C:\docs\report.html

# CSS can be used to style a report. I have an example already which is included in the exercise files
Get-Content C:\Docs\style.css

# You can specify an external CSS file when converting the data to HTML, which will then be used when the HTML file is rendered in a browser
$MyReport = ConvertTo-Html -Body "$ComputerName $Services $Disk" -Title MyFancyReport -PostContent "<p>created by @mattallford on $(Get-Date)</p>" -CssUri C:\Docs\style.css
$myreport | Out-File C:\Docs\report.html
Invoke-Item C:\docs\report.html