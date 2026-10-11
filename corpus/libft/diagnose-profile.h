/* Only included in the derived trusted profiling client. Never in the worker. */
#include <time.h>
static int profile_enabled;
struct profile_stat {uint64_t calls,inclusive_ns,exclusive_ns;};
struct profile_frame {unsigned id;uint64_t start,children;};
static struct profile_stat profile_stats[128];
static struct profile_stat profile_edges[129][128];
static struct profile_frame profile_stack[128];static unsigned profile_depth;
uint64_t profile_arena_visits;
static uint64_t profile_ns(void){struct timespec t;if(clock_gettime(CLOCK_MONOTONIC,&t))abort();return (uint64_t)t.tv_sec*1000000000+(uint64_t)t.tv_nsec;}
void profile_enter(unsigned id){if(!profile_enabled)return;if(id>=128||profile_depth>=128)abort();profile_stats[id].calls++;profile_stack[profile_depth++]=(struct profile_frame){id,profile_ns(),0};}
void profile_exit(unsigned id){if(!profile_enabled)return;if(!profile_depth||profile_stack[profile_depth-1].id!=id)abort();struct profile_frame f=profile_stack[--profile_depth];uint64_t elapsed=profile_ns()-f.start;profile_stats[id].inclusive_ns+=elapsed;profile_stats[id].exclusive_ns+=elapsed-f.children;unsigned parent=profile_depth?profile_stack[profile_depth-1].id:128;profile_edges[parent][id].calls++;profile_edges[parent][id].inclusive_ns+=elapsed;if(profile_depth)profile_stack[profile_depth-1].children+=elapsed;}
static void profile_reset(void){memset(profile_stats,0,sizeof profile_stats);memset(profile_edges,0,sizeof profile_edges);profile_arena_visits=0;profile_depth=0;profile_enabled=1;}
static void profile_dump(void){if(profile_depth)abort();int first=1;printf("{\"event\":\"profile\",\"arena_nodes_visited\":%" PRIu64 ",\"functions\":[",profile_arena_visits);for(unsigned i=0;i<128;i++)if(profile_stats[i].calls){struct profile_stat s=profile_stats[i];printf("%s{\"id\":%u,\"calls\":%" PRIu64 ",\"inclusive_ns\":%" PRIu64 ",\"exclusive_ns\":%" PRIu64 "}",first?"":",",i,s.calls,s.inclusive_ns,s.exclusive_ns);first=0;}printf("],\"edges\":[");first=1;for(unsigned p=0;p<129;p++)for(unsigned c=0;c<128;c++)if(profile_edges[p][c].calls){struct profile_stat s=profile_edges[p][c];printf("%s{\"caller\":%u,\"callee\":%u,\"calls\":%" PRIu64 ",\"inclusive_ns\":%" PRIu64 "}",first?"":",",p,c,s.calls,s.inclusive_ns);first=0;}printf("]}\n");}
