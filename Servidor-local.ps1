& {
    $ErrorActionPreference = 'Stop'
    $port = 47831
    $url = "http://127.0.0.1:$port/"

    try {
        $page = [System.IO.File]::ReadAllBytes($env:SPRITEFONT_HTML)
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $port)
        $listener.Start()
    } catch {
        Write-Host "No se pudo iniciar SpriteFont Studio. Si ya esta abierto, usa $url"
        Write-Host "Tambien podes abrir SpriteFont-Studio.html directamente con Edge o Chrome."
        Write-Host $_.Exception.Message
        exit 1
    }

    try {
        Write-Host "SpriteFont Studio en $url"
        Write-Host 'Deja esta ventana abierta mientras uses la herramienta. Para cerrar el servidor, pulsa Ctrl+C.'
        try {
            $edge = Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application\msedge.exe'
            if (Test-Path -LiteralPath $edge) {
                Start-Process -FilePath $edge -ArgumentList $url
            } else {
                Start-Process $url
            }
        } catch {
            Write-Host "Abri $url en Edge o Chrome."
        }

        $empty = [byte[]]::new(0)
        while ($true) {
            $client = $listener.AcceptTcpClient()
            try {
                $stream = $client.GetStream()
                $stream.ReadTimeout = 2000
                $stream.WriteTimeout = 2000
                $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII)
                $request = $reader.ReadLine()
                $hostMatches = $false
                for ($i = 0; $i -lt 40; $i++) {
                    $line = $reader.ReadLine()
                    if (-not $line) { break }
                    if ($line -eq "Host: 127.0.0.1:$port") { $hostMatches = $true }
                }
                $body = $empty
                $httpStatus = '404 Not Found'
                if ($hostMatches -and $request -match '^GET /(?:SpriteFont-Studio\.html)? HTTP/1\.[01]$') {
                    $body = $page
                    $httpStatus = '200 OK'
                }
                $headers = "HTTP/1.1 $httpStatus`r`nContent-Type: text/html; charset=utf-8`r`nContent-Length: $($body.Length)`r`nConnection: close`r`nCache-Control: no-store`r`nX-Content-Type-Options: nosniff`r`nX-Frame-Options: DENY`r`n`r`n"
                $bytes = [System.Text.Encoding]::ASCII.GetBytes($headers)
                $stream.Write($bytes, 0, $bytes.Length)
                if ($body.Length) { $stream.Write($body, 0, $body.Length) }
            } catch {
                # El navegador puede cerrar o abandonar conexiones especulativas.
            } finally {
                $client.Dispose()
            }
        }
    } finally {
        $listener.Stop()
    }
}

