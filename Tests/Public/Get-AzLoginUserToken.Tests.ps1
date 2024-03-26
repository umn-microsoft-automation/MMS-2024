BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/Get-AzLoginUserToken.ps1
}

Describe "Get-AzLoginUserToken" {
        Context "Should accept variable sets to get valid token" {
            $username = 'Test'
            $password = 'Password'| ConvertTo-SecureString -AsPlainText -Force
            $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

            It "Should accept username and password" {
                Mock Get-AzLoginUserToken {return "valid_access_token" }
                Get-AzLoginUserToken -user $username -pass $password |should -be "valid_access_token"
            }
            It "Should accept just a credential object" {
                Mock Get-AzLoginUserToken {return "valid_access_token" }
                Get-AzLoginUserToken -credential $credential |should -be "valid_access_token"
            }

        Context "Without required parameters" {
            It "should throw an error" {
                {Get-AzLoginUserToken} | Should -Throw

                {$return1 = Get-AzLoginUserToken -user 'username'
                $return1 | Should -BeNullOrEmpty}

                {$return2 = Get-AzLoginUserToken -pass 'password'
                $return2 | Should -BeNullOrEmpty}
            }
        }
    }
}
