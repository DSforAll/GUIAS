REM https://eternallybored.org/misc/wget/1.21.3/32/wget.exe  download this version of wget and put it in the same folder of this batch file

@echo off
cd %~dp0


set ADD_TO_PATH = 1
set PYTHON_VERSION=3.8.10
set PYTHON_AMD=python-%PYTHON_VERSION%-amd64.exe
set PYTHON_EXE=c:\Python38\python.exe
set PYTHON_PATH=c:\Python38
set PYTHON_PATH_SCRIPTS=c:\Python38\Scripts

set ENVS_PATH=c:\envs
set NAME_ENV=OCR_APP
set PYTHON_ENV_PATH= %ENVS_PATH%\%NAME_ENV%\Scripts
set PYTHON_ENV_EXE=%PYTHON_ENV_PATH%\python.exe


echo,
echo ------------------------------------------------------------------
echo Download Python
echo ------------------------------------------------------------------
echo,


if not exist %PYTHON_EXE% (
if not exist %PYTHON_AMD% (
	 wget -O "%PYTHON_AMD%" https://www.python.org/ftp/python/%PYTHON_VERSION%/%PYTHON_AMD%
)
)

echo,
echo ------------------------------------------------------------------
echo Install Python
echo ------------------------------------------------------------------
echo,

if not exist %PYTHON_EXE% (
if exist %PYTHON_AMD% (
	%PYTHON_AMD% /quiet /passive InstallAllUsers=1 PrependPath=%ADD_TO_PATH% Include_test=0 TargetDir=%PYTHON_PATH%
) else (
    echo Python installer package didn't seem to download correctly.
    exit /b 1
)
)


echo,
echo ------------------------------------------------------------------
echo Create VirtualEnv
echo ------------------------------------------------------------------
echo,


if not exist %ENVS_PATH%\%NAME_ENV% ( 
	mkdir %ENVS_PATH%\%NAME_ENV%
)

%PYTHON_EXE% -m pip install virtualenv 


if not exist %PYTHON_ENV_PATH% ( 
	%PYTHON_EXE% -m venv %ENVS_PATH%\%NAME_ENV%
	echo VirtualEnv Created
)


echo,
echo ------------------------------------------------------------------
echo install libraries
echo ------------------------------------------------------------------
echo,

if exist requirements.txt (
%PYTHON_ENV_EXE% -m pip install -r requirements.txt
)

if not exist requirements.txt (
%PYTHON_ENV_EXE% -m pip install PySide6 pdf2image Pillow easyocr
)

echo,
echo ------------------------------------------------------------------
echo Installation Completed
echo ------------------------------------------------------------------
echo,


