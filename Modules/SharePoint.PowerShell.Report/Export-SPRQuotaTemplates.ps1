function Export-SPRQuotaTemplates
{
  param(
    [string]$Path,
    [bool]$Async
  )

  $file = '{0}\SPRQuotaTemplate.xml' -f $Path
  
  $scriptblock = {
    param($Path = $file)
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
    Write-Host -Object 'Exporting: Quota Configuration. ' -NoNewline

    $output = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates
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

