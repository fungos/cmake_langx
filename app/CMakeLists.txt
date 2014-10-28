cmake_minimum_required(VERSION 2.8)

project(app C)

add_executable(exec main.c)
target_link_libraries(exec ${CMAKE_CURRENT_LIST_DIR}/prefixlibx.a ${CMAKE_CURRENT_LIST_DIR}/liblibc.a)
