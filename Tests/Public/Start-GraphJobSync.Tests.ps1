BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/Start-GraphJobSync.ps1
    function Add-Numbers($a, $b) {
        return $a + $b
    }
}
Describe "Dummy Test" {
    It "adds positive numbers" {
        $sum = Add-Numbers 2 3
        $sum | Should -Be 5
    }
}