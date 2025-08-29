@echo off
REM Build script for Windows
REM Prerequisites:
REM   - CMake
REM   - Visual Studio or MinGW
REM   - GStreamer (optional, for video/audio rendering)
REM   - Bonjour SDK for Windows
REM   - OpenSSL

echo Building RPiPlay for Windows...

if not exist build-windows mkdir build-windows
cd build-windows

REM Configure with CMake
cmake -G "Visual Studio 16 2019" -A x64 ..

REM Build the project
cmake --build . --config Release

echo Build complete. Executable should be in build-windows\Release\rpiplay.exe
pause
