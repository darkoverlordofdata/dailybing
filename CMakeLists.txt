cmake_minimum_required(VERSION 3.1)

# Project
Project(DailyBing VERSION 1.0.0)
find_library(COCOA_LIBRARY Cocoa)

# Options
set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
set(MACOSX_BUNDLE_COPYRIGHT "© 2022 by darkoverlordofdata")
set(MACOSX_BUNDLE_INFO_STRING "Select a Bing Picture of the Day")
set(MACOSX_BUNDLE_GUI_IDENTIFIER "org.darkoverlordofdata.dailybing")

# Resources
set_source_files_properties(Resources/DailyBing.png PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

# Application
add_executable(${PROJECT_NAME} MACOSX_BUNDLE main.m Controller.m Window.m  Resources/Logo.png)
target_link_libraries(${PROJECT_NAME} ${COCOA_LIBRARY})
set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER ".")
