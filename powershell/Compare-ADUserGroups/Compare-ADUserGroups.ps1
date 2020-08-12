<#
.Synopsis
    This script compares two different AD users and outputs which groups are common and which groups are user specific.


.DESCRIPTION
    This script is used for troubleshooting why users don't get the access they need based on Active Directory user groups.
		Instead of opening up the AD console to scroll back and forth in two user accounts it outputs the similarities and differences in a grid view.

.NOTES

	    FileName:  Compare-UserGroups

	    Author:  Tim Wetterek Andersson

	    Contact: timwa@protonmail.com

	    Created: 2019-04-01

#>

$input_user1 = Get-ADUser "username1"
$input_user2 = Get-ADUser "username2"

$user1 = Get-ADPrincipalGroupMembership -Identity $input_user1
$user2 = Get-ADPrincipalGroupMembership -Identity $input_user2

$result = Compare-Object -referenceobject ($user) -DifferenceObject ($user2) -Property name -IncludeEqual | Foreach-object {
	if ($_.SideIndicator -eq '=>')
	{
		$_.SideIndicator = $input_user1.givenName + ' ' + $input_user1.Surname + 's group'

	}

	elseif ($_.SideIndicator -eq '<=')
	{
		$_.SideIndicator = $input_user2.givenName + ' ' + $input_user2.Surname + 's group'
	}

    elseif ($_.SideIndicator -eq '==')
	{
		$_.SideIndicator = 'Common group'
	}
	$_
}  | Out-GridView
