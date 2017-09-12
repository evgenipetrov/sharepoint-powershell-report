function Get-SPRSearchIndexPartitions
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    $indexComponents = $searchServiceApplication.SearchComponent | Where-Object {$_.Name -eq 'IndexComponent1'}
    foreach ($indexComponent in $indexComponents)
    {
      $properties = [ordered]@{
        'Name'             = $indexComponent.Name
        'Topology'         = $indexComponent.TopologyId
        'ServiceApplication' = $searchServiceApplication.Name
        'Server'           = $indexComponent.ServerName
        'RootDirectory'    = $indexComponent.RootDirectory
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}