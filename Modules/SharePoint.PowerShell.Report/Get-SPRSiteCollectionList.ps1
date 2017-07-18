function Get-SPRSiteCollectionList
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRDatabase
  )
	
  $contentDatabases = $SPRDatabase | Where-Object -FilterScript {
    $_.Type -eq 'Content Database'
  }
  
  foreach ($contentDatabase in $contentDatabases)
  {
    $sites = $contentDatabase.Sites
    foreach ($site in $sites)
    {
      $owners = $site.Owner.DisplayName
      if($site.SecondaryContact -ne $null)
      {
        $owners += ','
        $owners += $site.SecondaryContact
      }

      $properties = [ordered]@{
        'WebApplication'              = $contentDatabase.WebApplication.DisplayName
        'SiteCollectionTitle'         = $site.RootWeb
        'SiteCollectionUrl'           = $site.Url
        'SiteCollectionContentDatabase' = $contentDatabase.Name
        'Owners'                      = $owners
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}
