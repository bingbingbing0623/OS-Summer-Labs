
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
#include "kernel/param.h"

int main(int argc, char* argv[]) {
   0:	cd010113          	addi	sp,sp,-816
   4:	32113423          	sd	ra,808(sp)
   8:	32813023          	sd	s0,800(sp)
   c:	30913c23          	sd	s1,792(sp)
  10:	31213823          	sd	s2,784(sp)
  14:	31313423          	sd	s3,776(sp)
  18:	31413023          	sd	s4,768(sp)
  1c:	1e00                	addi	s0,sp,816
  char* p = buf; // 指向缓冲区的指针
  char* args[MAXARG]; // 参数数组
  int i, n;

  // 如果参数数量小于2，报错，打印正确用法并退出
  if (argc < 2) {
  1e:	4785                	li	a5,1
  20:	04a7d063          	bge	a5,a0,60 <main+0x60>
  24:	05a1                	addi	a1,a1,8
  26:	cd040793          	addi	a5,s0,-816
  2a:	ffe5069b          	addiw	a3,a0,-2
  2e:	1682                	slli	a3,a3,0x20
  30:	9281                	srli	a3,a3,0x20
  32:	068e                	slli	a3,a3,0x3
  34:	cd840713          	addi	a4,s0,-808
  38:	96ba                	add	a3,a3,a4
    exit(1);
  }

  // 将命令行参数复制到参数数组中
  for (i = 1; i < argc; i++)
    args[i - 1] = argv[i];
  3a:	6198                	ld	a4,0(a1)
  3c:	e398                	sd	a4,0(a5)
  for (i = 1; i < argc; i++)
  3e:	05a1                	addi	a1,a1,8
  40:	07a1                	addi	a5,a5,8
  42:	fed79ce3          	bne	a5,a3,3a <main+0x3a>
  char* p = buf; // 指向缓冲区的指针
  46:	dd040493          	addi	s1,s0,-560

  // 读取标准输入
  while ((n = read(0, p, 1)) > 0) {
    // 如果读取到换行符
    if (*p == '\n') {
  4a:	4929                	li	s2,10
      *p = 0; // 将换行符替换为字符串结束符
      args[argc - 1] = buf; // 将缓冲区中的字符串作为参数添加到参数数组中
  4c:	fff50a1b          	addiw	s4,a0,-1
  50:	0a0e                	slli	s4,s4,0x3
  52:	fd040793          	addi	a5,s0,-48
  56:	9a3e                	add	s4,s4,a5
      args[argc] = 0; // 设置参数数组的结束标志
  58:	050e                	slli	a0,a0,0x3
  5a:	00a789b3          	add	s3,a5,a0
  5e:	a099                	j	a4 <main+0xa4>
    fprintf(2, "Error: xargs requires 1 or more arguments\nRight Usage: xargs command ...\n");
  60:	00001597          	auipc	a1,0x1
  64:	81858593          	addi	a1,a1,-2024 # 878 <malloc+0xe6>
  68:	4509                	li	a0,2
  6a:	00000097          	auipc	ra,0x0
  6e:	63c080e7          	jalr	1596(ra) # 6a6 <fprintf>
    exit(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	2e8080e7          	jalr	744(ra) # 35c <exit>
      *p = 0; // 将换行符替换为字符串结束符
  7c:	00048023          	sb	zero,0(s1)
      args[argc - 1] = buf; // 将缓冲区中的字符串作为参数添加到参数数组中
  80:	dd040793          	addi	a5,s0,-560
  84:	d0fa3023          	sd	a5,-768(s4)
      args[argc] = 0; // 设置参数数组的结束标志
  88:	d009b023          	sd	zero,-768(s3)

      // 创建子进程执行命令
      if (fork() == 0) {
  8c:	00000097          	auipc	ra,0x0
  90:	2c8080e7          	jalr	712(ra) # 354 <fork>
  94:	c51d                	beqz	a0,c2 <main+0xc2>
        exec(args[0], args);
        exit(0);
      }
      else {
        wait(0); // 父进程等待子进程完成
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	2cc080e7          	jalr	716(ra) # 364 <wait>
      }
      p = buf; // 重置指针指向缓冲区开头
  a0:	dd040493          	addi	s1,s0,-560
  while ((n = read(0, p, 1)) > 0) {
  a4:	4605                	li	a2,1
  a6:	85a6                	mv	a1,s1
  a8:	4501                	li	a0,0
  aa:	00000097          	auipc	ra,0x0
  ae:	2ca080e7          	jalr	714(ra) # 374 <read>
  b2:	02a05563          	blez	a0,dc <main+0xdc>
    if (*p == '\n') {
  b6:	0004c783          	lbu	a5,0(s1)
  ba:	fd2781e3          	beq	a5,s2,7c <main+0x7c>
    }
    else {
      p++; // 指针后移
  be:	0485                	addi	s1,s1,1
  c0:	b7d5                	j	a4 <main+0xa4>
        exec(args[0], args);
  c2:	cd040593          	addi	a1,s0,-816
  c6:	cd043503          	ld	a0,-816(s0)
  ca:	00000097          	auipc	ra,0x0
  ce:	2ca080e7          	jalr	714(ra) # 394 <exec>
        exit(0);
  d2:	4501                	li	a0,0
  d4:	00000097          	auipc	ra,0x0
  d8:	288080e7          	jalr	648(ra) # 35c <exit>
    }
  }

  exit(0); // 退出程序
  dc:	4501                	li	a0,0
  de:	00000097          	auipc	ra,0x0
  e2:	27e080e7          	jalr	638(ra) # 35c <exit>

00000000000000e6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ec:	87aa                	mv	a5,a0
  ee:	0585                	addi	a1,a1,1
  f0:	0785                	addi	a5,a5,1
  f2:	fff5c703          	lbu	a4,-1(a1)
  f6:	fee78fa3          	sb	a4,-1(a5)
  fa:	fb75                	bnez	a4,ee <strcpy+0x8>
    ;
  return os;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x1e>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x1e>
    p++, q++;
 116:	0505                	addi	a0,a0,1
 118:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 120:	0005c503          	lbu	a0,0(a1)
}
 124:	40a7853b          	subw	a0,a5,a0
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strlen>:

uint
strlen(const char *s)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strlen+0x26>
 13a:	0505                	addi	a0,a0,1
 13c:	87aa                	mv	a5,a0
 13e:	4685                	li	a3,1
 140:	9e89                	subw	a3,a3,a0
 142:	00f6853b          	addw	a0,a3,a5
 146:	0785                	addi	a5,a5,1
 148:	fff7c703          	lbu	a4,-1(a5)
 14c:	fb7d                	bnez	a4,142 <strlen+0x14>
    ;
  return n;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
  for(n = 0; s[n]; n++)
 154:	4501                	li	a0,0
 156:	bfe5                	j	14e <strlen+0x20>

0000000000000158 <memset>:

void*
memset(void *dst, int c, uint n)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15e:	ce09                	beqz	a2,178 <memset+0x20>
 160:	87aa                	mv	a5,a0
 162:	fff6071b          	addiw	a4,a2,-1
 166:	1702                	slli	a4,a4,0x20
 168:	9301                	srli	a4,a4,0x20
 16a:	0705                	addi	a4,a4,1
 16c:	972a                	add	a4,a4,a0
    cdst[i] = c;
 16e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 172:	0785                	addi	a5,a5,1
 174:	fee79de3          	bne	a5,a4,16e <memset+0x16>
  }
  return dst;
}
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	addi	sp,sp,16
 17c:	8082                	ret

000000000000017e <strchr>:

char*
strchr(const char *s, char c)
{
 17e:	1141                	addi	sp,sp,-16
 180:	e422                	sd	s0,8(sp)
 182:	0800                	addi	s0,sp,16
  for(; *s; s++)
 184:	00054783          	lbu	a5,0(a0)
 188:	cb99                	beqz	a5,19e <strchr+0x20>
    if(*s == c)
 18a:	00f58763          	beq	a1,a5,198 <strchr+0x1a>
  for(; *s; s++)
 18e:	0505                	addi	a0,a0,1
 190:	00054783          	lbu	a5,0(a0)
 194:	fbfd                	bnez	a5,18a <strchr+0xc>
      return (char*)s;
  return 0;
 196:	4501                	li	a0,0
}
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret
  return 0;
 19e:	4501                	li	a0,0
 1a0:	bfe5                	j	198 <strchr+0x1a>

00000000000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	711d                	addi	sp,sp,-96
 1a4:	ec86                	sd	ra,88(sp)
 1a6:	e8a2                	sd	s0,80(sp)
 1a8:	e4a6                	sd	s1,72(sp)
 1aa:	e0ca                	sd	s2,64(sp)
 1ac:	fc4e                	sd	s3,56(sp)
 1ae:	f852                	sd	s4,48(sp)
 1b0:	f456                	sd	s5,40(sp)
 1b2:	f05a                	sd	s6,32(sp)
 1b4:	ec5e                	sd	s7,24(sp)
 1b6:	1080                	addi	s0,sp,96
 1b8:	8baa                	mv	s7,a0
 1ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bc:	892a                	mv	s2,a0
 1be:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c0:	4aa9                	li	s5,10
 1c2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c4:	89a6                	mv	s3,s1
 1c6:	2485                	addiw	s1,s1,1
 1c8:	0344d863          	bge	s1,s4,1f8 <gets+0x56>
    cc = read(0, &c, 1);
 1cc:	4605                	li	a2,1
 1ce:	faf40593          	addi	a1,s0,-81
 1d2:	4501                	li	a0,0
 1d4:	00000097          	auipc	ra,0x0
 1d8:	1a0080e7          	jalr	416(ra) # 374 <read>
    if(cc < 1)
 1dc:	00a05e63          	blez	a0,1f8 <gets+0x56>
    buf[i++] = c;
 1e0:	faf44783          	lbu	a5,-81(s0)
 1e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e8:	01578763          	beq	a5,s5,1f6 <gets+0x54>
 1ec:	0905                	addi	s2,s2,1
 1ee:	fd679be3          	bne	a5,s6,1c4 <gets+0x22>
  for(i=0; i+1 < max; ){
 1f2:	89a6                	mv	s3,s1
 1f4:	a011                	j	1f8 <gets+0x56>
 1f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f8:	99de                	add	s3,s3,s7
 1fa:	00098023          	sb	zero,0(s3)
  return buf;
}
 1fe:	855e                	mv	a0,s7
 200:	60e6                	ld	ra,88(sp)
 202:	6446                	ld	s0,80(sp)
 204:	64a6                	ld	s1,72(sp)
 206:	6906                	ld	s2,64(sp)
 208:	79e2                	ld	s3,56(sp)
 20a:	7a42                	ld	s4,48(sp)
 20c:	7aa2                	ld	s5,40(sp)
 20e:	7b02                	ld	s6,32(sp)
 210:	6be2                	ld	s7,24(sp)
 212:	6125                	addi	sp,sp,96
 214:	8082                	ret

0000000000000216 <stat>:

int
stat(const char *n, struct stat *st)
{
 216:	1101                	addi	sp,sp,-32
 218:	ec06                	sd	ra,24(sp)
 21a:	e822                	sd	s0,16(sp)
 21c:	e426                	sd	s1,8(sp)
 21e:	e04a                	sd	s2,0(sp)
 220:	1000                	addi	s0,sp,32
 222:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 224:	4581                	li	a1,0
 226:	00000097          	auipc	ra,0x0
 22a:	176080e7          	jalr	374(ra) # 39c <open>
  if(fd < 0)
 22e:	02054563          	bltz	a0,258 <stat+0x42>
 232:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 234:	85ca                	mv	a1,s2
 236:	00000097          	auipc	ra,0x0
 23a:	17e080e7          	jalr	382(ra) # 3b4 <fstat>
 23e:	892a                	mv	s2,a0
  close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	142080e7          	jalr	322(ra) # 384 <close>
  return r;
}
 24a:	854a                	mv	a0,s2
 24c:	60e2                	ld	ra,24(sp)
 24e:	6442                	ld	s0,16(sp)
 250:	64a2                	ld	s1,8(sp)
 252:	6902                	ld	s2,0(sp)
 254:	6105                	addi	sp,sp,32
 256:	8082                	ret
    return -1;
 258:	597d                	li	s2,-1
 25a:	bfc5                	j	24a <stat+0x34>

000000000000025c <atoi>:

int
atoi(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	00054603          	lbu	a2,0(a0)
 266:	fd06079b          	addiw	a5,a2,-48
 26a:	0ff7f793          	andi	a5,a5,255
 26e:	4725                	li	a4,9
 270:	02f76963          	bltu	a4,a5,2a2 <atoi+0x46>
 274:	86aa                	mv	a3,a0
  n = 0;
 276:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 278:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 27a:	0685                	addi	a3,a3,1
 27c:	0025179b          	slliw	a5,a0,0x2
 280:	9fa9                	addw	a5,a5,a0
 282:	0017979b          	slliw	a5,a5,0x1
 286:	9fb1                	addw	a5,a5,a2
 288:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28c:	0006c603          	lbu	a2,0(a3)
 290:	fd06071b          	addiw	a4,a2,-48
 294:	0ff77713          	andi	a4,a4,255
 298:	fee5f1e3          	bgeu	a1,a4,27a <atoi+0x1e>
  return n;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  n = 0;
 2a2:	4501                	li	a0,0
 2a4:	bfe5                	j	29c <atoi+0x40>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ac:	02b57663          	bgeu	a0,a1,2d8 <memmove+0x32>
    while(n-- > 0)
 2b0:	02c05163          	blez	a2,2d2 <memmove+0x2c>
 2b4:	fff6079b          	addiw	a5,a2,-1
 2b8:	1782                	slli	a5,a5,0x20
 2ba:	9381                	srli	a5,a5,0x20
 2bc:	0785                	addi	a5,a5,1
 2be:	97aa                	add	a5,a5,a0
  dst = vdst;
 2c0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c2:	0585                	addi	a1,a1,1
 2c4:	0705                	addi	a4,a4,1
 2c6:	fff5c683          	lbu	a3,-1(a1)
 2ca:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2ce:	fee79ae3          	bne	a5,a4,2c2 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
    dst += n;
 2d8:	00c50733          	add	a4,a0,a2
    src += n;
 2dc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2de:	fec05ae3          	blez	a2,2d2 <memmove+0x2c>
 2e2:	fff6079b          	addiw	a5,a2,-1
 2e6:	1782                	slli	a5,a5,0x20
 2e8:	9381                	srli	a5,a5,0x20
 2ea:	fff7c793          	not	a5,a5
 2ee:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f0:	15fd                	addi	a1,a1,-1
 2f2:	177d                	addi	a4,a4,-1
 2f4:	0005c683          	lbu	a3,0(a1)
 2f8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fc:	fee79ae3          	bne	a5,a4,2f0 <memmove+0x4a>
 300:	bfc9                	j	2d2 <memmove+0x2c>

0000000000000302 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 308:	ca05                	beqz	a2,338 <memcmp+0x36>
 30a:	fff6069b          	addiw	a3,a2,-1
 30e:	1682                	slli	a3,a3,0x20
 310:	9281                	srli	a3,a3,0x20
 312:	0685                	addi	a3,a3,1
 314:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 316:	00054783          	lbu	a5,0(a0)
 31a:	0005c703          	lbu	a4,0(a1)
 31e:	00e79863          	bne	a5,a4,32e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 322:	0505                	addi	a0,a0,1
    p2++;
 324:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 326:	fed518e3          	bne	a0,a3,316 <memcmp+0x14>
  }
  return 0;
 32a:	4501                	li	a0,0
 32c:	a019                	j	332 <memcmp+0x30>
      return *p1 - *p2;
 32e:	40e7853b          	subw	a0,a5,a4
}
 332:	6422                	ld	s0,8(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret
  return 0;
 338:	4501                	li	a0,0
 33a:	bfe5                	j	332 <memcmp+0x30>

000000000000033c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33c:	1141                	addi	sp,sp,-16
 33e:	e406                	sd	ra,8(sp)
 340:	e022                	sd	s0,0(sp)
 342:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 344:	00000097          	auipc	ra,0x0
 348:	f62080e7          	jalr	-158(ra) # 2a6 <memmove>
}
 34c:	60a2                	ld	ra,8(sp)
 34e:	6402                	ld	s0,0(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret

0000000000000354 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 354:	4885                	li	a7,1
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <exit>:
.global exit
exit:
 li a7, SYS_exit
 35c:	4889                	li	a7,2
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <wait>:
.global wait
wait:
 li a7, SYS_wait
 364:	488d                	li	a7,3
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 36c:	4891                	li	a7,4
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <read>:
.global read
read:
 li a7, SYS_read
 374:	4895                	li	a7,5
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <write>:
.global write
write:
 li a7, SYS_write
 37c:	48c1                	li	a7,16
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <close>:
.global close
close:
 li a7, SYS_close
 384:	48d5                	li	a7,21
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <kill>:
.global kill
kill:
 li a7, SYS_kill
 38c:	4899                	li	a7,6
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exec>:
.global exec
exec:
 li a7, SYS_exec
 394:	489d                	li	a7,7
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <open>:
.global open
open:
 li a7, SYS_open
 39c:	48bd                	li	a7,15
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a4:	48c5                	li	a7,17
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ac:	48c9                	li	a7,18
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b4:	48a1                	li	a7,8
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <link>:
.global link
link:
 li a7, SYS_link
 3bc:	48cd                	li	a7,19
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c4:	48d1                	li	a7,20
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3cc:	48a5                	li	a7,9
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d4:	48a9                	li	a7,10
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3dc:	48ad                	li	a7,11
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e4:	48b1                	li	a7,12
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ec:	48b5                	li	a7,13
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f4:	48b9                	li	a7,14
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3fc:	1101                	addi	sp,sp,-32
 3fe:	ec06                	sd	ra,24(sp)
 400:	e822                	sd	s0,16(sp)
 402:	1000                	addi	s0,sp,32
 404:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 408:	4605                	li	a2,1
 40a:	fef40593          	addi	a1,s0,-17
 40e:	00000097          	auipc	ra,0x0
 412:	f6e080e7          	jalr	-146(ra) # 37c <write>
}
 416:	60e2                	ld	ra,24(sp)
 418:	6442                	ld	s0,16(sp)
 41a:	6105                	addi	sp,sp,32
 41c:	8082                	ret

