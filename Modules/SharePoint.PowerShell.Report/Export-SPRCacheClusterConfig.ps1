function Export-SPRCacheClusterConfig
{
  param(
    [string]$Path,
    [bool]$Async
  )

  $file = '{0}\SPRCacheClusterConfig.xml' -f $Path
  
  $scriptblock = {
    param($Path = $file)
    Use-CacheCluster
    Write-Host -Object 'Exporting: Distributed Cache Config. ' -NoNewline

    Export-CacheClusterConfig -Path c:\SPCacheClusterConfig.xml
    $output = [xml](get-content c:\SPCacheClusterConfig.xml)
    foreach ($cacheHost in $output.configuration.dataCache.hosts.host)
    {
      $cacheHost = Get-CacheHost -ComputerName sp2013.contoso.com -CachePort 22233
      $output.configuration.dataCache.hosts.host | Add-Member -MemberType NoteProperty -Name 'Status' -Value $cacheHost.Status
    }

    $output | Export-Clixml -Path $Path

    Write-Host -Object ' Done.'
  } 

  if($Async) 
  {
    Export-SPRObject -ScriptBlock $scriptblock -File $file -Async
  } else 
  {
    Export-SPRObject -ScriptBlock $scriptblock -File $file
  }
}
