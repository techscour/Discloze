!function(){Function.prototype.bind||(Function.prototype.bind=function(oThis){if("function"!=typeof this)throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");var aArgs=Array.prototype.slice.call(arguments,1),fToBind=this,fNOP=function(){},fBound=function(){return fToBind.apply(this instanceof fNOP&&oThis?this:oThis,aArgs.concat(Array.prototype.slice.call(arguments)))};return fNOP.prototype=this.prototype,fBound.prototype=new fNOP,fBound})}();