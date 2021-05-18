# Data can be exported to the CLI XML type by using Export-CliXml
Get-Process a* | Export-CliXml -Path C:\Docs\Process.xml
Invoke-item C:\Docs\process.xml

# CLI XML data can be imported back in to PowerShell using Import-CliXml, which will rebuild the objects with their metadata
# You can treat the imported data as normal powershell objects
$MyXml = Import-CliXml C:\Docs\Process.xml
$MyXml
$MyXml | Get-Member | more
$MyXml | Select Name,WorkingSet

# CLI XML is to be used only with Powershell. To export to standard XML, you need to use the ConvertTo-Xml cmd, and then use the save method
$ConvertedXml = Get-Process a* | ConvertTo-Xml
$ConvertedXml.Save("C:\Docs\ConvertedXml.xml")
Invoke-Item C:\Docs\ConvertedXml.xml

# If you try to import standard XML data with Import-CliXml, it will fail
Import-CliXml C:\Docs\ConvertedXml.xml

# You can use Get-Content to import standard XML data in to the shell, but make sure you cast the content to an XML object
[xml]$xml = Get-Content C:\Docs\Convertedxml.xml
$xml | gm
$xml
$xml.Objects
$Xml.Objects.Object