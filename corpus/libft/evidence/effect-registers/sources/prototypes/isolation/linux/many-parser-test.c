/* Exercise malformed untrusted requests without starting an unsafe worker. */
#define PROGRAM_LOADER_EMBEDDED 1
#include "program.c"
#undef main
int main(void) {
    for(unsigned test=0;test<10;test++) {
        struct message request={4,1,1000,1,1,0x55424332,0,0};
        struct many_request body={.args={{1,1234,16}}}; unsigned caller=0;
        switch(test) {
          case 0: request.length=7; break;
          case 1: request.rights=3; break;
          case 2: request.checksum=0; break;
          case 3: caller=1; break;
          case 4: body.args[0].length=65537; break;
          case 5: body.args[0].kind=5; break;
          case 6: body.args[1].value=1; break;
          case 7: request.length=3; request.rights=2;
                  body.args[1]=(struct many_argument){2,5678,16};
                  body.args[2]=(struct many_argument){1,9012,16}; break;
          case 8: body.args[0].kind=3; break;
          case 9: request.length=2; body.args[1]=(struct many_argument){4,0,1}; break;
        }
        int pair[2]; if(socketpair(AF_UNIX,SOCK_STREAM,0,pair)) return 1;
        if(write(pair[1],&body,sizeof body)!=sizeof body) return 2;
        shutdown(pair[1],SHUT_WR);
        if(service_many(pair[0],&request,caller) || serviced_calls || callee_launches) return 3;
        close(pair[0]);close(pair[1]);
    }
    puts("PASS 10 malformed request checks");return 0;
}
