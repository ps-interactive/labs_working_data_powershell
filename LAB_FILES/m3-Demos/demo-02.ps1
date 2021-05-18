# Use Invoke-RestMethod to get a response from an endpoint, in this example we will retrieve the
# PowerShell Microsoft blog feed
Invoke-RestMethod -Method get -Uri https://devblogs.microsoft.com/powershell/feed/
$PowerShellBlog = Invoke-RestMethod -Uri https://devblogs.microsoft.com/powershell/feed/

# When exploring the type of object that is returned, Invoke-RestMethod has automatically
# converted the data in the response to an XML object type in PowerShell. We can now work
# with that as a standard PowerShell object
$PowerShellBlog | get-member | more
$PowerShellBlog | select title,link | format-List

# This example does another get request against Matt Allford's user profile on the
# Github website. When we inspect the object type here, PowerShell has again done
# the heavy lifting to convert the response, which was JSON, to a PS Custom Object
Invoke-RestMethod -Method get -Uri https://api.github.com/users/mattallford
$GitHub = Invoke-RestMethod -Method get -Uri https://api.github.com/users/mattallford
$Github | Get-Member | more

# If we explore doing the same thing with Invoke-WebRequest against the same endpoint
# we'd need to manually then convert the data using the ConvertFrom-Json cmdlet
$WebRequest = Invoke-WebRequest -Method get -Uri https://api.github.com/users/mattallford
$WebRequest.Content
$WebRequest.Content | ConvertFrom-Json

# Let's create a new repository on github. We need to build a JSON body that contains
# a name value pair that specifies the name of the repository we want to create
$body = @{name = "PluralsightDemoRepo"}
$body
$body = @{name = "PluralsightDemoRepo"} | ConvertTo-Json
$body

# We can then perform a POST request to the endpoint, and speify the $body variable
# using the -Body parameter. This cmdlet will actually fail, as we aren't authenticated
# to the service
Invoke-RestMethod -Method post -Uri https://api.github.com/user/repos -Body $Body

# After generating a personal access token in our github profile, save it in PowerShell
# as a variable

# NOTE: The value of $Token below will need to be replaced with the value of the token you generate
# as you follow along
$Token = "38e04ec4c5afd8d28ed4e64f7d47d246eb736273"

# The token then needs to be converted to a Base64 string
$Base64Token = [System.Convert]::ToBase64String([char[]]$Token)

# Finally, we can specify a hashtable that contains a name for 'authorization' and a value which 
# contains the Base64 string of the personal access token. There can be multiple headers you might
# need to send in a single request to the URI, usually refer to the documentation of the system
# you are interacting with for more information on this. Additional name value pairs can be
# added to the #Header has table, and then sent as a single hash table in the $header variable
$Header = @{Authorization = "Basic $Base64Token"}
$Header 

# We can now re-try the POST method to create the repository, this time specifying the headers
# which will tell github we are authorized to create the repository
Invoke-RestMethod -Method post -Uri https://api.github.com/user/repos -Body $Body -Headers $Header

# The DELETE method could now be used to delete the repository. Note we need to send the headers again
# because this is a separate web request that has no relationship to the request we just made which
# created the repository, so we need to tell github again that we are authorized to perform a delete operation
Invoke-RestMethod -Method Delete -Uri https://api.github.com/repos/mattallford/PluralsightDemoRepo -Headers $Header