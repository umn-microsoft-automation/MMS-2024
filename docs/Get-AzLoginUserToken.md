---
external help file: mms-azure-help.xml
Module Name: mms-azure
online version:
schema: 2.0.0
---

# Get-AzLoginUserToken

## SYNOPSIS
Use Az Login to get a user oAuth Token

## SYNTAX

### plainText
```
Get-AzLoginUserToken [-user <String>] [-pass <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### psCredential
```
Get-AzLoginUserToken [-credential <PSCredential>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Simple method to capture an access token in a user's context

## EXAMPLES

### EXAMPLE 1
```
$accessToken = Get-AzLoginUserToken -username 'name' -password 'pass'
```

### EXAMPLE 2
```
$accessToken = Get-AzLoginUserToken -credential $psCredential
```

## PARAMETERS

### -user
Your username

```yaml
Type: String
Parameter Sets: plainText
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pass
Your password

```yaml
Type: String
Parameter Sets: plainText
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -credential
Your PSCredential

```yaml
Type: PSCredential
Parameter Sets: psCredential
Aliases:

Required: False
Position: Named
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
