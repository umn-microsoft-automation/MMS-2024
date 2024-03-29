BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/Start-GraphJobSync.ps1
}

Describe "Start-GraphJobSync" {
    Context "Tests for Start-GraphJobSync" {
        BeforeAll{
        $help = Get-Help Start-GraphJobSync
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