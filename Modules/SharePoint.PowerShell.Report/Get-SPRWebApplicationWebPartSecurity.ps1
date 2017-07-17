function Get-SPRWebApplicationWebPartSecurity
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRWebApplication
  )
	
  foreach ($webApplication in $SPRWebApplication)
  {
    $properties = [ordered]@{
      'DisplayName' = $webApplication.DisplayName
      'OnlineWebPartGallery' = $webApplication.AllowAccessToWebPartCatalog
      'WebPartConnections' = $webApplication.AllowPartToPartCommunication
      'ScriptableWebParts' = $webApplication.AllowContributorsToEditScriptableParts
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}