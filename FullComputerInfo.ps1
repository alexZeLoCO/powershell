﻿Write-Host "----------------------------- Identificación del equipo ---------------------------------"
$a = Get-CimInstance –ClassName Win32_ComputerSystem –NameSpace Root\CIMV2 –Property *
Write-Host "Nombre de equipo:" $a.Name
Write-Host "Dominio:" $a.Domain
Write-Host "----------------------------- Identificación del sistema operativo ----------------------"
$a = Get-CimInstance -ClassName Win32_OperatingSystem -Property *
Write-Host "Edición de Windows" $a.Caption
Write-Host "Fecha de instalación" $a.InstallDate
Write-Host "Directorio de Windows" $a.SystemDirectory
Write-Host "----------------------------- Listado de discos -----------------------------------------"
$a = Get-CimInstance –ClassName Win32_DiskDrive –Namespace Root\CIMV2 -ComputerName .
if ($a.GetType().IsArray) 
{
    Write-Host "Nº de discos" $a.Length
}
else
{
    Write-Host "Nº de discos 1"
}

$idx = 0
foreach ($vol in $a)
{
    Write-Host "============ Disco " $idx " ======="
    Write-Host "Nombre" $vol.Name
    Write-Host "Modelo" $vol.model
    Write-Host "Tamaño (en GB)" $vol.Size
    $idx = $idx + 1
}
Write-Host "----------------------------- Listado de volúmenes --------------------------------------"
$a = Get-CimInstance –ClassName Win32_Volume –Namespace Root\CIMV2 -ComputerName .
if ($a.GetType().IsArray) 
{
    Write-Host "Nº de volumenes" $a.Length
}
else
{
    Write-Host "Nº de volumenes 1"
}
$idx = 0
foreach ($vol in $a)
{
    Write-Host "============ Volumen " $idx " ======="
    Write-Host "Letra Asignada" $vol.DriveLetter
    Write-Host "Capacidad (en MB)" $vol.Capacity
    Write-Host "Espacio libre (en MB)"  $vol.FreeSpace
    Write-Host "Tipo de drive" $vol.DriveType
    Write-Host "Sistema de Ficheros" $vol.FileSystem
    $idx = $idx + 1
}