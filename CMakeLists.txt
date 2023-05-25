cmake_minimum_required(VERSION 3.25)
project(Cpp)

set(CMAKE_CXX_STANDARD 23)

add_executable(Cpp main.cpp)


project(Asm ASM)
set_property(SOURCE main.asm APPEND PROPERTY COMPILE_OPTIONS "-x" "assembler-with-cpp")
add_compile_options(-masm=intel)
add_executable(Asm main.asm)
