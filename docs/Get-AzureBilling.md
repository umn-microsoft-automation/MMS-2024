---
external help file: mms-azure-help.xml
Module Name: mms-azure
online version:
schema: 2.0.0
---

# Get-AzureBilling

## SYNOPSIS
Function to pull all azure billing

## SYNTAX

```
Get-AzureBilling [-enrollment] <String> [-accessToken] <String> [-date] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Will pull from usage API and marketplace API for cost.
usage includes Reserved Instances.

## EXAMPLES

### EXAMPLE 1
```
Get-AzureBilling -accessToken $key -enrollment '5123456123' -date '202311' -reservedDate '2023-11'
```

## PARAMETERS

### -enrollment
Your Enterprise Enrollment number.
Available form the EA portal.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accessToken
AccessToken to request the data.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -date
Billing date for marketplace and consumption Format yyyyMM

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Kyle Weeks

## RELATED LINKS
