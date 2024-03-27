BeforeAll {
    . $PSScriptRoot/../../mms-azure/Public/Get-AzureBilling.ps1

    function Get-AzureEnrollmentConsumption
        {
            param
            (
                $enrollment,
                $accessToken,
                $billingPeriod
            )

            Begin{
                $header = @{"authorization"="bearer $accessToken"}

                If ($billingPeriod -eq ''){
                    $scope = "/providers/Microsoft.Billing/billingAccounts/$enrollment"
                    $uri = "https://management.azure.com/$scope/providers/Microsoft.Consumption/usageDetails?api-version=2019-10-01"
                }
                Else {
                    $scope = "/providers/Microsoft.Billing/billingAccounts/$enrollment/providers/Microsoft.Billing/billingPeriods/$billingPeriod"
                    $uri = "https://management.azure.com/$scope/providers/Microsoft.Consumption/usageDetails?api-version=2019-10-01"
                }
            }

            Process
            {
                $usage = @()
                while ($uri)
                {
                    $response = Invoke-RestMethod $uri -Headers $header -method Get
                    $usage += $response.value.properties

                    If($response.nextLink)
                        {
                            $uri = $response.nextlink
                            Start-Sleep -seconds 5
                        }
                    Else{$uri = $null}
                }
            }

            End
            {
                return $usage
            }
        }
    function Get-AzureMarketplaceConsumption
    {
        param
        (
            $enrollment,
            $accessToken,
            $billingPeriod
        )

        Begin{
            $header = @{"authorization"="bearer $accessToken"}

            If ($billingPeriod -eq ''){
                $scope = "/providers/Microsoft.Billing/billingAccounts/$enrollment"
                $uri = "https://management.azure.com/$scope/providers/Microsoft.Consumption/marketplaces?api-version=2019-10-01"
            }
            Else {
                $scope = "/providers/Microsoft.Billing/billingAccounts/$enrollment/providers/Microsoft.Billing/billingPeriods/$billingPeriod"
                $uri = "https://management.azure.com/$scope/providers/Microsoft.Consumption/marketplaces?api-version=2018-06-30"
            }
        }

        Process
        {
            $usage = @()
            while ($uri)
            {
                $response = Invoke-RestMethod $uri -Headers $header -method Get
                $usage += $response.value.properties

                If($response.nextLink){$uri = $response.nextlink}
                Else{$uri = $null}
            }
        }

        End
        {
            return $usage
        }
    }
}

Describe "Get-AzureBilling" {
        Context "Should accept variable set to get market data" {
            It "Should accept accessToken, enrollment for date" {
                $enrollment = '12345'
                $date = '202311'
                $accessToken = 'valid_access_token'
                Mock Get-AzureBilling {}
                Get-AzureBilling -enrollment $enrollment -accessToken $accessToken -date $date | should -Exist
            }
            It "Should have the following properties returned -Property subscriptionGuid,extendedCost"{
                $enrollment = '12345'
                $date = '202311'
                $accessToken = 'valid_access_token'
                Mock Get-AzureMarketplaceConsumption {return @{ subscriptionGuid = "valid_guid";extendedCost = "valid_cost"}}
                $return = Get-AzureMarketplaceConsumption -accessToken $accessToken -enrollment $enrollment -billingperiod $date
                $return.subscriptionGuid | Should -Be "valid_guid"
                $return.extendedCost | Should -Be "valid_cost"
            }

        Context "Without required parameters" {
            It "should throw an error" {

                {Get-AzureBilling} | Should -Throw

                {Get-AzureBilling -enrollment '12345'} | should -Throw

                {Get-AzureBilling -date '202311'} | should -Throw

                {Get-AzureBilling -accessToken 'valid_access_token'} | should -Throw

                {Get-AzureBilling -accessToken 'valid_access_token' -date '202311'} | should -Throw

                {Get-AzureBilling -accessToken 'valid_access_token' -enrollment '12345'} | should -Throw

                {Get-AzureBilling -date '202311' -enrollment '12345'} | should -Throw

            }
        }
    }
}