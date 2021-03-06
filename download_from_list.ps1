$dest = "D:\VK"
$lines = Get-Content -Encoding UTF8 vk_music.txt | Where {$_ -notmatch '^\s+$'}  

foreach ($line in $lines){
    $url = $line.Split("?")[0];		
    $ind = $line.IndexOf("`t")+1;
    $title = $line.substring($ind) -replace "[`"\\/?|<>:*]", " ";
    $title = $title.replace("  "," ").trim();
    $path = $dest, $title -join "\";
	if (-Not (Test-Path -LiteralPath $path)) {
	    $tempPath = $dest, "downloading.temp" -join "\";
	    Write-Output "Downloading ($title) .....";
	#for windows >8
	    Invoke-WebRequest $url -OutFile $tempPath;
	# for windows 7
	#    (new-object System.Net.WebClient).DownloadFile($url,$path);
	
	    Move-Item -literalPath $tempPath -destination "$path";
	}
}
