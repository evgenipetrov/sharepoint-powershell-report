function Export-SPRWebApplication
{
  param(
    [string]$Path,
    [bool]$Async
  )

  $file = '{0}\SPRWebApplication.xml' -f $Path
  
  $scriptblock = {
    param($Path = $file)
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    Write-Host -Object 'Exporting: Web Application Configuration. ' -NoNewline

    $webApplications = Get-SPWebApplication -IncludeCentralAdministration
    $output = @()
    foreach ($webApplication in $webApplications)
    {
      $superUserHasFullControl = $null
      $superUserAccount = $webApplication.Properties['portalsuperuseraccount'] 
      $superUserHasFullControl = (($webApplication.Policies | Where-Object -FilterScript {
            $_.UserName -like "*$superUserAccount"
      } ) | Select-Object -First 1 -ExpandProperty PolicyRoleBindings ).Name -eq 'Full Control' 
      $webApplication | Add-Member -MemberType NoteProperty -Name 'SuperUserHasFullControl' -Value $superUserHasFullControl -Force
      
      $superReaderHasFullRead = $null
      $superReaderAccount = $webApplication.Properties['portalsuperreaderaccount'] 
      $superReaderHasFullRead = (($webApplication.Policies | Where-Object -FilterScript {
            $_.UserName -like "*$superReaderAccount"
      } ) | Select-Object -First 1 -ExpandProperty PolicyRoleBindings ).Name -eq 'Full Read' 
      $webApplication | Add-Member -MemberType NoteProperty -Name 'SuperReaderHasFullRead' -Value $superReaderHasFullRead -Force
      
      $managedPaths = Get-SPManagedPath -WebApplication $webApplication
      $myManagedPaths = @()      
      foreach ($managedPath in $managedPaths)
      {
        $properties = @{
          'Name'     = $managedPath.Name
          'Type' = $managedPath.Type
        }
        $myManagedPath = New-Object -TypeName PSObject -Property $properties
        $myManagedPaths += $myManagedPath
      }
      
      $webApplication | Add-Member -MemberType NoteProperty -Name 'ManagedPaths' -Value $myManagedPaths
      
      $output += $webApplication
    }
    $output | Export-Clixml -Path $Path

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
