
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sieve>:
#include "kernel/types.h"
#include "user/user.h"

void sieve(int p[2]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
    int prime;
    int n;
    int p_next[2];

    close(p[1]); // 关闭写端，只读
   c:	4148                	lw	a0,4(a0)
   e:	00000097          	auipc	ra,0x0
  12:	412080e7          	jalr	1042(ra) # 420 <close>

    if (read(p[0], &prime, sizeof(prime)) == 0) {
  16:	4611                	li	a2,4
  18:	fdc40593          	addi	a1,s0,-36
  1c:	4088                	lw	a0,0(s1)
  1e:	00000097          	auipc	ra,0x0
  22:	3f2080e7          	jalr	1010(ra) # 410 <read>
  26:	c531                	beqz	a0,72 <sieve+0x72>
        close(p[0]); // 没有更多数据，关闭读端
        exit(0);
    }

    printf("prime %d\n", prime);
  28:	fdc42583          	lw	a1,-36(s0)
  2c:	00001517          	auipc	a0,0x1
  30:	8ec50513          	addi	a0,a0,-1812 # 918 <malloc+0xea>
  34:	00000097          	auipc	ra,0x0
  38:	73c080e7          	jalr	1852(ra) # 770 <printf>

    pipe(p_next);
  3c:	fd040513          	addi	a0,s0,-48
  40:	00000097          	auipc	ra,0x0
  44:	3c8080e7          	jalr	968(ra) # 408 <pipe>

    if (fork() == 0) {
  48:	00000097          	auipc	ra,0x0
  4c:	3a8080e7          	jalr	936(ra) # 3f0 <fork>
  50:	e91d                	bnez	a0,86 <sieve+0x86>
        // 子进程处理筛选后的数据
        close(p[0]); // 关闭父进程的读端
  52:	4088                	lw	a0,0(s1)
  54:	00000097          	auipc	ra,0x0
  58:	3cc080e7          	jalr	972(ra) # 420 <close>
        sieve(p_next); // 递归调用 sieve
  5c:	fd040513          	addi	a0,s0,-48
  60:	00000097          	auipc	ra,0x0
  64:	fa0080e7          	jalr	-96(ra) # 0 <sieve>
        close(p[0]); // 关闭当前管道的读端
        close(p_next[1]); // 关闭下一个管道的写端
        wait(0); // 等待子进程完成
        exit(0);
    }
}
  68:	70a2                	ld	ra,40(sp)
  6a:	7402                	ld	s0,32(sp)
  6c:	64e2                	ld	s1,24(sp)
  6e:	6145                	addi	sp,sp,48
  70:	8082                	ret
        close(p[0]); // 没有更多数据，关闭读端
  72:	4088                	lw	a0,0(s1)
  74:	00000097          	auipc	ra,0x0
  78:	3ac080e7          	jalr	940(ra) # 420 <close>
        exit(0);
  7c:	4501                	li	a0,0
  7e:	00000097          	auipc	ra,0x0
  82:	37a080e7          	jalr	890(ra) # 3f8 <exit>
        close(p_next[0]); // 关闭子进程的读端
  86:	fd042503          	lw	a0,-48(s0)
  8a:	00000097          	auipc	ra,0x0
  8e:	396080e7          	jalr	918(ra) # 420 <close>
        while (read(p[0], &n, sizeof(n)) != 0) {
  92:	4611                	li	a2,4
  94:	fd840593          	addi	a1,s0,-40
  98:	4088                	lw	a0,0(s1)
  9a:	00000097          	auipc	ra,0x0
  9e:	376080e7          	jalr	886(ra) # 410 <read>
  a2:	c115                	beqz	a0,c6 <sieve+0xc6>
            if (n % prime != 0) {
  a4:	fd842783          	lw	a5,-40(s0)
  a8:	fdc42703          	lw	a4,-36(s0)
  ac:	02e7e7bb          	remw	a5,a5,a4
  b0:	d3ed                	beqz	a5,92 <sieve+0x92>
                write(p_next[1], &n, sizeof(n));
  b2:	4611                	li	a2,4
  b4:	fd840593          	addi	a1,s0,-40
  b8:	fd442503          	lw	a0,-44(s0)
  bc:	00000097          	auipc	ra,0x0
  c0:	35c080e7          	jalr	860(ra) # 418 <write>
  c4:	b7f9                	j	92 <sieve+0x92>
        close(p[0]); // 关闭当前管道的读端
  c6:	4088                	lw	a0,0(s1)
  c8:	00000097          	auipc	ra,0x0
  cc:	358080e7          	jalr	856(ra) # 420 <close>
        close(p_next[1]); // 关闭下一个管道的写端
  d0:	fd442503          	lw	a0,-44(s0)
  d4:	00000097          	auipc	ra,0x0
  d8:	34c080e7          	jalr	844(ra) # 420 <close>
        wait(0); // 等待子进程完成
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	322080e7          	jalr	802(ra) # 400 <wait>
        exit(0);
  e6:	4501                	li	a0,0
  e8:	00000097          	auipc	ra,0x0
  ec:	310080e7          	jalr	784(ra) # 3f8 <exit>

00000000000000f0 <main>:

int main() {
  f0:	7179                	addi	sp,sp,-48
  f2:	f406                	sd	ra,40(sp)
  f4:	f022                	sd	s0,32(sp)
  f6:	ec26                	sd	s1,24(sp)
  f8:	1800                	addi	s0,sp,48
    int p[2];
    int i;

    pipe(p);
  fa:	fd840513          	addi	a0,s0,-40
  fe:	00000097          	auipc	ra,0x0
 102:	30a080e7          	jalr	778(ra) # 408 <pipe>

    if (fork() == 0) {
 106:	00000097          	auipc	ra,0x0
 10a:	2ea080e7          	jalr	746(ra) # 3f0 <fork>
 10e:	ed09                	bnez	a0,128 <main+0x38>
        sieve(p); // 子进程执行 sieve 函数
 110:	fd840513          	addi	a0,s0,-40
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) # 0 <sieve>
        wait(0); // 等待子进程完成
        exit(0);
    }

    return 0;
}
 11c:	4501                	li	a0,0
 11e:	70a2                	ld	ra,40(sp)
 120:	7402                	ld	s0,32(sp)
 122:	64e2                	ld	s1,24(sp)
 124:	6145                	addi	sp,sp,48
 126:	8082                	ret
        close(p[0]); // 父进程关闭读端
 128:	fd842503          	lw	a0,-40(s0)
 12c:	00000097          	auipc	ra,0x0
 130:	2f4080e7          	jalr	756(ra) # 420 <close>
        for (i = 2; i <= 35; i++) {
 134:	4789                	li	a5,2
 136:	fcf42a23          	sw	a5,-44(s0)
 13a:	02300493          	li	s1,35
            write(p[1], &i, sizeof(i));
 13e:	4611                	li	a2,4
 140:	fd440593          	addi	a1,s0,-44
 144:	fdc42503          	lw	a0,-36(s0)
 148:	00000097          	auipc	ra,0x0
 14c:	2d0080e7          	jalr	720(ra) # 418 <write>
        for (i = 2; i <= 35; i++) {
 150:	fd442783          	lw	a5,-44(s0)
 154:	2785                	addiw	a5,a5,1
 156:	0007871b          	sext.w	a4,a5
 15a:	fcf42a23          	sw	a5,-44(s0)
 15e:	fee4d0e3          	bge	s1,a4,13e <main+0x4e>
        close(p[1]); // 关闭写端
 162:	fdc42503          	lw	a0,-36(s0)
 166:	00000097          	auipc	ra,0x0
 16a:	2ba080e7          	jalr	698(ra) # 420 <close>
        wait(0); // 等待子进程完成
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	290080e7          	jalr	656(ra) # 400 <wait>
        exit(0);
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	27e080e7          	jalr	638(ra) # 3f8 <exit>

0000000000000182 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 182:	1141                	addi	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 188:	87aa                	mv	a5,a0
 18a:	0585                	addi	a1,a1,1
 18c:	0785                	addi	a5,a5,1
 18e:	fff5c703          	lbu	a4,-1(a1)
 192:	fee78fa3          	sb	a4,-1(a5)
 196:	fb75                	bnez	a4,18a <strcpy+0x8>
    ;
  return os;
}
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret

000000000000019e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1a4:	00054783          	lbu	a5,0(a0)
 1a8:	cb91                	beqz	a5,1bc <strcmp+0x1e>
 1aa:	0005c703          	lbu	a4,0(a1)
 1ae:	00f71763          	bne	a4,a5,1bc <strcmp+0x1e>
    p++, q++;
 1b2:	0505                	addi	a0,a0,1
 1b4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1b6:	00054783          	lbu	a5,0(a0)
 1ba:	fbe5                	bnez	a5,1aa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1bc:	0005c503          	lbu	a0,0(a1)
}
 1c0:	40a7853b          	subw	a0,a5,a0
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strlen>:

uint
strlen(const char *s)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	cf91                	beqz	a5,1f0 <strlen+0x26>
 1d6:	0505                	addi	a0,a0,1
 1d8:	87aa                	mv	a5,a0
 1da:	4685                	li	a3,1
 1dc:	9e89                	subw	a3,a3,a0
 1de:	00f6853b          	addw	a0,a3,a5
 1e2:	0785                	addi	a5,a5,1
 1e4:	fff7c703          	lbu	a4,-1(a5)
 1e8:	fb7d                	bnez	a4,1de <strlen+0x14>
    ;
  return n;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	addi	sp,sp,16
 1ee:	8082                	ret
  for(n = 0; s[n]; n++)
 1f0:	4501                	li	a0,0
 1f2:	bfe5                	j	1ea <strlen+0x20>

00000000000001f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1fa:	ce09                	beqz	a2,214 <memset+0x20>
 1fc:	87aa                	mv	a5,a0
 1fe:	fff6071b          	addiw	a4,a2,-1
 202:	1702                	slli	a4,a4,0x20
 204:	9301                	srli	a4,a4,0x20
 206:	0705                	addi	a4,a4,1
 208:	972a                	add	a4,a4,a0
    cdst[i] = c;
 20a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 20e:	0785                	addi	a5,a5,1
 210:	fee79de3          	bne	a5,a4,20a <memset+0x16>
  }
  return dst;
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strchr>:

