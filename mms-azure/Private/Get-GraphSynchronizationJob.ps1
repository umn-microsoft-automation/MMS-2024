function Get-GraphSynchronizationJob
{
        <#
        .Synopsis
            Function to get current status of Enterprise Azure AD App provisioning job

        .DESCRIPTION
            Gets current job ID from registered application.

        .PARAMETER accessToken
            Azure AD accessToken

        .PARAMETER servicePrincipalID
            Service principal of the registered App.

        .PARAMETER jobID
            Syncronization jobID reference

        .EXAMPLE
            Get-GraphSynchronizationJob -accessToken $token -servicePrincipalID $servicePrincipal -jobID $jobID

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
        [string]$ServicePrincipalId,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$jobID
    )

    begin {
        $params = @{
            Method  = "GET"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/" + $jobID)
            Headers = @{
                "Authorization" = "Bearer $accessToken"
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }

    process {
        [int]$i = '0'
        $date = (get-date).toUniversalTime()
        While($i -lt 10){
            try {
                $response = (Invoke-RestMethod @params).status.lastExecution
                $state = $response.state
                $time = $response.timeEnded
                If($state -eq 'Succeeded'){
                    If($time -gt $date){
                        $i='10'
                        $state = 'Completed!'
                    }
                    Else{
                        $i++
                        start-sleep -seconds 30
                    }
                }
                Else{
                    $i++
                    start-sleep -seconds 30
                }
            }
            catch {
                Write-Error -ErrorRecord $_ -ErrorAction Stop
            }
        }
    }

    end {
        return $state
    }
}