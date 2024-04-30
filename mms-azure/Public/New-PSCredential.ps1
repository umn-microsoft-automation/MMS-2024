function New-PSCredential
{


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '', Justification='This is needed when doing self password generation of random string characters.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification='This is needed when doing self password generation of random string characters.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification='This is needed when doing self password generation of random string characters.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification='I know better!')]

    param
    (
        [Parameter(Mandatory=$true)]
        [string]$password,

        [Parameter(Mandatory=$true)]
        [string]$userName
    )

    Begin{}

    Process
    {
        [securestring]$secStringPassword = ConvertTo-SecureString $password -AsPlainText -Force
        [pscredential]$credential = New-Object System.Management.Automation.PSCredential ($userName, $secStringPassword)
    }

    End
    {
        return $credential
    }
}