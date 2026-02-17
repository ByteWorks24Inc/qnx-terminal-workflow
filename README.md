Setup Needed:
1)Creating the QNX C Project:
Inside Momentics:
Login to workspace
Create New → QNX C Project
Select predefined template (e.g., Hello World)
This generates:
.project
.cproject
Makefile
src/Demo.c
These predefined files configure:
Cross compilation toolchain
Target architecture (x86_64)
Debug build configuration
Output folder structure
2)Creating the QNX VM with SSH Support:
We created the QNX VMware target using Momentics.
During Target Creation, we added SSH properties under:
```
Extra Options
```
🔐 SSH Extra Options Used
```sh
--ssh-ident=none --sshd-pregen=yes --getip --users=root/root
```
🧠 What These Options Do
Option	Purpose
--ssh-ident=none	Enables SSH without requiring public key file
--sshd-pregen=yes	Pre-generates SSH host keys
--getip	Enables DHCP networking
--users=root/root	Creates root user with password root
This ensures:
SSH server is included in image
Networking works automatically
We can login via SSH from host
VM gets IP address dynamically
After creation, the VM boots and networking is verified using:
```sh
ifconfig
```
Example output:
vmx0:
```sh
inet xxx.xxx.xx.xxx
```
3)Modifying the Source File:
modified:
```
src/Demo.c
```
Example:
```c
#include <stdio.h>

int main() {
    printf("Hello from TERMINAL WORKFLOW 🚀\n");
    return 0;
}
```
4)Loading QNX Build Environment (Host):
Before building from terminal:
```
C:\Users\xx\qnx800\env_full.bat
```
This sets:
QNX toolchain in PATH
Cross compiler (qcc)
Debug tools
env_full.bat:
```sh
@echo off
REM ===== Windows system paths first (so where, dir, etc work) =====
set PATH=C:\Windows\System32;C:\Windows;%PATH%
REM ===== QNX Base =====
set QNX_BASE=C:\Users\xx\qnx800
set QNX_HOST=%QNX_BASE%\host\win64\x86_64
set QNX_TARGET=%QNX_BASE%\target\qnx
set QNX_CONFIGURATION=C:\Users\xx\.qnx
set QNX_CONFIGURATION_EXCLUSIVE=%QNX_CONFIGURATION%
REM ===== Compiler include paths =====
set MAKEFLAGS=-I%QNX_TARGET%\usr\include
REM ===== Add QNX tools to PATH =====
set PATH=%QNX_HOST%\usr\bin;%QNX_BASE%\jre\bin;%QNX_BASE%\host\common\bin;%PATH%
REM ===== Temp dir =====
set TMPDIR=%TEMP%
echo.
echo QNX SDP 8 Environment Loaded
echo.
```
5)Building the Project from Terminal:
Navigate to project:
```
cd C:\Users\xx\ide-8.0-workspace\Demo
```
Clean (optional):
```sh
make clean
```
Build:
```sh
make
```
Output binary:
```sh
build\x86_64-debug\Demo
```
6)Connecting to VM via SSH:
Because of crypto compatibility between Windows and QNX, we used:
```sh
ssh -o MACs=hmac-sha2-256 -o Ciphers=aes128-ctr root@xxx.xxx.xx.xxx
Password:
root
```
7)Running the Program on VM:
Inside SSH session:
```sh
chmod +x /tmp/Demo
/tmp/Demo
```
OR directly from Windows:
```sh
ssh -o MACs=hmac-sha2-256 -o Ciphers=aes128-ctr root@xxx.xxx.xx.xxx /tmp/Demo
```
Full Terminal Automation Script:
```
run.bat
```
```sh
call C:\Users\xx\qnx800\env_full.bat
cd C:\Users\xx\ide-8.0-workspace\Demo
make
scp -o MACs=hmac-sha2-256 -o Ciphers=aes128-ctr build\x86_64-debug\Demo root@xxx.xxx.xx.xxx:/tmp/
ssh -o MACs=hmac-sha2-256 -o Ciphers=aes128-ctr root@xxx.xxx.xx.xxx /tmp/Demo
```
Run:
```
run
```
