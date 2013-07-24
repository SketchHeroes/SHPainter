package mx.containers
{
   import mx.core.Container;
   import mx.core.mx_internal;
   import mx.containers.utilityClasses.BoxLayout;
   import flash.events.Event;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class Box extends Container
   {
      public function Box() {
         this.layoutObject=new BoxLayout();
         super();
         this.layoutObject.target=this;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var layoutObject:BoxLayout;

      public function get direction() : String {
         return this.layoutObject.direction;
      }

      public function set direction(param1:String) : void {
         this.layoutObject.direction=param1;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("directionChanged"));
         return;
      }

      override protected function measure() : void {
         super.measure();
         this.layoutObject.measure();
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         this.layoutObject.updateDisplayList(param1,param2);
         return;
      }

      public function pixelsToPercent(param1:Number) : Number {
         var _loc8_:IUIComponent = null;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc2_:Boolean = this.isVertical();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = numChildren;
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_=getLayoutChildAt(_loc6_);
            _loc9_=_loc2_?_loc8_.height:_loc8_.width;
            _loc10_=_loc2_?_loc8_.percentHeight:_loc8_.percentWidth;
            if(!isNaN(_loc10_))
            {
               _loc3_=_loc3_ + _loc10_;
               _loc4_=_loc4_ + _loc9_;
            }
            _loc6_++;
         }
         var _loc7_:Number = 100;
         if(_loc4_ != param1)
         {
            _loc7_=_loc4_ * _loc3_ / (_loc4_ - param1) - _loc3_;
         }
         return _loc7_;
      }

      mx_internal function isVertical() : Boolean {
         return !(this.direction == BoxDirection.HORIZONTAL);
      }
   }

}