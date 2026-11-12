## Backup-automatisering

### Projektmål

Målet med projektet är att automatisera säkerhetskopiering av filer med hjälp av Terraform och PowerShell.

Terraform ska skapa mappar och filer som behövs för projektet. PowerShell ska sedan kopiera testfiler till en backupmapp och kontrollera att säkerhetskopieringen har fungerat.

### Verktyg
- Ubuntu via WSL
- Visual Studio Code
- Terraform
- PowerShell 7
- Git och GitHub

### Metod

Terraform används för att skapa originalfilen och en JSON-fil med sökvägar till originalfilen och backupmappen.
PowerShell läser in konfigurationen från JSON-filen, skapar backupmappen och kopierar originalfilen dit. Därefter kontrollerar skriptet att backupfilen har skapats.

### Resultat

Projektet fungerar som planerat. Terraform skapar originalfilen och konfigurationsfilen. PowerShell skapar backupmappen och kopierar originalfilen dit.

Skriptet kontrollerar att backupfilen finns och skriver ut hur många filer som har säkerhetskopierats. Jag har även testat felhanteringen genom att ange en sökväg till en fil som inte finns.

### Reflektion

Genom projektet har jag fått lära mig hur Terraform och PowerShell kan användas tillsammans för att automatisera en säkerhetskopiering.

Jag har fått en bättre förståelse för hur Terraform skapar resurser och hur PowerShell kan läsa konfigurationen, hantera filer och kontrollera resultatet.

Jag har även lärt mig hur viktigt det är med felhantering för att upptäcka problem när ett skript körs.

### Körning av projektet

1. Klona projektet från GitHub.
2. Öppna projektmappen i Ubuntu via WSL.
3. Kör `terraform init` för att initiera Terraform.
4. Kör `terraform apply` för att skapa filerna.
5. Kör `pwsh ./backup.ps1` för att starta säkerhetskopieringen.

### GitHub

Projektets källkod finns här:

https://github.com/MariteK88/Backup-automatisering