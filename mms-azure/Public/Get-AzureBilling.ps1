function Get-AzureBilling
{
    <#
        .Synopsis
            Function to pull all azure billing

        .DESCRIPTION
            Will pull from usage API and marketplace API for cost. usage includes Reserved Instances.

        .PARAMETER accessToken
            AccessToken to request the data.

        .PARAMETER enrollment
            Your Enterprise Enrollment number. Available form the EA portal.

        .PARAMETER date
            Billing date for marketplace and consumption Format yyyyMM

        .PARAMETER reservedDate
            Billing date for reserved instances in format yyyy-MM

        .EXAMPLE
            Get-AzureBilling -accessToken $key -enrollment '5123456123' -date '202311' -reservedDate '2023-11'

        .Notes
            Author: Kyle Weeks
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", '', Justification='This is needed.')]
    param
    (
        [Parameter(Mandatory=$true)]
        [string] $enrollment,

        [Parameter(Mandatory=$true)]
        [string] $accessToken,

        [Parameter(Mandatory=$true)]
        [string]$date
    )

    Begin{
        $marketCharges = Get-AzureMarketplaceConsumption -accessToken $accessToken -enrollment $enrollment -billingPeriod $date
        $usageCharges = Get-AzureEnrollmentConsumption -accessToken $accessToken -enrollment $enrollment -billingPeriod $date
        $subscriptions = [Pscustomobject]@()
        $azureBilling = New-Object System.Collections.ArrayList($null)
    }

    Process
    {
        $marketData = $marketCharges |select-object -Property subscriptionGuid,extendedCost |where-object -property extendedCost -ne $null
        $usageData = $usageCharges |select-object -Property subscriptionId,cost

        $marketSubs = $marketData|select-object -Property @{Name = 'subscriptionId'; Expression = {$_.subscriptionGuid}} |sort-object -Property subscriptionId -Unique
        $usageSubs = $usageData|select-object -Property subscriptionId |sort-object -Property subscriptionId -Unique

        $subscriptions+=$marketSubs
        $subscriptions+=$usageSubs
        $subscriptions=$subscriptions|Sort-Object -Property subscriptionId -Unique

        Foreach($subscription in $subscriptions){
            $object,$cost,$market,$usage = $null,$null,$null,$null
            $subscription=$subscription.subscriptionId
            $market = ($marketData |where-object -Property subscriptionGuid -eq $subscription).extendedCost
            $usage = ($usageData |where-object -property subscriptionId -eq $subscription).cost

            $market = ($market | Measure-object -Sum).sum
            $usage = ($usage | Measure-object -Sum).sum

            $cost = $market+$usage
            $object = [ordered]@{'subscriptionId'=$subscription;'cost'=$cost}
            [void]$azureBilling.add($object)
        }
    }

    End
    {
        return $azureBilling
    }
}