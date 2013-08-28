module doogle.util.shaderstorage;
import std.algorithm : canFind;

protected {
	string[string] shaderDefaults;
	string[string] shaderApps;
	string[string] shaderSystems;
	string[string] shaderUsers;
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