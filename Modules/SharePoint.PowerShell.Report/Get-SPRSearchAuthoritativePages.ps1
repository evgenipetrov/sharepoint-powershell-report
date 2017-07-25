function Get-SPRSearchAuthoritativePages
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
      'Url'              = $searchServiceApplication.SearchQueryAuthority.Url
      'Level'            = $searchServiceApplication.SearchQueryAuthority.Level
      'Status'           = $searchServiceApplication.SearchQueryAuthority.Status
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}