
cmake_minimum_required(VERSION 3.10)

project(HelloWorld VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON) 

add_executable(hello-world src/main.cpp)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(hello-world PRIVATE -g -O0)
endif()