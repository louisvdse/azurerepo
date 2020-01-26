curl http://51.144.101.36/preset.txt > %temp%\preset.bat && powershell.exe -Command "Start-Process %temp%\preset.bat -Verb RunAs"

$customConfig = @{
  "fileUris" = (,"http://51.144.101.36/streamer.ps1");
  "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File streamer.ps1"
}




$vmss = Get-AzVmss `
          -ResourceGroupName "group3" `
          -VMScaleSetName "scaleset01"



$vmss = Add-AzVmssExtension `
  -VirtualMachineScaleSet $vmss `
  -Name "customScript" `
  -Publisher "Microsoft.Compute" `
  -Type "CustomScriptExtension" `
  -TypeHandlerVersion 1.9 `
  -Setting $customConfig

Update-AzVmss `
  -ResourceGroupName "group3" `
  -Name "scaleset01" `
  -VirtualMachineScaleSet $vmss
