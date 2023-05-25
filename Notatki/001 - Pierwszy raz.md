# Pierwsze spotkanie z asemblerem

## Nauka metodą kamienia z rosetty
Kod CMake do budowania projektu
```cmake
cmake_minimum_required(VERSION 3.25)
project(Cpp)

set(CMAKE_CXX_STANDARD 23)

add_executable(Cpp main.cpp)


project(Asm ASM)
set_property(SOURCE main.asm APPEND PROPERTY COMPILE_OPTIONS "-x" "assembler-with-cpp")
add_compile_options(-masm=intel)
add_executable(Asm main.asm)
```

Kod w C++
```c++
int main() {
    unsigned int zm_a = 5;
    unsigned int zm_b = 8;
    return zm_a + zm_b;
}
```

Komenda do dekompilacji kodu z pliku `cmake-build-debug/CMakeFiles/Cpp.dir/main.cpp.obj`
```bash
objdump -d .\cmake-build-debug\CMakeFiles\Cpp.dir\main.cpp.obj
```

Wygenerowany asembler
```text
.\cmake-build-debug\CMakeFiles\Cpp.dir\main.cpp.obj:     file format pe-x86-64


Disassembly of section .text:

0000000000000000 <main>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	48 83 ec 30          	sub    $0x30,%rsp
   8:	e8 00 00 00 00       	call   d <main+0xd>
   d:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
  14:	c7 45 f8 08 00 00 00 	movl   $0x8,-0x8(%rbp)
  1b:	8b 55 fc             	mov    -0x4(%rbp),%edx
  1e:	8b 45 f8             	mov    -0x8(%rbp),%eax
  21:	01 d0                	add    %edx,%eax
  23:	48 83 c4 30          	add    $0x30,%rsp
  27:	5d                   	pop    %rbp
  28:	c3                   	ret    
  29:	90                   	nop
  2a:	90                   	nop
  2b:	90                   	nop
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
```

## Wnioski
```asm
push   %rbp                 ; Zapisanie obecnego stanu rejestru na stosie
mov    %rsp,%rbp            ; Skopiowanie rejestru rsp do rbp
sub    $0x30,%rsp           ; Odjęcie od  0x30 zawartości rejestru rsp
call   d <main+0xd>         ; Wywołanie funkcji main()
movl   $0x5,-0x4(%rbp)      ; Zapisanie do fragmentu rejestru rbp wartości 0x5
movl   $0x8,-0x8(%rbp)      ; Zapisanie do fragmentu rejestru rbp wartości 0x8
mov    -0x4(%rbp),%edx      ; Przeniesienie wcześniej zapisanego 0x5 do rejestru edx
mov    -0x8(%rbp),%eax      ; Przeniesienie wcześniej zapisanego 0x8 do rejestru eax
add    %edx,%eax            ; Operacja dodawania rejestrów edx do eax
add    $0x30,%rsp           ; Dodanie 0x30 do rejestru rsp
pop    %rbp                 ; Cofnięcie z rejestru wartości rejestru rbp
ret                         ; Zakończenie programu
nop
nop
nop
nop
nop
nop
nop
```

### Symbole
`%` - odwołanie do rejestru \
`$` - literał \
`0x4(%rbp)` - odwołanie do adresu `0x4` rejestru rbp. Jeśli będzie jakaś liczba bez podania symbolu to oznacza sztywny adres w pamięci.

### Instrukcje
- `movl` - Przeniesienie wartości typu long