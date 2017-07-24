#requires -Version 3.0
function Get-SPRDistributedCacheConfig
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRCacheClusterConfig
  )

  foreach ($entry in $SPRCacheClusterConfig.configuration.dataCache.hosts.host)
  {
    $properties = [ordered]@{
      'Host'          = $entry.Name
      'Size'          = $entry.Size
      'CachePort'     = $entry.CachePort
      'ClusterPort'   = $entry.ClusterPort
      'ReplicationPort' = $entry.ReplicationPort
      'ArbitrationPort' = $entry.ArbitrationPort
      'Status'        = $entry.Status
    }
    $output = New-Object -TypeName PSObject -Property $properties
    Write-Output -InputObject $output
  }
}
