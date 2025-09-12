# Test configuration
include(GoogleTest)

# Collect all test files
file(GLOB_RECURSE TEST_SOURCES "*.cpp")

# Create test executable for each test file
foreach(TEST_SOURCE ${TEST_SOURCES})
    get_filename_component(TEST_NAME ${TEST_SOURCE} NAME_WE)
    add_executable(${TEST_NAME} ${TEST_SOURCE})
    
    # Link with Google Test and project library
    target_link_libraries(${TEST_NAME}
        GTest::gtest_main
        GTest::gmock_main
    )
    
    # Link with project library if it exists
    if(TARGET ${PROJECT_NAME}_lib)
        target_link_libraries(${TEST_NAME} ${PROJECT_NAME}_lib)
    endif()
    
    # Include src directory for headers
    target_include_directories(${TEST_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/src)
    
    # Register the test
    gtest_discover_tests(${TEST_NAME})
endforeach()