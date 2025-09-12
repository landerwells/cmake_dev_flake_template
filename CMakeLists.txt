cmake_minimum_required(VERSION 3.20)
project(MyProject LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Fetch Google Test
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/5376968f6948923e2411081fd9372e71a59d8e77.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Collect source files (excluding main.cpp for library)
file(GLOB_RECURSE LIB_SOURCES "src/*.cpp")
list(REMOVE_ITEM LIB_SOURCES "${CMAKE_SOURCE_DIR}/src/main.cpp")

# Create library if there are other sources besides main.cpp
if(LIB_SOURCES)
    add_library(${PROJECT_NAME}_lib ${LIB_SOURCES})
    target_include_directories(${PROJECT_NAME}_lib PUBLIC src)
endif()

# Create main executable
add_executable(${PROJECT_NAME} src/main.cpp)
if(LIB_SOURCES)
    target_link_libraries(${PROJECT_NAME} ${PROJECT_NAME}_lib)
endif()

enable_testing()
# Add tests subdirectory if it exists
if(EXISTS ${CMAKE_SOURCE_DIR}/tests)
    add_subdirectory(tests)
endif()
