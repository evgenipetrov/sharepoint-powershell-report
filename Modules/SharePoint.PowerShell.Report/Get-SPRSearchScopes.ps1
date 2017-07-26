function Get-SPRSearchScopes
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    foreach ($searchQueryScope in $searchServiceApplication.SearchQueryScopes)
    {
        $properties = [ordered]@{
      'ServiceApplication'      = $searchServiceApplication.Name
      'DisplayName'             = $searchQueryScope.Name
      'LastModifiedBy'          = $searchQueryScope.LastModifiedBy
      'AlternateResultsPage'    = $searchQueryScope.AlternateResultsPage
      'DefaultSearchResults'    = '?'
      'DifferentPageForSearching' = '?'
      'RuleCount'              = $searchQueryScope.Rules.Count
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
      
    }
    

  }
}