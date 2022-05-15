
# chrome dir used to store extensions
$Chrome_Ext_dir = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Extensions"

try {
    # check if dir is there
    if(Test-Path $Chrome_Ext_dir)
    {
        #get a list of extentions and iter
        $ext_list = Get-ChildItem -Path $Chrome_Ext_dir
        foreach($ext_dir in $ext_list)
        {
             Write-Host $ext_dir -ForegroundColor Green 
             $ext_path = $Chrome_Ext_dir + "\" + $ext_dir
             # each extentions uses manifest file as config source. However, the manifest file might have a different structure, so "-Pattern description, name, permissions" might not work.
             # you can remove Select-String to display the entire file and look for info that way
             if (Test-Path -Path $ext_path -PathType Container)
             {
                $manifest = Get-ChildItem -Path $ext_path -Recurse -Filter "manifest.json" -Name
                $mmanifest_path = $ext_path + "\" + $manifest

                Write-Host (Get-Content -Path $mmanifest_path | Select-String -Pattern 'name') -ForegroundColor yellow
                Write-Host (Get-Content -Path $mmanifest_path | Select-String -Pattern 'description') -ForegroundColor yellow
                Write-Host (Get-Content -Path $mmanifest_path | Select-String -Pattern 'permissions') -ForegroundColor yellow
         
             }
             
        }
       
    }
}
catch [System.IO.IOException] {
    Write-host "Dir is not found" -ForegroundColor red
}