package mx.binding
{
   import mx.core.mx_internal;
   import flash.utils.Dictionary;
   import mx.collections.errors.ItemPendingError;

   use namespace mx_internal;

   public class Binding extends Object
   {
      public function Binding(param1:Object, param2:Function, param3:Function, param4:String, param5:String=null) {
         super();
         this.document=param1;
         this.srcFunc=param2;
         this.destFunc=param3;
         this.destString=param4;
         this.srcString=param5;
         if(this.srcFunc == null)
         {
            this.srcFunc=this.defaultSrcFunc;
         }
         if(this.destFunc == null)
         {
            this.destFunc=this.defaultDestFunc;
         }
         this._isEnabled=true;
         this.isExecuting=false;
         this.isHandlingEvent=false;
         this.hasHadValue=false;
         this.uiComponentWatcher=-1;
         BindingManager.addBinding(param1,param4,this);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var _isEnabled:Boolean;

      mx_internal function get isEnabled() : Boolean {
         return this._isEnabled;
      }

      mx_internal function set isEnabled(param1:Boolean) : void {
         this._isEnabled=param1;
         if(param1)
         {
            this.processDisabledRequests();
         }
         return;
      }

      mx_internal var isExecuting:Boolean;

      mx_internal var isHandlingEvent:Boolean;

      mx_internal var disabledRequests:Dictionary;

      private var hasHadValue:Boolean;

      public var uiComponentWatcher:int;

      public var twoWayCounterpart:Binding;

      public var isTwoWayPrimary:Boolean;

      private var wrappedFunctionSuccessful:Boolean;

      mx_internal var document:Object;

      mx_internal var srcFunc:Function;

      mx_internal var destFunc:Function;

      mx_internal var destString:String;

      mx_internal var srcString:String;

      private var lastValue:Object;

      private function defaultDestFunc(param1:Object) : void {
         var _loc2_:Array = this.destString.split(".");
         var _loc3_:Object = this.document;
         var _loc4_:uint = 0;
         if(_loc2_[0] == "this")
         {
            _loc4_++;
         }
         while(_loc4_ < _loc2_.length-1)
         {
            _loc3_=_loc3_[_loc2_[_loc4_++]];
         }
         _loc3_[_loc2_[_loc4_]]=param1;
         return;
      }

      private function defaultSrcFunc() : Object {
         return this.document[this.srcString];
      }

      public function execute(param1:Object=null) : void {
         var o:Object = param1;
         if(!this.isEnabled)
         {
            if(o != null)
            {
               this.registerDisabledExecute(o);
            }
            return;
         }
         if((this.twoWayCounterpart) && (!this.twoWayCounterpart.hasHadValue) && (this.twoWayCounterpart.isTwoWayPrimary))
         {
            this.twoWayCounterpart.execute();
            this.hasHadValue=true;
            return;
         }
         if((this.isExecuting) || (this.twoWayCounterpart) && (this.twoWayCounterpart.isExecuting))
         {
            this.hasHadValue=true;
            return;
         }
         try
         {
            this.isExecuting=true;
            this.wrapFunctionCall(this,this.innerExecute,o);
         }
         catch(error:Error)
         {
            if(error.errorID != 1507)
            {
               throw error;
            }
         }
         finally
         {
            this.isExecuting=false;
         }
         return;
      }

      private function registerDisabledExecute(param1:Object) : void {
         if(param1 != null)
         {
            this.disabledRequests=this.disabledRequests != null?this.disabledRequests:new Dictionary(true);
            this.disabledRequests[param1]=true;
         }
         return;
      }

      private function processDisabledRequests() : void {
         var _loc1_:Object = null;
         if(this.disabledRequests != null)
         {
            for (_loc1_ in this.disabledRequests)
            {
               this.execute(_loc1_);
            }
            this.disabledRequests=null;
         }
         return;
      }

      protected function wrapFunctionCall(param1:Object, param2:Function, param3:Object=null, ... rest) : Object {
         var result:Object = null;
         var thisArg:Object = param1;
         var wrappedFunction:Function = param2;
         var object:Object = param3;
         var args:Array = rest;
         this.wrappedFunctionSuccessful=false;
         try
         {
            result=wrappedFunction.apply(thisArg,args);
            this.wrappedFunctionSuccessful=true;
            return result;
         }
         catch(itemPendingError:ItemPendingError)
         {
            itemPendingError.addResponder(new EvalBindingResponder(this,object));
            if(BindingManager.debugDestinationStrings[destString])
            {
               trace("Binding: destString = " + destString + ", error = " + itemPendingError);
            }
            return null;
         }
         catch(rangeError:RangeError)
         {
            if(BindingManager.debugDestinationStrings[destString])
            {
               trace("Binding: destString = " + destString + ", error = " + rangeError);
            }
            return null;
         }
         catch(error:Error)
         {
            if(!(error.errorID == 1006) && !(error.errorID == 1009) && !(error.errorID == 1010) && !(error.errorID == 1055) && !(error.errorID == 1069))
            {
               throw error;
            }
            else
            {
               if(BindingManager.debugDestinationStrings[destString])
               {
                  trace("Binding: destString = " + destString + ", error = " + error);
               }
            }
         }
         return null;
      }

      private function nodeSeqEqual(param1:XMLList, param2:XMLList) : Boolean {
         var _loc4_:uint = 0;
         var _loc3_:uint = param1.length();
         if(_loc3_ == param2.length())
         {
            _loc4_=0;
            while(_loc4_ < _loc3_ && param1[_loc4_] === param2[_loc4_])
            {
               _loc4_++;
            }
            return _loc4_ == _loc3_;
         }
         return false;
      }

      private function innerExecute() : void {
         var _loc1_:Object = this.wrapFunctionCall(this.document,this.srcFunc);
         if(BindingManager.debugDestinationStrings[this.destString])
         {
            trace("Binding: destString = " + this.destString + ", srcFunc result = " + _loc1_);
         }
         if((this.hasHadValue) || (this.wrappedFunctionSuccessful))
         {
            if(!((this.lastValue  is  XML && (this.lastValue.hasComplexContent())) && (this.lastValue === _loc1_)) && !((((this.lastValue  is  XMLList) && (this.lastValue.hasComplexContent())) && _loc1_  is  XMLList) && (this.nodeSeqEqual(this.lastValue as XMLList,_loc1_ as XMLList))))
            {
               this.destFunc.call(this.document,_loc1_);
               this.lastValue=_loc1_;
               this.hasHadValue=true;
            }
         }
         return;
      }

      public function watcherFired(param1:Boolean, param2:int) : void {
         var commitEvent:Boolean = param1;
         var cloneIndex:int = param2;
         if(this.isHandlingEvent)
         {
            return;
         }
         this.isHandlingEvent=true;
         this.execute(cloneIndex);
         this.isHandlingEvent=false;
         if(!-1)
         {
            throw _loc5_;
         }
         else
         {
            return;
         }
      }
   }

}