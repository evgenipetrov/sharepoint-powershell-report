function Add-SPHModulePath
{
  param
  (
    [String]$Path
  )
  
  if ($env:PSModulePath -notlike ('*{0}*' -f $Path))
  {
    $env:PSModulePath += ';{0}\Modules' -f $Path
  }
}

function Get-SPHScriptLocation
{
  if ($PSScriptRoot -eq $null)
  {
    $location = $PSCommandPath
  }
  else
  {
    $location = $PSScriptRoot
  }
  
  Write-Output -InputObject $location
}

#requires -Version 2.0
$scriptLocation = Get-SPHScriptLocation
Add-SPHModulePath -Path $scriptLocation

Remove-Module -Name 'SharePoint.PowerShell.Report' -ErrorAction SilentlyContinue
Import-Module -Name 'SharePoint.PowerShell.Report'
  
Remove-Module -Name 'SharePoint.PowerShell.Helpers' -ErrorAction SilentlyContinue
Import-Module -Name 'SharePoint.PowerShell.Helpers'

$exportPath = '{0}\Export' -f $scriptLocation
$reportPath = '{0}\Report\Report.html' -f $scriptLocation

Export-SPRObjects -Path $exportPath -Async:$false
Get-SPReport -ExportPath $exportPath -ReportPath $reportPath -FromExportedFiles 



























































































































































































































