function Get-SPRSearchCrawlStores
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    $properties = [ordered]@{
      'ServiceApplication' = $searchServiceApplication.Name
      'Name'             = $searchServiceApplication.SearchCrawlDatabase.Name
      'SQLServer'        = $searchServiceApplication.Database.Server.Name
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}