# Konfiguration av Terraform och den
# provider som projektet använder
 terraform {
  required_providers {
    local = {
        source = "hashicorp/local"
        version = "~> 2.5"
 }
  }  
 }
 # Variabel som anger projektets namn
    variable "project_name" {
        type = string
        default = "backup-automatisering"
    }
# Variabel som anger sökvägen till backupmappen
variable "backup_path" {
  type    = string
  default = "Backup"
}
# Resurs som skapar information om backup-projektet
resource "local_file" "backup_info" {
    filename = "${path.module}/backup-info.txt"
    content = "Backup-projektet är förberett."
}
# Resurs som skapar en testfil för säkerhetskopiering
resource "local_file" "test_file" {
    filename = "${path.module}/testfil.txt"
    content = "Detta är en testfil för backup."
}
# Resurs som skapar en fil i backupmappen
resource "local_file" "backup_test" {
  filename = "${path.module}/${var.backup_path}/backup_test.txt"
  content  = "Detta är en testfil i backupmappen."
}
# Visar sökvägen till informationsfilen
output "backup_info_file" {
    value = local_file.backup_info.filename
}
# Visar sökvägen till testfilen
output "test_file" {
    value = local_file.test_file.filename
}