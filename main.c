#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <lua.h>

const char code_out[] = {
  0x1b, 0x4c, 0x75, 0x61, 0x53, 0x00, 0x19, 0x93, 0x0d, 0x0a, 0x1a, 0x0a,
  0x04, 0x04, 0x04, 0x04, 0x04, 0x78, 0x56, 0x00, 0x00, 0x00, 0x40, 0xb9,
  0x43, 0x01, 0x0a, 0x40, 0x63, 0x6f, 0x64, 0x65, 0x2e, 0x6c, 0x75, 0x61,
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x05,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x41, 0x40, 0x00, 0x00, 0x8d,
  0x40, 0x00, 0x00, 0xa6, 0x00, 0x00, 0x01, 0x26, 0x00, 0x80, 0x00, 0x02,
  0x00, 0x00, 0x00, 0x13, 0x05, 0x00, 0x00, 0x00, 0x13, 0x0a, 0x00, 0x00,
  0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03,
  0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03,
  0x00, 0x00, 0x00, 0x02, 0x61, 0x01, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00,
  0x00, 0x02, 0x62, 0x02, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x02,
  0x63, 0x03, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
  0x00, 0x05, 0x5f, 0x45, 0x4e, 0x56
};
unsigned int code_out_len = 162;

static int panic(lua_State *L)
{
    printf("PANIC: unprotected error in call to Lua API (%s)\n",
           lua_tostring(L, -1));
    return 0; /* return to Lua to abort */
}

static void *l_alloc(void *ud, void *ptr, size_t osize, size_t nsize)
{
    (void)ud;
    if (nsize == 0)
    {
        //printf("FREE: %lu\n", osize);
        free(ptr);
        return NULL;
    }
    else
    {
        //printf("ALLOC: %lu %lu\n", osize, nsize);
        return realloc(ptr, nsize);
    }
}

static const char *load_buff(lua_State *L, void *ud, size_t *size)
{
    (void)L;
    int *left = (int *)ud;
    if (*left == 0)
        return NULL;
    *size = *left;
    *left = 0;
    return code_out;
}

int main(void)
{
    void *a = malloc(10);
    printf("Hello, world! %p\n", a);
    lua_State *L = lua_newstate(l_alloc, NULL);
    lua_atpanic(L, &panic);
    int left = code_out_len;
    lua_load(L, load_buff, &left, "buffer", NULL);
    lua_pcall(L, 0, LUA_MULTRET, 0);
    printf("result = %s\n", lua_tostring(L, -1));
    lua_close(L);
    for (;;);
}

void default_handler() {
    for (;;);
}

void reset_handler() {
    extern char __data_load;
    extern char __data_start;
    extern char __data_end;
    extern char __bss_start;
    extern char __bss_end;
    memcpy(&__data_start, &__data_load, (&__data_end - &__data_start));
    memset(&__bss_start, 0, (&__bss_end - &__bss_start));

    volatile unsigned *vfp = 0xE000ED88;
    *vfp |= (0xF << 20);
    extern void initialise_monitor_handles();
    initialise_monitor_handles();

    main();
}

extern char __stack_top;
extern void nmi_handler();
extern void hardfault_handler();
extern void memmanage_handler();
extern void busfault_handler();
extern void usagefault_handler();
extern void svc_handler();
extern void debugmon_handler();
extern void pendsv_handler();
extern void systick_handler();

__attribute__((section(".vectors"), used))
void *VECTORS[] = {
     &__stack_top,
     &reset_handler,
     &nmi_handler,
     &hardfault_handler,
     &memmanage_handler,
     &busfault_handler,
     &usagefault_handler,
     0,
     0,
     0,
     0,
     &svc_handler,
     &debugmon_handler,
     0,
     &pendsv_handler,
     &systick_handler,
};
