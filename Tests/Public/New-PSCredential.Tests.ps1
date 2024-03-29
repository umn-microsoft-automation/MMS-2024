BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/New-PSCredential.ps1
}

Describe "New-PSCredential" {
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