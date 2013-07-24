package mx.controls.colorPickerClasses
{
   import mx.core.mx_internal;
   import mx.collections.IList;
   import mx.collections.ArrayList;

   use namespace mx_internal;

   public class WebSafePalette extends Object
   {
      public function WebSafePalette() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public function getList() : IList {
         var _loc10_:* = 0;
         var _loc11_:* = NaN;
         var _loc12_:String = null;
         var _loc1_:IList = new ArrayList();
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Array = [0,3355443,6710886,10066329,13421772,16777215,16711680,65280,255,16776960,65535,16711935];
         var _loc5_:Array = ["00","00","00","00","00","00","33","33","33","33","33","33","66","66","66","66","66","66"];
         var _loc6_:Array = ["99","99","99","99","99","99","CC","CC","CC","CC","CC","CC","FF","FF","FF","FF","FF","FF"];
         var _loc7_:Array = ["00","33","66","99","CC","FF","00","33","66","99","CC","FF","00","33","66","99","CC","FF"];
         var _loc8_:Array = ["00","33","66","99","CC","FF","00","33","66","99","CC","FF"];
         var _loc9_:* = 0;
         while(_loc9_ < 12)
         {
            _loc10_=0;
            while(_loc10_ < 20)
            {
               if(_loc10_ == 0)
               {
                  _loc11_=_loc4_[_loc9_];
               }
               else
               {
                  if(_loc10_ == 1)
                  {
                     _loc11_=_loc3_;
                  }
                  else
                  {
                     _loc12_=_loc5_[_loc10_ - 2];
                     _loc11_=Number("0x" + _loc12_ + _loc7_[_loc10_ - 2] + _loc8_[_loc9_]);
                  }
               }
               _loc1_.addItem(_loc11_);
               _loc2_++;
               _loc10_++;
            }
            _loc9_++;
         }
         return _loc1_;
      }
   }

}