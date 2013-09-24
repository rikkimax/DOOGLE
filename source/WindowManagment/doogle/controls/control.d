module doogle.controls.control;

static if (__traits(compiles, {import doogle.controls.control_standard;})) {
	public import doogle.controls.control_standard;
	alias Control_Standard Control;
} else {
	pragma(msg, "Control implementation is not implemented");
	static assert(0);
}

shared class Control_Def {

}