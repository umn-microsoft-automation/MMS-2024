function Start-GraphJobSync
{
    <#
        .Synopsis
            Start the graph job sync

        .DESCRIPTION
            Calls all the functions needed to gather information, IDs, tokens, and start the Azure AD Job provisioning sync

        .PARAMETER tenantID
            Azure AD Tenant ID

        .PARAMETER applicationID
            Application ID of the registered Azure AD App to get a token from. Also called 'clientID'

        .PARAMETER clientSecret
            Pre-shared client secret. Password not certificate.

        .PARAMETER username
            The username of the account to assume token

        .PARAMETER password
            The password of the account to assume token

        .PARAMETER displayName
            Displayname of the Azure App

        .EXAMPLE
            Start-GraphJobSync -tenantID '1234-asdff' -applicationID '12345-asdf' -clientSecret $secret -username 'Name' -password 'password'

        .Notes
            Author: AWS, modified by Kyle Weeks
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUsernameAndPasswordParams", '', Justification='This is what I want to do.')]
    [CmdletBinding()]
    param (
        [string]$tenantID,

        [string]$displayName,

        [string]$applicationID,

        [string]$clientSecret,

        [string]$username,

        [string]$password
    )

    begin {}

    process {
        $accessToken = New-GraphAccessToken -TenantId $tenantId -ApplicationId $applicationId -ClientSecret $clientSecret -Username $username -Password $password
        $servicePrincipalId = Get-GraphServicePrincipal -AccessToken $accessToken -DisplayName $displayName
        $jobId = Get-GraphSynchronizationJobId -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId
        Start-GraphSynchronizationJob -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId -JobId $jobId
        $return = Get-GraphSynchronizationJob -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId -jobID $jobId
    }

    end {
        return $return
    }
}