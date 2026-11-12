# Sökvägen till konfigurationsfilen
$configPath = Join-Path $PSScriptRoot "backup-config.json" #$PSScriptRoot är en automatisk PowerShell-variabel som hämtar sökvägen till katalogen där det aktuella PowerShell-skriptet ligger.

# Läser in konfigurationen med felhantering
try {
    $config = Get-Content -Path $configPath -Raw -ErrorAction Stop | ConvertFrom-Json
}
catch {
    Write-Host "Kunde inte läsa konfigurationsfilen: $_"
    return
}
# Hämtar sökvägarna från JSON-konfigurationen
$sourcePath = Join-Path $PSScriptRoot $config.source_path
$backupPath = Join-Path $PSScriptRoot $config.backup_path

# Hämtar alla textfiler från projektmappen
$sourceFolder = Split-Path -Path $sourcePath -Parent
$filesToBackup = @(Get-ChildItem -Path $sourceFolder -Filter "*.txt" -File)

# Funktion som skapar backupmappen
function New-BackupFolder {
    param(
        [string]$Path
    )

    if (-not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType Directory
    }
}

# Funktion som kopierar originalfilen till backupmappen
function Copy-BackupFile {
    param(
        [string]$SourcePath,
        [string]$DestinationPath
    )

    try {
    Copy-Item -Path $SourcePath -Destination $DestinationPath -ErrorAction Stop
}
catch {
    throw "Kunde inte kopiera filen: $_" # Jag använder throw för att skicka vidare ett fel om kopieringen misslyckas. På så sätt fortsätter inte skriptet som om allt fungerade, utan det avbryts och ett felmeddelande visas.
}
}

# Funktion som kontrollerar att backupfilen finns
function Test-BackupFile {
    param(
        [string]$BackupPath,
        [string]$SourcePath
    )

    $backupFile = Join-Path $BackupPath (Split-Path $SourcePath -Leaf)

    if (Test-Path -Path $backupFile) {
        Write-Host "Säkerhetskopieringen lyckades!"
    }
    else {
        Write-Host "Säkerhetskopieringen misslyckades!"
    }
}
# Split-Path delar upp en sökvägen, -Leaf hämtar den sista delen av sökvägen, alltså filnamnet. 
# Join-Path kombinerar två delar till en sökväg.$backupFile = sparar sökvägen till backupfilen då vi inte vill skriva in filnamnet ifall om vi i framtiden vill byta namn på filen. 

# Anropar funktionen och skickar in sökvägen till backupmappen
New-BackupFolder -Path $backupPath

# Heltalsvariabel som räknar antalet säkerhetskopierade filer
[int]$backupCount = 0

# Loopar igenom filerna och kopierar dem
foreach ($file in $filesToBackup) {

    Copy-BackupFile -SourcePath $file.FullName -DestinationPath $backupPath

    # Kontrollerar att varje backupfil har skapats
    Test-BackupFile -BackupPath $backupPath -SourcePath $file.FullName

    # Ökar räknaren med 1 för varje kopierad fil
    $backupCount++
}
# Skriver ut antalet säkerhetskopierade filer
Write-Host "Antal säkerhetskopierade filer: $backupCount" 