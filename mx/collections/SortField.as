package mx.collections
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import flash.events.Event;
   import mx.utils.ObjectUtil;
   import mx.collections.errors.SortError;
   import mx.resources.ResourceManager;

   use namespace mx_internal;

   public class SortField extends EventDispatcher implements ISortField
   {
      public function SortField(param1:String=null, param2:Boolean=false, param3:Boolean=false, param4:Object=null) {
         this.resourceManager=ResourceManager.getInstance();
         super();
         this._name=param1;
         this._caseInsensitive=param2;
         this._descending=param3;
         this._numeric=param4;
         this._compareFunction=this.stringCompare;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var resourceManager:IResourceManager;

      public function get arraySortOnOptions() : int {
         if((this.usingCustomCompareFunction) || this.name == null || this._compareFunction == this.xmlCompare || this._compareFunction == this.dateCompare)
         {
            return -1;
         }
         var _loc1_:* = 0;
         if(this.caseInsensitive)
         {
            _loc1_=_loc1_ | Array.CASEINSENSITIVE;
         }
         if(this.descending)
         {
            _loc1_=_loc1_ | Array.DESCENDING;
         }
         if(this.numeric == true || this._compareFunction == this.numericCompare)
         {
            _loc1_=_loc1_ | Array.NUMERIC;
         }
         return _loc1_;
      }

      private var _caseInsensitive:Boolean;

      public function get caseInsensitive() : Boolean {
         return this._caseInsensitive;
      }

      public function set caseInsensitive(param1:Boolean) : void {
         if(param1 != this._caseInsensitive)
         {
            this._caseInsensitive=param1;
            dispatchEvent(new Event("caseInsensitiveChanged"));
         }
         return;
      }

      private var _compareFunction:Function;

      public function get compareFunction() : Function {
         return this._compareFunction;
      }

      public function set compareFunction(param1:Function) : void {
         this._compareFunction=param1;
         this._usingCustomCompareFunction=!(param1 == null);
         return;
      }

      private var _descending:Boolean;

      public function get descending() : Boolean {
         return this._descending;
      }

      public function set descending(param1:Boolean) : void {
         if(this._descending != param1)
         {
            this._descending=param1;
            dispatchEvent(new Event("descendingChanged"));
         }
         return;
      }

      private var _name:String;

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name=param1;
         dispatchEvent(new Event("nameChanged"));
         return;
      }

      private var _numeric:Object;

      public function get numeric() : Object {
         return this._numeric;
      }

      public function set numeric(param1:Object) : void {
         if(this._numeric != param1)
         {
            this._numeric=param1;
            dispatchEvent(new Event("numericChanged"));
         }
         return;
      }

      private var _usingCustomCompareFunction:Boolean;

      public function get usingCustomCompareFunction() : Boolean {
         return this._usingCustomCompareFunction;
      }

      override public function toString() : String {
         return ObjectUtil.toString(this);
      }

      public function initializeDefaultCompareFunction(param1:Object) : void {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!this.usingCustomCompareFunction)
         {
            if(this.numeric == true)
            {
               this._compareFunction=this.numericCompare;
            }
            else
            {
               if((this.caseInsensitive) || this.numeric == false)
               {
                  this._compareFunction=this.stringCompare;
               }
               else
               {
                  if(this._name)
                  {
                     try
                     {
                        _loc2_=param1[this._name];
                     }
                     catch(error:Error)
                     {
                     }
                  }
                  if(_loc2_ == null)
                  {
                     _loc2_=param1;
                  }
                  _loc3_=typeof _loc2_;
                  switch(_loc3_)
                  {
                     case "string":
                        this._compareFunction=this.stringCompare;
                        break;
                     case "object":
                        if(_loc2_  is  Date)
                        {
                           this._compareFunction=this.dateCompare;
                        }
                        else
                        {
                           this._compareFunction=this.stringCompare;
                           try
                           {
                              _loc4_=_loc2_.toString();
                           }
                           catch(error2:Error)
                           {
                           }
                           if(!_loc4_ || _loc4_ == "[object Object]")
                           {
                              this._compareFunction=this.nullCompare;
                           }
                        }
                        break;
                     case "xml":
                        this._compareFunction=this.xmlCompare;
                        break;
                     case "boolean":
                     case "number":
                        this._compareFunction=this.numericCompare;
                        break;
                  }
               }
            }
         }
         return;
      }

      public function reverse() : void {
         this.descending=!this.descending;
         return;
      }

      private function nullCompare(param1:Object, param2:Object) : int {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc9_:String = null;
         var _loc6_:* = false;
         if(param1 == null && param2 == null)
         {
            return 0;
         }
         if(this._name)
         {
            try
            {
               _loc4_=param1[this._name];
            }
            catch(error:Error)
            {
            }
            try
            {
               _loc5_=param2[this._name];
            }
            catch(error:Error)
            {
            }
         }
         if(_loc4_ == null && _loc5_ == null)
         {
            return 0;
         }
         if(_loc4_ == null && !this._name)
         {
            _loc4_=param1;
         }
         if(_loc5_ == null && !this._name)
         {
            _loc5_=param2;
         }
         var _loc7_:* = typeof _loc4_;
         var _loc8_:* = typeof _loc5_;
         if(_loc7_ == "string" || _loc8_ == "string")
         {
            _loc6_=true;
            this._compareFunction=this.stringCompare;
         }
         else
         {
            if(_loc7_ == "object" || _loc8_ == "object")
            {
               if(_loc4_  is  Date || _loc5_  is  Date)
               {
                  _loc6_=true;
                  this._compareFunction=this.dateCompare;
               }
            }
            else
            {
               if(_loc7_ == "xml" || _loc8_ == "xml")
               {
                  _loc6_=true;
                  this._compareFunction=this.xmlCompare;
               }
               else
               {
                  if(_loc7_ == "number" || _loc8_ == "number" || _loc7_ == "boolean" || _loc8_ == "boolean")
                  {
                     _loc6_=true;
                     this._compareFunction=this.numericCompare;
                  }
               }
            }
         }
         if(_loc6_)
         {
            return this._compareFunction(_loc4_,_loc5_);
         }
         _loc9_=this.resourceManager.getString("collections","noComparatorSortField",[this.name]);
         throw new SortError(_loc9_);
      }

      private function numericCompare(param1:Object, param2:Object) : int {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         try
         {
            _loc3_=this._name == null?Number(param1):Number(param1[this._name]);
         }
         catch(error:Error)
         {
         }
         try
         {
            _loc4_=this._name == null?Number(param2):Number(param2[this._name]);
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.numericCompare(_loc3_,_loc4_);
      }

      private function dateCompare(param1:Object, param2:Object) : int {
         var _loc3_:Date = null;
         var _loc4_:Date = null;
         try
         {
            _loc3_=this._name == null?param1 as Date:param1[this._name] as Date;
         }
         catch(error:Error)
         {
         }
         try
         {
            _loc4_=this._name == null?param2 as Date:param2[this._name] as Date;
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.dateCompare(_loc3_,_loc4_);
      }

      private function stringCompare(param1:Object, param2:Object) : int {
         var _loc3_:String = null;
         var _loc4_:String = null;
         try
         {
            _loc3_=this._name == null?String(param1):String(param1[this._name]);
         }
         catch(error:Error)
         {
         }
         try
         {
            _loc4_=this._name == null?String(param2):String(param2[this._name]);
         }
         catch(error:Error)
         {
         }
         return ObjectUtil.stringCompare(_loc3_,_loc4_,this._caseInsensitive);
      }

      private function xmlCompare(param1:Object, param2:Object) : int {
         var _loc3_:String = null;
         var _loc4_:String = null;
         try
         {
            _loc3_=this._name == null?param1.toString():param1[this._name].toString();
         }
         catch(error:Error)
         {
         }
         try
         {
            _loc4_=this._name == null?param2.toString():param2[this._name].toString();
         }
         catch(error:Error)
         {
         }
         if(this.numeric == true)
         {
            return ObjectUtil.numericCompare(parseFloat(_loc3_),parseFloat(_loc4_));
         }
         return ObjectUtil.stringCompare(_loc3_,_loc4_,this._caseInsensitive);
      }
   }

}