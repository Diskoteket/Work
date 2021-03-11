<#
.Synopsis
		This script is used for throwing status codes to OP5 based on the size of an Exchange Servers submission queue and the threshold input of a user in OP5 Monitor.
.DESCRIPTION
		This script is used for throwing status codes to OP5 based on the size of an Exchange Servers submission queue and the threshold input of a user in OP5 Monitor.
        This script is based on a similar one created by Sten Kedåker.
		My changes to it incorporates user input via arguments and some more logic to throw warnings or criticals etc.
.NOTES
		FileName:  check_exchange_submission_queue.ps1
		Author:  Tim Wetterek Andersson
		Contact: tim@wetterek.se
		Created: 2021-03-11
#>

# Set parameters for user input thresholds in OP5
param(
    [Parameter(Mandatory = $true)][Int]$thresholdWarning,
    [Parameter(Mandatory = $true)][Int]$thresholdCritical
)

# Check version on powershell and reject to run if to old
$powerversion = 4

if ($PSVersionTable.PSVersion.Major -lt $powerversion){
    Write-Host "Powershell version less than $powerversion"
}

# Add snapin for Exchange Management Shell
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

# Get Submission-queue for local machine
$submissionQueue = (Get-MailboxServer -Identity $env:COMPUTERNAME | Get-Queue | where {$_.identity -like "*submission*"})

# Compare MessageCount to thresholds set by user and tell OP5 what return codes to throw
if($submissionQueue.MessageCount  -lt $thresholdWarning){
    # OK to OP5
    write-host "SubmissionQueue below warning levels:"$submissionQueue.MessageCount" Status:"$submissionQueue.Status
    exit 0
}

elseif($submissionQueue.MessageCount -ge $treshold_warning -and $submissionQueue.MessageCount -lt $thresholdCritical){
    # Warning to OP5
    write-host "SubmissionQueue over warning levels: "$submissionQueue.MessageCount" Status:"$submissionQueue.Status
    exit 1
}

elseif($submissionQueue.MessageCount -ge $treshold_warning -and $submissionQueue.MessageCount -ge $thresholdCritical){
    # Critical to OP5
    write-host "SubmissionQueue over critical levels: "$submissionQueue.MessageCount" Status:"$submissionQueue.Status
    exit 2
}

else{
    # If check fails to OP5
    write-host "Error - Could not execute script on remote target"
    exit 3
}