$c = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName .
$c.Name + "_Info.txt"
$fpath = "C:\Temp"
$full = $fpath + "\" + $outFile

if (!(Test-Path $fpath)) {
    Write-Host "El directorio no existe"
    Exit
}

if (Test-Path $full) {
    Write-Host "El fichero ya existe."
    Exit
}

Add-Content -Path $full -value ("{0,-30}" -f "----------------------------- Identificación del equipo ---------------------------------")
$a = Get-CimInstance –ClassName Win32_ComputerSystem –NameSpace Root\CIMV2 –Property *
Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Nombre de equipo:", $a.Name)
Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Dominio:", $a.Domain)
Add-Content -Path $full -value ("{0,-30}" -f  "----------------------------- Identificación del sistema operativo ----------------------")
$a = Get-CimInstance -ClassName Win32_OperatingSystem -Property *
Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Edición de Windows", $a.Caption)
Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Fecha de instalación", $a.InstallDate)
Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Directorio de Windows", $a.SystemDirectory)Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Arquitectura del SO", $a.OSArchitecture)switch ($a.PCSystemType){    0 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Sin Especificar") }    1 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Escritorio") }    2 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Movil") }    3 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Estación de Trabajo") }    4 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Enterprise Server") }    5 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Servidor SOHO") }    6 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: PC del dispositivo") }    7 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Servidor de rendimiento") }    8 { Add-Content -Path $full -value ("{0,-30}" -f  "Tipo de producto: Máximo") }}
Add-Content -Path $full -value ("{0,-30}" -f  "----------------------------- Listado de discos -----------------------------------------")
$a = Get-CimInstance –ClassName Win32_DiskDrive –Namespace Root\CIMV2 -ComputerName .
if ($a.GetType().IsArray) 
{
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Nº de discos", $a.Length)
}
else
{
    Add-Content -Path $full -value ("{0,-30}" -f  "Nº de discos 1")
}

$idx = 0
foreach ($vol in $a)
{
    Add-Content -Path $full -value ("{0,-30} {1,0} {1, -60}" -f  "============ Disco ", $idx, " =======")
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Nombre", $vol.Name)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Modelo", $vol.model)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Tamaño (en GB)", $vol.Size)
    $idx = $idx + 1
}
Add-Content -Path $full -value ("{0,-30}" -f  "----------------------------- Listado de volúmenes --------------------------------------")
$a = Get-CimInstance –ClassName Win32_Volume –Namespace Root\CIMV2 -ComputerName .
if ($a.GetType().IsArray) 
{
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f  "Nº de volumenes", $a.Length)
}
else
{
    Add-Content -Path $full -value ("{0,-30}" -f  "Nº de volumenes 1")
}
$idx = 0
foreach ($vol in $a)
{
    Add-Content -Path $full -value ("{0,-30} {1,0} {1, -60}" -f  "============ Volumen ", $idx, " =======")
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f "Letra Asignada", $vol.DriveLetter)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f "Capacidad (en MB)", $vol.Capacity)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f "Espacio libre (en MB)",  $vol.FreeSpace)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f "Tipo de drive", $vol.DriveType)
    Add-Content -Path $full -value ("{0,-30} {1,-60}" -f "Sistema de Ficheros", $vol.FileSystem)
    $idx = $idx + 1
}
