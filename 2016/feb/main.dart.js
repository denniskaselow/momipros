(function(){var supportsDirectProtoAccess=function(){var z=function(){}
z.prototype={p:{}}
var y=new z()
return y.__proto__&&y.__proto__.p===z.prototype.p}()
function map(a){a=Object.create(null)
a.x=0
delete a.x
return a}var A=map()
var B=map()
var C=map()
var D=map()
var E=map()
var F=map()
var G=map()
var H=map()
var J=map()
var K=map()
var L=map()
var M=map()
var N=map()
var O=map()
var P=map()
var Q=map()
var R=map()
var S=map()
var T=map()
var U=map()
var V=map()
var W=map()
var X=map()
var Y=map()
var Z=map()
function I(){}init()
function setupProgram(a,b){"use strict"
function generateAccessor(a9,b0,b1){var g=a9.split("-")
var f=g[0]
var e=f.length
var d=f.charCodeAt(e-1)
var c
if(g.length>1)c=true
else c=false
d=d>=60&&d<=64?d-59:d>=123&&d<=126?d-117:d>=37&&d<=43?d-27:0
if(d){var a0=d&3
var a1=d>>2
var a2=f=f.substring(0,e-1)
var a3=f.indexOf(":")
if(a3>0){a2=f.substring(0,a3)
f=f.substring(a3+1)}if(a0){var a4=a0&2?"r":""
var a5=a0&1?"this":"r"
var a6="return "+a5+"."+f
var a7=b1+".prototype.g"+a2+"="
var a8="function("+a4+"){"+a6+"}"
if(c)b0.push(a7+"$reflectable("+a8+");\n")
else b0.push(a7+a8+";\n")}if(a1){var a4=a1&2?"r,v":"v"
var a5=a1&1?"this":"r"
var a6=a5+"."+f+"=v"
var a7=b1+".prototype.s"+a2+"="
var a8="function("+a4+"){"+a6+"}"
if(c)b0.push(a7+"$reflectable("+a8+");\n")
else b0.push(a7+a8+";\n")}}return f}function defineClass(a1,a2){var g=[]
var f="function "+a1+"("
var e=""
for(var d=0;d<a2.length;d++){if(d!=0)f+=", "
var c=generateAccessor(a2[d],g,a1)
var a0="p_"+c
f+=a0
e+="this."+c+" = "+a0+";\n"}if(supportsDirectProtoAccess)e+="this."+"$deferredAction"+"();"
f+=") {\n"+e+"}\n"
f+=a1+".builtin$cls=\""+a1+"\";\n"
f+="$desc=$collectedClasses."+a1+"[1];\n"
f+=a1+".prototype = $desc;\n"
if(typeof defineClass.name!="string")f+=a1+".name=\""+a1+"\";\n"
f+=g.join("")
return f}var z=supportsDirectProtoAccess?function(c,d){var g=c.prototype
g.__proto__=d.prototype
g.constructor=c
g["$is"+c.name]=c
return convertToFastObject(g)}:function(){function tmp(){}return function(a0,a1){tmp.prototype=a1.prototype
var g=new tmp()
convertToSlowObject(g)
var f=a0.prototype
var e=Object.keys(f)
for(var d=0;d<e.length;d++){var c=e[d]
g[c]=f[c]}g["$is"+a0.name]=a0
g.constructor=a0
a0.prototype=g
return g}}()
function finishClasses(a4){var g=init.allClasses
a4.combinedConstructorFunction+="return [\n"+a4.constructorsList.join(",\n  ")+"\n]"
var f=new Function("$collectedClasses",a4.combinedConstructorFunction)(a4.collected)
a4.combinedConstructorFunction=null
for(var e=0;e<f.length;e++){var d=f[e]
var c=d.name
var a0=a4.collected[c]
var a1=a0[0]
a0=a0[1]
g[c]=d
a1[c]=d}f=null
var a2=init.finishedClasses
function finishClass(c1){if(a2[c1])return
a2[c1]=true
var a5=a4.pending[c1]
if(a5&&a5.indexOf("+")>0){var a6=a5.split("+")
a5=a6[0]
var a7=a6[1]
finishClass(a7)
var a8=g[a7]
var a9=a8.prototype
var b0=g[c1].prototype
var b1=Object.keys(a9)
for(var b2=0;b2<b1.length;b2++){var b3=b1[b2]
if(!u.call(b0,b3))b0[b3]=a9[b3]}}if(!a5||typeof a5!="string"){var b4=g[c1]
var b5=b4.prototype
b5.constructor=b4
b5.$isb=b4
b5.$deferredAction=function(){}
return}finishClass(a5)
var b6=g[a5]
if(!b6)b6=existingIsolateProperties[a5]
var b4=g[c1]
var b5=z(b4,b6)
if(a9)b5.$deferredAction=mixinDeferredActionHelper(a9,b5)
if(Object.prototype.hasOwnProperty.call(b5,"%")){var b7=b5["%"].split(";")
if(b7[0]){var b8=b7[0].split("|")
for(var b2=0;b2<b8.length;b2++){init.interceptorsByTag[b8[b2]]=b4
init.leafTags[b8[b2]]=true}}if(b7[1]){b8=b7[1].split("|")
if(b7[2]){var b9=b7[2].split("|")
for(var b2=0;b2<b9.length;b2++){var c0=g[b9[b2]]
c0.$nativeSuperclassTag=b8[0]}}for(b2=0;b2<b8.length;b2++){init.interceptorsByTag[b8[b2]]=b4
init.leafTags[b8[b2]]=false}}b5.$deferredAction()}if(b5.$isd)b5.$deferredAction()}var a3=Object.keys(a4.pending)
for(var e=0;e<a3.length;e++)finishClass(a3[e])}function finishAddStubsHelper(){var g=this
while(!g.hasOwnProperty("$deferredAction"))g=g.__proto__
delete g.$deferredAction
var f=Object.keys(g)
for(var e=0;e<f.length;e++){var d=f[e]
var c=d.charCodeAt(0)
var a0
if(d!=="^"&&d!=="$reflectable"&&c!==43&&c!==42&&(a0=g[d])!=null&&a0.constructor===Array&&d!=="<>")addStubs(g,a0,d,false,[])}convertToFastObject(g)
g=g.__proto__
g.$deferredAction()}function mixinDeferredActionHelper(c,d){var g
if(d.hasOwnProperty("$deferredAction"))g=d.$deferredAction
return function foo(){var f=this
while(!f.hasOwnProperty("$deferredAction"))f=f.__proto__
if(g)f.$deferredAction=g
else{delete f.$deferredAction
convertToFastObject(f)}c.$deferredAction()
f.$deferredAction()}}function processClassData(b1,b2,b3){b2=convertToSlowObject(b2)
var g
var f=Object.keys(b2)
var e=false
var d=supportsDirectProtoAccess&&b1!="b"
for(var c=0;c<f.length;c++){var a0=f[c]
var a1=a0.charCodeAt(0)
if(a0==="j"){processStatics(init.statics[b1]=b2.j,b3)
delete b2.j}else if(a1===43){w[g]=a0.substring(1)
var a2=b2[a0]
if(a2>0)b2[g].$reflectable=a2}else if(a1===42){b2[g].$defaultValues=b2[a0]
var a3=b2.$methodsWithOptionalArguments
if(!a3)b2.$methodsWithOptionalArguments=a3={}
a3[a0]=g}else{var a4=b2[a0]
if(a0!=="^"&&a4!=null&&a4.constructor===Array&&a0!=="<>")if(d)e=true
else addStubs(b2,a4,a0,false,[])
else g=a0}}if(e)b2.$deferredAction=finishAddStubsHelper
var a5=b2["^"],a6,a7,a8=a5
var a9=a8.split(";")
a8=a9[1]?a9[1].split(","):[]
a7=a9[0]
a6=a7.split(":")
if(a6.length==2){a7=a6[0]
var b0=a6[1]
if(b0)b2.$signature=function(b4){return function(){return init.types[b4]}}(b0)}if(a7)b3.pending[b1]=a7
b3.combinedConstructorFunction+=defineClass(b1,a8)
b3.constructorsList.push(b1)
b3.collected[b1]=[m,b2]
i.push(b1)}function processStatics(a3,a4){var g=Object.keys(a3)
for(var f=0;f<g.length;f++){var e=g[f]
if(e==="^")continue
var d=a3[e]
var c=e.charCodeAt(0)
var a0
if(c===43){v[a0]=e.substring(1)
var a1=a3[e]
if(a1>0)a3[a0].$reflectable=a1
if(d&&d.length)init.typeInformation[a0]=d}else if(c===42){m[a0].$defaultValues=d
var a2=a3.$methodsWithOptionalArguments
if(!a2)a3.$methodsWithOptionalArguments=a2={}
a2[e]=a0}else if(typeof d==="function"){m[a0=e]=d
h.push(e)
init.globalFunctions[e]=d}else if(d.constructor===Array)addStubs(m,d,e,true,h)
else{a0=e
processClassData(e,d,a4)}}}function addStubs(b6,b7,b8,b9,c0){var g=0,f=b7[g],e
if(typeof f=="string")e=b7[++g]
else{e=f
f=b8}var d=[b6[b8]=b6[f]=e]
e.$stubName=b8
c0.push(b8)
for(g++;g<b7.length;g++){e=b7[g]
if(typeof e!="function")break
if(!b9)e.$stubName=b7[++g]
d.push(e)
if(e.$stubName){b6[e.$stubName]=e
c0.push(e.$stubName)}}for(var c=0;c<d.length;g++,c++)d[c].$callName=b7[g]
var a0=b7[g]
b7=b7.slice(++g)
var a1=b7[0]
var a2=a1>>1
var a3=(a1&1)===1
var a4=a1===3
var a5=a1===1
var a6=b7[1]
var a7=a6>>1
var a8=(a6&1)===1
var a9=a2+a7!=d[0].length
var b0=b7[2]
if(typeof b0=="number")b7[2]=b0+b
var b1=2*a7+a2+3
if(a0){e=tearOff(d,b7,b9,b8,a9)
b6[b8].$getter=e
e.$getterStub=true
if(b9){init.globalFunctions[b8]=e
c0.push(a0)}b6[a0]=e
d.push(e)
e.$stubName=a0
e.$callName=null}var b2=b7.length>b1
if(b2){d[0].$reflectable=1
d[0].$reflectionInfo=b7
for(var c=1;c<d.length;c++){d[c].$reflectable=2
d[c].$reflectionInfo=b7}var b3=b9?init.mangledGlobalNames:init.mangledNames
var b4=b7[b1]
var b5=b4
if(a0)b3[a0]=b5
if(a4)b5+="="
else if(!a5)b5+=":"+(a2+a7)
b3[b8]=b5
d[0].$reflectionName=b5
d[0].$metadataIndex=b1+1
if(a7)b6[b4+"*"]=d[0]}}Function.prototype.$1=function(c){return this(c)}
Function.prototype.$0=function(){return this()}
Function.prototype.$2=function(c,d){return this(c,d)}
Function.prototype.$3=function(c,d,e){return this(c,d,e)}
Function.prototype.$4=function(c,d,e,f){return this(c,d,e,f)}
function tearOffGetter(c,d,e,f){return f?new Function("funcs","reflectionInfo","name","H","c","return function tearOff_"+e+y+++"(x) {"+"if (c === null) c = "+"H.Y"+"("+"this, funcs, reflectionInfo, false, [x], name);"+"return new c(this, funcs[0], x, name);"+"}")(c,d,e,H,null):new Function("funcs","reflectionInfo","name","H","c","return function tearOff_"+e+y+++"() {"+"if (c === null) c = "+"H.Y"+"("+"this, funcs, reflectionInfo, false, [], name);"+"return new c(this, funcs[0], null, name);"+"}")(c,d,e,H,null)}function tearOff(c,d,e,f,a0){var g
return e?function(){if(g===void 0)g=H.Y(this,c,d,true,[],f).prototype
return g}:tearOffGetter(c,d,f,a0)}var y=0
if(!init.libraries)init.libraries=[]
if(!init.mangledNames)init.mangledNames=map()
if(!init.mangledGlobalNames)init.mangledGlobalNames=map()
if(!init.statics)init.statics=map()
if(!init.typeInformation)init.typeInformation=map()
if(!init.globalFunctions)init.globalFunctions=map()
var x=init.libraries
var w=init.mangledNames
var v=init.mangledGlobalNames
var u=Object.prototype.hasOwnProperty
var t=a.length
var s=map()
s.collected=map()
s.pending=map()
s.constructorsList=[]
s.combinedConstructorFunction="function $reflectable(fn){fn.$reflectable=1;return fn};\n"+"var $desc;\n"
for(var r=0;r<t;r++){var q=a[r]
var p=q[0]
var o=q[1]
var n=q[2]
var m=q[3]
var l=q[4]
var k=!!q[5]
var j=l&&l["^"]
if(j instanceof Array)j=j[0]
var i=[]
var h=[]
processStatics(l,s)
x.push([p,o,i,h,n,j,k,m])}finishClasses(s)}I.az=function(){}
var dart=[["","",,H,{"^":"",cl:{"^":"b;p:a>"}}],["","",,J,{"^":"",
i:function(a){return void 0},
O:function(a,b,c,d){return{i:a,p:b,e:c,x:d}},
a_:function(a){var z,y,x,w
z=a[init.dispatchPropertyName]
if(z==null)if($.a1==null){H.bQ()
z=a[init.dispatchPropertyName]}if(z!=null){y=z.p
if(!1===y)return z.i
if(!0===y)return a
x=Object.getPrototypeOf(a)
if(y===x)return z.i
if(z.e===x)throw H.c(new P.av("Return interceptor for "+H.a(y(a,z))))}w=H.bY(a)
if(w==null){if(typeof a=="function")return C.p
y=Object.getPrototypeOf(a)
if(y==null||y===Object.prototype)return C.r
else return C.u}return w},
d:{"^":"b;",
u:function(a,b){return a===b},
gl:function(a){return H.m(a)},
h:["V",function(a){return H.G(a)}],
F:["U",function(a,b){throw H.c(P.ac(a,b.gM(),b.gO(),b.gN(),null))}],
$isb0:1,
$isbp:1,
"%":"Navigator|SVGAnimatedLength|SVGAnimatedNumberList"},
b6:{"^":"d;",
h:function(a){return String(a)},
gl:function(a){return a?519018:218159},
$isbG:1},
b9:{"^":"d;",
u:function(a,b){return null==b},
h:function(a){return"null"},
gl:function(a){return 0},
F:function(a,b){return this.U(a,b)}},
h:{"^":"d;",
gl:function(a){return 0},
h:["W",function(a){return String(a)}],
gi:function(a){return a.message},
ga1:function(a){return a.codeResult},
gp:function(a){return a.code}},
bk:{"^":"h;"},
v:{"^":"h;"},
F:{"^":"h;",
h:function(a){var z=a[$.$get$C()]
return z==null?this.W(a):J.A(z)}},
u:{"^":"d;",
J:function(a,b){if(!!a.fixed$length)throw H.c(new P.bx(b))},
a0:function(a,b){this.J(a,"add")
a.push(b)},
I:function(a,b){var z
this.J(a,"addAll")
for(z=J.a4(b);z.v();)a.push(z.gK())},
q:function(a,b){var z,y
z=a.length
for(y=0;y<z;++y){b.$1(a[y])
if(a.length!==z)throw H.c(new P.S(a))}},
h:function(a){return P.b5(a,"[","]")},
ga6:function(a){return new J.a6(a,a.length,0,null)},
gl:function(a){return H.m(a)},
gn:function(a){return a.length},
$isV:1},
ck:{"^":"u;"},
a6:{"^":"b;a,b,c,d",
gK:function(){return this.d},
v:function(){var z,y,x
z=this.a
y=z.length
if(this.b!==y)throw H.c(H.c2(z))
x=this.c
if(x>=y){this.d=null
return!1}this.d=z[x]
this.c=x+1
return!0}},
D:{"^":"d;",
h:function(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gl:function(a){return a&0x1FFFFFFF},
t:function(a,b){if(typeof b!=="number")throw H.c(H.q(b))
return a+b},
a_:function(a,b){var z
if(a>0)z=b>31?0:a>>>b
else{z=b>31?31:b
z=a>>z>>>0}return z},
w:function(a,b){if(typeof b!=="number")throw H.c(H.q(b))
return a<b},
$isy:1},
aa:{"^":"D;",$isy:1,$isaH:1},
b7:{"^":"D;",$isy:1},
E:{"^":"d;",
a2:function(a,b){if(b>=a.length)throw H.c(H.ay(a,b))
return a.charCodeAt(b)},
t:function(a,b){if(typeof b!=="string")throw H.c(P.aO(b,null,null))
return a+b},
T:function(a,b,c){if(typeof b!=="number"||Math.floor(b)!==b)H.aF(H.q(b))
if(c==null)c=a.length
if(typeof c!=="number"||Math.floor(c)!==c)H.aF(H.q(c))
if(typeof b!=="number")return b.w()
if(b<0)throw H.c(P.H(b,null,null))
if(typeof c!=="number")return H.L(c)
if(b>c)throw H.c(P.H(b,null,null))
if(c>a.length)throw H.c(P.H(c,null,null))
return a.substring(b,c)},
S:function(a,b){return this.T(a,b,null)},
h:function(a){return a},
gl:function(a){var z,y,x
for(z=a.length,y=0,x=0;x<z;++x){y=536870911&y+a.charCodeAt(x)
y=536870911&y+((524287&y)<<10>>>0)
y^=y>>6}y=536870911&y+((67108863&y)<<3>>>0)
y^=y>>11
return 536870911&y+((16383&y)<<15>>>0)},
gn:function(a){return a.length},
$isbs:1}}],["","",,H,{"^":"",
bL:function(a){return init.types[a]},
a:function(a){var z
if(typeof a==="string")return a
if(typeof a==="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
z=J.A(a)
if(typeof z!=="string")throw H.c(H.q(a))
return z},
m:function(a){var z=a.$identityHash
if(z==null){z=Math.random()*0x3fffffff|0
a.$identityHash=z}return z},
ag:function(a){var z,y,x,w,v,u,t,s
z=J.i(a)
y=z.constructor
if(typeof y=="function"){x=y.name
w=typeof x==="string"?x:null}else w=null
if(w==null||z===C.i||!!J.i(a).$isv){v=C.e(a)
if(v==="Object"){u=a.constructor
if(typeof u=="function"){t=String(u).match(/^\s*function\s*([\w$]*)\s*\(/)
s=t==null?null:t[1]
if(typeof s==="string"&&/^\w+$/.test(s))w=s}if(w==null)w=v}else w=v}w=w
if(w.length>1&&C.c.a2(w,0)===36)w=C.c.S(w,1)
return function(b,c){return b.replace(/[^<,> ]+/g,function(d){return c[d]||d})}(w+H.aB(H.bK(a),0,null),init.mangledGlobalNames)},
G:function(a){return"Instance of '"+H.ag(a)+"'"},
af:function(a,b,c){var z,y,x,w
z={}
z.a=0
y=[]
x=[]
if(b!=null){w=J.z(b)
if(typeof w!=="number")return H.L(w)
z.a=w
C.a.I(y,b)}z.b=""
if(c!=null&&c.a!==0)c.q(0,new H.bm(z,y,x))
return J.aM(a,new H.b8(C.t,""+"$"+z.a+z.b,0,y,x,null))},
ae:function(a,b){var z,y
if(b!=null)z=b instanceof Array?b:P.ab(b,!0)
else z=[]
y=z.length
if(y===0){if(!!a.$0)return a.$0()}else if(y===1){if(!!a.$1)return a.$1(z[0])}else if(y===2){if(!!a.$2)return a.$2(z[0],z[1])}else if(y===3)if(!!a.$3)return a.$3(z[0],z[1],z[2])
return H.bl(a,z)},
bl:function(a,b){var z,y,x,w,v,u
z=b.length
y=a[""+"$"+z]
if(y==null){y=J.i(a)["call*"]
if(y==null)return H.af(a,b,null)
x=H.ah(y)
w=x.d
v=w+x.e
if(x.f||w>z||v<z)return H.af(a,b,null)
b=P.ab(b,!0)
for(u=z;u<v;++u)C.a.a0(b,init.metadata[x.a3(0,u)])}return y.apply(a,b)},
L:function(a){throw H.c(H.q(a))},
x:function(a,b){if(a==null)J.z(a)
throw H.c(H.ay(a,b))},
ay:function(a,b){var z,y
if(typeof b!=="number"||Math.floor(b)!==b)return new P.l(!0,b,"index",null)
z=J.z(a)
if(!(b<0)){if(typeof z!=="number")return H.L(z)
y=b>=z}else y=!0
if(y)return P.b4(b,a,"index",null,z)
return P.H(b,"index",null)},
q:function(a){return new P.l(!0,a,null,null)},
c:function(a){var z
if(a==null)a=new P.bj()
z=new Error()
z.dartException=a
if("defineProperty" in Object){Object.defineProperty(z,"message",{get:H.aG})
z.name=""}else z.toString=H.aG
return z},
aG:[function(){return J.A(this.dartException)},null,null,0,0,null],
aF:function(a){throw H.c(a)},
c2:function(a){throw H.c(new P.S(a))},
c4:function(a){var z,y,x,w,v,u,t,s,r,q,p,o,n,m,l
z=new H.c5(a)
if(a==null)return
if(typeof a!=="object")return a
if("dartException" in a)return z.$1(a.dartException)
else if(!("message" in a))return a
y=a.message
if("number" in a&&typeof a.number=="number"){x=a.number
w=x&65535
if((C.b.a_(x,16)&8191)===10)switch(w){case 438:return z.$1(H.U(H.a(y)+" (Error "+w+")",null))
case 445:case 5007:v=H.a(y)+" (Error "+w+")"
return z.$1(new H.ad(v,null))}}if(a instanceof TypeError){u=$.$get$ak()
t=$.$get$al()
s=$.$get$am()
r=$.$get$an()
q=$.$get$ar()
p=$.$get$as()
o=$.$get$ap()
$.$get$ao()
n=$.$get$au()
m=$.$get$at()
l=u.m(y)
if(l!=null)return z.$1(H.U(y,l))
else{l=t.m(y)
if(l!=null){l.method="call"
return z.$1(H.U(y,l))}else{l=s.m(y)
if(l==null){l=r.m(y)
if(l==null){l=q.m(y)
if(l==null){l=p.m(y)
if(l==null){l=o.m(y)
if(l==null){l=r.m(y)
if(l==null){l=n.m(y)
if(l==null){l=m.m(y)
v=l!=null}else v=!0}else v=!0}else v=!0}else v=!0}else v=!0}else v=!0}else v=!0
if(v)return z.$1(new H.ad(y,l==null?null:l.method))}}return z.$1(new H.bv(typeof y==="string"?y:""))}if(a instanceof RangeError){if(typeof y==="string"&&y.indexOf("call stack")!==-1)return new P.ai()
y=function(b){try{return String(b)}catch(k){}return null}(a)
return z.$1(new P.l(!1,null,null,typeof y==="string"?y.replace(/^RangeError:\s*/,""):y))}if(typeof InternalError=="function"&&a instanceof InternalError)if(typeof y==="string"&&y==="too much recursion")return new P.ai()
return a},
bS:[function(a,b,c,d,e,f,g){switch(c){case 0:return new H.bT(a).$0()
case 1:return new H.bU(a,d).$0()
case 2:return new H.bV(a,d,e).$0()
case 3:return new H.bW(a,d,e,f).$0()
case 4:return new H.bX(a,d,e,f,g).$0()}throw H.c(new P.by("Unsupported number of arguments for wrapped closure"))},null,null,14,0,null,2,3,4,5,6,7,8],
cy:function(a,b){var z
if(a==null)return
z=a.$identity
if(!!z)return z
z=function(c,d,e,f){return function(g,h,i,j){return f(c,e,d,g,h,i,j)}}(a,b,$,H.bS)
a.$identity=z
return z},
aT:function(a,b,c,d,e,f){var z,y,x,w,v,u,t,s,r,q,p,o,n,m
z=b[0]
y=z.$callName
if(!!J.i(c).$isV){z.$reflectionInfo=c
x=H.ah(z).r}else x=c
w=d?Object.create(new H.br().constructor.prototype):Object.create(new H.Q(null,null,null,null).constructor.prototype)
w.$initialize=w.constructor
if(d)v=function(){this.$initialize()}
else{u=$.j
$.j=J.o(u,1)
u=new Function("a,b,c,d","this.$initialize(a,b,c,d);"+u)
v=u}w.constructor=v
v.prototype=w
u=!d
if(u){t=e.length==1&&!0
s=H.a9(a,z,t)
s.$reflectionInfo=c}else{w.$static_name=f
s=z
t=!1}if(typeof x=="number")r=function(g,h){return function(){return g(h)}}(H.bL,x)
else if(u&&typeof x=="function"){q=t?H.a8:H.R
r=function(g,h){return function(){return g.apply({$receiver:h(this)},arguments)}}(x,q)}else throw H.c("Error in reflectionInfo.")
w.$signature=r
w[y]=s
for(u=b.length,p=1;p<u;++p){o=b[p]
n=o.$callName
if(n!=null){m=d?o:H.a9(a,o,t)
w[n]=m}}w["call*"]=s
w.$requiredArgCount=z.$requiredArgCount
w.$defaultValues=z.$defaultValues
return v},
aQ:function(a,b,c,d){var z=H.R
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,z)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,z)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,z)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,z)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,z)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,z)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,z)}},
a9:function(a,b,c){var z,y,x,w,v,u
if(c)return H.aS(a,b)
z=b.$stubName
y=b.length
x=a[z]
w=b==null?x==null:b===x
v=!w||y>=27
if(v)return H.aQ(y,!w,z,b)
if(y===0){w=$.p
if(w==null){w=H.B("self")
$.p=w}w="return function(){return this."+H.a(w)+"."+H.a(z)+"();"
v=$.j
$.j=J.o(v,1)
return new Function(w+H.a(v)+"}")()}u="abcdefghijklmnopqrstuvwxyz".split("").splice(0,y).join(",")
w="return function("+u+"){return this."
v=$.p
if(v==null){v=H.B("self")
$.p=v}v=w+H.a(v)+"."+H.a(z)+"("+u+");"
w=$.j
$.j=J.o(w,1)
return new Function(v+H.a(w)+"}")()},
aR:function(a,b,c,d){var z,y
z=H.R
y=H.a8
switch(b?-1:a){case 0:throw H.c(new H.bq("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,z,y)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,z,y)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,z,y)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,z,y)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,z,y)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,z,y)
default:return function(e,f,g,h){return function(){h=[g(this)]
Array.prototype.push.apply(h,arguments)
return e.apply(f(this),h)}}(d,z,y)}},
aS:function(a,b){var z,y,x,w,v,u,t,s
z=H.aP()
y=$.a7
if(y==null){y=H.B("receiver")
$.a7=y}x=b.$stubName
w=b.length
v=a[x]
u=b==null?v==null:b===v
t=!u||w>=28
if(t)return H.aR(w,!u,x,b)
if(w===1){y="return function(){return this."+H.a(z)+"."+H.a(x)+"(this."+H.a(y)+");"
u=$.j
$.j=J.o(u,1)
return new Function(y+H.a(u)+"}")()}s="abcdefghijklmnopqrstuvwxyz".split("").splice(0,w-1).join(",")
y="return function("+s+"){return this."+H.a(z)+"."+H.a(x)+"(this."+H.a(y)+", "+s+");"
u=$.j
$.j=J.o(u,1)
return new Function(y+H.a(u)+"}")()},
Y:function(a,b,c,d,e,f){var z
b.fixed$length=Array
if(!!J.i(c).$isV){c.fixed$length=Array
z=c}else z=c
return H.aT(a,b,z,!!d,e,f)},
c3:function(a){throw H.c(new P.aX("Cyclic initialization for static "+H.a(a)))},
bK:function(a){if(a==null)return
return a.$builtinTypeInfo},
c1:function(a,b){if(a==null)return"dynamic"
else if(typeof a==="object"&&a!==null&&a.constructor===Array)return a[0].builtin$cls+H.aB(a,1,b)
else if(typeof a=="function")return a.builtin$cls
else if(typeof a==="number"&&Math.floor(a)===a)return C.b.h(a)
else return},
aB:function(a,b,c){var z,y,x,w,v,u
if(a==null)return""
z=new P.I("")
for(y=b,x=!0,w=!0,v="";y<a.length;++y){if(x)x=!1
else z.a=v+", "
u=a[y]
if(u!=null)w=!1
v=z.a+=H.a(H.c1(u,c))}return w?"":"<"+H.a(z)+">"},
cB:function(a){var z=$.a0
return"Instance of "+(z==null?"<Unknown>":z.$1(a))},
cA:function(a){return H.m(a)},
cz:function(a,b,c){Object.defineProperty(a,b,{value:c,enumerable:false,writable:true,configurable:true})},
bY:function(a){var z,y,x,w,v,u
z=$.a0.$1(a)
y=$.K[z]
if(y!=null){Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}x=$.M[z]
if(x!=null)return x
w=init.interceptorsByTag[z]
if(w==null){z=$.ax.$2(a,z)
if(z!=null){y=$.K[z]
if(y!=null){Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}x=$.M[z]
if(x!=null)return x
w=init.interceptorsByTag[z]}}if(w==null)return
x=w.prototype
v=z[0]
if(v==="!"){y=H.a2(x)
$.K[z]=y
Object.defineProperty(a,init.dispatchPropertyName,{value:y,enumerable:false,writable:true,configurable:true})
return y.i}if(v==="~"){$.M[z]=x
return x}if(v==="-"){u=H.a2(x)
Object.defineProperty(Object.getPrototypeOf(a),init.dispatchPropertyName,{value:u,enumerable:false,writable:true,configurable:true})
return u.i}if(v==="+")return H.aD(a,x)
if(v==="*")throw H.c(new P.av(z))
if(init.leafTags[z]===true){u=H.a2(x)
Object.defineProperty(Object.getPrototypeOf(a),init.dispatchPropertyName,{value:u,enumerable:false,writable:true,configurable:true})
return u.i}else return H.aD(a,x)},
aD:function(a,b){var z=Object.getPrototypeOf(a)
Object.defineProperty(z,init.dispatchPropertyName,{value:J.O(b,z,null,null),enumerable:false,writable:true,configurable:true})
return b},
a2:function(a){return J.O(a,!1,null,!!a.$isba)},
c0:function(a,b,c){var z=b.prototype
if(init.leafTags[a]===true)return J.O(z,!1,null,!!z.$isba)
else return J.O(z,c,null,null)},
bQ:function(){if(!0===$.a1)return
$.a1=!0
H.bR()},
bR:function(){var z,y,x,w,v,u,t,s
$.K=Object.create(null)
$.M=Object.create(null)
H.bM()
z=init.interceptorsByTag
y=Object.getOwnPropertyNames(z)
if(typeof window!="undefined"){window
x=function(){}
for(w=0;w<y.length;++w){v=y[w]
u=$.aE.$1(v)
if(u!=null){t=H.c0(v,z[v],u)
if(t!=null){Object.defineProperty(u,init.dispatchPropertyName,{value:t,enumerable:false,writable:true,configurable:true})
x.prototype=u}}}}for(w=0;w<y.length;++w){v=y[w]
if(/^[A-Za-z_]/.test(v)){s=z[v]
z["!"+v]=s
z["~"+v]=s
z["-"+v]=s
z["+"+v]=s
z["*"+v]=s}}},
bM:function(){var z,y,x,w,v,u,t
z=C.j()
z=H.n(C.k,H.n(C.l,H.n(C.d,H.n(C.d,H.n(C.n,H.n(C.m,H.n(C.o(C.e),z)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){y=dartNativeDispatchHooksTransformer
if(typeof y=="function")y=[y]
if(y.constructor==Array)for(x=0;x<y.length;++x){w=y[x]
if(typeof w=="function")z=w(z)||z}}v=z.getTag
u=z.getUnknownTag
t=z.prototypeForTag
$.a0=new H.bN(v)
$.ax=new H.bO(u)
$.aE=new H.bP(t)},
n:function(a,b){return a(b)||b},
aV:{"^":"bw;a"},
aU:{"^":"b;",
h:function(a){return P.W(this)}},
aW:{"^":"aU;a,b,c",
gn:function(a){return this.a},
Y:function(a){return this.b[a]},
q:function(a,b){var z,y,x,w
z=this.c
for(y=z.length,x=0;x<y;++x){w=z[x]
b.$2(w,this.Y(w))}}},
b8:{"^":"b;a,b,c,d,e,f",
gM:function(){return this.a},
gO:function(){var z,y,x,w
if(this.c===1)return C.f
z=this.d
y=z.length-this.e.length
if(y===0)return C.f
x=[]
for(w=0;w<y;++w){if(w>=z.length)return H.x(z,w)
x.push(z[w])}x.fixed$length=Array
x.immutable$list=Array
return x},
gN:function(){var z,y,x,w,v,u,t,s
if(this.c!==0)return C.h
z=this.e
y=z.length
x=this.d
w=x.length-y
if(y===0)return C.h
v=new H.bb(0,null,null,null,null,null,0)
for(u=0;u<y;++u){if(u>=z.length)return H.x(z,u)
t=z[u]
s=w+u
if(s<0||s>=x.length)return H.x(x,s)
v.R(0,new H.X(t),x[s])}return new H.aV(v)}},
bo:{"^":"b;a,b,c,d,e,f,r,x",
a3:function(a,b){var z=this.d
if(typeof b!=="number")return b.w()
if(b<z)return
return this.b[3+b-z]},
j:{
ah:function(a){var z,y,x
z=a.$reflectionInfo
if(z==null)return
z.fixed$length=Array
z=z
y=z[0]
x=z[1]
return new H.bo(a,z,(y&1)===1,y>>1,x>>1,(x&1)===1,z[2],null)}}},
bm:{"^":"e;a,b,c",
$2:function(a,b){var z=this.a
z.b=z.b+"$"+H.a(a)
this.c.push(a)
this.b.push(b);++z.a}},
bu:{"^":"b;a,b,c,d,e,f",
m:function(a){var z,y,x
z=new RegExp(this.a).exec(a)
if(z==null)return
y=Object.create(null)
x=this.b
if(x!==-1)y.arguments=z[x+1]
x=this.c
if(x!==-1)y.argumentsExpr=z[x+1]
x=this.d
if(x!==-1)y.expr=z[x+1]
x=this.e
if(x!==-1)y.method=z[x+1]
x=this.f
if(x!==-1)y.receiver=z[x+1]
return y},
j:{
k:function(a){var z,y,x,w,v,u
a=a.replace(String({}),'$receiver$').replace(/[[\]{}()*+?.\\^$|]/g,"\\$&")
z=a.match(/\\\$[a-zA-Z]+\\\$/g)
if(z==null)z=[]
y=z.indexOf("\\$arguments\\$")
x=z.indexOf("\\$argumentsExpr\\$")
w=z.indexOf("\\$expr\\$")
v=z.indexOf("\\$method\\$")
u=z.indexOf("\\$receiver\\$")
return new H.bu(a.replace('\\$arguments\\$','((?:x|[^x])*)').replace('\\$argumentsExpr\\$','((?:x|[^x])*)').replace('\\$expr\\$','((?:x|[^x])*)').replace('\\$method\\$','((?:x|[^x])*)').replace('\\$receiver\\$','((?:x|[^x])*)'),y,x,w,v,u)},
J:function(a){return function($expr$){var $argumentsExpr$='$arguments$'
try{$expr$.$method$($argumentsExpr$)}catch(z){return z.message}}(a)},
aq:function(a){return function($expr$){try{$expr$.$method$}catch(z){return z.message}}(a)}}},
ad:{"^":"f;a,b",
h:function(a){var z=this.b
if(z==null)return"NullError: "+H.a(this.a)
return"NullError: method not found: '"+H.a(z)+"' on null"}},
bc:{"^":"f;a,b,c",
h:function(a){var z,y
z=this.b
if(z==null)return"NoSuchMethodError: "+H.a(this.a)
y=this.c
if(y==null)return"NoSuchMethodError: method not found: '"+H.a(z)+"' ("+H.a(this.a)+")"
return"NoSuchMethodError: method not found: '"+H.a(z)+"' on '"+H.a(y)+"' ("+H.a(this.a)+")"},
j:{
U:function(a,b){var z,y
z=b==null
y=z?null:b.method
return new H.bc(a,y,z?null:b.receiver)}}},
bv:{"^":"f;a",
h:function(a){var z=this.a
return z.length===0?"Error":"Error: "+z}},
c5:{"^":"e;a",
$1:function(a){if(!!J.i(a).$isf)if(a.$thrownJsError==null)a.$thrownJsError=this.a
return a}},
bT:{"^":"e;a",
$0:function(){return this.a.$0()}},
bU:{"^":"e;a,b",
$0:function(){return this.a.$1(this.b)}},
bV:{"^":"e;a,b,c",
$0:function(){return this.a.$2(this.b,this.c)}},
bW:{"^":"e;a,b,c,d",
$0:function(){return this.a.$3(this.b,this.c,this.d)}},
bX:{"^":"e;a,b,c,d,e",
$0:function(){return this.a.$4(this.b,this.c,this.d,this.e)}},
e:{"^":"b;",
h:function(a){return"Closure '"+H.ag(this)+"'"},
gP:function(){return this},
gP:function(){return this}},
aj:{"^":"e;"},
br:{"^":"aj;",
h:function(a){var z=this.$static_name
if(z==null)return"Closure of unknown static method"
return"Closure '"+z+"'"}},
Q:{"^":"aj;a,b,c,d",
u:function(a,b){if(b==null)return!1
if(this===b)return!0
if(!(b instanceof H.Q))return!1
return this.a===b.a&&this.b===b.b&&this.c===b.c},
gl:function(a){var z,y
z=this.c
if(z==null)y=H.m(this.a)
else y=typeof z!=="object"?J.P(z):H.m(z)
return(y^H.m(this.b))>>>0},
h:function(a){var z=this.c
if(z==null)z=this.a
return"Closure '"+H.a(this.d)+"' of "+H.G(z)},
j:{
R:function(a){return a.a},
a8:function(a){return a.c},
aP:function(){var z=$.p
if(z==null){z=H.B("self")
$.p=z}return z},
B:function(a){var z,y,x,w,v
z=new H.Q("self","target","receiver","name")
y=Object.getOwnPropertyNames(z)
y.fixed$length=Array
x=y
for(y=x.length,w=0;w<y;++w){v=x[w]
if(z[v]===a)return v}}}},
bq:{"^":"f;i:a>",
h:function(a){return"RuntimeError: "+this.a}},
bb:{"^":"b;a,b,c,d,e,f,r",
gn:function(a){return this.a},
R:function(a,b,c){var z,y,x,w,v,u
if(typeof b==="string"){z=this.b
if(z==null){z=this.C()
this.b=z}this.G(z,b,c)}else if(typeof b==="number"&&(b&0x3ffffff)===b){y=this.c
if(y==null){y=this.C()
this.c=y}this.G(y,b,c)}else{x=this.d
if(x==null){x=this.C()
this.d=x}w=J.P(b)&0x3ffffff
v=this.H(x,w)
if(v==null)this.E(x,w,[this.D(b,c)])
else{u=this.a5(v,b)
if(u>=0)v[u].sL(c)
else v.push(this.D(b,c))}}},
q:function(a,b){var z,y
z=this.e
y=this.r
for(;z!=null;){b.$2(z.a,z.b)
if(y!==this.r)throw H.c(new P.S(this))
z=z.c}},
G:function(a,b,c){var z=this.H(a,b)
if(z==null)this.E(a,b,this.D(b,c))
else z.sL(c)},
D:function(a,b){var z,y
z=new H.bd(a,b,null,null)
if(this.e==null){this.f=z
this.e=z}else{y=this.f
z.d=y
y.c=z
this.f=z}++this.a
this.r=this.r+1&67108863
return z},
a5:function(a,b){var z,y
if(a==null)return-1
z=a.length
for(y=0;y<z;++y)if(J.a3(a[y].ga4(),b))return y
return-1},
h:function(a){return P.W(this)},
H:function(a,b){return a[b]},
E:function(a,b,c){a[b]=c},
X:function(a,b){delete a[b]},
C:function(){var z=Object.create(null)
this.E(z,"<non-identifier-key>",z)
this.X(z,"<non-identifier-key>")
return z}},
bd:{"^":"b;a4:a<,L:b?,c,d"},
bN:{"^":"e;a",
$1:function(a){return this.a(a)}},
bO:{"^":"e;a",
$2:function(a,b){return this.a(a,b)}},
bP:{"^":"e;a",
$1:function(a){return this.a(a)}}}],["","",,H,{"^":"",X:{"^":"b;Z:a<",
u:function(a,b){if(b==null)return!1
return b instanceof H.X&&J.a3(this.a,b.a)},
gl:function(a){return 536870911&664597*J.P(this.a)},
h:function(a){return'Symbol("'+H.a(this.a)+'")'}}}],["","",,P,{"^":"",
b5:function(a,b,c){var z,y,x
if(P.aw(a))return b+"..."+c
z=new P.I(b)
y=$.$get$w()
y.push(a)
try{x=z
x.sk(P.bt(x.gk(),a,", "))}finally{if(0>=y.length)return H.x(y,-1)
y.pop()}y=z
y.sk(y.gk()+c)
y=z.gk()
return y.charCodeAt(0)==0?y:y},
aw:function(a){var z,y
for(z=0;y=$.$get$w(),z<y.length;++z)if(a===y[z])return!0
return!1},
W:function(a){var z,y,x
z={}
if(P.aw(a))return"{...}"
y=new P.I("")
try{$.$get$w().push(a)
x=y
x.sk(x.gk()+"{")
z.a=!0
J.aJ(a,new P.bf(z,y))
z=y
z.sk(z.gk()+"}")}finally{z=$.$get$w()
if(0>=z.length)return H.x(z,-1)
z.pop()}z=y.gk()
return z.charCodeAt(0)==0?z:z},
bz:{"^":"b;"},
be:{"^":"b;",
q:function(a,b){this.a.q(0,b)},
gn:function(a){return this.a.a},
h:function(a){return P.W(this.a)}},
bw:{"^":"be+bz;"},
bf:{"^":"e;a,b",
$2:function(a,b){var z,y
z=this.a
if(!z.a)this.b.a+=", "
z.a=!1
z=this.b
y=z.a+=H.a(a)
z.a=y+": "
z.a+=H.a(b)}}}],["","",,P,{"^":"",
r:function(a){if(typeof a==="number"||typeof a==="boolean"||null==a)return J.A(a)
if(typeof a==="string")return JSON.stringify(a)
return P.b1(a)},
b1:function(a){var z=J.i(a)
if(!!z.$ise)return z.h(a)
return H.G(a)},
ab:function(a,b){var z,y
z=[]
for(y=J.a4(a);y.v();)z.push(y.gK())
return z},
bh:{"^":"e;a,b",
$2:function(a,b){var z,y,x
z=this.b
y=this.a
z.a+=y.a
x=z.a+=H.a(a.gZ())
z.a=x+": "
z.a+=H.a(P.r(b))
y.a=", "}},
bG:{"^":"b;",
h:function(a){return this?"true":"false"}},
"+bool":0,
c6:{"^":"y;"},
"+double":0,
f:{"^":"b;"},
bj:{"^":"f;",
h:function(a){return"Throw of null."}},
l:{"^":"f;a,b,c,i:d>",
gB:function(){return"Invalid argument"+(!this.a?"(s)":"")},
gA:function(){return""},
h:function(a){var z,y,x,w,v,u
z=this.c
y=z!=null?" ("+H.a(z)+")":""
z=this.d
x=z==null?"":": "+H.a(z)
w=this.gB()+y+x
if(!this.a)return w
v=this.gA()
u=P.r(this.b)
return w+v+": "+H.a(u)},
j:{
aN:function(a){return new P.l(!1,null,null,a)},
aO:function(a,b,c){return new P.l(!0,a,b,c)}}},
bn:{"^":"l;e,f,a,b,c,d",
gB:function(){return"RangeError"},
gA:function(){var z,y,x
z=this.e
if(z==null){z=this.f
y=z!=null?": Not less than or equal to "+H.a(z):""}else{x=this.f
if(x==null)y=": Not greater than or equal to "+H.a(z)
else{if(typeof x!=="number")return x.a7()
if(typeof z!=="number")return H.L(z)
if(x>z)y=": Not in range "+z+".."+x+", inclusive"
else y=x<z?": Valid value range is empty":": Only valid value is "+z}}return y},
j:{
H:function(a,b,c){return new P.bn(null,null,!0,a,b,"Value not in range")}}},
b3:{"^":"l;e,n:f>,a,b,c,d",
gB:function(){return"RangeError"},
gA:function(){if(J.aI(this.b,0))return": index must not be negative"
var z=this.f
if(z===0)return": no indices are valid"
return": index should be less than "+H.a(z)},
j:{
b4:function(a,b,c,d,e){var z=e!=null?e:J.z(b)
return new P.b3(b,z,!0,a,c,"Index out of range")}}},
bg:{"^":"f;a,b,c,d,e",
h:function(a){var z,y,x,w,v,u,t,s
z={}
y=new P.I("")
z.a=""
for(x=this.c,w=x.length,v=0;v<w;++v){u=x[v]
y.a+=z.a
y.a+=H.a(P.r(u))
z.a=", "}this.d.q(0,new P.bh(z,y))
t=P.r(this.a)
s=H.a(y)
return"NoSuchMethodError: method not found: '"+H.a(this.b.a)+"'\nReceiver: "+H.a(t)+"\nArguments: ["+s+"]"},
j:{
ac:function(a,b,c,d,e){return new P.bg(a,b,c,d,e)}}},
bx:{"^":"f;i:a>",
h:function(a){return"Unsupported operation: "+this.a}},
av:{"^":"f;i:a>",
h:function(a){var z=this.a
return z!=null?"UnimplementedError: "+H.a(z):"UnimplementedError"}},
S:{"^":"f;a",
h:function(a){var z=this.a
if(z==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+H.a(P.r(z))+"."}},
ai:{"^":"b;",
h:function(a){return"Stack Overflow"},
$isf:1},
aX:{"^":"f;a",
h:function(a){return"Reading static variable '"+this.a+"' during its initialization"}},
by:{"^":"b;i:a>",
h:function(a){return"Exception: "+this.a}},
aH:{"^":"y;"},
"+int":0,
V:{"^":"b;"},
"+List":0,
cq:{"^":"b;",
h:function(a){return"null"}},
"+Null":0,
y:{"^":"b;"},
"+num":0,
b:{"^":";",
u:function(a,b){return this===b},
gl:function(a){return H.m(this)},
h:function(a){return H.G(this)},
F:function(a,b){throw H.c(P.ac(this,b.gM(),b.gO(),b.gN(),null))},
toString:function(){return this.h(this)}},
bs:{"^":"b;"},
"+String":0,
I:{"^":"b;k:a@",
gn:function(a){return this.a.length},
h:function(a){var z=this.a
return z.charCodeAt(0)==0?z:z},
j:{
bt:function(a,b,c){var z=new J.a6(b,b.length,0,null)
if(!z.v())return a
if(c.length===0){do a+=H.a(z.d)
while(z.v())}else{a+=H.a(z.d)
for(;z.v();)a=a+c+H.a(z.d)}return a}}},
cx:{"^":"b;"}}],["","",,W,{"^":"",t:{"^":"b_;","%":"HTMLAppletElement|HTMLAudioElement|HTMLBRElement|HTMLBaseElement|HTMLBodyElement|HTMLButtonElement|HTMLCanvasElement|HTMLContentElement|HTMLDListElement|HTMLDataListElement|HTMLDetailsElement|HTMLDialogElement|HTMLDirectoryElement|HTMLEmbedElement|HTMLFieldSetElement|HTMLFontElement|HTMLFrameElement|HTMLFrameSetElement|HTMLHRElement|HTMLHeadElement|HTMLHeadingElement|HTMLHtmlElement|HTMLIFrameElement|HTMLImageElement|HTMLInputElement|HTMLKeygenElement|HTMLLIElement|HTMLLabelElement|HTMLLegendElement|HTMLLinkElement|HTMLMapElement|HTMLMarqueeElement|HTMLMediaElement|HTMLMenuElement|HTMLMenuItemElement|HTMLMetaElement|HTMLMeterElement|HTMLModElement|HTMLOListElement|HTMLObjectElement|HTMLOptGroupElement|HTMLOptionElement|HTMLOutputElement|HTMLParagraphElement|HTMLParamElement|HTMLPictureElement|HTMLPreElement|HTMLProgressElement|HTMLQuoteElement|HTMLScriptElement|HTMLShadowElement|HTMLSourceElement|HTMLSpanElement|HTMLStyleElement|HTMLTableCaptionElement|HTMLTableCellElement|HTMLTableColElement|HTMLTableDataCellElement|HTMLTableElement|HTMLTableHeaderCellElement|HTMLTableRowElement|HTMLTableSectionElement|HTMLTemplateElement|HTMLTextAreaElement|HTMLTitleElement|HTMLTrackElement|HTMLUListElement|HTMLUnknownElement|HTMLVideoElement;HTMLElement"},c7:{"^":"t;",
h:function(a){return String(a)},
"%":"HTMLAnchorElement"},c8:{"^":"T;i:message=","%":"ApplicationCacheErrorEvent"},c9:{"^":"t;",
h:function(a){return String(a)},
"%":"HTMLAreaElement"},aY:{"^":"t;","%":";HTMLDivElement"},aZ:{"^":"d;i:message=","%":";DOMError"},ce:{"^":"d;i:message=",
h:function(a){return String(a)},
"%":"DOMException"},b_:{"^":"bi;",
h:function(a){return a.localName},
"%":"SVGAElement|SVGAltGlyphDefElement|SVGAltGlyphElement|SVGAltGlyphItemElement|SVGAnimateElement|SVGAnimateMotionElement|SVGAnimateTransformElement|SVGAnimationElement|SVGCircleElement|SVGClipPathElement|SVGComponentTransferFunctionElement|SVGCursorElement|SVGDefsElement|SVGDescElement|SVGDiscardElement|SVGElement|SVGEllipseElement|SVGFEBlendElement|SVGFEColorMatrixElement|SVGFEComponentTransferElement|SVGFECompositeElement|SVGFEConvolveMatrixElement|SVGFEDiffuseLightingElement|SVGFEDisplacementMapElement|SVGFEDistantLightElement|SVGFEDropShadowElement|SVGFEFloodElement|SVGFEFuncAElement|SVGFEFuncBElement|SVGFEFuncGElement|SVGFEFuncRElement|SVGFEGaussianBlurElement|SVGFEImageElement|SVGFEMergeElement|SVGFEMergeNodeElement|SVGFEMorphologyElement|SVGFEOffsetElement|SVGFEPointLightElement|SVGFESpecularLightingElement|SVGFESpotLightElement|SVGFETileElement|SVGFETurbulenceElement|SVGFilterElement|SVGFontElement|SVGFontFaceElement|SVGFontFaceFormatElement|SVGFontFaceNameElement|SVGFontFaceSrcElement|SVGFontFaceUriElement|SVGForeignObjectElement|SVGGElement|SVGGeometryElement|SVGGlyphElement|SVGGlyphRefElement|SVGGradientElement|SVGGraphicsElement|SVGHKernElement|SVGImageElement|SVGLineElement|SVGLinearGradientElement|SVGMPathElement|SVGMarkerElement|SVGMaskElement|SVGMetadataElement|SVGMissingGlyphElement|SVGPathElement|SVGPatternElement|SVGPolygonElement|SVGPolylineElement|SVGRadialGradientElement|SVGRectElement|SVGSVGElement|SVGScriptElement|SVGSetElement|SVGStopElement|SVGStyleElement|SVGSwitchElement|SVGSymbolElement|SVGTSpanElement|SVGTextContentElement|SVGTextElement|SVGTextPathElement|SVGTextPositioningElement|SVGTitleElement|SVGUseElement|SVGVKernElement|SVGViewElement;Element"},cf:{"^":"T;i:message=","%":"ErrorEvent"},T:{"^":"d;","%":"AutocompleteErrorEvent;ClipboardEvent|Event|InputEvent"},b2:{"^":"d;","%":"DOMWindow|Window;EventTarget"},cg:{"^":"aZ;p:code=","%":"FileError"},ch:{"^":"t;n:length=","%":"HTMLFormElement"},cn:{"^":"d;p:code=","%":"MediaError"},co:{"^":"d;p:code=","%":"MediaKeyError"},cp:{"^":"d;i:message=","%":"NavigatorUserMediaError"},bi:{"^":"b2;",
h:function(a){var z=a.nodeValue
return z==null?this.V(a):z},
"%":"Document|HTMLDocument;Node"},cr:{"^":"aY;i:message=","%":"PluginPlaceholderElement"},cs:{"^":"d;p:code=,i:message=","%":"PositionError"},ct:{"^":"t;n:length=","%":"HTMLSelectElement"},cu:{"^":"T;i:message=","%":"SpeechRecognitionError"}}],["","",,P,{"^":""}],["","",,P,{"^":"",cv:{"^":"d;p:code=,i:message=","%":"SQLError"}}],["","",,P,{"^":"",
bC:function(a){var z,y
z=a.$dart_jsFunction
if(z!=null)return z
y=function(b,c){return function(){return b(c,Array.prototype.slice.apply(arguments))}}(P.bA,a)
y[$.$get$C()]=a
a.$dart_jsFunction=y
return y},
bD:function(a){var z,y
z=a._$dart_jsFunctionCaptureThis
if(z!=null)return z
y=function(b,c){return function(){return b(c,this,Array.prototype.slice.apply(arguments))}}(P.bB,a)
y[$.$get$C()]=a
a._$dart_jsFunctionCaptureThis=y
return y},
bA:[function(a,b){return H.ae(a,b)},null,null,4,0,null,0,1],
bB:[function(a,b,c){var z=[b]
C.a.I(z,c)
return H.ae(a,z)},null,null,6,0,null,0,11,1],
bE:function(a){if(typeof a=="function")return a
else return P.bC(a)},
bF:function(a){if(typeof a=="function")throw H.c(P.aN("Function is already a JS function so cannot capture this."))
else return P.bD(a)}}],["","",,F,{"^":"",
aC:function(){var z,y,x,w,v,u,t,s
x={constraints:{height:480,width:640},type:"LiveStream"}
w={halfSample:!1,patchSize:"medium"}
z={decoder:{readers:["code_128_reader"]},inputStream:x,locate:!0,locator:w,numOfWorkers:0,tracking:!0}
try{v=P.bF(new F.bZ())
Quagga.init(z,v)}catch(u){v=H.c4(u)
y=v
v=document.querySelector("#output")
t=v.textContent
s=H.a(y)
if(t==null)return t.t()
v.textContent=t+s}v=P.bE(new F.c_())
Quagga.onDetected(v)},
bZ:{"^":"e;",
$1:[function(a){var z,y,x
z=a
if((z==null?z:J.a5(z))!=null){z=document.querySelector("#output")
y=z.textContent
x=H.a(J.a5(a))
if(y==null)return y.t()
z.textContent=y+x
return}Quagga.start()
z=document.querySelector("#output")
y=z.textContent
if(y==null)return y.t()
z.textContent=y+"barcodescanner started"},null,null,2,0,null,9,"call"]},
c_:{"^":"e;",
$1:[function(a){var z,y,x
z=document.querySelector("#output")
y=z.textContent
x=J.aK(J.aL(a))
if(y==null)return y.t()
z.textContent=J.o(y,x)
Quagga.stop()},null,null,2,0,null,10,"call"]}},1],["","",,O,{"^":"",cc:{"^":"h;","%":""}}],["","",,Q,{"^":"",cd:{"^":"h;","%":""}}],["","",,G,{"^":"",ci:{"^":"h;","%":""},cj:{"^":"h;","%":""},cb:{"^":"h;","%":""},b0:{"^":"h;","%":""}}],["","",,A,{"^":"",cm:{"^":"h;","%":""}}],["","",,Z,{"^":"",bp:{"^":"h;","%":""},cw:{"^":"h;","%":""},ca:{"^":"h;","%":""}}]]
setupProgram(dart,0)
J.i=function(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.aa.prototype
return J.b7.prototype}if(typeof a=="string")return J.E.prototype
if(a==null)return J.b9.prototype
if(typeof a=="boolean")return J.b6.prototype
if(a.constructor==Array)return J.u.prototype
if(typeof a!="object"){if(typeof a=="function")return J.F.prototype
return a}if(a instanceof P.b)return a
return J.a_(a)}
J.aA=function(a){if(a==null)return a
if(a.constructor==Array)return J.u.prototype
if(!(a instanceof P.b))return J.v.prototype
return a}
J.bH=function(a){if(typeof a=="string")return J.E.prototype
if(a==null)return a
if(a.constructor==Array)return J.u.prototype
if(typeof a!="object"){if(typeof a=="function")return J.F.prototype
return a}if(a instanceof P.b)return a
return J.a_(a)}
J.bI=function(a){if(typeof a=="number")return J.D.prototype
if(a==null)return a
if(!(a instanceof P.b))return J.v.prototype
return a}
J.bJ=function(a){if(typeof a=="number")return J.D.prototype
if(typeof a=="string")return J.E.prototype
if(a==null)return a
if(!(a instanceof P.b))return J.v.prototype
return a}
J.Z=function(a){if(a==null)return a
if(typeof a!="object"){if(typeof a=="function")return J.F.prototype
return a}if(a instanceof P.b)return a
return J.a_(a)}
J.o=function(a,b){if(typeof a=="number"&&typeof b=="number")return a+b
return J.bJ(a).t(a,b)}
J.a3=function(a,b){if(a==null)return b==null
if(typeof a!="object")return b!=null&&a===b
return J.i(a).u(a,b)}
J.aI=function(a,b){if(typeof a=="number"&&typeof b=="number")return a<b
return J.bI(a).w(a,b)}
J.aJ=function(a,b){return J.aA(a).q(a,b)}
J.aK=function(a){return J.Z(a).gp(a)}
J.aL=function(a){return J.Z(a).ga1(a)}
J.P=function(a){return J.i(a).gl(a)}
J.a4=function(a){return J.aA(a).ga6(a)}
J.z=function(a){return J.bH(a).gn(a)}
J.a5=function(a){return J.Z(a).gi(a)}
J.aM=function(a,b){return J.i(a).F(a,b)}
J.A=function(a){return J.i(a).h(a)}
I.N=function(a){a.immutable$list=Array
a.fixed$length=Array
return a}
var $=I.p
C.i=J.d.prototype
C.a=J.u.prototype
C.b=J.aa.prototype
C.c=J.E.prototype
C.p=J.F.prototype
C.r=J.bk.prototype
C.u=J.v.prototype
C.j=function() {  function typeNameInChrome(o) {    var constructor = o.constructor;    if (constructor) {      var name = constructor.name;      if (name) return name;    }    var s = Object.prototype.toString.call(o);    return s.substring(8, s.length - 1);  }  function getUnknownTag(object, tag) {    if (/^HTML[A-Z].*Element$/.test(tag)) {      var name = Object.prototype.toString.call(object);      if (name == "[object Object]") return null;      return "HTMLElement";    }  }  function getUnknownTagGenericBrowser(object, tag) {    if (self.HTMLElement && object instanceof HTMLElement) return "HTMLElement";    return getUnknownTag(object, tag);  }  function prototypeForTag(tag) {    if (typeof window == "undefined") return null;    if (typeof window[tag] == "undefined") return null;    var constructor = window[tag];    if (typeof constructor != "function") return null;    return constructor.prototype;  }  function discriminator(tag) { return null; }  var isBrowser = typeof navigator == "object";  return {    getTag: typeNameInChrome,    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,    prototypeForTag: prototypeForTag,    discriminator: discriminator };}
C.d=function(hooks) { return hooks; }
C.k=function(hooks) {  if (typeof dartExperimentalFixupGetTag != "function") return hooks;  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);}
C.l=function(hooks) {  var getTag = hooks.getTag;  var prototypeForTag = hooks.prototypeForTag;  function getTagFixed(o) {    var tag = getTag(o);    if (tag == "Document") {      // "Document", so we check for the xmlVersion property, which is the empty      if (!!o.xmlVersion) return "!Document";      return "!HTMLDocument";    }    return tag;  }  function prototypeForTagFixed(tag) {    if (tag == "Document") return null;    return prototypeForTag(tag);  }  hooks.getTag = getTagFixed;  hooks.prototypeForTag = prototypeForTagFixed;}
C.m=function(hooks) {  var userAgent = typeof navigator == "object" ? navigator.userAgent : "";  if (userAgent.indexOf("Firefox") == -1) return hooks;  var getTag = hooks.getTag;  var quickMap = {    "BeforeUnloadEvent": "Event",    "DataTransfer": "Clipboard",    "GeoGeolocation": "Geolocation",    "Location": "!Location",    "WorkerMessageEvent": "MessageEvent",    "XMLDocument": "!Document"};  function getTagFirefox(o) {    var tag = getTag(o);    return quickMap[tag] || tag;  }  hooks.getTag = getTagFirefox;}
C.n=function(hooks) {  var userAgent = typeof navigator == "object" ? navigator.userAgent : "";  if (userAgent.indexOf("Trident/") == -1) return hooks;  var getTag = hooks.getTag;  var quickMap = {    "BeforeUnloadEvent": "Event",    "DataTransfer": "Clipboard",    "HTMLDDElement": "HTMLElement",    "HTMLDTElement": "HTMLElement",    "HTMLPhraseElement": "HTMLElement",    "Position": "Geoposition"  };  function getTagIE(o) {    var tag = getTag(o);    var newTag = quickMap[tag];    if (newTag) return newTag;    if (tag == "Object") {      if (window.DataView && (o instanceof window.DataView)) return "DataView";    }    return tag;  }  function prototypeForTagIE(tag) {    var constructor = window[tag];    if (constructor == null) return null;    return constructor.prototype;  }  hooks.getTag = getTagIE;  hooks.prototypeForTag = prototypeForTagIE;}
C.e=function getTagFallback(o) {  var constructor = o.constructor;  if (typeof constructor == "function") {    var name = constructor.name;    if (typeof name == "string" &&        // constructor name does not 'stick'.  The shortest real DOM object        name.length > 2 &&        // On Firefox we often get "Object" as the constructor name, even for        name !== "Object" &&        name !== "Function.prototype") {      return name;    }  }  var s = Object.prototype.toString.call(o);  return s.substring(8, s.length - 1);}
C.o=function(getTagFallback) {  return function(hooks) {    if (typeof navigator != "object") return hooks;    var ua = navigator.userAgent;    if (ua.indexOf("DumpRenderTree") >= 0) return hooks;    if (ua.indexOf("Chrome") >= 0) {      function confirm(p) {        return typeof window == "object" && window[p] && window[p].name == p;      }      if (confirm("Window") && confirm("HTMLElement")) return hooks;    }    hooks.getTag = getTagFallback;  };}
C.f=I.N([])
C.q=I.N([])
C.h=new H.aW(0,{},C.q)
C.t=new H.X("call")
$.j=0
$.p=null
$.a7=null
$.a0=null
$.ax=null
$.aE=null
$.K=null
$.M=null
$.a1=null
$=null
init.isHunkLoaded=function(a){return!!$dart_deferred_initializers$[a]}
init.deferredInitialized=new Object(null)
init.isHunkInitialized=function(a){return init.deferredInitialized[a]}
init.initializeLoadedHunk=function(a){$dart_deferred_initializers$[a]($globals$,$)
init.deferredInitialized[a]=true}
init.deferredLibraryUris={}
init.deferredLibraryHashes={};(function(a){for(var z=0;z<a.length;){var y=a[z++]
var x=a[z++]
var w=a[z++]
I.$lazy(y,x,w)}})(["C","$get$C",function(){return init.getIsolateTag("_$dart_dartClosure")},"ak","$get$ak",function(){return H.k(H.J({
toString:function(){return"$receiver$"}}))},"al","$get$al",function(){return H.k(H.J({$method$:null,
toString:function(){return"$receiver$"}}))},"am","$get$am",function(){return H.k(H.J(null))},"an","$get$an",function(){return H.k(function(){var $argumentsExpr$='$arguments$'
try{null.$method$($argumentsExpr$)}catch(z){return z.message}}())},"ar","$get$ar",function(){return H.k(H.J(void 0))},"as","$get$as",function(){return H.k(function(){var $argumentsExpr$='$arguments$'
try{(void 0).$method$($argumentsExpr$)}catch(z){return z.message}}())},"ap","$get$ap",function(){return H.k(H.aq(null))},"ao","$get$ao",function(){return H.k(function(){try{null.$method$}catch(z){return z.message}}())},"au","$get$au",function(){return H.k(H.aq(void 0))},"at","$get$at",function(){return H.k(function(){try{(void 0).$method$}catch(z){return z.message}}())},"w","$get$w",function(){return[]}])
I=I.$finishIsolateConstructor(I)
$=new I()
init.metadata=["callback","arguments","closure","isolate","numberOfArguments","arg1","arg2","arg3","arg4","err","data","self"]
init.types=[]
function convertToFastObject(a){function MyClass(){}MyClass.prototype=a
new MyClass()
return a}function convertToSlowObject(a){a.__MAGIC_SLOW_PROPERTY=1
delete a.__MAGIC_SLOW_PROPERTY
return a}A=convertToFastObject(A)
B=convertToFastObject(B)
C=convertToFastObject(C)
D=convertToFastObject(D)
E=convertToFastObject(E)
F=convertToFastObject(F)
G=convertToFastObject(G)
H=convertToFastObject(H)
J=convertToFastObject(J)
K=convertToFastObject(K)
L=convertToFastObject(L)
M=convertToFastObject(M)
N=convertToFastObject(N)
O=convertToFastObject(O)
P=convertToFastObject(P)
Q=convertToFastObject(Q)
R=convertToFastObject(R)
S=convertToFastObject(S)
T=convertToFastObject(T)
U=convertToFastObject(U)
V=convertToFastObject(V)
W=convertToFastObject(W)
X=convertToFastObject(X)
Y=convertToFastObject(Y)
Z=convertToFastObject(Z)
function init(){I.p=Object.create(null)
init.allClasses=map()
init.getTypeFromName=function(a){return init.allClasses[a]}
init.interceptorsByTag=map()
init.leafTags=map()
init.finishedClasses=map()
I.$lazy=function(a,b,c,d,e){if(!init.lazies)init.lazies=Object.create(null)
init.lazies[a]=b
e=e||I.p
var z={}
var y={}
e[a]=z
e[b]=function(){var x=this[a]
try{if(x===z){this[a]=y
try{x=this[a]=c()}finally{if(x===z)this[a]=null}}else if(x===y)H.c3(d||a)
return x}finally{this[b]=function(){return this[a]}}}}
I.$finishIsolateConstructor=function(a){var z=a.p
function Isolate(){var y=Object.keys(z)
for(var x=0;x<y.length;x++){var w=y[x]
this[w]=z[w]}var v=init.lazies
var u=v?Object.keys(v):[]
for(var x=0;x<u.length;x++)this[v[u[x]]]=null
function ForceEfficientMap(){}ForceEfficientMap.prototype=this
new ForceEfficientMap()
for(var x=0;x<u.length;x++){var t=v[u[x]]
this[t]=z[t]}}Isolate.prototype=a.prototype
Isolate.prototype.constructor=Isolate
Isolate.p=z
Isolate.N=a.N
Isolate.az=a.az
return Isolate}}!function(){var z=function(a){var t={}
t[a]=1
return Object.keys(convertToFastObject(t))[0]}
init.getIsolateTag=function(a){return z("___dart_"+a+init.isolateTag)}
var y="___dart_isolate_tags_"
var x=Object[y]||(Object[y]=Object.create(null))
var w="_ZxYxX"
for(var v=0;;v++){var u=z(w+"_"+v+"_")
if(!(u in x)){x[u]=1
init.isolateTag=u
break}}init.dispatchPropertyName=init.getIsolateTag("dispatch_record")}();(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!='undefined'){a(document.currentScript)
return}var z=document.scripts
function onLoad(b){for(var x=0;x<z.length;++x)z[x].removeEventListener("load",onLoad,false)
a(b.target)}for(var y=0;y<z.length;++y)z[y].addEventListener("load",onLoad,false)})(function(a){init.currentScript=a
if(typeof dartMainRunner==="function")dartMainRunner(F.aC,[])
else F.aC([])})})()