
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"

int main() {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
    int p1[2]; // 父到子的管道
    int p2[2]; // 子到父的管道
    char byte = 'a';
   8:	06100793          	li	a5,97
   c:	fcf40fa3          	sb	a5,-33(s0)

    // 创建两个管道
    pipe(p1);
  10:	fe840513          	addi	a0,s0,-24
  14:	00000097          	auipc	ra,0x0
  18:	394080e7          	jalr	916(ra) # 3a8 <pipe>
    pipe(p2);
  1c:	fe040513          	addi	a0,s0,-32
  20:	00000097          	auipc	ra,0x0
  24:	388080e7          	jalr	904(ra) # 3a8 <pipe>

    if (fork() == 0) { // 子进程
  28:	00000097          	auipc	ra,0x0
  2c:	368080e7          	jalr	872(ra) # 390 <fork>
  30:	ed2d                	bnez	a0,aa <main+0xaa>
        close(p1[1]); // 关闭父到子的写端
  32:	fec42503          	lw	a0,-20(s0)
  36:	00000097          	auipc	ra,0x0
  3a:	38a080e7          	jalr	906(ra) # 3c0 <close>
        close(p2[0]); // 关闭子到父的读端
  3e:	fe042503          	lw	a0,-32(s0)
  42:	00000097          	auipc	ra,0x0
  46:	37e080e7          	jalr	894(ra) # 3c0 <close>

        read(p1[0], &byte, 1); // 从父进程读取字节
  4a:	4605                	li	a2,1
  4c:	fdf40593          	addi	a1,s0,-33
  50:	fe842503          	lw	a0,-24(s0)
  54:	00000097          	auipc	ra,0x0
  58:	35c080e7          	jalr	860(ra) # 3b0 <read>
        printf("%d: received ping\n", getpid());
  5c:	00000097          	auipc	ra,0x0
  60:	3bc080e7          	jalr	956(ra) # 418 <getpid>
  64:	85aa                	mv	a1,a0
  66:	00001517          	auipc	a0,0x1
  6a:	85250513          	addi	a0,a0,-1966 # 8b8 <malloc+0xea>
  6e:	00000097          	auipc	ra,0x0
  72:	6a2080e7          	jalr	1698(ra) # 710 <printf>

        write(p2[1], &byte, 1); // 将字节写回父进程
  76:	4605                	li	a2,1
  78:	fdf40593          	addi	a1,s0,-33
  7c:	fe442503          	lw	a0,-28(s0)
  80:	00000097          	auipc	ra,0x0
  84:	338080e7          	jalr	824(ra) # 3b8 <write>

        close(p1[0]); // 关闭父到子的读端
  88:	fe842503          	lw	a0,-24(s0)
  8c:	00000097          	auipc	ra,0x0
  90:	334080e7          	jalr	820(ra) # 3c0 <close>
        close(p2[1]); // 关闭子到父的写端
  94:	fe442503          	lw	a0,-28(s0)
  98:	00000097          	auipc	ra,0x0
  9c:	328080e7          	jalr	808(ra) # 3c0 <close>
        exit(0);
  a0:	4501                	li	a0,0
  a2:	00000097          	auipc	ra,0x0
  a6:	2f6080e7          	jalr	758(ra) # 398 <exit>
    } else { // 父进程
        close(p1[0]); // 关闭父到子的读端
  aa:	fe842503          	lw	a0,-24(s0)
  ae:	00000097          	auipc	ra,0x0
  b2:	312080e7          	jalr	786(ra) # 3c0 <close>
        close(p2[1]); // 关闭子到父的写端
  b6:	fe442503          	lw	a0,-28(s0)
  ba:	00000097          	auipc	ra,0x0
  be:	306080e7          	jalr	774(ra) # 3c0 <close>

        write(p1[1], &byte, 1); // 将字节写给子进程
  c2:	4605                	li	a2,1
  c4:	fdf40593          	addi	a1,s0,-33
  c8:	fec42503          	lw	a0,-20(s0)
  cc:	00000097          	auipc	ra,0x0
  d0:	2ec080e7          	jalr	748(ra) # 3b8 <write>

        read(p2[0], &byte, 1); // 从子进程读取字节
  d4:	4605                	li	a2,1
  d6:	fdf40593          	addi	a1,s0,-33
  da:	fe042503          	lw	a0,-32(s0)
  de:	00000097          	auipc	ra,0x0
  e2:	2d2080e7          	jalr	722(ra) # 3b0 <read>
        printf("%d: received pong\n", getpid());
  e6:	00000097          	auipc	ra,0x0
  ea:	332080e7          	jalr	818(ra) # 418 <getpid>
  ee:	85aa                	mv	a1,a0
  f0:	00000517          	auipc	a0,0x0
  f4:	7e050513          	addi	a0,a0,2016 # 8d0 <malloc+0x102>
  f8:	00000097          	auipc	ra,0x0
  fc:	618080e7          	jalr	1560(ra) # 710 <printf>

        close(p1[1]); // 关闭父到子的写端
 100:	fec42503          	lw	a0,-20(s0)
 104:	00000097          	auipc	ra,0x0
 108:	2bc080e7          	jalr	700(ra) # 3c0 <close>
        close(p2[0]); // 关闭子到父的读端
 10c:	fe042503          	lw	a0,-32(s0)
 110:	00000097          	auipc	ra,0x0
 114:	2b0080e7          	jalr	688(ra) # 3c0 <close>
        exit(0);
 118:	4501                	li	a0,0
 11a:	00000097          	auipc	ra,0x0
 11e:	27e080e7          	jalr	638(ra) # 398 <exit>

0000000000000122 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 122:	1141                	addi	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 128:	87aa                	mv	a5,a0
 12a:	0585                	addi	a1,a1,1
 12c:	0785                	addi	a5,a5,1
 12e:	fff5c703          	lbu	a4,-1(a1)
 132:	fee78fa3          	sb	a4,-1(a5)
 136:	fb75                	bnez	a4,12a <strcpy+0x8>
    ;
  return os;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x1e>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x1e>
    p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	6422                	ld	s0,8(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret

000000000000016a <strlen>:

uint
strlen(const char *s)
{
 16a:	1141                	addi	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cf91                	beqz	a5,190 <strlen+0x26>
 176:	0505                	addi	a0,a0,1
 178:	87aa                	mv	a5,a0
 17a:	4685                	li	a3,1
 17c:	9e89                	subw	a3,a3,a0
 17e:	00f6853b          	addw	a0,a3,a5
 182:	0785                	addi	a5,a5,1
 184:	fff7c703          	lbu	a4,-1(a5)
 188:	fb7d                	bnez	a4,17e <strlen+0x14>
    ;
  return n;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	addi	sp,sp,16
 18e:	8082                	ret
  for(n = 0; s[n]; n++)
 190:	4501                	li	a0,0
 192:	bfe5                	j	18a <strlen+0x20>

0000000000000194 <memset>:

void*
memset(void *dst, int c, uint n)
{
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19a:	ce09                	beqz	a2,1b4 <memset+0x20>
 19c:	87aa                	mv	a5,a0
 19e:	fff6071b          	addiw	a4,a2,-1
 1a2:	1702                	slli	a4,a4,0x20
 1a4:	9301                	srli	a4,a4,0x20
 1a6:	0705                	addi	a4,a4,1
 1a8:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	addi	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x16>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	89a6                	mv	s3,s1
 202:	2485                	addiw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	1a0080e7          	jalr	416(ra) # 3b0 <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
  for(i=0; i+1 < max; ){
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	176080e7          	jalr	374(ra) # 3d8 <open>
  if(fd < 0)
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	17e080e7          	jalr	382(ra) # 3f0 <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	142080e7          	jalr	322(ra) # 3c0 <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054603          	lbu	a2,0(a0)
 2a2:	fd06079b          	addiw	a5,a2,-48
 2a6:	0ff7f793          	andi	a5,a5,255
 2aa:	4725                	li	a4,9
 2ac:	02f76963          	bltu	a4,a5,2de <atoi+0x46>
 2b0:	86aa                	mv	a3,a0
  n = 0;
 2b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b6:	0685                	addi	a3,a3,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb1                	addw	a5,a5,a2
 2c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c8:	0006c603          	lbu	a2,0(a3)
 2cc:	fd06071b          	addiw	a4,a2,-48
 2d0:	0ff77713          	andi	a4,a4,255
 2d4:	fee5f1e3          	bgeu	a1,a4,2b6 <atoi+0x1e>
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  n = 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <atoi+0x40>

00000000000002e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e8:	02b57663          	bgeu	a0,a1,314 <memmove+0x32>
    while(n-- > 0)
 2ec:	02c05163          	blez	a2,30e <memmove+0x2c>
 2f0:	fff6079b          	addiw	a5,a2,-1
 2f4:	1782                	slli	a5,a5,0x20
 2f6:	9381                	srli	a5,a5,0x20
 2f8:	0785                	addi	a5,a5,1
 2fa:	97aa                	add	a5,a5,a0
  dst = vdst;
 2fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fe:	0585                	addi	a1,a1,1
 300:	0705                	addi	a4,a4,1
 302:	fff5c683          	lbu	a3,-1(a1)
 306:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 30a:	fee79ae3          	bne	a5,a4,2fe <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret
    dst += n;
 314:	00c50733          	add	a4,a0,a2
    src += n;
 318:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 31a:	fec05ae3          	blez	a2,30e <memmove+0x2c>
 31e:	fff6079b          	addiw	a5,a2,-1
 322:	1782                	slli	a5,a5,0x20
 324:	9381                	srli	a5,a5,0x20
 326:	fff7c793          	not	a5,a5
 32a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32c:	15fd                	addi	a1,a1,-1
 32e:	177d                	addi	a4,a4,-1
 330:	0005c683          	lbu	a3,0(a1)
 334:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 338:	fee79ae3          	bne	a5,a4,32c <memmove+0x4a>
 33c:	bfc9                	j	30e <memmove+0x2c>

000000000000033e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 344:	ca05                	beqz	a2,374 <memcmp+0x36>
 346:	fff6069b          	addiw	a3,a2,-1
 34a:	1682                	slli	a3,a3,0x20
 34c:	9281                	srli	a3,a3,0x20
 34e:	0685                	addi	a3,a3,1
 350:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 352:	00054783          	lbu	a5,0(a0)
 356:	0005c703          	lbu	a4,0(a1)
 35a:	00e79863          	bne	a5,a4,36a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35e:	0505                	addi	a0,a0,1
    p2++;
 360:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 362:	fed518e3          	bne	a0,a3,352 <memcmp+0x14>
  }
  return 0;
 366:	4501                	li	a0,0
 368:	a019                	j	36e <memcmp+0x30>
      return *p1 - *p2;
 36a:	40e7853b          	subw	a0,a5,a4
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <memcmp+0x30>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	00000097          	auipc	ra,0x0
 384:	f62080e7          	jalr	-158(ra) # 2e2 <memmove>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 390:	4885                	li	a7,1
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <exit>:
.global exit
exit:
 li a7, SYS_exit
 398:	4889                	li	a7,2
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a0:	488d                	li	a7,3
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a8:	4891                	li	a7,4
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <read>:
.global read
read:
 li a7, SYS_read
 3b0:	4895                	li	a7,5
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <write>:
.global write
write:
 li a7, SYS_write
 3b8:	48c1                	li	a7,16
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <close>:
.global close
close:
 li a7, SYS_close
 3c0:	48d5                	li	a7,21
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c8:	4899                	li	a7,6
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d0:	489d                	li	a7,7
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <open>:
.global open
open:
 li a7, SYS_open
 3d8:	48bd                	li	a7,15
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e0:	48c5                	li	a7,17
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e8:	48c9                	li	a7,18
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f0:	48a1                	li	a7,8
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <link>:
.global link
link:
 li a7, SYS_link
 3f8:	48cd                	li	a7,19
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 400:	48d1                	li	a7,20
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 408:	48a5                	li	a7,9
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <dup>:
.global dup
dup:
 li a7, SYS_dup
 410:	48a9                	li	a7,10
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 418:	48ad                	li	a7,11
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 420:	48b1                	li	a7,12
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 428:	48b5                	li	a7,13
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 430:	48b9                	li	a7,14
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 438:	1101                	addi	sp,sp,-32
 43a:	ec06                	sd	ra,24(sp)
 43c:	e822                	sd	s0,16(sp)
 43e:	1000                	addi	s0,sp,32
 440:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 444:	4605                	li	a2,1
 446:	fef40593          	addi	a1,s0,-17
 44a:	00000097          	auipc	ra,0x0
 44e:	f6e080e7          	jalr	-146(ra) # 3b8 <write>
}
 452:	60e2                	ld	ra,24(sp)
 454:	6442                	ld	s0,16(sp)
 456:	6105                	addi	sp,sp,32
 458:	8082                	ret

000000000000045a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 45a:	7139                	addi	sp,sp,-64
 45c:	fc06                	sd	ra,56(sp)
 45e:	f822                	sd	s0,48(sp)
 460:	f426                	sd	s1,40(sp)
 462:	f04a                	sd	s2,32(sp)
 464:	ec4e                	sd	s3,24(sp)
 466:	0080                	addi	s0,sp,64
 468:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46a:	c299                	beqz	a3,470 <printint+0x16>
 46c:	0805c863          	bltz	a1,4fc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 470:	2581                	sext.w	a1,a1
  neg = 0;
 472:	4881                	li	a7,0
 474:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 478:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 47a:	2601                	sext.w	a2,a2
 47c:	00000517          	auipc	a0,0x0
 480:	47450513          	addi	a0,a0,1140 # 8f0 <digits>
 484:	883a                	mv	a6,a4
 486:	2705                	addiw	a4,a4,1
 488:	02c5f7bb          	remuw	a5,a1,a2
 48c:	1782                	slli	a5,a5,0x20
 48e:	9381                	srli	a5,a5,0x20
 490:	97aa                	add	a5,a5,a0
 492:	0007c783          	lbu	a5,0(a5)
 496:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 49a:	0005879b          	sext.w	a5,a1
 49e:	02c5d5bb          	divuw	a1,a1,a2
 4a2:	0685                	addi	a3,a3,1
 4a4:	fec7f0e3          	bgeu	a5,a2,484 <printint+0x2a>
  if(neg)
 4a8:	00088b63          	beqz	a7,4be <printint+0x64>
    buf[i++] = '-';
 4ac:	fd040793          	addi	a5,s0,-48
 4b0:	973e                	add	a4,a4,a5
 4b2:	02d00793          	li	a5,45
 4b6:	fef70823          	sb	a5,-16(a4)
 4ba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4be:	02e05863          	blez	a4,4ee <printint+0x94>
 4c2:	fc040793          	addi	a5,s0,-64
 4c6:	00e78933          	add	s2,a5,a4
 4ca:	fff78993          	addi	s3,a5,-1
 4ce:	99ba                	add	s3,s3,a4
 4d0:	377d                	addiw	a4,a4,-1
 4d2:	1702                	slli	a4,a4,0x20
 4d4:	9301                	srli	a4,a4,0x20
 4d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4da:	fff94583          	lbu	a1,-1(s2)
 4de:	8526                	mv	a0,s1
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f58080e7          	jalr	-168(ra) # 438 <putc>
  while(--i >= 0)
 4e8:	197d                	addi	s2,s2,-1
 4ea:	ff3918e3          	bne	s2,s3,4da <printint+0x80>
}
 4ee:	70e2                	ld	ra,56(sp)
 4f0:	7442                	ld	s0,48(sp)
 4f2:	74a2                	ld	s1,40(sp)
 4f4:	7902                	ld	s2,32(sp)
 4f6:	69e2                	ld	s3,24(sp)
 4f8:	6121                	addi	sp,sp,64
 4fa:	8082                	ret
    x = -xx;
 4fc:	40b005bb          	negw	a1,a1
    neg = 1;
 500:	4885                	li	a7,1
    x = -xx;
 502:	bf8d                	j	474 <printint+0x1a>

0000000000000504 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 504:	7119                	addi	sp,sp,-128
 506:	fc86                	sd	ra,120(sp)
 508:	f8a2                	sd	s0,112(sp)
 50a:	f4a6                	sd	s1,104(sp)
 50c:	f0ca                	sd	s2,96(sp)
 50e:	ecce                	sd	s3,88(sp)
 510:	e8d2                	sd	s4,80(sp)
 512:	e4d6                	sd	s5,72(sp)
 514:	e0da                	sd	s6,64(sp)
 516:	fc5e                	sd	s7,56(sp)
 518:	f862                	sd	s8,48(sp)
 51a:	f466                	sd	s9,40(sp)
 51c:	f06a                	sd	s10,32(sp)
 51e:	ec6e                	sd	s11,24(sp)
 520:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 522:	0005c903          	lbu	s2,0(a1)
 526:	18090f63          	beqz	s2,6c4 <vprintf+0x1c0>
 52a:	8aaa                	mv	s5,a0
 52c:	8b32                	mv	s6,a2
 52e:	00158493          	addi	s1,a1,1
  state = 0;
 532:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 534:	02500a13          	li	s4,37
      if(c == 'd'){
 538:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 53c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 540:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 544:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 548:	00000b97          	auipc	s7,0x0
 54c:	3a8b8b93          	addi	s7,s7,936 # 8f0 <digits>
 550:	a839                	j	56e <vprintf+0x6a>
        putc(fd, c);
 552:	85ca                	mv	a1,s2
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	ee2080e7          	jalr	-286(ra) # 438 <putc>
 55e:	a019                	j	564 <vprintf+0x60>
    } else if(state == '%'){
 560:	01498f63          	beq	s3,s4,57e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 564:	0485                	addi	s1,s1,1
 566:	fff4c903          	lbu	s2,-1(s1)
 56a:	14090d63          	beqz	s2,6c4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 572:	fe0997e3          	bnez	s3,560 <vprintf+0x5c>
      if(c == '%'){
 576:	fd479ee3          	bne	a5,s4,552 <vprintf+0x4e>
        state = '%';
 57a:	89be                	mv	s3,a5
 57c:	b7e5                	j	564 <vprintf+0x60>
      if(c == 'd'){
 57e:	05878063          	beq	a5,s8,5be <vprintf+0xba>
      } else if(c == 'l') {
 582:	05978c63          	beq	a5,s9,5da <vprintf+0xd6>
      } else if(c == 'x') {
 586:	07a78863          	beq	a5,s10,5f6 <vprintf+0xf2>
      } else if(c == 'p') {
 58a:	09b78463          	beq	a5,s11,612 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 58e:	07300713          	li	a4,115
 592:	0ce78663          	beq	a5,a4,65e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 596:	06300713          	li	a4,99
 59a:	0ee78e63          	beq	a5,a4,696 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 59e:	11478863          	beq	a5,s4,6ae <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a2:	85d2                	mv	a1,s4
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	e92080e7          	jalr	-366(ra) # 438 <putc>
        putc(fd, c);
 5ae:	85ca                	mv	a1,s2
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	e86080e7          	jalr	-378(ra) # 438 <putc>
      }
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	b765                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5be:	008b0913          	addi	s2,s6,8
 5c2:	4685                	li	a3,1
 5c4:	4629                	li	a2,10
 5c6:	000b2583          	lw	a1,0(s6)
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e8e080e7          	jalr	-370(ra) # 45a <printint>
 5d4:	8b4a                	mv	s6,s2
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b771                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5da:	008b0913          	addi	s2,s6,8
 5de:	4681                	li	a3,0
 5e0:	4629                	li	a2,10
 5e2:	000b2583          	lw	a1,0(s6)
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e72080e7          	jalr	-398(ra) # 45a <printint>
 5f0:	8b4a                	mv	s6,s2
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	bf85                	j	564 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f6:	008b0913          	addi	s2,s6,8
 5fa:	4681                	li	a3,0
 5fc:	4641                	li	a2,16
 5fe:	000b2583          	lw	a1,0(s6)
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	e56080e7          	jalr	-426(ra) # 45a <printint>
 60c:	8b4a                	mv	s6,s2
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf91                	j	564 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 612:	008b0793          	addi	a5,s6,8
 616:	f8f43423          	sd	a5,-120(s0)
 61a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61e:	03000593          	li	a1,48
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e14080e7          	jalr	-492(ra) # 438 <putc>
  putc(fd, 'x');
 62c:	85ea                	mv	a1,s10
 62e:	8556                	mv	a0,s5
 630:	00000097          	auipc	ra,0x0
 634:	e08080e7          	jalr	-504(ra) # 438 <putc>
 638:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 63a:	03c9d793          	srli	a5,s3,0x3c
 63e:	97de                	add	a5,a5,s7
 640:	0007c583          	lbu	a1,0(a5)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	df2080e7          	jalr	-526(ra) # 438 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64e:	0992                	slli	s3,s3,0x4
 650:	397d                	addiw	s2,s2,-1
 652:	fe0914e3          	bnez	s2,63a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 656:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 65a:	4981                	li	s3,0
 65c:	b721                	j	564 <vprintf+0x60>
        s = va_arg(ap, char*);
 65e:	008b0993          	addi	s3,s6,8
 662:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 666:	02090163          	beqz	s2,688 <vprintf+0x184>
        while(*s != 0){
 66a:	00094583          	lbu	a1,0(s2)
 66e:	c9a1                	beqz	a1,6be <vprintf+0x1ba>
          putc(fd, *s);
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	dc6080e7          	jalr	-570(ra) # 438 <putc>
          s++;
 67a:	0905                	addi	s2,s2,1
        while(*s != 0){
 67c:	00094583          	lbu	a1,0(s2)
 680:	f9e5                	bnez	a1,670 <vprintf+0x16c>
        s = va_arg(ap, char*);
 682:	8b4e                	mv	s6,s3
      state = 0;
 684:	4981                	li	s3,0
 686:	bdf9                	j	564 <vprintf+0x60>
          s = "(null)";
 688:	00000917          	auipc	s2,0x0
 68c:	26090913          	addi	s2,s2,608 # 8e8 <malloc+0x11a>
        while(*s != 0){
 690:	02800593          	li	a1,40
 694:	bff1                	j	670 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 696:	008b0913          	addi	s2,s6,8
 69a:	000b4583          	lbu	a1,0(s6)
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	d98080e7          	jalr	-616(ra) # 438 <putc>
 6a8:	8b4a                	mv	s6,s2
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bd65                	j	564 <vprintf+0x60>
        putc(fd, c);
 6ae:	85d2                	mv	a1,s4
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	d86080e7          	jalr	-634(ra) # 438 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b565                	j	564 <vprintf+0x60>
        s = va_arg(ap, char*);
 6be:	8b4e                	mv	s6,s3
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	b54d                	j	564 <vprintf+0x60>
    }
  }
}
 6c4:	70e6                	ld	ra,120(sp)
 6c6:	7446                	ld	s0,112(sp)
 6c8:	74a6                	ld	s1,104(sp)
 6ca:	7906                	ld	s2,96(sp)
 6cc:	69e6                	ld	s3,88(sp)
 6ce:	6a46                	ld	s4,80(sp)
 6d0:	6aa6                	ld	s5,72(sp)
 6d2:	6b06                	ld	s6,64(sp)
 6d4:	7be2                	ld	s7,56(sp)
 6d6:	7c42                	ld	s8,48(sp)
 6d8:	7ca2                	ld	s9,40(sp)
 6da:	7d02                	ld	s10,32(sp)
 6dc:	6de2                	ld	s11,24(sp)
 6de:	6109                	addi	sp,sp,128
 6e0:	8082                	ret

00000000000006e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e2:	715d                	addi	sp,sp,-80
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e010                	sd	a2,0(s0)
 6ec:	e414                	sd	a3,8(s0)
 6ee:	e818                	sd	a4,16(s0)
 6f0:	ec1c                	sd	a5,24(s0)
 6f2:	03043023          	sd	a6,32(s0)
 6f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6fa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fe:	8622                	mv	a2,s0
 700:	00000097          	auipc	ra,0x0
 704:	e04080e7          	jalr	-508(ra) # 504 <vprintf>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6161                	addi	sp,sp,80
 70e:	8082                	ret

0000000000000710 <printf>:

void
printf(const char *fmt, ...)
{
 710:	711d                	addi	sp,sp,-96
 712:	ec06                	sd	ra,24(sp)
 714:	e822                	sd	s0,16(sp)
 716:	1000                	addi	s0,sp,32
 718:	e40c                	sd	a1,8(s0)
 71a:	e810                	sd	a2,16(s0)
 71c:	ec14                	sd	a3,24(s0)
 71e:	f018                	sd	a4,32(s0)
 720:	f41c                	sd	a5,40(s0)
 722:	03043823          	sd	a6,48(s0)
 726:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 72a:	00840613          	addi	a2,s0,8
 72e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 732:	85aa                	mv	a1,a0
 734:	4505                	li	a0,1
 736:	00000097          	auipc	ra,0x0
 73a:	dce080e7          	jalr	-562(ra) # 504 <vprintf>
}
 73e:	60e2                	ld	ra,24(sp)
 740:	6442                	ld	s0,16(sp)
 742:	6125                	addi	sp,sp,96
 744:	8082                	ret

0000000000000746 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 746:	1141                	addi	sp,sp,-16
 748:	e422                	sd	s0,8(sp)
 74a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 750:	00000797          	auipc	a5,0x0
 754:	1b87b783          	ld	a5,440(a5) # 908 <freep>
 758:	a805                	j	788 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 75a:	4618                	lw	a4,8(a2)
 75c:	9db9                	addw	a1,a1,a4
 75e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 762:	6398                	ld	a4,0(a5)
 764:	6318                	ld	a4,0(a4)
 766:	fee53823          	sd	a4,-16(a0)
 76a:	a091                	j	7ae <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 76c:	ff852703          	lw	a4,-8(a0)
 770:	9e39                	addw	a2,a2,a4
 772:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 774:	ff053703          	ld	a4,-16(a0)
 778:	e398                	sd	a4,0(a5)
 77a:	a099                	j	7c0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	6398                	ld	a4,0(a5)
 77e:	00e7e463          	bltu	a5,a4,786 <free+0x40>
 782:	00e6ea63          	bltu	a3,a4,796 <free+0x50>
{
 786:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 788:	fed7fae3          	bgeu	a5,a3,77c <free+0x36>
 78c:	6398                	ld	a4,0(a5)
 78e:	00e6e463          	bltu	a3,a4,796 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	fee7eae3          	bltu	a5,a4,786 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 796:	ff852583          	lw	a1,-8(a0)
 79a:	6390                	ld	a2,0(a5)
 79c:	02059713          	slli	a4,a1,0x20
 7a0:	9301                	srli	a4,a4,0x20
 7a2:	0712                	slli	a4,a4,0x4
 7a4:	9736                	add	a4,a4,a3
 7a6:	fae60ae3          	beq	a2,a4,75a <free+0x14>
    bp->s.ptr = p->s.ptr;
 7aa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ae:	4790                	lw	a2,8(a5)
 7b0:	02061713          	slli	a4,a2,0x20
 7b4:	9301                	srli	a4,a4,0x20
 7b6:	0712                	slli	a4,a4,0x4
 7b8:	973e                	add	a4,a4,a5
 7ba:	fae689e3          	beq	a3,a4,76c <free+0x26>
  } else
    p->s.ptr = bp;
 7be:	e394                	sd	a3,0(a5)
  freep = p;
 7c0:	00000717          	auipc	a4,0x0
 7c4:	14f73423          	sd	a5,328(a4) # 908 <freep>
}
 7c8:	6422                	ld	s0,8(sp)
 7ca:	0141                	addi	sp,sp,16
 7cc:	8082                	ret

00000000000007ce <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ce:	7139                	addi	sp,sp,-64
 7d0:	fc06                	sd	ra,56(sp)
 7d2:	f822                	sd	s0,48(sp)
 7d4:	f426                	sd	s1,40(sp)
 7d6:	f04a                	sd	s2,32(sp)
 7d8:	ec4e                	sd	s3,24(sp)
 7da:	e852                	sd	s4,16(sp)
 7dc:	e456                	sd	s5,8(sp)
 7de:	e05a                	sd	s6,0(sp)
 7e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	02051493          	slli	s1,a0,0x20
 7e6:	9081                	srli	s1,s1,0x20
 7e8:	04bd                	addi	s1,s1,15
 7ea:	8091                	srli	s1,s1,0x4
 7ec:	0014899b          	addiw	s3,s1,1
 7f0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7f2:	00000517          	auipc	a0,0x0
 7f6:	11653503          	ld	a0,278(a0) # 908 <freep>
 7fa:	c515                	beqz	a0,826 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fe:	4798                	lw	a4,8(a5)
 800:	02977f63          	bgeu	a4,s1,83e <malloc+0x70>
 804:	8a4e                	mv	s4,s3
 806:	0009871b          	sext.w	a4,s3
 80a:	6685                	lui	a3,0x1
 80c:	00d77363          	bgeu	a4,a3,812 <malloc+0x44>
 810:	6a05                	lui	s4,0x1
 812:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 816:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81a:	00000917          	auipc	s2,0x0
 81e:	0ee90913          	addi	s2,s2,238 # 908 <freep>
  if(p == (char*)-1)
 822:	5afd                	li	s5,-1
 824:	a88d                	j	896 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 826:	00000797          	auipc	a5,0x0
 82a:	0ea78793          	addi	a5,a5,234 # 910 <base>
 82e:	00000717          	auipc	a4,0x0
 832:	0cf73d23          	sd	a5,218(a4) # 908 <freep>
 836:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 838:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 83c:	b7e1                	j	804 <malloc+0x36>
      if(p->s.size == nunits)
 83e:	02e48b63          	beq	s1,a4,874 <malloc+0xa6>
        p->s.size -= nunits;
 842:	4137073b          	subw	a4,a4,s3
 846:	c798                	sw	a4,8(a5)
        p += p->s.size;
 848:	1702                	slli	a4,a4,0x20
 84a:	9301                	srli	a4,a4,0x20
 84c:	0712                	slli	a4,a4,0x4
 84e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 850:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 854:	00000717          	auipc	a4,0x0
 858:	0aa73a23          	sd	a0,180(a4) # 908 <freep>
      return (void*)(p + 1);
 85c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 860:	70e2                	ld	ra,56(sp)
 862:	7442                	ld	s0,48(sp)
 864:	74a2                	ld	s1,40(sp)
 866:	7902                	ld	s2,32(sp)
 868:	69e2                	ld	s3,24(sp)
 86a:	6a42                	ld	s4,16(sp)
 86c:	6aa2                	ld	s5,8(sp)
 86e:	6b02                	ld	s6,0(sp)
 870:	6121                	addi	sp,sp,64
 872:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 874:	6398                	ld	a4,0(a5)
 876:	e118                	sd	a4,0(a0)
 878:	bff1                	j	854 <malloc+0x86>
  hp->s.size = nu;
 87a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87e:	0541                	addi	a0,a0,16
 880:	00000097          	auipc	ra,0x0
 884:	ec6080e7          	jalr	-314(ra) # 746 <free>
  return freep;
 888:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 88c:	d971                	beqz	a0,860 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 890:	4798                	lw	a4,8(a5)
 892:	fa9776e3          	bgeu	a4,s1,83e <malloc+0x70>
    if(p == freep)
 896:	00093703          	ld	a4,0(s2)
 89a:	853e                	mv	a0,a5
 89c:	fef719e3          	bne	a4,a5,88e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8a0:	8552                	mv	a0,s4
 8a2:	00000097          	auipc	ra,0x0
 8a6:	b7e080e7          	jalr	-1154(ra) # 420 <sbrk>
  if(p == (char*)-1)
 8aa:	fd5518e3          	bne	a0,s5,87a <malloc+0xac>
        return 0;
 8ae:	4501                	li	a0,0
 8b0:	bf45                	j	860 <malloc+0x92>
