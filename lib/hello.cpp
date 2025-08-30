#ifdef __GNUC__ // GCC / Clang
#define FFI_EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#else
#define FFI_EXPORT
#endif

FFI_EXPORT const char *hello(){
    return "Hello World From Cpp";
}

/*int* testFunc(){
    int* a = new int[5];
    return a;
}

int main(int argc, char const *argv[]){
    int* abc = testFunc();
    delete[] abc;
    return 0;
}
*/ // insignificant
