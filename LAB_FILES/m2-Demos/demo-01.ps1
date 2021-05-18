# Export data to CSV
Get-Process m* | Export-Csv -Path C:\Docs\Processes.csv

# Open in Notepad
Notepad C:\docs\processes.csv

# Open in Microsoft Excel (if associated with CSV files)
Invoke-Item C:\docs\Processes.csv

# Select specific properties to export, and then display the results in the shell
Get-Process m* | Select-Object Name,Handles,Threads,Company,StartTime | Export-Csv C:\Docs\Processes.csv
Get-Content C:\Docs\Processes.csv

# Use the append parameter to add data to an exising file
Get-Process w* | Select-Object Name,Handles,Threads,Company,StartTime | Export-Csv C:\Docs\Processes.csv -Append
Invoke-Item C:\docs\Processes.csv

# Using the noclobber parameter will ensure the file can't be overwritten
Get-Process w* | Select-Object Name,Handles,Threads,Company,StartTime | Export-Csv C:\Docs\Processes.csv -NoClobber

# The delimiter can be changed by using the -Delimiter parameter
Get-Process m* | Select-Object Name,Handles,Threads,Company,StartTime | Export-Csv C:\Docs\ProcessesDelim.csv -Delimiter ':'
Get-Content C:\Docs\ProcessesDelim.csv
Invoke-Item C:\docs\ProcessesDelim.csv

# Type information of the objects can be exported by using the -IncludeTypeInformation parameter
Get-Process m* | Select-Object Name,Handles,Threads,Company,StartTime | Export-Csv C:\Docs\ProcessesWithType.csv -IncludeTypeInformation
Invoke-Item C:\Docs\ProcessesWithType.csv



# Import data to PowerShell
Import-Csv C:\Docs\Processes.csv
$MyData = Import-Csv C:\Docs\Processes.csv

# Review the object type after importing CSV, and compare this to importing a CSV object that includes the data type
$MyData | Get-Member
Import-Csv C:\Docs\ProcessesWithType.csv | gm

# Experiment with importing CSV that has a different delimiter
Import-Csv -Path C:\Docs\ProcessesDelim.csv
Import-Csv -Path C:\Docs\ProcessesDelim.csv -Delimiter ':'

# When importing CSV data without a header, the first row will get used as the header
Import-Csv C:\Docs\IceCreamData.csv

# Headers can be built as an object and then specified with Import-Csv
$Header = 'FirstName','Lastname','City','Flavour'
Import-Csv C:\Docs\IceCreamData.csv -Header $Header


# Converting data
# Converting will leave the converted data in the shell
Get-Process w* | Select-Object Name,Handles,Company | ConvertTo-

# Powershell data can be converted to CSV, and then back from CSV to PowerShell objects
$CsvData = Get-Process w* | Select-Object Name,Handles,Company | ConvertTo-Csv
$CsvData | get-Member | more
$CSVData
$CsvData | ConvertFrom-Csv
$CsvData | ConvertFrom-Csv | gm