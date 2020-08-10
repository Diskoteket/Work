<#
.Synopsis
    This script gets the ID used in connecting to remote computers with TeamViewer


.DESCRIPTION
    This is a small script mainly used by our serivcedesk to get the TeamViewer ID of computers in our organization.
    The reason why this script is needed is because sometimes the agents can't connect to a computer with just the host name.
    So instead of getting the user to read the ID out load you can simply remote to the computer and get the ID.

.NOTES

	    FileName:  Get-TeamviewerID.ps1

	    Author:  Tim Wetterek Andersson

	    Contact: timwa@protonmail.com

	    Created: 2019-02-25

#>

$ComputerName = ""
$Session = New-PSSession -ComputerName $ComputerName

$LocalKeyValue = Invoke-Command -Session $Session -ScriptBlock {
  $RegKey = 'HKLM:\SOFTWARE\WOW6432Node\TeamViewer'
  $RemoteKeyValue = (Get-ItemProperty -Path $RegKey -Name ClientID).ClientID; $RemoteKeyValue
}
