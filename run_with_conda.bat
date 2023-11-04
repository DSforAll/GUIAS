@echo OFF
rem la linea de abajo minimizará la ventana del cmd pero seguirá aparenciendo
rem if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit

rem Cómo ejecutar un script de Python en un entorno conda determinado desde un archivo .bat .

rem Esto no requiere:
rem - tener conda añadido al PATH
rem - cmd.exe que se inicializará con conda init

rem Defina aquí la ruta a su instalación de conda o miniconda.
set CONDAPATH=C:\Users\pepe\Anaconda3
rem Defina aquí el nombre del entorno
set ENVNAME=ia

rem El siguiente comando activa el entorno base.

if %ENVNAME%==base (set ENVPATH=%CONDAPATH%) else (set ENVPATH=%CONDAPATH%\envs\%ENVNAME%)

rem Activar el entorno conda
rem Se requiere el uso de call aquí, see: https://stackoverflow.com/questions/24678144/conda-environments-and-bat-files
call %CONDAPATH%\Scripts\activate.bat %ENVPATH%

rem  con el comando cd %~dp0  nos colocamos directamente en la carpeta donde se encuentra el archivo .bat
cd %~dp0
rem Ejecutar un script de Python en ese entorno. Debido al comando anterior el script de python a ejecitarse debe estar en la misma carpeta que este .bat
python login.py

rem desactivamos el entorno
call conda deactivate

exit

rem Si conda está añadido a las variables del sistema, con el siguiente código basta
rem call activate someenv
rem python script.py
rem conda deactivate

rem También se podría usar el comando conda run
rem conda run -n someenv python script.py