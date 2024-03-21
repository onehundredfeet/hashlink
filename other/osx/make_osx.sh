#!/bin/sh

make clean
arch -x86_64 make -j 32
mv libhl.dylib libhl_x86_64.dylib
mv fmt.hdll fmt_x86_64.dylib
mv openal.hdll openal_x86_64.dylib
mv sdl.hdll sdl_x86_64.dylib
mv ssl.hdll ssl_x86_64.dylib
mv ui.hdll ui_x86_64.dylib
mv uv.hdll uv_x86_64.dylib
mv hl hl_x86_64


make clean
make -j 32
mv libhl.dylib libhl_arm64.dylib
mv fmt.hdll fmt_arm64.dylib
mv openal.hdll openal_arm64.dylib
mv sdl.hdll sdl_arm64.dylib
mv ssl.hdll ssl_arm64.dylib
mv ui.hdll ui_arm64.dylib
mv uv.hdll uv_arm64.dylib
mv hl hl_arm64

lipo -create -output libhl.dylib libhl_x86_64.dylib libhl_arm64.dylib 
lipo -create -output fmt.hdll fmt_x86_64.dylib fmt_arm64.dylib
lipo -create -output openal.hdll openal_x86_64.dylib openal_arm64.dylib
lipo -create -output sdl.hdll sdl_x86_64.dylib sdl_arm64.dylib
lipo -create -output ssl.hdll ssl_x86_64.dylib ssl_arm64.dylib
lipo -create -output ui.hdll ui_x86_64.dylib ui_arm64.dylib
lipo -create -output uv.hdll uv_x86_64.dylib uv_arm64.dylib
mv hl_x86_64 hl



