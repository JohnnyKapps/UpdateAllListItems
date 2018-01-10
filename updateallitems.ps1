Add-PSSnapin Microsoft.SharePoint.Powershell

Write-Host "########################################################"
Write-Host "#                                                      #"
Write-Host "#                UPDATE ALL LIST ITEMS                 #"
Write-Host "#                                                      #"
Write-Host "########################################################"


function UpdateAllListItems([string]$url, [string]$listTitle){
    Write-Host "Loading $url site"
    $site = Get-SPSite $url
    $rootWeb = $site.rootWeb
    
    Write-Host "Loading $list list"
    $lists = $rootWeb.Lists
    $list = $lists | Where-Object {$_.Title -eq $listTitle}
    
    if ($list -ne $null) {
        Write-Host "List found, updating items..."
        $items = $list.items
        $currentItem = 1
        foreach ($item in $items) {
            Write-Host "Updating item: [ $currentItem ]"
            $item.update()
            $currentItem += 1
        }
    }
    else{
        Write-Host "List $list not found, finishing process..."
    }
}

Write-Host "Site URL:"
$siteUrl = Read-Host 

Write-Host "List name:"
$listName = Read-Host

UpdateAllListItems $siteUrl $listName


Write-Host "Finished"
Read-Host "Press any key to exit"
