$dest = "C:\temp"
$lines = Get-Content -Encoding UTF8 vk_music.txt | Where {$_ -notmatch '^\s+$'}  

foreach ($line in $lines){
    $url = $line.Split('?')[0];		
    $s = $line.Split(',')[1];
    $title = $s.substring(4);
    $path = $dest, $title -join "\";	
    Write-Output "Downloading ($title) .....";
    Invoke-WebRequest $url -OutFile $path;
# for windows 7
#    (new-object System.Net.WebClient).DownloadFile($url,$path);
}
