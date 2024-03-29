BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/New-PSCredential.ps1
}

Describe "New-PSCredential" {
    Describe "New-PSCredential Tests" {
        Context "Should accept variable sets to create a credential" {
            It "Should accept username and password" {
                $username = 'Test'
                $password = 'Password'| ConvertTo-SecureString -AsPlainText -Force
                New-PSCredential -username $username -password $password |should -Not -BeNullOrEmpty
            }
            It "Should return a PSCredential Object"{
                $username = 'Test'
                $password = 'Password'| ConvertTo-SecureString -AsPlainText -Force
                $return = New-PSCredential -username $username -password $password
                $return.GetType().Name |should -Be "PSCredential"
            }
        Context "Without required parameters" {
            It "should throw an error" {
                {New-PSCredential} | Should -Throw

                {$return1 = New-PSCredential -username 'username'
                $return1 | Should -BeNullOrEmpty}

                {$return2 = New-PSCredential -password 'password'
                $return2 | Should -BeNullOrEmpty}
            }
        }
    }
    Context "Tests for New-PSCredential" {
        BeforeAll{
        $help = Get-Help New-PSCredential
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
}