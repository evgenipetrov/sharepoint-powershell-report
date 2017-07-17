function Get-SPRWebApplicationManagedPaths
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRWebApplication
  )
	
  foreach ($webApplication in $SPRWebApplication)
  {
    $managedPaths = $webApplication.ManagedPaths
    
    foreach ($managedPath in $ManagedPaths)
    {
      if($managedPath.Name -eq '')
      {
        $name = '/'
      }
      else 
      {
        $name = '/{0}/' -f $managedPath.Name
      }
      
      if ($managedPath.Type -eq 'ExplicitInclusion')
      {
        $prefixType = 'Explicit Inclusion'
      }
      elseif($managedPath.Type -eq 'WildcardInclusion') 
      {
        $prefixType = 'Wildcard Inclusion'
      }
      
      $properties = @{
        'WebApplicationUrl' = $webApplication.Url
        'Name'      = $name
        'PrefixType' = $prefixType
      }

      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}