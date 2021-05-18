# Use Invoke-WebRequest to get a response from a website and save it to a variable
Invoke-WebRequest -Method Get -Uri www.mattallford.com
$Result = Invoke-WebRequest -Method Get -Uri www.mattallford.com

# Explore some of the properties of the object that was returned from the web request
$Result.Links
$Result.Links.href

$Result.StatusCode
$Result.StatusDescription

$Result.Headers
$Result.Content

# Use invoke-webrequest to get an RSS feed, which is XML based data
Invoke-WebRequest -Method get -Uri https://www.reddit.com/r/PowerShell/.rss
$Result = Invoke-WebRequest -Method get -Uri https://www.reddit.com/r/PowerShell/.rss

# The data contained in the content property is just a string of data, this cmdlet does not serialize or convert data
# If you want to do that with invoke-webrequest, you need to take a second step of converting the data, which is shown
# below where we cast the content to an XML object type
$Result | get-member | more
[xml]$xml = $Result.Content
$xml
$xml.feed
$xml.feed.entry
$xml.feed.entry[0].link

# The -OutFile parameter can be used to save the response body out to a file
Invoke-WebRequest -Method Get -Uri www.mattallford.com -OutFile C:\Docs\mattallford.html
Invoke-item C:\Docs\mattallford.html

# Invoke-WebRequest can also be used to download files from the endpoint. The example below is downloading the
# PowerShell 7 Windows MSI installer from github, and storing it in C:\Docs on the local machine
Invoke-WebRequest -Uri 'https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/PowerShell-7.0.3-win-x64.msi' -OutFile C:\Docs\PowerShell7.msi