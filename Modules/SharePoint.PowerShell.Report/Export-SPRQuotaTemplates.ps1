function Export-SPRQuotaTemplates
{
  param(
    [string]$Path
  )

  $file = '{0}\SPQuotaTemplate.xml' -f $Path
  Start-Job -Name 'Quota' -ScriptBlock {
    Add-PSSnapin -Name Microsoft.SharePoint.PowerShell
    $object = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.QuotaTemplates

    $object | Export-Clixml -Path $args[0]
    
  } -ArgumentList $file
}
cls
