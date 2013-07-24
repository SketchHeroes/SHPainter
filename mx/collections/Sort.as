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

   public class Sort extends EventDispatcher implements ISort
   {
      public function Sort() {
         this.resourceManager=ResourceManager.getInstance();
         this.fieldList=[];
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const ANY_INDEX_MODE:String = "any";

      public static const FIRST_INDEX_MODE:String = "first";

      public static const LAST_INDEX_MODE:String = "last";

      private var resourceManager:IResourceManager;

      private var _compareFunction:Function;

      private var usingCustomCompareFunction:Boolean;

      public function get compareFunction() : Function {
         return this.usingCustomCompareFunction?this._compareFunction:this.internalCompare;
      }

      public function set compareFunction(param1:Function) : void {
         this._compareFunction=param1;
         this.usingCustomCompareFunction=!(this._compareFunction == null);
         return;
      }

      private var _fields:Array;

      private var fieldList:Array;

      public function get fields() : Array {
         return this._fields;
      }

      public function set fields(param1:Array) : void {
         var _loc2_:ISortField = null;
         var _loc3_:* = 0;
         this._fields=param1;
         this.fieldList=[];
         if(this._fields)
         {
            _loc3_=0;
            while(_loc3_ < this._fields.length)
            {
               _loc2_=ISortField(this._fields[_loc3_]);
               this.fieldList.push(_loc2_.name);
               _loc3_++;
            }
         }
         dispatchEvent(new Event("fieldsChanged"));
         return;
      }

      private var _unique:Boolean;

      public function get unique() : Boolean {
         return this._unique;
      }

      public function set unique(param1:Boolean) : void {
         this._unique=param1;
         return;
      }

      override public function toString() : String {
         return ObjectUtil.toString(this);
      }

      public function findItem(param1:Array, param2:Object, param3:String, param4:Boolean=false, param5:Function=null) : int {
         var compareForFind:Function = null;
         var fieldsForCompare:Array = null;
         var message:String = null;
         var index:int = 0;
         var fieldName:String = null;
         var hadPreviousFieldName:Boolean = false;
         var i:int = 0;
         var hasFieldName:Boolean = false;
         var objIndex:int = 0;
         var match:Boolean = false;
         var prevCompare:int = 0;
         var nextCompare:int = 0;
         var items:Array = param1;
         var values:Object = param2;
         var mode:String = param3;
         var returnInsertionIndex:Boolean = param4;
         var compareFunction:Function = param5;
         if(!items)
         {
            message=this.resourceManager.getString("collections","noItems");
            throw new SortError(message);
         }
         else
         {
            if(items.length == 0)
            {
               return returnInsertionIndex?1:-1;
            }
            if(compareFunction == null)
            {
               compareForFind=this.compareFunction;
               if((values) && this.fieldList.length > 0)
               {
                  fieldsForCompare=[];
                  hadPreviousFieldName=true;
                  i=0;
                  while(true)
                  {
                     if(i >= this.fieldList.length)
                     {
                        if(fieldsForCompare.length == 0)
                        {
                           message=this.resourceManager.getString("collections","findRestriction");
                           throw new SortError(message);
                        }
                        else
                        {
                           try
                           {
                              this.initSortFields(items[0]);
                           }
                           catch(initSortError:SortError)
                           {
                           }
                        }
                     }
                     else
                     {
                        fieldName=this.fieldList[i];
                        if(fieldName)
                        {
                           try
                           {
                              hasFieldName=!(values[fieldName] === undefined);
                           }
                           catch(e:Error)
                           {
                              hasFieldName=false;
                           }
                           if(hasFieldName)
                           {
                              if(!hadPreviousFieldName)
                              {
                                 break;
                              }
                              fieldsForCompare.push(fieldName);
                           }
                           else
                           {
                              hadPreviousFieldName=false;
                           }
                        }
                        else
                        {
                           fieldsForCompare.push(null);
                        }
                        i++;
                        continue;
                     }
                  }
                  message=this.resourceManager.getString("collections","findCondition",[fieldName]);
                  throw new SortError(message);
               }
            }
            else
            {
               compareForFind=compareFunction;
            }
            found=false;
            objFound=false;
            index=0;
            lowerBound=0;
            upperBound=items.length-1;
            obj=null;
            direction=1;
            loop1:
            while(true)
            {
               if(!(!objFound && lowerBound <= upperBound))
               {
                  if(!found && !returnInsertionIndex)
                  {
                     return -1;
                  }
                  return direction > 0?index + 1:index;
               }
               index=Math.round((lowerBound + upperBound) / 2);
               obj=items[index];
               direction=fieldsForCompare?compareForFind(values,obj,fieldsForCompare):compareForFind(values,obj);
               switch(direction)
               {
                  case -1:
                     upperBound=index-1;
                     continue;
                  case 0:
                     objFound=true;
                     switch(mode)
                     {
                        case ANY_INDEX_MODE:
                           found=true;
                           break;
                        case FIRST_INDEX_MODE:
                           found=index == lowerBound;
                           objIndex=index-1;
                           match=true;
                           while((match) && !found && objIndex >= lowerBound)
                           {
                              obj=items[objIndex];
                              prevCompare=fieldsForCompare?compareForFind(values,obj,fieldsForCompare):compareForFind(values,obj);
                              match=prevCompare == 0;
                              if(!match || (match) && objIndex == lowerBound)
                              {
                                 found=true;
                                 index=objIndex + (match?0:1);
                              }
                              objIndex--;
                           }
                           break;
                        case LAST_INDEX_MODE:
                           found=index == upperBound;
                           objIndex=index + 1;
                           match=true;
                           while((match) && !found && objIndex <= upperBound)
                           {
                              obj=items[objIndex];
                              nextCompare=fieldsForCompare?compareForFind(values,obj,fieldsForCompare):compareForFind(values,obj);
                              match=nextCompare == 0;
                              if(!match || (match) && objIndex == upperBound)
                              {
                                 found=true;
                                 index=objIndex - (match?0:1);
                              }
                              objIndex++;
                           }
                           break;
                        default:
                           break loop1;
                     }
                     continue;
                  case 1:
                     lowerBound=index + 1;
                     continue;
                  default:
                     continue;
               }
            }
            message=this.resourceManager.getString("collections","unknownMode");
            throw new SortError(message);
         }
      }

      public function propertyAffectsSort(param1:String) : Boolean {
         var _loc3_:ISortField = null;
         if((this.usingCustomCompareFunction) || !this.fields)
         {
            return true;
         }
         var _loc2_:* = 0;
         while(_loc2_ < this.fields.length)
         {
            _loc3_=this.fields[_loc2_];
            if(_loc3_.name == param1 || (_loc3_.usingCustomCompareFunction))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }

      public function reverse() : void {
         var _loc1_:* = 0;
         if(this.fields)
         {
            _loc1_=0;
            while(_loc1_ < this.fields.length)
            {
               ISortField(this.fields[_loc1_]).reverse();
               _loc1_++;
            }
         }
         this.noFieldsDescending=!this.noFieldsDescending;
         return;
      }

      public function sort(param1:Array) : void {
         var fixedCompareFunction:Function = null;
         var message:String = null;
         var uniqueRet1:Object = null;
         var fields:Array = null;
         var i:int = 0;
         var sortArgs:Object = null;
         var uniqueRet2:Object = null;
         var items:Array = param1;
         if(!items || items.length <= 1)
         {
            return;
         }
         if(this.usingCustomCompareFunction)
         {
            fixedCompareFunction=new function(param1:Object, param2:Object):int
            {
               return compareFunction(param1,param2,_fields);
            };
            if(this.unique)
            {
               uniqueRet1=items.sort(fixedCompareFunction,Array.UNIQUESORT);
               if(uniqueRet1 == 0)
               {
                  message=this.resourceManager.getString("collections","nonUnique");
                  throw new SortError(message);
               }
            }
            else
            {
               items.sort(fixedCompareFunction);
            }
         }
         else
         {
            fields=this.fields;
            if((fields) && fields.length > 0)
            {
               sortArgs=this.initSortFields(items[0],true);
               if(this.unique)
               {
                  if((sortArgs) && fields.length == 1)
                  {
                     uniqueRet2=items.sortOn(sortArgs.fields[0],sortArgs.options[0] | Array.UNIQUESORT);
                  }
                  else
                  {
                     uniqueRet2=items.sort(this.internalCompare,Array.UNIQUESORT);
                  }
                  if(uniqueRet2 == 0)
                  {
                     message=this.resourceManager.getString("collections","nonUnique");
                     throw new SortError(message);
                  }
               }
               else
               {
                  if(sortArgs)
                  {
                     items.sortOn(sortArgs.fields,sortArgs.options);
                  }
                  else
                  {
                     items.sort(this.internalCompare);
                  }
               }
            }
            else
            {
               items.sort(this.internalCompare);
            }
         }
         return;
      }

      private function initSortFields(param1:Object, param2:Boolean=false) : Object {
         var _loc4_:* = 0;
         var _loc5_:ISortField = null;
         var _loc6_:* = 0;
         var _loc3_:Object = null;
         _loc4_=0;
         while(_loc4_ < this.fields.length)
         {
            ISortField(this.fields[_loc4_]).initializeDefaultCompareFunction(param1);
            _loc4_++;
         }
         if(param2)
         {
            _loc3_=
               {
                  "fields":[],
                  "options":[]
               }
            ;
            _loc4_=0;
            while(_loc4_ < this.fields.length)
            {
               _loc5_=this.fields[_loc4_];
               _loc6_=_loc5_.arraySortOnOptions;
               if(_loc6_ == -1)
               {
                  return null;
               }
               _loc3_.fields.push(_loc5_.name);
               _loc3_.options.push(_loc6_);
               _loc4_++;
            }
         }
         return _loc3_;
      }

      private function internalCompare(param1:Object, param2:Object, param3:Array=null) : int {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:ISortField = null;
         var _loc4_:* = 0;
         if(!this._fields)
         {
            _loc4_=this.noFieldsCompare(param1,param2);
         }
         else
         {
            _loc5_=0;
            _loc6_=param3?param3.length:this._fields.length;
            while(_loc5_ < _loc6_)
            {
               _loc7_=ISortField(this._fields[_loc5_]);
               _loc4_=_loc7_.compareFunction(param1,param2);
               if(_loc7_.descending)
               {
                  _loc4_=_loc4_ * -1;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }

      private var defaultEmptyField:ISortField;

      private var noFieldsDescending:Boolean = false;

      private function noFieldsCompare(param1:Object, param2:Object, param3:Array=null) : int {
         var message:String = null;
         var a:Object = param1;
         var b:Object = param2;
         var fields:Array = param3;
         if(!this.defaultEmptyField)
         {
            this.defaultEmptyField=new SortField();
            try
            {
               this.defaultEmptyField.initializeDefaultCompareFunction(a);
            }
            catch(e:SortError)
            {
               message=resourceManager.getString("collections","noComparator",[a]);
               throw new SortError(message);
            }
         }
         var result:int = this.defaultEmptyField.compareFunction(a,b);
         if(this.noFieldsDescending)
         {
            result=result * -1;
         }
         return result;
      }
   }

}