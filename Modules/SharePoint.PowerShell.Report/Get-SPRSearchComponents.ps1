function Get-SPRSearchComponents
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    foreach ($searchComponent in $searchServiceApplication.SearchComponent)
    {
      $properties = [ordered]@{
        'Name'             = $searchComponent.Name
        'Topology'         = $searchComponent.TopologyId
        'ServiceApplication' = $searchServiceApplication.Name
        'Server'           = $searchComponent.ServerName
        'Type'             = $searchComponent
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}
