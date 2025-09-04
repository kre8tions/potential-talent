# Path to Conda environment and activation script
$envName = "NLP"
$condaEnvPath = "C:\Users\Alex Chung\anaconda3\envs\$envName"
$activateScript = "$condaEnvPath\Scripts\activate.bat"

# Target folder to move requirements.txt
$destination = "C:\Users\Alex Chung\Documents\the_Lab\Apziva\Potential Talent"

# Check for activate.bat
if (-Not (Test-Path $activateScript)) {
    Write-Error "Activation script not found at $activateScript. Check your conda env path."
    exit 1
}

# Activate environment in CMD and run freeze
cmd.exe /k "`"$activateScript`" && pip freeze > requirements.txt && exit"

# Wait for user to confirm
Read-Host "After requirements.txt is created, press Enter to copy it"

# Copy requirements.txt
if (Test-Path ".\requirements.txt") {
    if (-Not (Test-Path $destination)) {
        New-Item -Path $destination -ItemType Directory -Force | Out-Null
    }
    Copy-Item -Path ".\requirements.txt" -Destination "$destination\requirements.txt" -Force
    Write-Host "✅ requirements.txt copied to $destination"
} else {
    Write-Error "❌ requirements.txt was not created. Check pip freeze step."
}
