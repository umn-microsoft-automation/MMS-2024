function Get-GraphServicePrincipal
{
    <#
        .Synopsis
            Function to get service principal ID of a registered application

        .DESCRIPTION
            Gets Enterprise AD App servicePrincipal ID

        .PARAMETER accessToken
            Azure AD accessToken

        .PARAMETER displayName
            The display name of the enterprise AD registered application

        .EXAMPLE
            Get-GraphServicePrincipal -accessToken $token -displayName 'Some app'

        .Notes
            Author: AWS, modified by Kyle Weeks
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSPossibleIncorrectComparisonWithNull", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSReviewUnusedParameter", '', Justification='This is what I want to do.')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", '', Justification='This is what I want to do.')]
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$DisplayName
    )

    begin {
        $params = @{
            Method  = "GET"
            Headers = @{
                "Authorization" = "Bearer $accessToken"
                "Accept"        = "application/json"
            }
        }
    }

    process {
        try {
            $response = Invoke-RestMethod @params -Uri "https://graph.microsoft.com/beta/servicePrincipals"
            $response.value | ForEach-Object {
                if ($_.displayName -like $displayName) {
                    $objectId = $_.id
                }
            }
            if ($response.'@odata.nextLink') {
                $nextLink = $response.'@odata.nextLink'
                while ($nextLink -ne $null) {
                    $output = Invoke-RestMethod @params -Uri $nextLink
                    $output.value | ForEach-Object {
                        if ($_.displayName -like $displayName) {
                            $objectId = $_.id
                        }
                    }
                    $nextLink = $output.'@odata.nextLink'
                }
            }
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }

    end {
        return $objectId
    }

}