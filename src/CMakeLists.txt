cmake_minimum_required(VERSION 3.12)
project(testTravisCI)

set(CMAKE_CXX_STANDARD 17)

if (WIN32)
    set(LIB_PATH .)
else ()
    set(LIB_PATH lib)
endif ()

add_executable(${CMAKE_PROJECT_NAME} main.cpp)

install(TARGETS ${CMAKE_PROJECT_NAME}
        RUNTIME DESTINATION .
        LIBRARY DESTINATION ${LIB_PATH}
        )

set(CPACK_MONOLITHIC_INSTALL TRUE)
SET(CPACK_PACKAGE_VERSION_MAJOR "1")
SET(CPACK_PACKAGE_VERSION_MINOR "2")
SET(CPACK_PACKAGE_VERSION_PATCH "3")


INCLUDE(CPack)

add_custom_target(cpack cpack -G 7Z .
        DEPENDS ${CMAKE_PROJECT_NAME})