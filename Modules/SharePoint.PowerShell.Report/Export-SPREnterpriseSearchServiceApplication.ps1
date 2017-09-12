function Export-SPREnterpriseSearchServiceApplication
{
  param(
    [string]$Path,
    [bool]$Async
  )

  $file = '{0}\SPREnterpriseSearchServiceApplication.xml' -f $Path
    
  $scriptblock = {
    param($Path = $file)
    Write-Host -Object 'Exporting: Search Service Application Configuration. ' -NoNewline
    
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    $searchServiceApplications = Get-SPEnterpriseSearchServiceApplication


    
    $output = @()
    foreach ($searchServiceApplication in $searchServiceApplications)
    {
      $mySearchServiceApplication = $searchServiceApplication | Select-Object -Property Name, Id, LocationConfigurations

      $content = New-Object -TypeName Microsoft.Office.Server.Search.Administration.Content -ArgumentList $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'Content' -Value $content

      $crawlContentSource = Get-SPEnterpriseSearchCrawlContentSource -SearchApplication $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'CrawlContentSources' -Value $crawlContentSource

      $searchCrawlDatabase = Get-SPEnterpriseSearchCrawlDatabase -SearchApplication $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchCrawlDatabase' -Value $searchCrawlDatabase

      $searchFileExtension = Get-SPEnterpriseSearchCrawlExtension -SearchApplication $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'CrawlFileExtensions' -Value $searchFileExtension

      $searchOwner = Get-SPEnterpriseSearchOwner -Level Ssa
      $searchQueryAuthority = Get-SPEnterpriseSearchQueryAuthority -SearchApplication $searchServiceApplication -Owner $searchOwner
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchQueryAuthority' -Value $searchQueryAuthority
      
      $topology = $searchServiceApplication | Get-SPEnterpriseSearchTopology
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchTopology' -Value $topology
      
      $component = $searchServiceApplication |
      Get-SPEnterpriseSearchTopology -Active |
      Get-SPEnterpriseSearchComponent
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchComponent' -Value $component

      $managedProperties = Get-SPEnterpriseSearchMetadataManagedProperty -SearchApplication $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'ManagedProperties' -Value $managedProperties

      $searchQueryScopes = Get-SPEnterpriseSearchQueryScope -SearchApplication $searchServiceApplication
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchQueryScopes' -Value $searchQueryScopes

      $searchServiceInstances = Get-SPEnterpriseSearchServiceInstance
      $mySearchServiceApplication | Add-Member -MemberType NoteProperty -Name 'SearchServiceInstances' -Value $searchServiceInstances

      $output += $mySearchServiceApplication
    }

    $output | Export-Clixml -Path $Path -Depth 5
    Write-Host -Object ' Done.'
  }
  if($Async) 
  {
    Export-SPRObject -ScriptBlock $scriptblock -File $file -Async
  }
  else 
  {
    Export-SPRObject -ScriptBlock $scriptblock -File $file
  }
}
