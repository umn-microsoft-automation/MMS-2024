function Start-GraphSynchronizationJob
{
    <#
        .Synopsis
            Start a provision synchronization

        .DESCRIPTION
            Start an Azure AD Enterprise Registered application provisioning sync process

        .PARAMETER accessToken
            Azure AD accessToken

        .PARAMETER servicePrincipalID
            The service principal ID of the Registered application.

        .PARAMETER jobID
            The job ID to start

        .EXAMPLE
            Start-GraphSynchronizationJob -accessToken $token -servicePrincipalID $serviceID -jobID $jobID

        .Notes
            Author: AWS, modified by Kyle Weeks
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", '', Justification='This is what I want to do.')]
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$JobId
    )

    begin {
        $params = @{
            Method  = "POST"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/" + $JobId + "/start")
            Headers = @{
                "Authorization" = "Bearer $accessToken"
            }
        }
    }

    process {
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }

    end {
        return $response
    }

}