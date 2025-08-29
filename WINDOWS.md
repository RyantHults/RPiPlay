# Building RPiPlay on Windows

## Prerequisites

1. **CMake** (3.4.1 or later)
2. **Visual Studio 2019 or later** (with C++ support) OR **MinGW-w64**
3. **Bonjour SDK for Windows** (for DNS-SD support)
4. **OpenSSL for Windows** (for encryption)
5. **GStreamer** (optional, for hardware-accelerated rendering)

## Dependencies Installation

### 1. Bonjour SDK
- Download from Apple Developer site or use Bonjour Print Services for Windows
- Required for network discovery functionality

### 2. OpenSSL
- Download from: https://slproweb.com/products/Win32OpenSSL.html
- Or use vcpkg: `vcpkg install openssl:x64-windows`

### 3. GStreamer (Optional)
- Download from: https://gstreamer.freedesktop.org/download/
- Install the MSVC x86_64 runtime and development packages
- Add GStreamer bin directory to PATH

## Building

### Option 1: Using the provided batch script
```cmd
build-windows.bat
```

### Option 2: Manual build
```cmd
mkdir build-windows
cd build-windows
cmake -G "Visual Studio 16 2019" -A x64 ..
cmake --build . --config Release
```

## Notes

- On Windows, only the **dummy** and **GStreamer** renderers are available
- The Raspberry Pi OpenMAX renderer is not supported on Windows
- Make sure all dependencies are properly installed and in PATH
- You may need to adjust CMake paths if dependencies are installed in non-standard locations

## Troubleshooting

1. **Bonjour/DNS-SD errors**: Ensure Bonjour SDK is properly installed
2. **OpenSSL errors**: Check OpenSSL installation and add to PATH if needed
3. **GStreamer errors**: Verify GStreamer installation and PATH configuration
4. **Build errors**: Ensure Visual Studio C++ tools are properly installed
