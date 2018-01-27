<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 12:18
	 Created by:   	HmH
	 Organization: 	ITTC.com.ua
	 Filename:     	Initialize-WinCredRepository.ps1
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

function Initialize-WinCredRepository
{
	[CmdletBinding()]
	param
	(
		[string]$CredentialRepository = (Join-Path -path $env:USERPROFILE -ChildPath '.wincred' -Verbose:$false)
	)
	
	# If necessary, create our repository under $env:USERNAME\.wincred
	$repo = (Join-Path -Path $env:USERPROFILE -ChildPath '.wincred')
	if (-not (Test-Path -Path $repo -Verbose:$false))
	{
		Write-Debug -Message "Creating WinCred configuration repository: $repo"
		New-Item -ItemType Directory -Path $repo -Verbose:$false | Out-Null
	}
	else
	{
		Write-Debug -Message "WinCred configuration repository appears to already be created at [$repo]"
	}
	
	$options = @{
		credential_repository   = $CredentialRepository
	}
	
	$json = $options | ConvertTo-Json -Verbose:$false
	Write-Debug -Message $json
	$json | Out-File -FilePath (Join-Path -Path $repo -ChildPath 'options.json') -Force -Confirm:$false -Verbose:$false
}