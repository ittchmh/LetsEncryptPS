<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 14:19
	 Created by:   	HmH
	 Organization: 	ITTC.com.ua
	 Filename:     	Export-PsCredToFile.ps1
	===========================================================================
	.DESCRIPTION
	
	Copyright 2018 HmH
	
	Code used from project https://github.com/devblackops/PasswordState/
	Copyright 2015 Brandon Olin
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
#>

<#
	.SYNOPSIS
		Export credential
	
	.DESCRIPTION
		Export credential. Should run under automation user.
	
	.PARAMETER CredentialType
		A description of the CredentialType parameter.
	
	.PARAMETER Repository
		A description of the Repository parameter.
	
	.PARAMETER Verbose
		A description of the Verbose parameter.
	
	.PARAMETER Debug
		A description of the Debug parameter.
	
	.EXAMPLE
		PS C:\> Export-PsCredToFile
	
	.NOTES
		Additional information about the function.
#>
function Export-PsCredToFile
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $false)]
		[ValidateSet('PS', 'Win', IgnoreCase = $true)]
		[string]$CredentialType = 'PS',
		[string]$Repository
	)
	
	#TODO: Rewrite to accept ValueFromPipeline = $true
	
	if ($CredentialType -eq 'Win')
	{
		Write-Verbose "Using credential type: $CredentialType"
		$User = "$env:UserName"
		$Credential = $Host.ui.PromptForCredential("Need credentials for WinCred", "Please enter Store name and Windows Password.", "$User", "WinCreds")
		$CredentialPFX = $Host.ui.PromptForCredential("Need credentials PFX Crtificate", "Please enter Store name and PFX Password.", "pfx", "PFX Password")
		if ([string]::IsNullOrEmpty($Repository))
		{
			$Repository = (Join-Path -Path $env:USERPROFILE -ChildPath '.wincred')
			Write-Verbose "Repository parameter not set, using default for WinCred"
			Write-Verbose $Repository
			Export-PasswordStateApiKey -ApiKey $Credential -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference
			Export-PasswordStateApiKey -ApiKey $CredentialPFX -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference

		}
		else
		{
			Export-PasswordStateApiKey -ApiKey $Credential -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference
			Export-PasswordStateApiKey -ApiKey $CredentialPFX -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference
		}
	}
	else
	{
		Write-Verbose "Using credential type: $CredentialType"
		$User = "$env:UserName"
		$Credential = $Host.ui.PromptForCredential("Need credentials for PS API", "Please enter Store name and PS API Key.", "$User", "PasswordState")
		$CredentialPFX = $Host.ui.PromptForCredential("Need credentials PFX Crtificate", "Please enter Store name and PFX Password.", "pfx", "PFX Password")
		if ([string]::IsNullOrEmpty($Repository))
		{
			Export-PasswordStateApiKey -ApiKey $Credential
			Export-PasswordStateApiKey -ApiKey $CredentialPFX
		}
		else
		{
			Export-PasswordStateApiKey -ApiKey $Credential -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference
			Export-PasswordStateApiKey -ApiKey $CredentialPFX -Repository $Repository -verbose:$VerbosePreference -Debug:$DebugPreference
		}
	}
}
