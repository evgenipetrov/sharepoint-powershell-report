function Get-SPRIISSettings
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRWebApplication
  )
	
  foreach ($webApplication in $SPRWebApplication)
  {
    $alternateUrls = $webApplication.AlternateUrls
    
    foreach ($alternateUrl in $alternateUrls)
    {
      $ssl = $alternateUrl.PublicUrl -like 'https*'
      
      $properties = [ordered]@{
        'DisplayName'           = $webApplication.DisplayName
        'Url'                   = $alternateUrl.IncomingUrl
        'Zone'                  = $alternateUrl.Zone
        'Authentication'        = $alternateUrl.authentication
        'ApplicationPoolName'   = $webApplication.ApplicationPool.Name
        'ApplicationPoolIdentity' = $webApplication.ApplicationPool.Username
        'SSL'                   = $ssl
        'ClaimsAuth'            = $webApplication.UseClaimsAuthentication
        'CEIP'                  = $webApplication.BrowserCEIPEnabled
      }
      
      $output = New-Object -TypeName PSObject -Property $properties
      Write-Output -InputObject $output
    }
  }
}
