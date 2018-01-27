<#	
	.NOTES
	===========================================================================
	 Created on:   	27.01.2018 08:07
	 Created by:   	HmH
	 Organization: 	ITTC.com.ua
	 Filename:     	Usage-Example.ps1
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

#Explicitly import the module for testing
Import-Module 'Posh-SSH'
Import-Module 'LetsEncryptPS'

# Initialize PasswordState Repository
Initialize-PsCredRepo -ApiEndpoint "https://psswordstate.local/api"

# Initialize Win Credential Repository
#Initialize-PsCredRepo -CredType "Win"

# Save password data to repository
Export-PsCredToFile
#Export-PsCredToFile -CredentialType Win

# Save settings to options file
Set-LetsEncryptPsSettings -PasswordId 1234 -Verbose
#Set-LetsEncryptPsSettings -PasswordId 1234 -UserName "CertMGM" -Repository "C:\Users\administrator.ITTC\.passwordstate" `
#						  -PFXPassStoreName "C:\Users\administrator.ITTC\.passwordstate\pfx.cred" `
#						  -CredentialType "PS" -Verbose


