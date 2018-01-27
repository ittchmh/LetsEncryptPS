<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 12:13
	 Created by:   	HmH
	 Organization: 	ITTC.com.ua
	 Filename:     	Initialize-PsCredRepo.ps1
	===========================================================================
	.DESCRIPTION
	
	Copyright 2018 HmH
	
	Part of code used from project https://github.com/devblackops/PasswordState/
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
		A brief description of the Initialize-PsCredRepo function.
	
	.DESCRIPTION
		A detailed description of the Initialize-PsCredRepo function.
	
	.PARAMETER ApiEndpoint
		Password State API Endpoint
	
	.PARAMETER CredentialRepository
		Credential Repository path
	
	.EXAMPLE
		PS C:\> Initialize-PsCredRepo
	
	.OUTPUTS
		string
	
	.NOTES
		Additional information about the function.
#>

<#
	.SYNOPSIS
		Initialize Credential Repository.
	
	.DESCRIPTION
		Initialize Credential Repository.
		Could be Windows credential or PasswordState API key.
	
	.PARAMETER ApiEndpoint
		PasswordState API Endpoint
	
	.PARAMETER CredentialRepository
		Credential repositry path
	
	.PARAMETER CredType
		Initialize credential repo. Default PasswordState. Valid options
		PS - PasswordState
		Win - Windows credentials
	
	.EXAMPLE
		For PasswordState repository run:
		PS C:\> Initialize-PsCredRepo -ApiEndpoint 'https://passwst.domain.local/api'
		
		For Windows credential repository run:
		PS C:\> Initialize-PsCredRepo -CredType "Win"
	
	.NOTES
		Additional information about the function.
#>
function Initialize-PsCredRepo
{
	[CmdletBinding(DefaultParameterSetName = 'PS')]
	param
	(
		[Parameter(ParameterSetName = 'PS',
				   Mandatory = $true,
				   Position = 1)]
		[ValidatePattern('^(https?\:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})+(\/[api]{3})')]
		[string]$ApiEndpoint,
		[Parameter(ParameterSetName = 'PS',
				   Position = 2)]
		[Parameter(ParameterSetName = 'Win',
				   Position = 1)]
		[string]$CredentialRepository,
		[Parameter(ParameterSetName = 'PS',
				   Mandatory = $false,
				   Position = 3,
				   HelpMessage = 'Credential type. PS or Win.')]
		[Parameter(ParameterSetName = 'Win',
				   Mandatory = $false,
				   Position = 2,
				   HelpMessage = 'Credential type. PS or Win.')]
		[ValidateSet('PS', 'Win')]
		[string]$CredType = 'PS'
	)
	
	#
	if (-not ([string]::IsNullOrEmpty($ApiEndpoint)))
	{
		$CredType = 'PS'
	}
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'PS' {
			$CredentialRepository = (Join-Path -path $env:USERPROFILE -ChildPath '.passwordstate' -Verbose:$false)
			Initialize-PasswordStateRepository -ApiEndpoint $ApiEndpoint -CredentialRepository $CredentialRepository
		}
		'Win' {
			$CredentialRepository = (Join-Path -path $env:USERPROFILE -ChildPath '.wincred' -Verbose:$false)
			Initialize-WinCredRepository -CredentialRepository $CredentialRepository
		}
	}
}
