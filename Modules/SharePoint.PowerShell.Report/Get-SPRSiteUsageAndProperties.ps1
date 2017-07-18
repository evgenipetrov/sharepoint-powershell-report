function Get-SPRSiteUsageAndProperties
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRSite
  )
	
  foreach ($site in $SPRSite)
  {
    $properties = [ordered]@{
      'SiteCollectionTitle' = $site.RootWeb.Title
      'SiteCollectionUrl' = $site.Url
      'Language'     = $site.RootWeb.Language
      'Template'     = $site.RootWeb.WebTemplate
      'NumberOfSites' = $site.AllWebs.Count
      'UIVersion'    = $site.RootWeb.UIVersion
      'Storage'      = $site.Usage.Storage
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}