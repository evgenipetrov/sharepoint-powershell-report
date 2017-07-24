function Get-SPRSearchSettings
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication    
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    $properties = [ordered]@{
      'ServiceApplication'        = $searchServiceApplication.Name
      'DefaultContentAccessAccount' = $searchServiceApplication.Content.DefaultGatheringAccount
      'ContactEmailAddress'       = $XXX
      'IndexLocation'             = $searchServiceApplication.CrawlComponents.IndexLocation
      'SearchAlertsStatus'        = $searchServiceApplication.AlertsEnabled
      'QueryLogging'              = $searchServiceApplication.QueryLoggingEnabled
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}
