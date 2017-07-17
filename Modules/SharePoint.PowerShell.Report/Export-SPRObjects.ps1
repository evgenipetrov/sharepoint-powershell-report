function Export-SPRObjects
{
  [OutputType([void])]
  param
  (
    [Parameter(
        Mandatory = $true,
    Position = 0)]
    [string]$Path,
    [bool]$Async
  )

  if (!(Test-Path -PathType Container -Path $Path))
  {
    mkdir -Path $Path
  } 
	
  Add-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
  
  #Export-SPRFarm -Path $Path -Async $Async
  #Export-SPRDatabase -Path $Path -Async $Async
  #Export-SPRServer -Path $Path -Async $Async
  #Export-SPRSite -Path $Path -Async $Async
  #Export-SPRWebApplication -Path $Path -Async $Async
  #Export-SPREnterpriseSearchServiceApplication -Path $Path -Async $Async
  #Export-SPRFeature -Path $Path -Async $Async
  
  
  ###Export-SPREnterpriseSearchTopologyConfiguration -Path $Path -Async $Async
  ###Export-SPREnterpriseSearchComponent -Path $Path -Async $Async
  #
  ###Export-SPRManagedPath -Path $Path -Async $Async
  #Export-SPRManagedAccount -Path $Path -Async $Async
  ###Export-SPRAlternateUrl -Path $Path -Async $Async
  #Export-SPRAuthenticationProvider -Path $Path -Async $Async
  #Export-SPRDiagnosticLogging -Path $Path -Async $Async
  #Export-SPRContentDeploymentSettings -Path $Path -Async $Async
  #Export-SPRCacheClusterConfig -Path $Path -Async $Async
  #Export-SPRCacheHost -Path $Path -Async $Async
  #Export-SPRLogLevel -Path $Path -Async $Async
  #Export-SPRFarmAdmins -Path $Path -Async $Async
  #Export-SPRWebServices -Path $Path -Async $Async
  #Export-SPRWebServicesAdministration -Path $Path -Async $Async
  #Export-SPRScheduledTasks -Path $Path -Async $Async
  #Export-SPRUserProfileManager -Path $Path -Async $Async
  #Export-SPRUserProfileServiceApplication -Path $Path -Async $Async
  #Export-SPRQuotaTemplates -Path $Path -Async $Async
  #Export-SPREnterpriseSearchServiceApplicationInstance -Path $Path -Async $Async
    
  if($Async)
  {
    Write-Host -Object 'Waiting on exports to complete...' -NoNewline
    $null = Get-Job | 
    Wait-Job
    Write-Host -Object 'Done.'
  }
  Remove-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
}

