<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 08:08
	 Created by:   	administrator
	 Organization: 	
	 Filename:     	test.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

function Log
{
	param ([string]$filename,
		[string]$text)
	Out-File $filename -append -noclobber -inputobject $text -encoding ASCII
}

Import-Module Posh-SSH

