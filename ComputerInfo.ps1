$a = Get-CimInstance –ClassName Win32_ComputerSystem –NameSpace Root\CIMV2 –Property *
Write-Host "Nombre de equipo:" $a.Name
Write-Host "Dominio:" $a.Domain
switch ($a.DomainRole)
{
    0 { "Estación de trabajo independiente" }
    1 { "Estación de trabajo miembro" }
    2 { "Servidor independiente" }
    3 { "Servidor miembro" }
    4 { "Controlador de dominio de copia de seguridad" }
    5 { "Controlador de dominio principal" }
}
