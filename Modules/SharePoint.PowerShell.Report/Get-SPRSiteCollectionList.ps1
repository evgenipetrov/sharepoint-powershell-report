function Get-SPRSiteCollectionList
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRSite
  )
	
    foreach ($site in $SPRSite)
    {
      $owners = $site.Owner.DisplayName
      if($site.SecondaryContact -ne $null)
      {
        $owners += ','
        $owners += $site.SecondaryContact
      }

      $properties = [ordered]@{
        'WebApplication'              = $site.WebApplication.DisplayName
        'SiteCollectionTitle'         = $site.RootWeb.Title
        'SiteCollectionUrl'           = $site.Url
        'SiteCollectionContentDatabase' = $site.ContentDatabase.Name
        'Owners'                      = $owners
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }

