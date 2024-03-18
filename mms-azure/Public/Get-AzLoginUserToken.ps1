function Get-AzLoginUserToken
{
   <#
        .Synopsis
            Use Az Login to get a user oAuth Token

        .DESCRIPTION
            Simple method to capture an access token in a user's context

        .PARAMETER credential
            Your PSCredential

        .PARAMETER user
            Your username

        .PARAMETER pass
            Your password

        .EXAMPLE
            $accessToken = Get-AzLoginUserToken -username 'name' -password 'pass'

        .EXAMPLE
            $accessToken = Get-AzLoginUserToken -credential $psCredential

        .Notes
            Author: Kyle Weeks
    #>

    param
    (
        [Parameter(ParameterSetName='plainText')]
        [string] $user,

        [Parameter(ParameterSetName='plainText')]
        [string] $pass,

        [Parameter(ParameterSetName='psCredential')]
        [pscredential]$credential
    )

    Begin{
        If($credential){
            $user = $credential.username
            $pass = $credential.getnetworkcredential().password
        }
    }

    Process
    {
        $null = az login -u $user -p $pass
        $accessToken = (az account get-access-token |convertfrom-json).accessToken
    }

    End
    {
        return $accessToken
    }
}