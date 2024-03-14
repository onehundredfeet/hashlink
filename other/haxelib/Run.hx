class Build {

	var output : String;
	var name : String;
	var targetDir : String;
	var dataPath : String;
	var config : {
		var version : Int;
		var libs : Array<String>;
		var defines : haxe.DynamicAccess<String>;
		var files : Array<String>;
	};

	public function new(dataPath,output,config) {
		this.output = output;
		this.config = config;
		this.dataPath = dataPath;
		var path = new haxe.io.Path(output);
		this.name = path.file;
		this.targetDir = path.dir+"/";
	}

	public function run() {
		var tpl = config.defines.get("hlgen.makefile");
		var cmf = config.defines.get("hlgen.cmakefile");
		if (cmf != null){
			generatecmakefile(cmf);
		}
		if( tpl != null )
			generateTemplates(tpl);
		// if( config.defines.get("hlgen.silent") == null )
		// 	Sys.println("Code generated in "+output+" automatic native compilation not yet implemented");
	}
	
	function generatecmakefile(path:String) {
		var builder = new StringBuf();

		var c_files = [for( f in config.files ) if( StringTools.endsWith(f,".c") ) f];
		
		builder.add("# This file is automatically generated by hlc\n");
		builder.add("cmake_minimum_required(VERSION 3.10)\n");
		builder.add("project("+name+" C CXX)\n");
		builder.add("set(CMAKE_CXX_STANDARD 17)\n");
		
		builder.add("cmake_policy(SET CMP0015 NEW)\n");
		builder.add("cmake_policy(SET CMP0091 NEW)\n");

		builder.add('add_executable(${name}');

		for( f in c_files ) {
			builder.add(' "'+f+'"');
		}
		builder.add(')\n');

		builder.add("SET(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -DHL_MAKE )\n");
		builder.add("SET(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -DHL_MAKE )\n");

		var cmakeRoot = "${CMAKE_CURRENT_SOURCE_DIR}";

		builder.add('target_include_directories(${name} PRIVATE /opt/homebrew/include ${cmakeRoot})\n');
		builder.add('set(CMAKE_IGNORE_PATH)\n');
		builder.add('find_library(LIBHL NAMES hl PATHS /usr/local/lib NO_DEFAULT_PATH)\n');
		builder.add('find_library(LIBUV NAMES libuv.a PATHS /opt/homebrew/lib NO_DEFAULT_PATH)\n');
		
		var HL_LIBS_NAMES = ["uv", "ui", "fmt", "sdl", "openal", "ssl"];
		var HL_LIBS_ARRAY = [for( l in HL_LIBS_NAMES ) '/usr/local/lib/${l}.hdll'];
		var HL_LIBS = HL_LIBS_ARRAY.join(" ");

		var PROJECT_HDLL_NAMES = ["recast"];
		var PROJECT_HDLL_ARRAY = [for( l in PROJECT_HDLL_NAMES ) "${CMAKE_CURRENT_SOURCE_DIR}" + '/../../${l}.hdll'];
		var PROJECT_HDLL = PROJECT_HDLL_ARRAY.join(" ");


		var libhl = "${LIBHL} ${LIBUV}";
		builder.add('target_link_libraries(${name} ${libhl} ${HL_LIBS} ${PROJECT_HDLL})\n');



		//builder.add('target_include_directories(${name} PRIVATE /opt/homebrew/include ${cmakeRoot})\n');

		// link_directories(${PROJECT_LIB_NAME}
		// 	#${TARGET_LIB_DIR}
		// 	${LOCAL_LIB}
		// 	)
			
		// 	set(ALL_LIBS 
		// 	${TARGET_LIBS}
		// 	${PROJECT_ADDITIONAL_LIBS}
		// 	)
			
			


		Sys.println('Generating cmake file at '+path);
		sys.io.File.saveContent(path, builder.toString());
	}
	function isAscii( bytes : haxe.io.Bytes ) {
		// BOM CHECK
		if( bytes.length > 3 && bytes.get(0) == 0xEF && bytes.get(1) == 0xBB && bytes.get(2) == 0xBF )
			return true;
		var i = 0;
		var len = bytes.length;
		while( i < len ) {
			var c = bytes.get(i++);
			if( c == 0 || c >= 0x80 ) return false;			
		}
		return true;
	}

	function generateTemplates( ?tpl ) {
		if( tpl == null || tpl == "1" )
			tpl = "vs2015";
		var srcDir = tpl;
		var targetDir = config.defines.get("hlgen.makefilepath");
		var relDir = "";
		if( targetDir == null )
			targetDir = this.targetDir;
		else {
			if( !StringTools.endsWith(targetDir,"/") && !StringTools.endsWith(targetDir,"\\") )
				targetDir += "/";
			var targetAbs = sys.FileSystem.absolutePath(targetDir);
			var currentAbs = sys.FileSystem.absolutePath(this.targetDir);
			if( !StringTools.startsWith(currentAbs, targetAbs+"/") )
				relDir = currentAbs+"/"; // absolute
			else 
				relDir = currentAbs.substr(targetAbs.length+1);
			relDir = relDir.split("\\").join("/");
			if( relDir != "" )
				relDir += "/";
		}
		if( !sys.FileSystem.exists(srcDir) ) {
			srcDir = dataPath + "templates/"+tpl;
			if( !sys.FileSystem.exists(srcDir) )
				throw "Failed to find make template '"+tpl+"'";
		}
		
		var allFiles = config.files.copy();
		for( f in config.files )
			if( StringTools.endsWith(f,".c") ) {
				var h = f.substr(0,-2) + ".h";
				if( sys.FileSystem.exists(targetDir+h) )
					allFiles.push(h);
			}
		allFiles.sort(Reflect.compare);

		var files = [for( f in allFiles ) { path : f, directory : new haxe.io.Path(f).dir }];
		var directories = new Map();
		for( f in files )
			if( f.directory != null )
				directories.set(f.directory, true);
		for( k in directories.keys() ) {
			var dir = k.split("/");
			dir.pop();
			while( dir.length > 0 ) {
				var p = dir.join("/");
				directories.set(p, true);
				dir.pop();
			}
		}

		var directories = [for( k in directories.keys() ) { path : k }];
		directories.sort(function(a,b) return Reflect.compare(a.path,b.path));
		
		function genRec( path : String ) {
			var dir = srcDir + "/" + path;
			for( f in sys.FileSystem.readDirectory(dir) ) {
				var srcPath = dir + "/" + f;
				var parts = f.split(".");
				var isBin = parts[parts.length-2] == "bin"; // .bin.xxx file
				var isOnce = isBin || parts[parts.length-2] == "once"; // .once.xxxx file - don't overwrite existing
				var f = (isBin || isOnce) ? { parts.splice(parts.length-2,1); parts.join("."); } : f;
				var targetPath = targetDir + path + "/" + f.split("__file__").join(name);
				if( sys.FileSystem.isDirectory(srcPath) ) {
					try sys.FileSystem.createDirectory(targetPath) catch( e : Dynamic ) {};
					genRec(path+"/"+f);
					continue;
				}
				var bytes = sys.io.File.getBytes(srcPath);
				if( !isAscii(bytes) ) {
					isBin = true;
					isOnce = true;
				}
				if( isOnce && sys.FileSystem.exists(targetPath) )
					continue;
				if( isBin ) {
					sys.io.File.copy(srcPath,targetPath);
					continue;
				}
				var content = sys.io.File.getContent(srcPath);
				var tpl = new haxe.Template(content);
				content = tpl.execute({
					name : this.name,
					libraries : [for( l in config.libs ) if( l != "std" ) { name : l }],
					files : files,
					relDir : relDir,
					directories : directories,
					cfiles : [for( f in files ) if( StringTools.endsWith(f.path,".c") ) f],
					hfiles : [for( f in files ) if( StringTools.endsWith(f.path,".h") ) f],
				},{
					makeUID : function(_,s:String) {
						var sha1 = haxe.crypto.Sha1.encode(s);
						sha1 = sha1.toUpperCase();
						return sha1.substr(0,8)+"-"+sha1.substr(8,4)+"-"+sha1.substr(12,4)+"-"+sha1.substr(16,4)+"-"+sha1.substr(20,12);
					},
					makePath : function(_,dir:String) {
						return dir == "" ? "./" : (StringTools.endsWith(dir,"/") || StringTools.endsWith(dir,"\\")) ? dir : dir + "/";
					},
					upper : function(_,s:String) {
						return s.charAt(0).toUpperCase() + s.substr(1);
					},
					winPath : function(_,s:String) return s.split("/").join("\\"),
					getEnv : function(_,s:String) return Sys.getEnv(s),
				});
				var prevContent = try sys.io.File.getContent(targetPath) catch( e : Dynamic ) null;
				if( prevContent != content )
					sys.io.File.saveContent(targetPath, content);
			}
		}
		genRec(".");
	}

}

class Run {
	static function main() {
		var args = Sys.args();
		var originalPath = args.pop();
		var haxelibPath = Sys.getCwd()+"/";
		Sys.setCwd(originalPath);
		
		switch( args.shift() ) {
		case "build":
			var output = args.shift();
			var path = new haxe.io.Path(output);
			path.file = "hlc";
			path.ext = "json";
			var config = haxe.Json.parse(sys.io.File.getContent(path.toString()));
			new Build(haxelibPath,output,config).run();
		case "run":
			var output = args.shift();
			if( StringTools.endsWith(output,".c") ) return;			
			Sys.command("hl "+output);
		case cmd:
			Sys.println("Unknown command "+cmd);
			Sys.exit(1);
		}
	}
}