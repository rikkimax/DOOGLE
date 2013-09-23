module doogle.util.shaderstorage;
import std.algorithm : canFind;
import std.file : exists, mkdirRecurse, isDir, dirEntries, SpanMode, read, FileException;
import std.process : environment;
import std.path : buildPath, baseName;
import std.stdio : writeln;

protected {
	/*
	 * Once app start this should be read only ;)
     */

	__gshared string[string] shaderDefaults;
	__gshared string[string] shaderApps;
	__gshared string[string] shaderSystems;
	__gshared string[string] shaderUsers;
}

struct ShaderStorage {
	void registerDefault(string mod, string shader) {
		shaderDefaults[mod] = shader;
	}

	void registerApps(string mod, string shader) {
		shaderApps[mod] = shader;
	}

	void registerSystems(string mod, string shader) {
		shaderSystems[mod] = shader;
	}

	string get(string mod) {
		if (shaderApps.keys.canFind(mod)) return shaderApps[mod];
		if (shaderUsers.keys.canFind(mod)) return shaderUsers[mod];
		if (shaderSystems.keys.canFind(mod)) return shaderSystems[mod];
		return shaderDefaults.get(mod, "");
	}

	void init() {
		// TODO detect the different locations
		// load the shaders up from it
		string dir;
		version(Windows) {
			// detect users
			dir = buildPath(environment["LOCALAPPDATA"], "doogle", "shaders");
			shaderUsers = getShaderFromFileSystem(dir);
			// detect systems
			dir = buildPath(environment["PROGRAMFILES"], "doogle", "shaders");
			shaderSystems = getShaderFromFileSystem(dir);
		} else version(Posix) {
			pragma(msg, "Have not implemented Posix shader storage locations and loading yet.");
			static assert(0);
		}
	}
}

__gshared ShaderStorage shaderStorage;

unittest {
	shaderStorage.registerDefault(__MODULE__, """
test hi :)
""");
	assert(shaderStorage.get(__MODULE__) == """
test hi :)
""");
}

private {
	string[string] getShaderFromFileSystem(string dir)
	in {
		if (exists(dir)) {
			if (isDir(dir)) {
				// directory exists.
			} else {
				// not a directory
				try {
					mkdirRecurse(dir);
				} catch (Error e) {
				} catch (Exception e) {
				}
			}
		} else {
			try {
				// does not exist
				mkdirRecurse(dir);
			} catch (Error e) {
			} catch (Exception e) {
			}
		}
	} body {
		string[string] ret;
		if (exists(dir)) {
			if (isDir(dir)) {
				// once we get here we already _know_ the directory exists
				try {
					foreach(string entry; dirEntries(dir, SpanMode.shallow)) {
						ret[baseName(entry)] = cast(string)read(entry);
					}
				} catch (Error e) {
					writeln("Error: Could not use directory ", dir, " for shader loading");
				} catch (Exception e) {
					writeln("Error: Could not use directory ", dir, " for shader loading");
				}
			}
		}
		return ret;
	}
}