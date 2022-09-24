if(WIN32)
    set(SDL2_PATH ${INCLUDES_BASE_DIR}/sdl)
endif()
find_package(SDL2 REQUIRED)

add_library(sdl.hdll SHARED
    sdl.c
    gl.c
    sdl_gl.c
#    sdl_metal.cpp
)

set_property(TARGET sdl.hdll PROPERTY CXX_STANDARD 17)

set_as_hdll(sdl)
target_include_directories(sdl.hdll
    PRIVATE
    ${SDL2_INCLUDE_DIR}
    ${INCLUDES_BASE_DIR}/gl
    metal-cpp
)
target_link_libraries(sdl.hdll
    libhl
    ${SDL2_LIBRARY}
)

if(WIN32)
    target_link_libraries(sdl.hdll
        winmm
        opengl32
    )
endif()

if(APPLE)
    find_library(FOUNDATIONLIB Foundation)
    find_library(QUARTZCORELIB QuartzCore)
    find_library(METALLIB Metal)
    find_library(APPKITLIB AppKit)
endif()

if(APPLE)
    set( APPLE_LIBS ${FOUNDATIONLIB} ${QUARTZCORELIB} ${METALLIB} ${APPKITLIB})
endif()

if(APPLE OR UNIX)
    find_package(OPENGL REQUIRED)


    target_include_directories(sdl.hdll
        PRIVATE
        ${OPENGL_INCLUDE_DIR}
    )
    target_link_libraries(sdl.hdll
        libhl
        ${OPENGL_gl_LIBRARY}
        ${APPLE_LIBS}
    )
endif()


install(
    TARGETS sdl.hdll
    DESTINATION ${HDLL_DESTINATION}
)
