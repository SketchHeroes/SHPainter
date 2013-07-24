package mx.containers.utilityClasses
{
   import mx.core.mx_internal;
   import mx.core.IFlexDisplayObject;
   import mx.core.Container;

   use namespace mx_internal;

   public class ApplicationLayout extends BoxLayout
   {
      public function ApplicationLayout() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function updateDisplayList(param1:Number, param2:Number) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:IFlexDisplayObject = null;
         super.updateDisplayList(param1,param2);
         var _loc3_:Container = super.target;
         if((_loc3_.horizontalScrollBar) && (getHorizontalAlignValue() > 0) || (_loc3_.verticalScrollBar) && (getVerticalAlignValue() > 0))
         {
            _loc4_=_loc3_.getStyle("paddingLeft");
            _loc5_=_loc3_.getStyle("paddingTop");
            _loc6_=0;
            _loc7_=0;
            _loc8_=_loc3_.numChildren;
            _loc9_=0;
            while(_loc9_ < _loc8_)
            {
               _loc10_=IFlexDisplayObject(_loc3_.getChildAt(_loc9_));
               if(_loc10_.x < _loc4_)
               {
                  _loc6_=Math.max(_loc6_,_loc4_ - _loc10_.x);
               }
               if(_loc10_.y < _loc5_)
               {
                  _loc7_=Math.max(_loc7_,_loc5_ - _loc10_.y);
               }
               _loc9_++;
            }
            if(!(_loc6_ == 0) || !(_loc7_ == 0))
            {
               _loc9_=0;
               while(_loc9_ < _loc8_)
               {
                  _loc10_=IFlexDisplayObject(_loc3_.getChildAt(_loc9_));
                  _loc10_.move(_loc10_.x + _loc6_,_loc10_.y + _loc7_);
                  _loc9_++;
               }
            }
         }
         return;
      }
   }

}