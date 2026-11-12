#Jag använder local-providern i Terraform för att kunna skapa och hantera filer lokalt på datorn
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

# Variabel som anger sökvägen till backupmappen
variable "backup_path" {
  type    = string
  default = "Backup"
}

# Resurs som skapar originalfilen för säkerhetskopiering
resource "local_file" "test_file" {
  filename = "${path.module}/testfil.txt"
  content  = "Detta är en testfil för backup."
}

# Resurs som skapar en JSON-fil med backupinställningar
resource "local_file" "backup_config" {
  filename = "${path.module}/backup-config.json"

  content = jsonencode({
    source_path = local_file.test_file.filename
    backup_path = "${path.module}/${var.backup_path}"
  })
}

# Visar sökvägen till originalfilen
output "test_file" {
  value = local_file.test_file.filename
}