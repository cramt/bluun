this is an extension of the regular powershell language, think of it like jquery for powershell

install script

```ps
if (!(Test-Path -Path $PROFILE ))
{ New-Item -Type File -Path $PROFILE -Force };
Add-Content -Path $PROFILE -Value '. ("$((Get-Item $PROFILE).Directory.FullName)\bluun\index.ps1")'
git clone https://github.com/cramt/bluun.git "$((Get-Item $PROFILE).Directory.FullName)"
```