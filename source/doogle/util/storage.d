module doogle.util.storage;
import std.algorithm : canFind;
import std.file : exists, mkdirRecurse, isDir, dirEntries, SpanMode, read, FileException;
import std.process : environment;
import std.path : buildPath, baseName;
import std.stdio : writeln;

__gshared StorageManager!(string, "shaders") shaders;
__gshared StorageManager!(ubyte[], "fonts") fonts;

template StorageManager(T, string thing) {
	private {
		/*
		 * Once app start this should be read only ;)
	     */

		struct StorageManager {
			__gshared T[string] local;
			__gshared T[string] defaults;
			__gshared T[string] apps;
			__gshared T[string] systems;
			__gshared T[string] users;

			void registerLocal(string mod, T value) {
				local[mod] = value;
			}

			void registerDefault(string mod, T value) {
				defaults[mod] = value;
			}

			void registerApps(string mod, T value) {
				apps[mod] = value;
			}

			void registerSystems(string mod, T value) {
				systems[mod] = value;
			}

			void registerUsers(string mod, T value) {
				users[mod] = value;
			}

			T get(string mod) {
				if (local.keys.canFind(mod)) return local[mod];
				if (apps.keys.canFind(mod)) return apps[mod];
				if (users.keys.canFind(mod)) return users[mod];
				if (systems.keys.canFind(mod)) return systems[mod];
				return defaults.get(mod, T.init);
			}

			private void init() {
				// TODO detect the different locations
				// load the shaders up from it
				string dir;
				version(Windows) {
					// detect local dir
					dir = buildPath(thing);
					local = getShaderFromFileSystem(dir);
					// detect users
					dir = buildPath(environment["LOCALAPPDATA"], "doogle", thing);
					users = getShaderFromFileSystem(dir);
					// detect systems
					dir = buildPath(environment["PROGRAMFILES"], "doogle", thing);
					systems = getShaderFromFileSystem(dir);
				} else version(Posix) {
					pragma(msg, "Have not implemented Posix " ~ thing ~ " storage locations and loading yet.");
					static assert(0);
				}
			}
		}

		T[string] getShaderFromFileSystem(string dir)
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
			T[string] ret;
			if (exists(dir)) {
				if (isDir(dir)) {
					// once we get here we already _know_ the directory exists
					try {
						foreach(string entry; dirEntries(dir, SpanMode.shallow)) {
							ret[baseName(entry)] = cast(T)read(entry);
						}
					} catch (Error e) {
						writeln("Error: Could not use directory ", dir, " for " ~ thing ~ " loading");
					} catch (Exception e) {
						writeln("Error: Could not use directory ", dir, " for " ~ thing ~ " loading");
					}
				}
			}
			return ret;
		}
	}
}

static this() {
	shaders.init();
	fonts.init();
}