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
        Context "Tests for Get-AzLoginUser params" {
            BeforeAll{
            $help = Get-Help Get-AzLoginUserToken
            }
            it "Has a synopsis" {
            $help.synopsis | Should -Not -BeNullOrEmpty
            }
            it "Has a description" {
            $help.description | Should -Not -BeNullOrEmpty
            }
            it "Has an example" {
            $help.examples | Should -Not -BeNullOrEmpty
            }
            foreach($parameter in $help.parameters.parameter)
            {
            if($parameter -notmatch 'whatif|confirm')
            {
                it "Has a Parameter description for '$($parameter.name)'" {
                $parameter.Description.text | Should -Not -BeNullOrEmpty
                }
            }
            }
    }
}
