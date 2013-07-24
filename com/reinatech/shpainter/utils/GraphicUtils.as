package com.reinatech.shpainter.utils
{


   public class GraphicUtils extends Object
   {
      public function GraphicUtils() {
         super();
         return;
      }

      public static function returnARGB(param1:uint, param2:uint) : uint {
         var _loc3_:uint = 0;
         _loc3_=_loc3_ + (param2 << 24);
         _loc3_=_loc3_ + param1;
         return _loc3_;
      }
   }

}