@echo off
echo =========================================
echo  REORGANIZANDO Y COMPILANDO PROYECTO
echo =========================================

:: 1. Detener Tomcat para liberar los archivos .class bloqueados
echo Deteniendo Tomcat...
taskkill /F /IM java.exe /T 2>nul

:: 2. Ir a la carpeta del proyecto
cd /d C:\Users\or361\OneDrive\Documentos\apache-tomcat-9.0.118-windows-x64\apache-tomcat-9.0.118\webapps\WebContent

:: 3. Compilar todos los archivos Java de la carpeta src
echo Compilando archivos .java...
javac -encoding UTF-8 -cp "WEB-INF/lib/*;../../lib/*" -d WEB-INF/classes src/*.java

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ¡COMPILACION EXITOSA!
    echo Reiniciando Tomcat...
    :: 4. Volver a arrancar Tomcat automáticamente
    start C:\Users\or361\OneDrive\Documentos\apache-tomcat-9.0.118-windows-x64\apache-tomcat-9.0.118\bin\startup.bat
) else (
    echo.
    echo [ERROR] Hubo un problema al compilar. Revisa los errores arriba.
)

pause