char*
strchr(const char *s, char c)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 220:	00054783          	lbu	a5,0(a0)
 224:	cb99                	beqz	a5,23a <strchr+0x20>
    if(*s == c)
 226:	00f58763          	beq	a1,a5,234 <strchr+0x1a>
  for(; *s; s++)
 22a:	0505                	addi	a0,a0,1
 22c:	00054783          	lbu	a5,0(a0)
 230:	fbfd                	bnez	a5,226 <strchr+0xc>
      return (char*)s;
  return 0;
 232:	4501                	li	a0,0
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
  return 0;
 23a:	4501                	li	a0,0
 23c:	bfe5                	j	234 <strchr+0x1a>

000000000000023e <gets>:

char*
gets(char *buf, int max)
{
 23e:	711d                	addi	sp,sp,-96
 240:	ec86                	sd	ra,88(sp)
 242:	e8a2                	sd	s0,80(sp)
 244:	e4a6                	sd	s1,72(sp)
 246:	e0ca                	sd	s2,64(sp)
 248:	fc4e                	sd	s3,56(sp)
 24a:	f852                	sd	s4,48(sp)
 24c:	f456                	sd	s5,40(sp)
 24e:	f05a                	sd	s6,32(sp)
 250:	ec5e                	sd	s7,24(sp)
 252:	1080                	addi	s0,sp,96
 254:	8baa                	mv	s7,a0
 256:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 258:	892a                	mv	s2,a0
 25a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 25c:	4aa9                	li	s5,10
 25e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 260:	89a6                	mv	s3,s1
 262:	2485                	addiw	s1,s1,1
 264:	0344d863          	bge	s1,s4,294 <gets+0x56>
    cc = read(0, &c, 1);
 268:	4605                	li	a2,1
 26a:	faf40593          	addi	a1,s0,-81
 26e:	4501                	li	a0,0
 270:	00000097          	auipc	ra,0x0
 274:	1a0080e7          	jalr	416(ra) # 410 <read>
    if(cc < 1)
 278:	00a05e63          	blez	a0,294 <gets+0x56>
    buf[i++] = c;
 27c:	faf44783          	lbu	a5,-81(s0)
 280:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 284:	01578763          	beq	a5,s5,292 <gets+0x54>
 288:	0905                	addi	s2,s2,1
 28a:	fd679be3          	bne	a5,s6,260 <gets+0x22>
  for(i=0; i+1 < max; ){
 28e:	89a6                	mv	s3,s1
 290:	a011                	j	294 <gets+0x56>
 292:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 294:	99de                	add	s3,s3,s7
 296:	00098023          	sb	zero,0(s3)
  return buf;
}
 29a:	855e                	mv	a0,s7
 29c:	60e6                	ld	ra,88(sp)
 29e:	6446                	ld	s0,80(sp)
 2a0:	64a6                	ld	s1,72(sp)
 2a2:	6906                	ld	s2,64(sp)
 2a4:	79e2                	ld	s3,56(sp)
 2a6:	7a42                	ld	s4,48(sp)
 2a8:	7aa2                	ld	s5,40(sp)
 2aa:	7b02                	ld	s6,32(sp)
 2ac:	6be2                	ld	s7,24(sp)
 2ae:	6125                	addi	sp,sp,96
 2b0:	8082                	ret

00000000000002b2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b2:	1101                	addi	sp,sp,-32
 2b4:	ec06                	sd	ra,24(sp)
 2b6:	e822                	sd	s0,16(sp)
 2b8:	e426                	sd	s1,8(sp)
 2ba:	e04a                	sd	s2,0(sp)
 2bc:	1000                	addi	s0,sp,32
 2be:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c0:	4581                	li	a1,0
 2c2:	00000097          	auipc	ra,0x0
 2c6:	176080e7          	jalr	374(ra) # 438 <open>
  if(fd < 0)
 2ca:	02054563          	bltz	a0,2f4 <stat+0x42>
 2ce:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d0:	85ca                	mv	a1,s2
 2d2:	00000097          	auipc	ra,0x0
 2d6:	17e080e7          	jalr	382(ra) # 450 <fstat>
 2da:	892a                	mv	s2,a0
  close(fd);
 2dc:	8526                	mv	a0,s1
 2de:	00000097          	auipc	ra,0x0
 2e2:	142080e7          	jalr	322(ra) # 420 <close>
  return r;
}
 2e6:	854a                	mv	a0,s2
 2e8:	60e2                	ld	ra,24(sp)
 2ea:	6442                	ld	s0,16(sp)
 2ec:	64a2                	ld	s1,8(sp)
 2ee:	6902                	ld	s2,0(sp)
 2f0:	6105                	addi	sp,sp,32
 2f2:	8082                	ret
    return -1;
 2f4:	597d                	li	s2,-1
 2f6:	bfc5                	j	2e6 <stat+0x34>

