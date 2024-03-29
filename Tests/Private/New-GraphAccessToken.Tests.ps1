BeforeAll {
    . $PSScriptRoot/../../mms-azure/Private/New-GraphAccessToken.ps1
}

Describe "New-GraphAccessToken" {
    Context "Tests for New-GraphAccessToken" {
        BeforeAll{
        $help = Get-Help New-GraphAccessToken
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