000000000000041e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41e:	7139                	addi	sp,sp,-64
 420:	fc06                	sd	ra,56(sp)
 422:	f822                	sd	s0,48(sp)
 424:	f426                	sd	s1,40(sp)
 426:	f04a                	sd	s2,32(sp)
 428:	ec4e                	sd	s3,24(sp)
 42a:	0080                	addi	s0,sp,64
 42c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42e:	c299                	beqz	a3,434 <printint+0x16>
 430:	0805c863          	bltz	a1,4c0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 434:	2581                	sext.w	a1,a1
  neg = 0;
 436:	4881                	li	a7,0
 438:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 43c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 43e:	2601                	sext.w	a2,a2
 440:	00000517          	auipc	a0,0x0
 444:	49050513          	addi	a0,a0,1168 # 8d0 <digits>
 448:	883a                	mv	a6,a4
 44a:	2705                	addiw	a4,a4,1
 44c:	02c5f7bb          	remuw	a5,a1,a2
 450:	1782                	slli	a5,a5,0x20
 452:	9381                	srli	a5,a5,0x20
 454:	97aa                	add	a5,a5,a0
 456:	0007c783          	lbu	a5,0(a5)
 45a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 45e:	0005879b          	sext.w	a5,a1
 462:	02c5d5bb          	divuw	a1,a1,a2
 466:	0685                	addi	a3,a3,1
 468:	fec7f0e3          	bgeu	a5,a2,448 <printint+0x2a>
  if(neg)
 46c:	00088b63          	beqz	a7,482 <printint+0x64>
    buf[i++] = '-';
 470:	fd040793          	addi	a5,s0,-48
 474:	973e                	add	a4,a4,a5
 476:	02d00793          	li	a5,45
 47a:	fef70823          	sb	a5,-16(a4)
 47e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 482:	02e05863          	blez	a4,4b2 <printint+0x94>
 486:	fc040793          	addi	a5,s0,-64
 48a:	00e78933          	add	s2,a5,a4
 48e:	fff78993          	addi	s3,a5,-1
 492:	99ba                	add	s3,s3,a4
 494:	377d                	addiw	a4,a4,-1
 496:	1702                	slli	a4,a4,0x20
 498:	9301                	srli	a4,a4,0x20
 49a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 49e:	fff94583          	lbu	a1,-1(s2)
 4a2:	8526                	mv	a0,s1
 4a4:	00000097          	auipc	ra,0x0
 4a8:	f58080e7          	jalr	-168(ra) # 3fc <putc>
  while(--i >= 0)
 4ac:	197d                	addi	s2,s2,-1
 4ae:	ff3918e3          	bne	s2,s3,49e <printint+0x80>
}
 4b2:	70e2                	ld	ra,56(sp)
 4b4:	7442                	ld	s0,48(sp)
 4b6:	74a2                	ld	s1,40(sp)
 4b8:	7902                	ld	s2,32(sp)
 4ba:	69e2                	ld	s3,24(sp)
 4bc:	6121                	addi	sp,sp,64
 4be:	8082                	ret
    x = -xx;
 4c0:	40b005bb          	negw	a1,a1
    neg = 1;
 4c4:	4885                	li	a7,1
    x = -xx;
 4c6:	bf8d                	j	438 <printint+0x1a>

