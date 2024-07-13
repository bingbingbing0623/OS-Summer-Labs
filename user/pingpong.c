#include "kernel/types.h"
#include "user/user.h"

int main() {
    int p1[2]; // 父到子的管道
    int p2[2]; // 子到父的管道
    char byte = 'a';

    // 创建两个管道
    pipe(p1);
    pipe(p2);

    if (fork() == 0) { // 子进程
        close(p1[1]); // 关闭父到子的写端
        close(p2[0]); // 关闭子到父的读端

        read(p1[0], &byte, 1); // 从父进程读取字节
        printf("%d: received ping\n", getpid());

        write(p2[1], &byte, 1); // 将字节写回父进程

        close(p1[0]); // 关闭父到子的读端
        close(p2[1]); // 关闭子到父的写端
        exit(0);
    } else { // 父进程
        close(p1[0]); // 关闭父到子的读端
        close(p2[1]); // 关闭子到父的写端

        write(p1[1], &byte, 1); // 将字节写给子进程

        read(p2[0], &byte, 1); // 从子进程读取字节
        printf("%d: received pong\n", getpid());

        close(p1[1]); // 关闭父到子的写端
        close(p2[0]); // 关闭子到父的读端
        exit(0);
    }
}

