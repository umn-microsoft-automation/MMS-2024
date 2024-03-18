function New-PSCredential
{
    <#
        .Synopsis
            A function for generating a new PSCredential

        .DESCRIPTION
            Needed for Diagnostics.CodeAnalysis.SuppressMessageAttribute which can't run from Azure Automation

        .PARAMETER password
            The clear text password to be used in creating the PSCredential

        .PARAMETER userName
            The username to be used with credential

        .EXAMPLE
            New-PSCredential -username 'Kyle' -password 'alfkm98j23og8j98qov0u8u8ojoiujiojf'

        .Notes
            Author: Kyle Weeks
    #>

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