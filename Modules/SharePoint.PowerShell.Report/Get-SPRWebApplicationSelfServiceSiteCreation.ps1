﻿function Get-SPRWebApplicationSelfServiceSiteCreation
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPWebApplication
  )
	
  foreach ($webApplication in $SPWebApplication)
  {
    $properties = [ordered]@{
      'WebApplicationName'    = $webApplication.DisplayName
      'WebApplicationUrl' = $webApplication.Url
      'Allowed' = $webApplication.SelfServiceCreateIndividualSite
      'RequireSecondaryContact' = $webApplication.RequireContactForSelfServiceSiteCreation
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}