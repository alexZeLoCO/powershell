$serviceName = Read-Host "Introduzca el nombre del servicio a gestionar"

if ((Get-CimInstance -Query "SELECT * FROM Win32_Service WHERE name = '$serviceName'" -NameSpace root/cimv2) -eq $null) {
    Write-Host "El servicio no existe"
    Exit
}

Write-Host "Seleccione una opción"
Write-Host "1) Obtener una descripcion del servicio"
Write-Host "2) Indicar modo de arranque"
Write-Host "3) Indicar estado del servicio"
Write-Host "4) Arrancar el servicio"
Write-Host "5) Parar el servicio"

$option = Read-Host "Introduzca el numero de la opcion debe estar entre 1 y 5."
if ($option -lt 1 -or $option -gt 5) {
    Write-Host "Opcion Invalida. El numero de opción debe estar entre 1 y 5"
    Exit
}

switch ($option) {
    1 {
        $service = Get-CimInstance -Class Win32_Service -Filter "Name='$serviceName'"
        Write-Host "Descripcion del cometido del servicio '$serviceName': $($service.Description)"
    }
    2 {
        $service = Get-CimInstance -Class Win32_Service -Filter "Name='$serviceName'"
        Write-Host "Modo de arranque del servicio '$serviceName': $($service.Description)"
    }
    3 {
        $service = Get-CimInstance -Class Win32_Service -Filter "Name='$serviceName'"
        Write-Host "Estado del servicio '$serviceName': $($service.State)"
    }
    4 {
        $service = Get-CimInstance -Class Win32_Service -Filter "Name='$serviceName'"
        $out = Invoke-CimMethod -InputObject $service -MethodName StartService
        if ($out.ReturnValue -eq 0) {
            Write-Host "El servico ha sido iniciado"
        } else {
            Write-Host "Error al iniciar el servicio '$serviceName'."
        }
    }
    5 {
        $service = Get-CimInstance -Class Win32_Service -Filter "Name='$serviceName'"
        $out = Invoke-CimMethod -InputObject $service -MethodName StopService
        if ($out.ReturnValue -eq 0) {
            Write-Host "El servico ha sido detenido"
        } else {
            Write-Host "Error al detener el servicio '$serviceName'."
        }
    }
}
