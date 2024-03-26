---
external help file: mms-azure-help.xml
Module Name: mms-azure
online version:
schema: 2.0.0
---

# Start-GraphJobSync

## SYNOPSIS
Start the graph job sync

## SYNTAX

```
Start-GraphJobSync [[-tenantID] <String>] [[-displayName] <String>] [[-applicationID] <String>]
 [[-clientSecret] <String>] [[-username] <String>] [[-password] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Calls all the functions needed to gather information, IDs, tokens, and start the Azure AD Job provisioning sync

## EXAMPLES

### EXAMPLE 1
```
Start-GraphJobSync -tenantID '1234-asdff' -applicationID '12345-asdf' -clientSecret $secret -username 'Name' -password 'password'
```

## PARAMETERS

### -tenantID
Azure AD Tenant ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -displayName
Displayname of the Azure App

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationID
Application ID of the registered Azure AD App to get a token from.
Also called 'clientID'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientSecret
Pre-shared client secret.
Password not certificate.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -username
The username of the account to assume token

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
The password of the account to assume token

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Author: AWS, modified by Kyle Weeks

## RELATED LINKS
