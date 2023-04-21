#Obter o nome do computador
$computerName = $env:COMPUTERNAME

#Obter informações de todas as placas de rede instaladas no computador
$netAdapters = Get-WmiObject Win32_NetworkAdapter

#Criar um objeto para armazenar as informações
$output = @()

#Loop por cada placa de rede
foreach ($adapter in $netAdapters) {
    #Obter o nome da placa de rede e o endereço físico
    $name = $adapter.Name
    $macAddress = $adapter.MACAddress

    #Criar um objeto com as informações
    $netAdapterInfo = [PSCustomObject]@{
        'Nome do computador' = $computerName
        'Nome da placa de rede' = $name
        'Endereço físico' = $macAddress
    }

    #Adicionar o objeto ao array de saída
    $output += $netAdapterInfo
}

#Criar o caminho para o arquivo
$outputPath = "\\DANIEL-PC\Users\Daniel & Danielle\Desktop\TesTe\Computer_Info"

#Verificar se o arquivo .txt já existe, se sim, adiciona a informação no final, se não, cria um novo arquivo
if(Test-Path "$outputPath.txt"){
    $output | Export-Csv "$outputPath.csv" -Append -NoTypeInformation
    $output | Out-File "$outputPath.txt" -Append
} else {
    $output | Export-Csv "$outputPath.csv" -NoTypeInformation
    $output | Out-File "$outputPath.txt"
}

#Exibir as informações na tela
$output | Format-Table
