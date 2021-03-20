#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>

// SimSig: wrapper for simsig to permit correct Discord activity detection when other Wine programs
// are in use

int main(int argc, char *argv[]) {
  pid_t pid = fork();

  if (pid == -1) {
    perror("simsig");
    exit(errno);
  } else if (pid == 0) {
    putenv("WINEPREFIX=/home/thomas/simsig/wine");
    if (argc > 1) {
      execv(argv[1], argv+2);
    } else {
      execl("/home/thomas/simsig/wine/drive_c/Program Files/SimSig/SimSigLoader.test.exe", (char *) NULL);
    }
    perror("simsig");
    exit(errno);
  } else {
    wait(NULL);
  }
}