00000000000004c8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c8:	7119                	addi	sp,sp,-128
 4ca:	fc86                	sd	ra,120(sp)
 4cc:	f8a2                	sd	s0,112(sp)
 4ce:	f4a6                	sd	s1,104(sp)
 4d0:	f0ca                	sd	s2,96(sp)
 4d2:	ecce                	sd	s3,88(sp)
 4d4:	e8d2                	sd	s4,80(sp)
 4d6:	e4d6                	sd	s5,72(sp)
 4d8:	e0da                	sd	s6,64(sp)
 4da:	fc5e                	sd	s7,56(sp)
 4dc:	f862                	sd	s8,48(sp)
 4de:	f466                	sd	s9,40(sp)
 4e0:	f06a                	sd	s10,32(sp)
 4e2:	ec6e                	sd	s11,24(sp)
 4e4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4e6:	0005c903          	lbu	s2,0(a1)
 4ea:	18090f63          	beqz	s2,688 <vprintf+0x1c0>
 4ee:	8aaa                	mv	s5,a0
 4f0:	8b32                	mv	s6,a2
 4f2:	00158493          	addi	s1,a1,1
  state = 0;
 4f6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f8:	02500a13          	li	s4,37
      if(c == 'd'){
 4fc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 500:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 504:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 508:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 50c:	00000b97          	auipc	s7,0x0
 510:	3c4b8b93          	addi	s7,s7,964 # 8d0 <digits>
 514:	a839                	j	532 <vprintf+0x6a>
        putc(fd, c);
 516:	85ca                	mv	a1,s2
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	ee2080e7          	jalr	-286(ra) # 3fc <putc>
 522:	a019                	j	528 <vprintf+0x60>
    } else if(state == '%'){
 524:	01498f63          	beq	s3,s4,542 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 528:	0485                	addi	s1,s1,1
 52a:	fff4c903          	lbu	s2,-1(s1)
 52e:	14090d63          	beqz	s2,688 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 532:	0009079b          	sext.w	a5,s2
    if(state == 0){
 536:	fe0997e3          	bnez	s3,524 <vprintf+0x5c>
      if(c == '%'){
 53a:	fd479ee3          	bne	a5,s4,516 <vprintf+0x4e>
        state = '%';
 53e:	89be                	mv	s3,a5
 540:	b7e5                	j	528 <vprintf+0x60>
      if(c == 'd'){
 542:	05878063          	beq	a5,s8,582 <vprintf+0xba>
      } else if(c == 'l') {
 546:	05978c63          	beq	a5,s9,59e <vprintf+0xd6>
      } else if(c == 'x') {
 54a:	07a78863          	beq	a5,s10,5ba <vprintf+0xf2>
      } else if(c == 'p') {
 54e:	09b78463          	beq	a5,s11,5d6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 552:	07300713          	li	a4,115
 556:	0ce78663          	beq	a5,a4,622 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55a:	06300713          	li	a4,99
 55e:	0ee78e63          	beq	a5,a4,65a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 562:	11478863          	beq	a5,s4,672 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 566:	85d2                	mv	a1,s4
 568:	8556                	mv	a0,s5
 56a:	00000097          	auipc	ra,0x0
 56e:	e92080e7          	jalr	-366(ra) # 3fc <putc>
        putc(fd, c);
 572:	85ca                	mv	a1,s2
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	e86080e7          	jalr	-378(ra) # 3fc <putc>
      }
      state = 0;
 57e:	4981                	li	s3,0
 580:	b765                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 582:	008b0913          	addi	s2,s6,8
 586:	4685                	li	a3,1
 588:	4629                	li	a2,10
 58a:	000b2583          	lw	a1,0(s6)
 58e:	8556                	mv	a0,s5
 590:	00000097          	auipc	ra,0x0
 594:	e8e080e7          	jalr	-370(ra) # 41e <printint>
 598:	8b4a                	mv	s6,s2
      state = 0;
 59a:	4981                	li	s3,0
 59c:	b771                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 59e:	008b0913          	addi	s2,s6,8
 5a2:	4681                	li	a3,0
 5a4:	4629                	li	a2,10
 5a6:	000b2583          	lw	a1,0(s6)
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e72080e7          	jalr	-398(ra) # 41e <printint>
 5b4:	8b4a                	mv	s6,s2
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	bf85                	j	528 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5ba:	008b0913          	addi	s2,s6,8
 5be:	4681                	li	a3,0
 5c0:	4641                	li	a2,16
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e56080e7          	jalr	-426(ra) # 41e <printint>
 5d0:	8b4a                	mv	s6,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	bf91                	j	528 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 5d6:	008b0793          	addi	a5,s6,8
 5da:	f8f43423          	sd	a5,-120(s0)
 5de:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 5e2:	03000593          	li	a1,48
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	e14080e7          	jalr	-492(ra) # 3fc <putc>
  putc(fd, 'x');
 5f0:	85ea                	mv	a1,s10
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e08080e7          	jalr	-504(ra) # 3fc <putc>
 5fc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5fe:	03c9d793          	srli	a5,s3,0x3c
 602:	97de                	add	a5,a5,s7
 604:	0007c583          	lbu	a1,0(a5)
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	df2080e7          	jalr	-526(ra) # 3fc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 612:	0992                	slli	s3,s3,0x4
 614:	397d                	addiw	s2,s2,-1
 616:	fe0914e3          	bnez	s2,5fe <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 61a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 61e:	4981                	li	s3,0
 620:	b721                	j	528 <vprintf+0x60>
        s = va_arg(ap, char*);
 622:	008b0993          	addi	s3,s6,8
 626:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 62a:	02090163          	beqz	s2,64c <vprintf+0x184>
        while(*s != 0){
 62e:	00094583          	lbu	a1,0(s2)
 632:	c9a1                	beqz	a1,682 <vprintf+0x1ba>
          putc(fd, *s);
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	dc6080e7          	jalr	-570(ra) # 3fc <putc>
          s++;
 63e:	0905                	addi	s2,s2,1
        while(*s != 0){
 640:	00094583          	lbu	a1,0(s2)
 644:	f9e5                	bnez	a1,634 <vprintf+0x16c>
        s = va_arg(ap, char*);
 646:	8b4e                	mv	s6,s3
      state = 0;
 648:	4981                	li	s3,0
 64a:	bdf9                	j	528 <vprintf+0x60>
          s = "(null)";
 64c:	00000917          	auipc	s2,0x0
 650:	27c90913          	addi	s2,s2,636 # 8c8 <malloc+0x136>
        while(*s != 0){
 654:	02800593          	li	a1,40
 658:	bff1                	j	634 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 65a:	008b0913          	addi	s2,s6,8
 65e:	000b4583          	lbu	a1,0(s6)
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	d98080e7          	jalr	-616(ra) # 3fc <putc>
 66c:	8b4a                	mv	s6,s2
      state = 0;
 66e:	4981                	li	s3,0
 670:	bd65                	j	528 <vprintf+0x60>
        putc(fd, c);
 672:	85d2                	mv	a1,s4
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	d86080e7          	jalr	-634(ra) # 3fc <putc>
      state = 0;
 67e:	4981                	li	s3,0
 680:	b565                	j	528 <vprintf+0x60>
        s = va_arg(ap, char*);
 682:	8b4e                	mv	s6,s3
      state = 0;
 684:	4981                	li	s3,0
 686:	b54d                	j	528 <vprintf+0x60>
    }
  }
}
 688:	70e6                	ld	ra,120(sp)
 68a:	7446                	ld	s0,112(sp)
 68c:	74a6                	ld	s1,104(sp)
 68e:	7906                	ld	s2,96(sp)
 690:	69e6                	ld	s3,88(sp)
 692:	6a46                	ld	s4,80(sp)
 694:	6aa6                	ld	s5,72(sp)
 696:	6b06                	ld	s6,64(sp)
 698:	7be2                	ld	s7,56(sp)
 69a:	7c42                	ld	s8,48(sp)
 69c:	7ca2                	ld	s9,40(sp)
 69e:	7d02                	ld	s10,32(sp)
 6a0:	6de2                	ld	s11,24(sp)
 6a2:	6109                	addi	sp,sp,128
 6a4:	8082                	ret

00000000000006a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6a6:	715d                	addi	sp,sp,-80
 6a8:	ec06                	sd	ra,24(sp)
 6aa:	e822                	sd	s0,16(sp)
 6ac:	1000                	addi	s0,sp,32
 6ae:	e010                	sd	a2,0(s0)
 6b0:	e414                	sd	a3,8(s0)
 6b2:	e818                	sd	a4,16(s0)
 6b4:	ec1c                	sd	a5,24(s0)
 6b6:	03043023          	sd	a6,32(s0)
 6ba:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6be:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6c2:	8622                	mv	a2,s0
 6c4:	00000097          	auipc	ra,0x0
 6c8:	e04080e7          	jalr	-508(ra) # 4c8 <vprintf>
}
 6cc:	60e2                	ld	ra,24(sp)
 6ce:	6442                	ld	s0,16(sp)
 6d0:	6161                	addi	sp,sp,80
 6d2:	8082                	ret

00000000000006d4 <printf>:

void
printf(const char *fmt, ...)
{
 6d4:	711d                	addi	sp,sp,-96
 6d6:	ec06                	sd	ra,24(sp)
 6d8:	e822                	sd	s0,16(sp)
 6da:	1000                	addi	s0,sp,32
 6dc:	e40c                	sd	a1,8(s0)
 6de:	e810                	sd	a2,16(s0)
 6e0:	ec14                	sd	a3,24(s0)
 6e2:	f018                	sd	a4,32(s0)
 6e4:	f41c                	sd	a5,40(s0)
 6e6:	03043823          	sd	a6,48(s0)
 6ea:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6ee:	00840613          	addi	a2,s0,8
 6f2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6f6:	85aa                	mv	a1,a0
 6f8:	4505                	li	a0,1
 6fa:	00000097          	auipc	ra,0x0
 6fe:	dce080e7          	jalr	-562(ra) # 4c8 <vprintf>
}
 702:	60e2                	ld	ra,24(sp)
 704:	6442                	ld	s0,16(sp)
 706:	6125                	addi	sp,sp,96
 708:	8082                	ret

000000000000070a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 70a:	1141                	addi	sp,sp,-16
 70c:	e422                	sd	s0,8(sp)
 70e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 710:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 714:	00000797          	auipc	a5,0x0
 718:	1d47b783          	ld	a5,468(a5) # 8e8 <freep>
 71c:	a805                	j	74c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71e:	4618                	lw	a4,8(a2)
 720:	9db9                	addw	a1,a1,a4
 722:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	6398                	ld	a4,0(a5)
 728:	6318                	ld	a4,0(a4)
 72a:	fee53823          	sd	a4,-16(a0)
 72e:	a091                	j	772 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 730:	ff852703          	lw	a4,-8(a0)
 734:	9e39                	addw	a2,a2,a4
 736:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 738:	ff053703          	ld	a4,-16(a0)
 73c:	e398                	sd	a4,0(a5)
 73e:	a099                	j	784 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	6398                	ld	a4,0(a5)
 742:	00e7e463          	bltu	a5,a4,74a <free+0x40>
 746:	00e6ea63          	bltu	a3,a4,75a <free+0x50>
{
 74a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	fed7fae3          	bgeu	a5,a3,740 <free+0x36>
 750:	6398                	ld	a4,0(a5)
 752:	00e6e463          	bltu	a3,a4,75a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 756:	fee7eae3          	bltu	a5,a4,74a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 75a:	ff852583          	lw	a1,-8(a0)
 75e:	6390                	ld	a2,0(a5)
 760:	02059713          	slli	a4,a1,0x20
 764:	9301                	srli	a4,a4,0x20
 766:	0712                	slli	a4,a4,0x4
 768:	9736                	add	a4,a4,a3
 76a:	fae60ae3          	beq	a2,a4,71e <free+0x14>
    bp->s.ptr = p->s.ptr;
 76e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 772:	4790                	lw	a2,8(a5)
 774:	02061713          	slli	a4,a2,0x20
 778:	9301                	srli	a4,a4,0x20
 77a:	0712                	slli	a4,a4,0x4
 77c:	973e                	add	a4,a4,a5
 77e:	fae689e3          	beq	a3,a4,730 <free+0x26>
  } else
    p->s.ptr = bp;
 782:	e394                	sd	a3,0(a5)
  freep = p;
 784:	00000717          	auipc	a4,0x0
 788:	16f73223          	sd	a5,356(a4) # 8e8 <freep>
}
 78c:	6422                	ld	s0,8(sp)
 78e:	0141                	addi	sp,sp,16
 790:	8082                	ret

0000000000000792 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 792:	7139                	addi	sp,sp,-64
 794:	fc06                	sd	ra,56(sp)
 796:	f822                	sd	s0,48(sp)
 798:	f426                	sd	s1,40(sp)
 79a:	f04a                	sd	s2,32(sp)
 79c:	ec4e                	sd	s3,24(sp)
 79e:	e852                	sd	s4,16(sp)
 7a0:	e456                	sd	s5,8(sp)
 7a2:	e05a                	sd	s6,0(sp)
 7a4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	02051493          	slli	s1,a0,0x20
 7aa:	9081                	srli	s1,s1,0x20
 7ac:	04bd                	addi	s1,s1,15
 7ae:	8091                	srli	s1,s1,0x4
 7b0:	0014899b          	addiw	s3,s1,1
 7b4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7b6:	00000517          	auipc	a0,0x0
 7ba:	13253503          	ld	a0,306(a0) # 8e8 <freep>
 7be:	c515                	beqz	a0,7ea <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c2:	4798                	lw	a4,8(a5)
 7c4:	02977f63          	bgeu	a4,s1,802 <malloc+0x70>
 7c8:	8a4e                	mv	s4,s3
 7ca:	0009871b          	sext.w	a4,s3
 7ce:	6685                	lui	a3,0x1
 7d0:	00d77363          	bgeu	a4,a3,7d6 <malloc+0x44>
 7d4:	6a05                	lui	s4,0x1
 7d6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7da:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7de:	00000917          	auipc	s2,0x0
 7e2:	10a90913          	addi	s2,s2,266 # 8e8 <freep>
  if(p == (char*)-1)
 7e6:	5afd                	li	s5,-1
 7e8:	a88d                	j	85a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7ea:	00000797          	auipc	a5,0x0
 7ee:	10678793          	addi	a5,a5,262 # 8f0 <base>
 7f2:	00000717          	auipc	a4,0x0
 7f6:	0ef73b23          	sd	a5,246(a4) # 8e8 <freep>
 7fa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7fc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 800:	b7e1                	j	7c8 <malloc+0x36>
      if(p->s.size == nunits)
 802:	02e48b63          	beq	s1,a4,838 <malloc+0xa6>
        p->s.size -= nunits;
 806:	4137073b          	subw	a4,a4,s3
 80a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 80c:	1702                	slli	a4,a4,0x20
 80e:	9301                	srli	a4,a4,0x20
 810:	0712                	slli	a4,a4,0x4
 812:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 814:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 818:	00000717          	auipc	a4,0x0
 81c:	0ca73823          	sd	a0,208(a4) # 8e8 <freep>
      return (void*)(p + 1);
 820:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 824:	70e2                	ld	ra,56(sp)
 826:	7442                	ld	s0,48(sp)
 828:	74a2                	ld	s1,40(sp)
 82a:	7902                	ld	s2,32(sp)
 82c:	69e2                	ld	s3,24(sp)
 82e:	6a42                	ld	s4,16(sp)
 830:	6aa2                	ld	s5,8(sp)
 832:	6b02                	ld	s6,0(sp)
 834:	6121                	addi	sp,sp,64
 836:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 838:	6398                	ld	a4,0(a5)
 83a:	e118                	sd	a4,0(a0)
 83c:	bff1                	j	818 <malloc+0x86>
  hp->s.size = nu;
 83e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 842:	0541                	addi	a0,a0,16
 844:	00000097          	auipc	ra,0x0
 848:	ec6080e7          	jalr	-314(ra) # 70a <free>
  return freep;
 84c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 850:	d971                	beqz	a0,824 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 854:	4798                	lw	a4,8(a5)
 856:	fa9776e3          	bgeu	a4,s1,802 <malloc+0x70>
    if(p == freep)
 85a:	00093703          	ld	a4,0(s2)
 85e:	853e                	mv	a0,a5
 860:	fef719e3          	bne	a4,a5,852 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 864:	8552                	mv	a0,s4
 866:	00000097          	auipc	ra,0x0
 86a:	b7e080e7          	jalr	-1154(ra) # 3e4 <sbrk>
  if(p == (char*)-1)
 86e:	fd5518e3          	bne	a0,s5,83e <malloc+0xac>
        return 0;
 872:	4501                	li	a0,0
 874:	bf45                	j	824 <malloc+0x92>
