New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
foreach ($user in (Get-LocalUser)) {
    if ($user.Enabled) {
        $userid=$user.SID.AccountDomainSid
        $userprofile=(get-itemproperty "HKU:\$userid-500\volatile environment" -Name USERPROFILE).USERPROFILE
        if ($userprofile) {
            write-host "Profile for '$user' ($userid) is '$userprofile'"
            # Remove all Google Chrome configurations
            remove-item "$userprofile\AppData\Local\Google\Chrome\User Data" -Recurse -Force
            # Remove all Mozilla applications' configurations
            remove-item "$userprofile\AppData\Local\Mozilla" -Recurse -Force
            # Remove all temp files
            remove-item "$userprofile\AppData\Local\Temp\*.*" -Recurse -Force
        }
    }
}
