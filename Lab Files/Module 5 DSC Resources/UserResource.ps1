Get-DscResource -Name User -Syntax

Configuration UserResource {
Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Node StudentServer2{
User UserResourceExample
{

    Ensure = "Present"  # To ensure the user account does not exist, set Ensure to "Absent"
    UserName = "Bob"
    #Password = $passwordCred # This needs to be a PS credential object
    #DependsOn = "[Group]GroupExample" # Configures GroupExample first
}


}}

UserResource -OutputPath 'C:\DSC Resources\MOF\User\'

Start-DscConfiguration -Path 'C:\DSC Resources\MOF\User\' -Wait -Verbose -Force