function Get-SPRSearchFileTypes
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPREnterpriseSearchServiceApplication
  )
	
  foreach ($searchServiceApplication in $SPREnterpriseSearchServiceApplication)
  {
    $filetypes = ($searchServiceApplication.CrawlFileExtensions | Select-Object -ExpandProperty FileExtension) -join (',')
    $properties = [ordered]@{
      'ServiceApplication' = $searchServiceApplication.Name
      'FileTypes'        = $filetypes
    }
    $output = New-Object -TypeName PSObject -Property $properties
		
    Write-Output -InputObject $output
  }
}
