## Getting Started

EN

1 - Create a CMakeLists.txt file under the Android folder. Write the name you want for it to be compiled as a dynamically shared file, then specify it with the `SHARED` key. Next, add the .cpp code you want to compile: `add_library(hello SHARED ../lib/hello.cpp)`. Since I wanted to use the cpp code in the same location as the dart files, I selected hello.cpp by specifying the path to the lib folder.

2 - Go to android/app/build.gradle, and add the following line so that it matches the minimum version you specified in CMakeLists.txt (`cmake_minimum_required(VERSION 3.22.1)`):
```gradle
android{
    namespace = "..."
    compileSdk = ...
    ndkVersion = ...
    compileOptions{...}
    kotlinOptions{...}
    defaultConfig {...}

//add new line
    externalNativeBuild{
        cmake{
            path file("../CMakeLists.txt")
            version "3.22.1"
        }
    }
}
```

3 - If you are writing in C++, you must wrap your functions with `extern "C"` and then add the `__attribute__((visibility(“default”))) __attribute__((used))` flag. We must add these so that they can be used when compiled as a dynamic shared file (.so) for Android on the Dart FFI side. If you are writing in C, you only need to add the `__attribute__((visibility(“default”))) __attribute__((used))` flag. You can then run the project from main.dart.

---------------

TR

1 - Android klasörü altında CMakeLists.txt dosyası oluşturun içeriğini dinamik paylaşılacak dosya olarak derlenmesi için istediğiniz ismi yazın ardından SHARED anahtarı ile belirtin daha sonra hangi .cpp kodunu derleyecekseniz onu ekleyin `add_library(hello SHARED ../lib/hello.cpp)`. Ben cpp kodunu dart dosyaları ile aynı konumda kullanmak istediğimden lib klasörünün yolunu vererek hello.cpp'yi seçtim.

2 - `android/app/build.gradle` içerisine girin, CMakeLists.txt içerisinde belirttiğiniz minimum sürüm ile(`cmake_minimum_required(VERSION 3.22.1)`) aynı olacak şekilde aşağıdaki eklemeyi yapın
```gradle
android{
    namespace = "..."
    compileSdk = ...
    ndkVersion = ...
    compileOptions{...}
    kotlinOptions{...}
    defaultConfig {...}

// bu satırı ekle
    externalNativeBuild{
        cmake{
            path file("../CMakeLists.txt")
            version "3.22.1"
        }
    }
}
```

3 - Eğer C++ yazacaksanız fonksiyonlarınızı `extern "C"` ile sarmalamanız gerekir daha sonra `__attribute__((visibility("default"))) __attribute__((used))` bayrağını eklemelisiniz. Bu dart ffi tarafında Android için .so olarak dinamik paylaşılabilir dosya halinde derlendiğinde kullanılmak için bunları eklemek zorundayız. C ile yazacaksanız sadece `__attribute__((visibility("default"))) __attribute__((used))` bayrağını eklemeniz yeterli olacak. Daha sonra projeyi `main.dart`'tan çalıştırabilirsiniz.
