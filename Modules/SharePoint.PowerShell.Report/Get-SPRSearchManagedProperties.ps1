function Get-SPRSearchManagedProperties
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    foreach ($managedProperty in $searchServiceApplication.ManagedProperties)
    {
      $properties = [ordered]@{
        'ServiceApplication' = $searchServiceApplication.Name
        'ServiceApplicationID' = $searchServiceApplication.ID
        'ManagedPropertyName' = $managedProperty.Name
        'Type'               = $managedProperty.ManagedType
        'MayBeDeleted'       = !($managedProperty.DeleteDisallowed)
        'UseInScopes'        = $managedProperty.EnabledForScoping
        'Optimized'          = $managedProperty.IsInFixedColumnOptimizedResults
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}
