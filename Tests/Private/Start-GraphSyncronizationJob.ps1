BeforeAll {
    . $PSScriptRoot/../../mms-azure/Private/Start-GraphSyncronizationJob.ps1
}

Describe "Start-GraphSyncronizationJob" {
    Context "Tests for Start-GraphSyncronizationJob" {
        BeforeAll{
        $help = Get-Help Start-GraphSyncronizationJob
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