00000000000002f8 <atoi>:

int
atoi(const char *s)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fe:	00054603          	lbu	a2,0(a0)
 302:	fd06079b          	addiw	a5,a2,-48
 306:	0ff7f793          	andi	a5,a5,255
 30a:	4725                	li	a4,9
 30c:	02f76963          	bltu	a4,a5,33e <atoi+0x46>
 310:	86aa                	mv	a3,a0
  n = 0;
 312:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 314:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 316:	0685                	addi	a3,a3,1
 318:	0025179b          	slliw	a5,a0,0x2
 31c:	9fa9                	addw	a5,a5,a0
 31e:	0017979b          	slliw	a5,a5,0x1
 322:	9fb1                	addw	a5,a5,a2
 324:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 328:	0006c603          	lbu	a2,0(a3)
 32c:	fd06071b          	addiw	a4,a2,-48
 330:	0ff77713          	andi	a4,a4,255
 334:	fee5f1e3          	bgeu	a1,a4,316 <atoi+0x1e>
  return n;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
  n = 0;
 33e:	4501                	li	a0,0
 340:	bfe5                	j	338 <atoi+0x40>

0000000000000342 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 348:	02b57663          	bgeu	a0,a1,374 <memmove+0x32>
    while(n-- > 0)
 34c:	02c05163          	blez	a2,36e <memmove+0x2c>
 350:	fff6079b          	addiw	a5,a2,-1
 354:	1782                	slli	a5,a5,0x20
 356:	9381                	srli	a5,a5,0x20
 358:	0785                	addi	a5,a5,1
 35a:	97aa                	add	a5,a5,a0
  dst = vdst;
 35c:	872a                	mv	a4,a0
      *dst++ = *src++;
 35e:	0585                	addi	a1,a1,1
 360:	0705                	addi	a4,a4,1
 362:	fff5c683          	lbu	a3,-1(a1)
 366:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 36a:	fee79ae3          	bne	a5,a4,35e <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
    dst += n;
 374:	00c50733          	add	a4,a0,a2
    src += n;
 378:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 37a:	fec05ae3          	blez	a2,36e <memmove+0x2c>
 37e:	fff6079b          	addiw	a5,a2,-1
 382:	1782                	slli	a5,a5,0x20
 384:	9381                	srli	a5,a5,0x20
 386:	fff7c793          	not	a5,a5
 38a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 38c:	15fd                	addi	a1,a1,-1
 38e:	177d                	addi	a4,a4,-1
 390:	0005c683          	lbu	a3,0(a1)
 394:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 398:	fee79ae3          	bne	a5,a4,38c <memmove+0x4a>
 39c:	bfc9                	j	36e <memmove+0x2c>

