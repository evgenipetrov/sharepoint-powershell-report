#requires -Version 3.0
function Get-SPRWebApplicationUserPolicy
{
  param
  (
    [Parameter(Mandatory = $true)]
    [object[]]$SPRWebApplication,
    [Parameter(Mandatory = $true)]
    [object[]]$SPRManagedAccount
  )
	
  foreach ($webApplication in $SPRWebApplication)
  {
    $policies = $webApplication.Policies
    $managedAccountUsernames = $SPRManagedAccount | Select-Object -ExpandProperty UserName
    
    foreach ($policy in $policies)
    {
      $systemUser = $managedAccountUsernames.Contains($policy.UserName)
      $properties = [ordered]@{
        'DisplayName'      = $webApplication.DisplayName
        'UserDisplayName'  = $policy.DisplayName
        'Username'         = $policy.UserName
        'PolicyRoleBindings' = $policy.PolicyRoleBindingName
        'SystemUser'       = $systemUser
      }
      $output = New-Object -TypeName PSObject -Property $properties
		
      Write-Output -InputObject $output
    }
  }
}
