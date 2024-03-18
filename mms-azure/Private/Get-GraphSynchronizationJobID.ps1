function Get-GraphSynchronizationJobId
{
        <#
        .Synopsis
            Function to get job ID from Enterprise App

        .DESCRIPTION
            Gets job ID from registered application.

        .PARAMETER accessToken
            Azure AD accessToken

        .PARAMETER servicePrincipalID
            Service principal of the registered App.

        .EXAMPLE
            Get-GraphSynchronizationJob -accessToken $token -servicePrincipalID $servicePrincipal

        .Notes
            Author: AWS, modified by Kyle Weeks
    #>

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId
    )

    begin {
        $params = @{
            Method  = "GET"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs")
            Headers = @{
                "Authorization" = "Bearer $accessToken"
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }

    process {
        try {
            $response = Invoke-RestMethod @params
            $response = $response.value[0].id
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }

    end {
        return $response
    }

}