000000000000039e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 39e:	1141                	addi	sp,sp,-16
 3a0:	e422                	sd	s0,8(sp)
 3a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3a4:	ca05                	beqz	a2,3d4 <memcmp+0x36>
 3a6:	fff6069b          	addiw	a3,a2,-1
 3aa:	1682                	slli	a3,a3,0x20
 3ac:	9281                	srli	a3,a3,0x20
 3ae:	0685                	addi	a3,a3,1
 3b0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3b2:	00054783          	lbu	a5,0(a0)
 3b6:	0005c703          	lbu	a4,0(a1)
 3ba:	00e79863          	bne	a5,a4,3ca <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3be:	0505                	addi	a0,a0,1
    p2++;
 3c0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3c2:	fed518e3          	bne	a0,a3,3b2 <memcmp+0x14>
  }
  return 0;
 3c6:	4501                	li	a0,0
 3c8:	a019                	j	3ce <memcmp+0x30>
      return *p1 - *p2;
 3ca:	40e7853b          	subw	a0,a5,a4
}
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
  return 0;
 3d4:	4501                	li	a0,0
 3d6:	bfe5                	j	3ce <memcmp+0x30>

00000000000003d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e406                	sd	ra,8(sp)
 3dc:	e022                	sd	s0,0(sp)
 3de:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3e0:	00000097          	auipc	ra,0x0
 3e4:	f62080e7          	jalr	-158(ra) # 342 <memmove>
}
 3e8:	60a2                	ld	ra,8(sp)
 3ea:	6402                	ld	s0,0(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret

00000000000003f0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f0:	4885                	li	a7,1
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f8:	4889                	li	a7,2
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <wait>:
.global wait
wait:
 li a7, SYS_wait
 400:	488d                	li	a7,3
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 408:	4891                	li	a7,4
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <read>:
.global read
read:
 li a7, SYS_read
 410:	4895                	li	a7,5
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <write>:
.global write
write:
 li a7, SYS_write
 418:	48c1                	li	a7,16
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <close>:
.global close
close:
 li a7, SYS_close
 420:	48d5                	li	a7,21
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <kill>:
.global kill
kill:
 li a7, SYS_kill
 428:	4899                	li	a7,6
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <exec>:
.global exec
exec:
 li a7, SYS_exec
 430:	489d                	li	a7,7
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <open>:
.global open
open:
 li a7, SYS_open
 438:	48bd                	li	a7,15
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 440:	48c5                	li	a7,17
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 448:	48c9                	li	a7,18
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 450:	48a1                	li	a7,8
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <link>:
.global link
link:
 li a7, SYS_link
 458:	48cd                	li	a7,19
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 460:	48d1                	li	a7,20
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 468:	48a5                	li	a7,9
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <dup>:
.global dup
dup:
 li a7, SYS_dup
 470:	48a9                	li	a7,10
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 478:	48ad                	li	a7,11
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 480:	48b1                	li	a7,12
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 488:	48b5                	li	a7,13
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 490:	48b9                	li	a7,14
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 498:	1101                	addi	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	1000                	addi	s0,sp,32
 4a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a4:	4605                	li	a2,1
 4a6:	fef40593          	addi	a1,s0,-17
 4aa:	00000097          	auipc	ra,0x0
 4ae:	f6e080e7          	jalr	-146(ra) # 418 <write>
}
 4b2:	60e2                	ld	ra,24(sp)
 4b4:	6442                	ld	s0,16(sp)
 4b6:	6105                	addi	sp,sp,32
 4b8:	8082                	ret

