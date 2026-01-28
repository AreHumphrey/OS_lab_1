#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
BUILD_TYPE="${1:-debug}"
echo "========================================"
echo "Обновление кода из git..."
echo "========================================"
cd "$PROJECT_DIR"
git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "Ветка не определена - пропускаем обновление"
echo "========================================"
echo "Очистка предыдущей сборки..."
echo "========================================"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
echo "========================================"
echo "Генерация проекта через CMake (тип: $BUILD_TYPE)..."
echo "========================================"
cmake .. -DCMAKE_BUILD_TYPE="${BUILD_TYPE^}" || { echo "Ошибка генерации CMake!"; exit 1; }
echo "========================================"
echo "Сборка проекта..."
echo "========================================"
cmake --build . --parallel $(nproc 2>/dev/null || echo 2) || { echo "Ошибка сборки!"; exit 1; }
echo
echo "========================================"
echo "Сборка завершена. Запуск программы:"
echo "========================================"
./hello-world