function Get-SPRSearchTopologies
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )

  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    foreach ($topology in $searchServiceApplication.SearchTopology)
    {
      $properties = [ordered]@{
        'ServiceApplication' = $searchServiceApplication.Name
        'Topology'         = $topology.TopologyId
        'CreationDate'     = $topology.CreationDate
        'State'            = $topology.State
        'ComponentCount'   = $topology.ComponentCount
        'IsActive'         = $topology.State
      }
      $output = New-Object -TypeName PSObject -Property $properties
      Write-Output -InputObject $output
    }
  }
}
