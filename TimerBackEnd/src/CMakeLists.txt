cmake_minimum_required(VERSION 3.25)

project(TimerBackEnd VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_FLAGS_INIT "-Wall -std=c++17")
set(CMAKE_CXX_STANDARD_REQUIRED ON) # 比设置的最低cmake级别低的cmake环境cmake运行会报错
set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # 生成 compile_commands.json 帮助 lsp 添加 include 路径

add_executable(main /home/hello/TimerBackEnd/src/main.cpp)
target_include_directories(main PRIVATE /usr/local/boost_1_81_0)

get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

