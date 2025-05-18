param(
    [string]$string,
    [int]$port = 22
)

$arg1 = $string.split("@")[0]
$arg2 = $string.split("@")[1]

$mypub = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"

# Prepare remote shell command with Unix-style newlines
$cmd = @"
mkdir -p ~/.ssh && \
touch ~/.ssh/authorized_keys && \
chmod 700 ~/.ssh && \
chmod 600 ~/.ssh/authorized_keys && \
echo '$mypub' >> ~/.ssh/authorized_keys
"@ -replace "`r`n", "`n"

ssh "$arg1@$arg2" -p $port $cmd
