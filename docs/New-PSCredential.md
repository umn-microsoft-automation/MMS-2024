---
external help file: mms-azure-help.xml
Module Name: mms-azure
online version:
schema: 2.0.0
---

# New-PSCredential

## SYNOPSIS
A function for generating a new PSCredential

## SYNTAX

```
New-PSCredential [-password] <String> [-userName] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Needed for Diagnostics.CodeAnalysis.SuppressMessageAttribute which can't run from Azure Automation

## EXAMPLES

### EXAMPLE 1
```
New-PSCredential -username 'Kyle' -password 'alfkm98j23og8j98qov0u8u8ojoiujiojf'
```

## PARAMETERS

### -password
The clear text password to be used in creating the PSCredential

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

### -userName
The username to be used with credential

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
