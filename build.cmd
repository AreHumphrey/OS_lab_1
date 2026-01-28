@echo off
REM build.cmd — автоматизированный скрипт сборки для Windows
REM Использование: build.cmd [debug|release]
REM Пример: build.cmd debug

setlocal enabledelayedexpansion
cd /d "%~dp0"

REM Определяем тип сборки (по умолчанию — debug)
set "BUILD_TYPE=%~1"
if "%BUILD_TYPE%"=="" set "BUILD_TYPE=debug"

echo ========================================
echo  Обновление кода из git...
echo ========================================
git pull origin main >nul 2>&1 || git pull origin master >nul 2>&1 || echo  Ветка не определена - пропускаем обновление

echo ========================================
echo  Очистка предыдущей сборки...
echo ========================================
rmdir /s /q build >nul 2>&1
mkdir build
cd build

echo ========================================
echo   Генерация проекта через CMake (тип: %BUILD_TYPE%)...
echo ========================================
cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=%BUILD_TYPE% || (
    echo  Ошибка генерации CMake!
    exit /b 1
)

echo ========================================
echo 🔨 Сборка проекта...
echo ========================================
cmake --build . --config %BUILD_TYPE% || (
    echo  Ошибка сборки!
    exit /b 1
)

echo.
echo ========================================
echo  Сборка завершена. Запуск программы:
echo ========================================
hello-world.exe
pause