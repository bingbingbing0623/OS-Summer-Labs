#include "kernel/types.h"
#include "user/user.h"

void sieve(int p[2]) {
    int prime;
    int n;
    int p_next[2];

    close(p[1]); // 关闭写端，只读

    if (read(p[0], &prime, sizeof(prime)) == 0) {
        close(p[0]); // 没有更多数据，关闭读端
        exit(0);
    }

    printf("prime %d\n", prime);

    pipe(p_next);

    if (fork() == 0) {
        // 子进程处理筛选后的数据
        close(p[0]); // 关闭父进程的读端
        sieve(p_next); // 递归调用 sieve
    } else {
        // 父进程继续读取并筛选数据
        close(p_next[0]); // 关闭子进程的读端

        while (read(p[0], &n, sizeof(n)) != 0) {
            if (n % prime != 0) {
                write(p_next[1], &n, sizeof(n));
            }
        }

        close(p[0]); // 关闭当前管道的读端
        close(p_next[1]); // 关闭下一个管道的写端
        wait(0); // 等待子进程完成
        exit(0);
    }
}

int main() {
    int p[2];
    int i;

    pipe(p);

    if (fork() == 0) {
        sieve(p); // 子进程执行 sieve 函数
    } else {
        close(p[0]); // 父进程关闭读端

        for (i = 2; i <= 35; i++) {
            write(p[1], &i, sizeof(i));
        }

        close(p[1]); // 关闭写端
        wait(0); // 等待子进程完成
        exit(0);
    }

    return 0;
}

