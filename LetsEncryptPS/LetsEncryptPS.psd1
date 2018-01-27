<#	
	===========================================================================
	 Created on:   	25.01.2018 08:23
	 Created by:   	HmH
	 Organization: 	ITTC
	 Filename:     	LetsEncryptPS.psd1
	 -------------------------------------------------------------------------
	 Module Manifest
	-------------------------------------------------------------------------
	 Module Name: LetsEncryptPS
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


@{
	
	# Script module or binary module file associated with this manifest
	ModuleToProcess = 'LetsEncryptPS.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.0.0.0'
	
	# ID used to uniquely identify this module
	GUID = '1a00239d-1d39-47b3-8d2c-3e9fbc82fc60'
	
	# Author of this module
	Author = 'hmh'
	
	# Company or vendor of this module
	CompanyName = 'ITTC.com.ua'
	
	# Copyright statement for this module
	Copyright = '(c) 2018. All rights reserved.'
	
	# Description of the functionality provided by this module
	Description = 'Automate LetsEncrypt Certificates Deployment with pfSesne and PasswordState'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '3.0'
	
	# Name of the Windows PowerShell host required by this module
	#PowerShellHostName = ''
	
	# Minimum version of the Windows PowerShell host required by this module
	#PowerShellHostVersion = ''
	
	# Minimum version of the .NET Framework required by this module
	#DotNetFrameworkVersion = '2.0'
	
	# Minimum version of the common language runtime (CLR) required by this module
	#CLRVersion = '2.0.50727'
	
	# Processor architecture (None, X86, Amd64, IA64) required by this module
	#ProcessorArchitecture = 'None'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = 'Posh-SSH'
	
	# Assemblies that must be loaded prior to importing this module
	#RequiredAssemblies = @()
	
	# Script files (.ps1) that are run in the caller's environment prior to
	# importing this module
	#ScriptsToProcess = @()
	
	# Type files (.ps1xml) to be loaded when importing this module
	#TypesToProcess = @()
	
	# Format files (.ps1xml) to be loaded when importing this module
	#FormatsToProcess = @()
	
	# Modules to import as nested modules of the module specified in
	# ModuleToProcess
	#NestedModules = @()
	
	# TODO: Define all functions 
	# Functions to export from this module
	FunctionsToExport = '*' #For performanace, list functions explicity
	
	# Cmdlets to export from this module
	#CmdletsToExport = '*' 
	
	# Variables to export from this module
	#VariablesToExport = '*'
	
	# Aliases to export from this module
	#AliasesToExport = '*' #For performanace, list alias explicity
	
	# List of all modules packaged with this module
	#ModuleList = @()
	
	# List of all files packaged with this module
	#FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = 'Let''s Encrypt, pfSense, PowerShell, Exchange Server, Remote Desktop Web Access'
			
			# A URL to the license for this module.
			LicenseUri = 'https://github.com/ittchmh/LetsEncryptPS/blob/master/LICENSE.md'
			
			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/ittchmh/LetsEncryptPS/'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}