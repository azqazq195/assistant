certutil
set path=%~dp0
certutil -addstore "Root" "%path%Moseoh.cer"
pause