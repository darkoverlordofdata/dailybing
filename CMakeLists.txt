cmake_minimum_required ( VERSION 3.16 )
###################################################################################
#
#   Build dailybing
#
###################################################################################
project ( dailybing VERSION 0.0.1 )

#
set ( VERSION 0.0.1 )
set ( RELEASE_NAME dailybing )
set ( PROJECT_NAME dailybing )
set ( APP_NAME "DailyBing" )
set ( CMAKE_EXPORT_COMPILE_COMMANDS ON )

include ( CMakeToolsHelpers OPTIONAL )
list ( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/GNUstep )
find_package ( GNUstep REQUIRED )

link_directories ( ${GNUSTEP_LIBRARY_DIRS} )

include_directories ( AFTER ${GNUSTEP_INCLUDE_DIRS} )

add_executable (
    ${APP_NAME}
    Source/main.m
    Source/Extensions/NSImage+ProportionalScaling.m
    Source/Extensions/NSImage+ResizeImage.m
    Source/Extensions/NSImage+SaveAs.m
    Source/AppDelegate.m
    Source/Interactive/ImageWindow.m
    Source/Interactive/ImageContainer.m
    Source/Interactive/ImagePanel.m
    Source/LockScreen/BackView.m
    Source/LockScreen/LockWindow.m
  )


target_link_libraries ( ${APP_NAME} ${GNUSTEP_LIBRARIES} )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy_directory
                        ${CMAKE_SOURCE_DIR}/Resources/ $<TARGET_FILE_DIR:${APP_NAME}>/Resources )

add_custom_command ( TARGET ${APP_NAME} PRE_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy
                        ${CMAKE_SOURCE_DIR}/${APP_NAME}Info.plist $<TARGET_FILE_DIR:${APP_NAME}>/Resources )

add_custom_command ( TARGET ${APP_NAME} POST_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy 
                          $<TARGET_FILE_DIR:${APP_NAME}>/compile_commands.json ${CMAKE_SOURCE_DIR}/compile_commands.json )
     
add_custom_command ( TARGET ${APP_NAME} POST_BUILD
                      COMMAND ${CMAKE_COMMAND} -E copy 
                          $<TARGET_FILE_DIR:${APP_NAME}>/DailyBing ${CMAKE_SOURCE_DIR}/DailyBing )
   
IF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
  install ( TARGETS ${APP_NAME} RUNTIME DESTINATION /Applications/${APP_NAME}.app )
  install ( DIRECTORY Resources DESTINATION /Applications/${APP_NAME}.app )
  install ( FILES ${APP_NAME}Info.plist DESTINATION /Applications/${APP_NAME}.app/Resources )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")

IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  install ( TARGETS ${APP_NAME} RUNTIME DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app )
  install ( DIRECTORY Resources DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app )
  install ( FILES ${APP_NAME}Info.plist DESTINATION /usr/GNUstep/Local/Applications/${APP_NAME}.app/Resources )
ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")



