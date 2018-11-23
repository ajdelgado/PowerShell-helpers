New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
foreach ($user in (Get-LocalUser)) {
    if ($user.Enabled) {
        $userid=$user.SID.AccountDomainSid
        $userprofile=(get-itemproperty "HKU:\$userid-500\volatile environment" -Name USERPROFILE).USERPROFILE
        if ($userprofile) {
            write-host "Profile for '$user' is '$userprofile'"
            # Remove all files in the Desktop
            remove-item "$userprofile\Desktop\*.*" -Recurse -Force
        }
    }
}
