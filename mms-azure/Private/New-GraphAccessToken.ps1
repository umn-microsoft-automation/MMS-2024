function New-GraphAccessToken
{

    <#
        .Synopsis
            New OAuth Token

        .DESCRIPTION
            Get a scoped OAuth token based on a registered application in Azure AD.

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

        .EXAMPLE
            New-GraphAccessToken -tenantID '1234-asdff' -applicationID '12345-asdf' -clientSecret $secret -username 'Name' -password 'password'

        .Notes
            Author: AWS, modified by Kyle Weeks
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUsernameAndPasswordParams", '', Justification='This is what I want to do.')]
    [CmdletBinding()]
    [OutputType([securestring])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$TenantId,

        [Parameter(Mandatory = $true)]
        [string]$ApplicationId,

        [Parameter(Mandatory = $true)]
        [string]$ClientSecret,

        [Parameter(Mandatory = $true)]
        [string]$Username,

        [Parameter(Mandatory = $true)]
        [string]$Password
    )

    begin {
        $params = @{
            Method  = "POST"
            Uri     = ("https://login.microsoftonline.com/" + $tenantId + "/oauth2/token")
            Headers = @{
                "Content-Type" = "application/x-www-form-urlencoded"
                "Accept"       = "application/json"
            }
            Body    = @{
                "resource"      = "https://graph.microsoft.com"
                "grant_type"    = "password"
                "client_id"     = "$applicationId"
                "client_secret" = "$clientSecret"
                "username"      = "$username"
                "password"      = "$password"
                "scope"         = "openid"
            }
        }
    }

    process {
        try {
            $response = Invoke-RestMethod @params
            $accessToken = $response.access_token
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }

    end {
        return $accessToken
    }

}