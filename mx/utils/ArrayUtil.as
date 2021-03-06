package mx.utils
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ArrayUtil extends Object
   {
      public function ArrayUtil() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function toArray(param1:Object) : Array {
         if(param1 == null)
         {
            return [];
         }
         if(param1  is  Array)
         {
            return param1 as Array;
         }
         return [param1];
      }

      public static function getItemIndex(param1:Object, param2:Array) : int {
         var _loc3_:int = param2.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_] === param1)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
   }

}