00000000000004ba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ba:	7139                	addi	sp,sp,-64
 4bc:	fc06                	sd	ra,56(sp)
 4be:	f822                	sd	s0,48(sp)
 4c0:	f426                	sd	s1,40(sp)
 4c2:	f04a                	sd	s2,32(sp)
 4c4:	ec4e                	sd	s3,24(sp)
 4c6:	0080                	addi	s0,sp,64
 4c8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ca:	c299                	beqz	a3,4d0 <printint+0x16>
 4cc:	0805c863          	bltz	a1,55c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4d0:	2581                	sext.w	a1,a1
  neg = 0;
 4d2:	4881                	li	a7,0
 4d4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4d8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4da:	2601                	sext.w	a2,a2
 4dc:	00000517          	auipc	a0,0x0
 4e0:	45450513          	addi	a0,a0,1108 # 930 <digits>
 4e4:	883a                	mv	a6,a4
 4e6:	2705                	addiw	a4,a4,1
 4e8:	02c5f7bb          	remuw	a5,a1,a2
 4ec:	1782                	slli	a5,a5,0x20
 4ee:	9381                	srli	a5,a5,0x20
 4f0:	97aa                	add	a5,a5,a0
 4f2:	0007c783          	lbu	a5,0(a5)
 4f6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4fa:	0005879b          	sext.w	a5,a1
 4fe:	02c5d5bb          	divuw	a1,a1,a2
 502:	0685                	addi	a3,a3,1
 504:	fec7f0e3          	bgeu	a5,a2,4e4 <printint+0x2a>
  if(neg)
 508:	00088b63          	beqz	a7,51e <printint+0x64>
    buf[i++] = '-';
 50c:	fd040793          	addi	a5,s0,-48
 510:	973e                	add	a4,a4,a5
 512:	02d00793          	li	a5,45
 516:	fef70823          	sb	a5,-16(a4)
 51a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 51e:	02e05863          	blez	a4,54e <printint+0x94>
 522:	fc040793          	addi	a5,s0,-64
 526:	00e78933          	add	s2,a5,a4
 52a:	fff78993          	addi	s3,a5,-1
 52e:	99ba                	add	s3,s3,a4
 530:	377d                	addiw	a4,a4,-1
 532:	1702                	slli	a4,a4,0x20
 534:	9301                	srli	a4,a4,0x20
 536:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 53a:	fff94583          	lbu	a1,-1(s2)
 53e:	8526                	mv	a0,s1
 540:	00000097          	auipc	ra,0x0
 544:	f58080e7          	jalr	-168(ra) # 498 <putc>
  while(--i >= 0)
 548:	197d                	addi	s2,s2,-1
 54a:	ff3918e3          	bne	s2,s3,53a <printint+0x80>
}
 54e:	70e2                	ld	ra,56(sp)
 550:	7442                	ld	s0,48(sp)
 552:	74a2                	ld	s1,40(sp)
 554:	7902                	ld	s2,32(sp)
 556:	69e2                	ld	s3,24(sp)
 558:	6121                	addi	sp,sp,64
 55a:	8082                	ret
    x = -xx;
 55c:	40b005bb          	negw	a1,a1
    neg = 1;
 560:	4885                	li	a7,1
    x = -xx;
 562:	bf8d                	j	4d4 <printint+0x1a>

