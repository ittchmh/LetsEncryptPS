<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 18:31
	 Created by:   	HmH
	 Organization: 	ITTC.com.ua
	 Filename:     	Set-LetsEncryptPsSettings.ps1
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
		Set-LetsEncryptPsSettings and save to file or edit options.json.
	
	.DESCRIPTION
		Set-LetsEncryptPsSettings and save to fileor edit options.json.
	
	.PARAMETER PasswordId
		PasswordID in Password State
	
	.PARAMETER UserName
		ApiKey and User name
		CertManagement

	.PARAMETER Repository
		A description of the Repository parameter.
		C:\Users\admin\.passwordstate

	.PARAMETER PFXPassStoreName
		A description of the PFXPassStoreName parameter.
		C:\Users\admin\.passwordstate\pfx.cred	

	.PARAMETER CredentialType
		A description of the CredentialType parameter.
		PS or Win 

	.EXAMPLE
		PS C:\> Set-LetsEncryptPsSettings -PasswordId $value1
		PS C:\> Set-LetsEncryptPsSettings -PasswordId 1234 -UserName "CertMGM" -Repository "C:\Users\administrator.ITTC\.passwordstate" `
										  -PFXPassStoreName "C:\Users\administrator.ITTC\.passwordstate\pfx.cred" `
										  -CredentialType "PS" -Verbose
	.NOTES
		Additional information about the function.
#>
function Set-LetsEncryptPsSettings
{
	param
	(
		[Parameter(Mandatory = $true)]
		[int]$PasswordId,
		[string]$UserName = "$env:UserName",
		[string]$Repository = (_GetDefault -Option 'credential_repository'),
		[string]$PFXPassStoreName = (Join-Path -Path $Repository -ChildPath 'pfx.cred'),
		[ValidateSet('PS', 'Win', IgnoreCase = $true)]
		[string]$CredentialType = 'PS'
	)
	
	if ($PSBoundParameters.ContainsKey('Repository'))
	{
		if (Test-Path -Path $Repository -Verbose:$false)
		{
			# Get options from .option file
			$options = (Get-Content -Path (Join-Path -Path $Repository -ChildPath 'options.json') -Force -Verbose:$false) | ConvertFrom-Json
		}
		else
		{
			Write-Debug "Repository error"
			break	
		}
	}
	else
	{
		if ((Get-Member -inputobject $options -name "credential_repository" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.Repository))))
		{
			$options.Repository = $Repository
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name Repository -Value $Repository
		}
	}
	
	# Get options from .option file
	#$options = (Get-Content -Path (Join-Path -Path $Repository -ChildPath 'options.json') -Force -Verbose:$false) | ConvertFrom-Json
	
	# Edit PasswordID property
	if ((Get-Member -inputobject $options -name "PasswordId" -Membertype Properties) -and $options.PasswordId -gt 0)
	{
		$options.PasswordId = $PasswordId
	}
	# Add PasswordID property
	else
	{
		$options | Add-Member -MemberType NoteProperty -Name PasswordId -Value $PasswordId
	}
	
	# UserName Property
	if ($PSBoundParameters.ContainsKey('Username'))
	{
		if ((Get-Member -inputobject $options -name "Username" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.Username))))
		{
			$options.Username = $UserName
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
		}
	}
	else
	{
		if ((Get-Member -inputobject $options -name "Username" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.Username))))
		{
			$options.Username = $UserName
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
		}
	}
	
	# PFXPassStoreName Property
	if ($PSBoundParameters.ContainsKey('PFXPassStoreName'))
	{
		if ((Get-Member -inputobject $options -name "PFXPassStoreName" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.PFXPassStoreName))))
		{
			$options.PFXPassStoreName = $PFXPassStoreName
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name PFXPassStoreName -Value $PFXPassStoreName
		}
	}
	else
	{
		if ((Get-Member -inputobject $options -name "PFXPassStoreName" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.PFXPassStoreName))))
		{
			$options.PFXPassStoreName = $PFXPassStoreName
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name PFXPassStoreName -Value $PFXPassStoreName
		}
	}
	
	# CredentialType Property
	if ($PSBoundParameters.ContainsKey('CredentialType'))
	{
		if ((Get-Member -inputobject $options -name "CredentialType" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.CredentialType))))
		{
			$options.CredentialType = $CredentialType
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name CredentialType -Value $CredentialType
		}
	}
	else
	{
		if ((Get-Member -inputobject $options -name "CredentialType" -Membertype Properties) -and (-not ([string]::IsNullOrEmpty($options.CredentialType))))
		{
			$options.CredentialType = $CredentialType
		}
		else
		{
			$options | Add-Member -MemberType NoteProperty -Name CredentialType -Value $CredentialType
		}
	}
	
	$json = $options | ConvertTo-Json -Verbose:$false
	Write-Debug -Message $json
	$json | Out-File -FilePath (Join-Path -Path $Repository -ChildPath 'options.json') -Force -Confirm:$false -Verbose:$false
}
