
##it install ssm on an aws instance then we can run EC2 command on that machine. basically run the script without having to login or use credentials on that instance.


## Download EXE Variables
$Source = "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/windows_amd64/AmazonSSMAgentSetup.exe"
$Dest = "$env:USERPROFILE\desktop\SSMAgent.exe"

## Only install if not installed already
$Path = "C:\Program Files\Amazon\SSM"
$TestPath = Test-Path $Path

If ($TestPath -eq $true) {
Write-Host "Already Installed!"
}

Else {
## Download EXE
Invoke-WebRequest $Source -OutFile $Dest

## Run EXE silently
Start-Process $Dest -ArgumentList "/s" -Wait 

## Delete EXE File
Remove-Item $Dest
}