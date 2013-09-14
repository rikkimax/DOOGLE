gcc windows.c -E -P > $1

echo $1 > temp
sed -i 's/.[a-zA-Z]$//g' temp
sed -i 's/\//./g' temp
module=`cat temp`

echo $1 > temp
sed -i 's/\//\\\//g' temp
fileDash=`cat temp`

rm temp

echo "Using module $module"

echo "Output file $1"
cp $1 $1.orig

grep -v "#pragma.*" $1.orig > $1
cp $1 $1.temp
grep -v "__dllimport__" $1.temp > $1
cp $1 $1.temp
grep -v "__gnuc" $1.temp > $1
cp $1 $1.temp
grep -v "vector_size__" $1.temp > $1
cp $1 $1.temp
grep -v "__m128" $1.temp > $1

sed -i 's/, /,/g' $1

sed -i 's/__extension__//g' $1
sed -i 's/__inline__//g' $1
sed -i 's/__inline//g' $1
sed -i 's/__volatile__//g' $1
sed -i 's/__restrict__//g' $1

sed -i 's/__attribute__[ ]*((__aligned__[ ]*(16)))//g' $1
sed -i 's/__attribute__[ ]*\([(__cdecl__)(__always_inline__)(__artificial__)(__gnu_inline__)(__returns_twice__)(__nothrow__)(__dllimport__),]*\)//g' $1

sed -i 's/align)/align_)/g' $1

sed -i '/^[ \t]*$/d' $1

sed -i 's/typedef EXCEPTION_DISPOSITION ( \*PEXCEPTION_ROUTINE)/typedef struct EXCEPTION_DISPOSITION\* PEXCEPTION_ROUTINE;/g' $1
sed -i 's/(PEXCEPTION_RECORD ExceptionRecord,/typedef struct PEXCEPTION_RECORD ExceptionRecord;/g' $1
sed -i 's/ULONG64 EstablisherFrame,/typedef ULONG64 EstablisherFrame;/g' $1
sed -i 's/PCONTEXT ContextRecord,/typedef struct PCONTEXT ContextRecord;/g' $1;

sed -i 's/(typedef struct PCONTEXT ContextRecord;/(PCONTEXT ContextRecord,/g' $1;
sed -i 's/,typedef struct PCONTEXT ContextRecord;PVOID/,PCONTEXT ContextRecord,PVOID/g' $1
sed -i 's/Ptypedef ULONG64 EstablisherFrame;PKNONVOLATILE_CONTEXT_POINTERS/PULONG64 EstablisherFrame,PKNONVOLATILE_CONTEXT_POINTERS/g' $1

sed -i 's/PDISPATCHER_CONTEXT DispatcherContext);/typedef struct PDISPATCHER_CONTEXT DispatcherContext;/g' $1

./htod $1 $1.d

sed -i 's/C func(/function(/g' $1.d
sed -i 's/ in)/)/g' $1.d
sed -i 's/alias ubyte byte;//g' $1.d
sed -i 's/BSTR version,/BSTR version_,/g' $1.d
sed -i "s/module $fileDash;/module $module;/g" $1.d

sed -i 's/lconv \*lconv;/struct lconv_;lconv_ \*lconv;/g' $1.d
sed -i 's/__lc_time_data \*lc_time_curr;/struct __lc_time_data; __lc_time_data \*lc_time_curr;/g' $1.d

sed -i 's/alias IDispatch \*LPDISPATCH;//g' $1.d
echo 'alias IDispatch *LPDISPATCH;' >> $1.d
sed -i 's/alias ITypeComp \*LPTYPECOMP;//g' $1.d
echo 'alias ITypeComp *LPTYPECOMP;' >> $1.d
sed -i 's/alias ITypeInfo \*LPTYPEINFO;//g' $1.d
echo 'alias ITypeInfo *LPTYPEINFO;' >> $1.d
sed -i 's/alias ITypeLib \*LPTYPELIB;//g' $1.d
echo 'alias ITypeLib *LPTYPELIB;' >> $1.d

sed -i 's/    DWORD RatePercent(DWORD value) { ( 0xffffffffffffff80) | (value << 0); return value; }//g' $1.d
sed -i 's/    DWORD Reserved0(DWORD value) { ( 0xffffffff0000007f) | (value << 7); return value; }//g' $1.d

sed -i 's/(...)/()/g' $1.d

sed -i 's/extern (C):/extern (System):/g' $1.d

sed -i 's/(Ê@H >> 0) & //g' $1.d
sed -i 's/Ê@H = (Ê@H &/(/g' $1.d
sed -i 's/(Ê@H >> 31) & //g' $1.d
sed -i 's/(Ê@H >> 7) & //g' $1.d

echo 'struct threadmbcinfostruct;' >> $1.d
echo 'struct EXCEPTION_DISPOSITION;' >> $1.d
echo 'struct _EXCEPTION_REGISTRATION_RECORD;' >> $1.d
echo 'struct _TEB;' >> $1.d
echo 'struct _NDR_ASYNC_MESSAGE;' >> $1.d
echo 'struct _NDR_CORRELATION_INFO;' >> $1.d
echo 'struct NDR_ALLOC_ALL_NODES_CONTEXT;' >> $1.d
echo 'struct NDR_POINTER_QUEUE_STATE;' >> $1.d
echo 'struct _NDR_PROC_CONTEXT;' >> $1.d
echo 'struct _PSP;' >> $1.d

cp $1.d $1.temp
grep -v '(DWORD value) { __bitfield1 = ' $1.temp > $1.d
cp $1.d $1.temp
grep -v '__bitfield1 = (__bitfield1' $1.temp > $1.d
cp $1.d $1.temp
grep -v '(DWORD value) { ( 0x[a-fA-F0-9]*) | ' $1.temp > $1.d

gcc test.c -E -P -dM > $1.temp
cat $1.temp | awk '/__MSABI_LONG\(.*\)/{gsub(/\/\/ C[ ]*/, "");gsub(/#define/, "const");gsub(/__MSABI_LONG\(/, "=");gsub(/\)$/, ";");print;}' >> $1.d

cp $1.d $1.temp
grep -v "^[ ]*const.*(.*)" $1.temp > $1.d
cp $1.d $1.temp
grep -v "const =x)" $1.temp > $1.d

rm $1.temp