0000000000000564 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 564:	7119                	addi	sp,sp,-128
 566:	fc86                	sd	ra,120(sp)
 568:	f8a2                	sd	s0,112(sp)
 56a:	f4a6                	sd	s1,104(sp)
 56c:	f0ca                	sd	s2,96(sp)
 56e:	ecce                	sd	s3,88(sp)
 570:	e8d2                	sd	s4,80(sp)
 572:	e4d6                	sd	s5,72(sp)
 574:	e0da                	sd	s6,64(sp)
 576:	fc5e                	sd	s7,56(sp)
 578:	f862                	sd	s8,48(sp)
 57a:	f466                	sd	s9,40(sp)
 57c:	f06a                	sd	s10,32(sp)
 57e:	ec6e                	sd	s11,24(sp)
 580:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 582:	0005c903          	lbu	s2,0(a1)
 586:	18090f63          	beqz	s2,724 <vprintf+0x1c0>
 58a:	8aaa                	mv	s5,a0
 58c:	8b32                	mv	s6,a2
 58e:	00158493          	addi	s1,a1,1
  state = 0;
 592:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 594:	02500a13          	li	s4,37
      if(c == 'd'){
 598:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 59c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 5a0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 5a4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a8:	00000b97          	auipc	s7,0x0
 5ac:	388b8b93          	addi	s7,s7,904 # 930 <digits>
 5b0:	a839                	j	5ce <vprintf+0x6a>
        putc(fd, c);
 5b2:	85ca                	mv	a1,s2
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	ee2080e7          	jalr	-286(ra) # 498 <putc>
 5be:	a019                	j	5c4 <vprintf+0x60>
    } else if(state == '%'){
 5c0:	01498f63          	beq	s3,s4,5de <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 5c4:	0485                	addi	s1,s1,1
 5c6:	fff4c903          	lbu	s2,-1(s1)
 5ca:	14090d63          	beqz	s2,724 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 5ce:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5d2:	fe0997e3          	bnez	s3,5c0 <vprintf+0x5c>
      if(c == '%'){
 5d6:	fd479ee3          	bne	a5,s4,5b2 <vprintf+0x4e>
        state = '%';
 5da:	89be                	mv	s3,a5
 5dc:	b7e5                	j	5c4 <vprintf+0x60>
      if(c == 'd'){
 5de:	05878063          	beq	a5,s8,61e <vprintf+0xba>
      } else if(c == 'l') {
 5e2:	05978c63          	beq	a5,s9,63a <vprintf+0xd6>
      } else if(c == 'x') {
 5e6:	07a78863          	beq	a5,s10,656 <vprintf+0xf2>
      } else if(c == 'p') {
 5ea:	09b78463          	beq	a5,s11,672 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5ee:	07300713          	li	a4,115
 5f2:	0ce78663          	beq	a5,a4,6be <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5f6:	06300713          	li	a4,99
 5fa:	0ee78e63          	beq	a5,a4,6f6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5fe:	11478863          	beq	a5,s4,70e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 602:	85d2                	mv	a1,s4
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	e92080e7          	jalr	-366(ra) # 498 <putc>
        putc(fd, c);
 60e:	85ca                	mv	a1,s2
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	e86080e7          	jalr	-378(ra) # 498 <putc>
      }
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b765                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 61e:	008b0913          	addi	s2,s6,8
 622:	4685                	li	a3,1
 624:	4629                	li	a2,10
 626:	000b2583          	lw	a1,0(s6)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e8e080e7          	jalr	-370(ra) # 4ba <printint>
 634:	8b4a                	mv	s6,s2
      state = 0;
 636:	4981                	li	s3,0
 638:	b771                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63a:	008b0913          	addi	s2,s6,8
 63e:	4681                	li	a3,0
 640:	4629                	li	a2,10
 642:	000b2583          	lw	a1,0(s6)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e72080e7          	jalr	-398(ra) # 4ba <printint>
 650:	8b4a                	mv	s6,s2
      state = 0;
 652:	4981                	li	s3,0
 654:	bf85                	j	5c4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 656:	008b0913          	addi	s2,s6,8
 65a:	4681                	li	a3,0
 65c:	4641                	li	a2,16
 65e:	000b2583          	lw	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e56080e7          	jalr	-426(ra) # 4ba <printint>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	bf91                	j	5c4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 672:	008b0793          	addi	a5,s6,8
 676:	f8f43423          	sd	a5,-120(s0)
 67a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 67e:	03000593          	li	a1,48
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	e14080e7          	jalr	-492(ra) # 498 <putc>
  putc(fd, 'x');
 68c:	85ea                	mv	a1,s10
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e08080e7          	jalr	-504(ra) # 498 <putc>
 698:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 69a:	03c9d793          	srli	a5,s3,0x3c
 69e:	97de                	add	a5,a5,s7
 6a0:	0007c583          	lbu	a1,0(a5)
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	df2080e7          	jalr	-526(ra) # 498 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6ae:	0992                	slli	s3,s3,0x4
 6b0:	397d                	addiw	s2,s2,-1
 6b2:	fe0914e3          	bnez	s2,69a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 6b6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b721                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 6be:	008b0993          	addi	s3,s6,8
 6c2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 6c6:	02090163          	beqz	s2,6e8 <vprintf+0x184>
        while(*s != 0){
 6ca:	00094583          	lbu	a1,0(s2)
 6ce:	c9a1                	beqz	a1,71e <vprintf+0x1ba>
          putc(fd, *s);
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	dc6080e7          	jalr	-570(ra) # 498 <putc>
          s++;
 6da:	0905                	addi	s2,s2,1
        while(*s != 0){
 6dc:	00094583          	lbu	a1,0(s2)
 6e0:	f9e5                	bnez	a1,6d0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6e2:	8b4e                	mv	s6,s3
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	bdf9                	j	5c4 <vprintf+0x60>
          s = "(null)";
 6e8:	00000917          	auipc	s2,0x0
 6ec:	24090913          	addi	s2,s2,576 # 928 <malloc+0xfa>
        while(*s != 0){
 6f0:	02800593          	li	a1,40
 6f4:	bff1                	j	6d0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6f6:	008b0913          	addi	s2,s6,8
 6fa:	000b4583          	lbu	a1,0(s6)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	d98080e7          	jalr	-616(ra) # 498 <putc>
 708:	8b4a                	mv	s6,s2
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bd65                	j	5c4 <vprintf+0x60>
        putc(fd, c);
 70e:	85d2                	mv	a1,s4
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	d86080e7          	jalr	-634(ra) # 498 <putc>
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b565                	j	5c4 <vprintf+0x60>
        s = va_arg(ap, char*);
 71e:	8b4e                	mv	s6,s3
      state = 0;
 720:	4981                	li	s3,0
 722:	b54d                	j	5c4 <vprintf+0x60>
    }
  }
}
 724:	70e6                	ld	ra,120(sp)
 726:	7446                	ld	s0,112(sp)
 728:	74a6                	ld	s1,104(sp)
 72a:	7906                	ld	s2,96(sp)
 72c:	69e6                	ld	s3,88(sp)
 72e:	6a46                	ld	s4,80(sp)
 730:	6aa6                	ld	s5,72(sp)
 732:	6b06                	ld	s6,64(sp)
 734:	7be2                	ld	s7,56(sp)
 736:	7c42                	ld	s8,48(sp)
 738:	7ca2                	ld	s9,40(sp)
 73a:	7d02                	ld	s10,32(sp)
 73c:	6de2                	ld	s11,24(sp)
 73e:	6109                	addi	sp,sp,128
 740:	8082                	ret

0000000000000742 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 742:	715d                	addi	sp,sp,-80
 744:	ec06                	sd	ra,24(sp)
 746:	e822                	sd	s0,16(sp)
 748:	1000                	addi	s0,sp,32
 74a:	e010                	sd	a2,0(s0)
 74c:	e414                	sd	a3,8(s0)
 74e:	e818                	sd	a4,16(s0)
 750:	ec1c                	sd	a5,24(s0)
 752:	03043023          	sd	a6,32(s0)
 756:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75e:	8622                	mv	a2,s0
 760:	00000097          	auipc	ra,0x0
 764:	e04080e7          	jalr	-508(ra) # 564 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6161                	addi	sp,sp,80
 76e:	8082                	ret

0000000000000770 <printf>:

void
printf(const char *fmt, ...)
{
 770:	711d                	addi	sp,sp,-96
 772:	ec06                	sd	ra,24(sp)
 774:	e822                	sd	s0,16(sp)
 776:	1000                	addi	s0,sp,32
 778:	e40c                	sd	a1,8(s0)
 77a:	e810                	sd	a2,16(s0)
 77c:	ec14                	sd	a3,24(s0)
 77e:	f018                	sd	a4,32(s0)
 780:	f41c                	sd	a5,40(s0)
 782:	03043823          	sd	a6,48(s0)
 786:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78a:	00840613          	addi	a2,s0,8
 78e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 792:	85aa                	mv	a1,a0
 794:	4505                	li	a0,1
 796:	00000097          	auipc	ra,0x0
 79a:	dce080e7          	jalr	-562(ra) # 564 <vprintf>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6125                	addi	sp,sp,96
 7a4:	8082                	ret

00000000000007a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	1141                	addi	sp,sp,-16
 7a8:	e422                	sd	s0,8(sp)
 7aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	00000797          	auipc	a5,0x0
 7b4:	1987b783          	ld	a5,408(a5) # 948 <freep>
 7b8:	a805                	j	7e8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ba:	4618                	lw	a4,8(a2)
 7bc:	9db9                	addw	a1,a1,a4
 7be:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c2:	6398                	ld	a4,0(a5)
 7c4:	6318                	ld	a4,0(a4)
 7c6:	fee53823          	sd	a4,-16(a0)
 7ca:	a091                	j	80e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7cc:	ff852703          	lw	a4,-8(a0)
 7d0:	9e39                	addw	a2,a2,a4
 7d2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 7d4:	ff053703          	ld	a4,-16(a0)
 7d8:	e398                	sd	a4,0(a5)
 7da:	a099                	j	820 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	6398                	ld	a4,0(a5)
 7de:	00e7e463          	bltu	a5,a4,7e6 <free+0x40>
 7e2:	00e6ea63          	bltu	a3,a4,7f6 <free+0x50>
{
 7e6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e8:	fed7fae3          	bgeu	a5,a3,7dc <free+0x36>
 7ec:	6398                	ld	a4,0(a5)
 7ee:	00e6e463          	bltu	a3,a4,7f6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f2:	fee7eae3          	bltu	a5,a4,7e6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7f6:	ff852583          	lw	a1,-8(a0)
 7fa:	6390                	ld	a2,0(a5)
 7fc:	02059713          	slli	a4,a1,0x20
 800:	9301                	srli	a4,a4,0x20
 802:	0712                	slli	a4,a4,0x4
 804:	9736                	add	a4,a4,a3
 806:	fae60ae3          	beq	a2,a4,7ba <free+0x14>
    bp->s.ptr = p->s.ptr;
 80a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80e:	4790                	lw	a2,8(a5)
 810:	02061713          	slli	a4,a2,0x20
 814:	9301                	srli	a4,a4,0x20
 816:	0712                	slli	a4,a4,0x4
 818:	973e                	add	a4,a4,a5
 81a:	fae689e3          	beq	a3,a4,7cc <free+0x26>
  } else
    p->s.ptr = bp;
 81e:	e394                	sd	a3,0(a5)
  freep = p;
 820:	00000717          	auipc	a4,0x0
 824:	12f73423          	sd	a5,296(a4) # 948 <freep>
}
 828:	6422                	ld	s0,8(sp)
 82a:	0141                	addi	sp,sp,16
 82c:	8082                	ret

000000000000082e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82e:	7139                	addi	sp,sp,-64
 830:	fc06                	sd	ra,56(sp)
 832:	f822                	sd	s0,48(sp)
 834:	f426                	sd	s1,40(sp)
 836:	f04a                	sd	s2,32(sp)
 838:	ec4e                	sd	s3,24(sp)
 83a:	e852                	sd	s4,16(sp)
 83c:	e456                	sd	s5,8(sp)
 83e:	e05a                	sd	s6,0(sp)
 840:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	02051493          	slli	s1,a0,0x20
 846:	9081                	srli	s1,s1,0x20
 848:	04bd                	addi	s1,s1,15
 84a:	8091                	srli	s1,s1,0x4
 84c:	0014899b          	addiw	s3,s1,1
 850:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 852:	00000517          	auipc	a0,0x0
 856:	0f653503          	ld	a0,246(a0) # 948 <freep>
 85a:	c515                	beqz	a0,886 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85e:	4798                	lw	a4,8(a5)
 860:	02977f63          	bgeu	a4,s1,89e <malloc+0x70>
 864:	8a4e                	mv	s4,s3
 866:	0009871b          	sext.w	a4,s3
 86a:	6685                	lui	a3,0x1
 86c:	00d77363          	bgeu	a4,a3,872 <malloc+0x44>
 870:	6a05                	lui	s4,0x1
 872:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 876:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 87a:	00000917          	auipc	s2,0x0
 87e:	0ce90913          	addi	s2,s2,206 # 948 <freep>
  if(p == (char*)-1)
 882:	5afd                	li	s5,-1
 884:	a88d                	j	8f6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 886:	00000797          	auipc	a5,0x0
 88a:	0ca78793          	addi	a5,a5,202 # 950 <base>
 88e:	00000717          	auipc	a4,0x0
 892:	0af73d23          	sd	a5,186(a4) # 948 <freep>
 896:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 898:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 89c:	b7e1                	j	864 <malloc+0x36>
      if(p->s.size == nunits)
 89e:	02e48b63          	beq	s1,a4,8d4 <malloc+0xa6>
        p->s.size -= nunits;
 8a2:	4137073b          	subw	a4,a4,s3
 8a6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a8:	1702                	slli	a4,a4,0x20
 8aa:	9301                	srli	a4,a4,0x20
 8ac:	0712                	slli	a4,a4,0x4
 8ae:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b4:	00000717          	auipc	a4,0x0
 8b8:	08a73a23          	sd	a0,148(a4) # 948 <freep>
      return (void*)(p + 1);
 8bc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8c0:	70e2                	ld	ra,56(sp)
 8c2:	7442                	ld	s0,48(sp)
 8c4:	74a2                	ld	s1,40(sp)
 8c6:	7902                	ld	s2,32(sp)
 8c8:	69e2                	ld	s3,24(sp)
 8ca:	6a42                	ld	s4,16(sp)
 8cc:	6aa2                	ld	s5,8(sp)
 8ce:	6b02                	ld	s6,0(sp)
 8d0:	6121                	addi	sp,sp,64
 8d2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d4:	6398                	ld	a4,0(a5)
 8d6:	e118                	sd	a4,0(a0)
 8d8:	bff1                	j	8b4 <malloc+0x86>
  hp->s.size = nu;
 8da:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8de:	0541                	addi	a0,a0,16
 8e0:	00000097          	auipc	ra,0x0
 8e4:	ec6080e7          	jalr	-314(ra) # 7a6 <free>
  return freep;
 8e8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ec:	d971                	beqz	a0,8c0 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ee:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f0:	4798                	lw	a4,8(a5)
 8f2:	fa9776e3          	bgeu	a4,s1,89e <malloc+0x70>
    if(p == freep)
 8f6:	00093703          	ld	a4,0(s2)
 8fa:	853e                	mv	a0,a5
 8fc:	fef719e3          	bne	a4,a5,8ee <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 900:	8552                	mv	a0,s4
 902:	00000097          	auipc	ra,0x0
 906:	b7e080e7          	jalr	-1154(ra) # 480 <sbrk>
  if(p == (char*)-1)
 90a:	fd5518e3          	bne	a0,s5,8da <malloc+0xac>
        return 0;
 90e:	4501                	li	a0,0
 910:	bf45                	j	8c0 <malloc+0x92>
