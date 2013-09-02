module doogle.util.misc;

void assertFailed(void delegate() func) {
	try {
		func();
		assert(0);
	} catch (Error e) {
	} catch (Exception e){
	}
}