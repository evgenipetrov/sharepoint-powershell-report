function Get-SPRSiteCollectionQuotas
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRSite,
    [Parameter(Mandatory = $true)]
    [object[]]$SPRQuotaTemplate
  )
	
  foreach ($site in $SPRSite)
  {
    $quotaID = $site.Quota.QuotaID
    $quotaName = 'Individual Quota'
    foreach ($quotaTemplate in $SPRQuotaTemplate) {
        if ($quotaTemplate.QuotaID -eq $site.Quota.QuotaID) {
            $quotaName = $quotaTemplate.Name
        }
    }

    $properties = [ordered]@{
      'SiteCollection'    = $site.RootWeb.Title
      'URL'               = $site.RootWeb.Url
      'QuotaName'         = $quotaName
      'LockStatus'        = $site.IsReadLocked
      'StorageMaximumLevel' = $site.Quota.StorageMaximumLevel
      'StorageWarningLevel' = $site.Quota.StorageWarningLevel
      'UsageStorage'      = $site.Usage.Storage
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}