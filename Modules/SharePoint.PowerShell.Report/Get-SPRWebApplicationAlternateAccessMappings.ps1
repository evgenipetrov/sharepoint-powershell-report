function Get-SPRWebApplicationAlternateAccessMappings
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRWebApplication
  )
	
  foreach ($webApplication in $SPRWebApplication)
  {
    $alternateURLs = $webApplication.AlternateUrls
    foreach ($alternateUrl in $alternateURLs)
    {
      $properties = [ordered]@{
        'DisplayName' = $webApplication.DisplayName
        'InternalUrl' = $alternateUrl.IncomingUrl
        'Zone'      = $alternateUrl.Zone
        'Url'       = $alternateUrl.PublicUrl
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}
