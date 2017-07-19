function Export-SPRDatabase
{
  param(
    [string]$Path,
    [bool]$Async
  )

  $file = '{0}\SPRDatabase.xml' -f $Path

  $scriptblock = {
    param($Path = $file)
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    Write-Host -Object 'Exporting: Database Configuration. ' -NoNewline

    $output = Get-SPDatabase
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
