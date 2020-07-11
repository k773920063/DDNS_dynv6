@echo off
setlocal enabledelayedexpansion

set token='Your token'
set hostname='Your dynv6 hostname'
set "ipv6_cache='ipv6 address file address'"

if not exist %ipv6_cache% (echo create_ipv6_cache_file > %ipv6_cache%)

for /f "delims={}" %%i in ('wmic nicConfig where "IPEnabled='True'" get IPAddress ^| find ":"') do (
    for %%j in (%%i) do (
        set "IPv6=%%~j"
        ::if "!IPv6::=!" NEQ "!IPv6!" echo;!IPv6!]
        set IPv6 = %%j
    )
)

set /P IPv6_old=<%ipv6_cache%
echo %IPv6_old%

if %IPv6_old% EQU %IPv6% (
echo The ipv6 address is not change.
goto :out2
) else (
echo Found new ipv6 address
goto :out1

)

:out1
echo %IPv6% > %ipv6_cache%
set "Url=https://dynv6.com/api/update?hostname=%hostname%^&ipv6=%IPv6%^&token=%token%"

curl %Url%

:out2
