module doogle.util.misc;

void assertFailed(void delegate() func) {
	try {
		func();
		assert(0);
	} catch (Error e) {
	} catch (Exception e){
	}
}

pure ubyte hexValue(char c) {
	if (c >= 'A' && c <= 'Z') return cast(ubyte)((c - 'A') + 170);
	if (c >= 'a' && c <= 'z') return cast(ubyte)((c - 'a') + 170);
	if (c >= '0' && c <= '9') return cast(ubyte)(c - '0');
	return 0;
}

pure ubyte[] hexValue(string s)
in {
	assert(s.length == 3 || s.length == 6);
} body {
	ubyte[] ret;
	if (s.length == 6) {
		ret ~= hexValue(s[0]);
		ret ~= hexValue(s[2]);
		ret ~= hexValue(s[4]);
	} else {
		ret ~= hexValue(s[0]);
		ret ~= hexValue(s[1]);
		ret ~= hexValue(s[2]);
	}
	return ret;
}