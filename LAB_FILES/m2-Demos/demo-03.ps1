# Powershell data can be converted to JSON in the shell
get-date | select * | ConvertTo-Json

# You can force the data to a JSON array, even if it is a single object
get-date | select * | ConvertTo-Json -AsArray

# You can use the compress parameter to remove the whitespace, while still leaving the result as a valid JSON construct
get-date | select * | ConvertTo-Json -Compress

# You can also use the InputObject parameter to specify the data to convert, instead of piping data to converto-json
$date = Get-Date | select *
ConvertTo-Json -InputObject $date

# When you want to get JSON data out of the shell, use the out-file cmdlet after the data has been converted
Get-Process w* | ConvertTo-Json
Get-Process w* | ConvertTo-Json | out-file C:\docs\procs.json
Invoke-Item C:\docs\procs.json
Get-Content C:\Docs\procs.json

# To bring JSON data in to the shell, use Get-Content, but if you don't convert the data from JSON, it will just be a string of data
$ProcessData = Get-Content C:\Docs\procs.json
$ProcessData | Get-Member | more
$processData[0]
$processData[1]
$processData[2]
$ProcessData | select name

# Make sure you convert the data from JSON, which will allow you to treat the data as standard powershell objects in a PS Custom Object
$ProcessData = Get-Content C:\Docs\procs.json | ConvertFrom-Json
$ProcessData | Get-Member | more
$processData[0]
$ProcessData | Select Name