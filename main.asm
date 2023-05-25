.global main

        .text
main:                                   # This is called by C library's startup code
        push   %rbp
        mov    %rsp,%rbp
        sub    $0x30,%rsp
        movl   $0x5,-0x4(%rbp)
        movl   $0x8,-0x8(%rbp)
        mov    -0x4(%rbp),%edx
        mov    -0x8(%rbp),%eax
        add    %edx,%eax
        add    $0x30,%rsp
        pop    %rbp
        ret                             # Return to C library code