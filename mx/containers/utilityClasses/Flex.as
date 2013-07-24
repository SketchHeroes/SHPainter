package mx.containers.utilityClasses
{
   import mx.core.mx_internal;
   import mx.core.IChildList;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class Flex extends Object
   {
      public function Flex() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function flexChildWidthsProportionally(param1:IChildList, param2:Number, param3:Number) : Number {
         var _loc7_:FlexChildInfo = null;
         var _loc8_:IUIComponent = null;
         var _loc9_:* = 0;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc4_:Number = param2;
         var _loc5_:Number = 0;
         var _loc6_:Array = [];
         var _loc10_:int = param1.numChildren;
         _loc9_=0;
         while(_loc9_ < _loc10_)
         {
            _loc8_=IUIComponent(param1.getChildAt(_loc9_));
            _loc11_=_loc8_.percentWidth;
            _loc12_=_loc8_.percentHeight;
            if(!isNaN(_loc12_) && (_loc8_.includeInLayout))
            {
               _loc13_=Math.max(_loc8_.minHeight,Math.min(_loc8_.maxHeight,_loc12_ >= 100?param3:param3 * _loc12_ / 100));
            }
            else
            {
               _loc13_=_loc8_.getExplicitOrMeasuredHeight();
            }
            if(!isNaN(_loc11_) && (_loc8_.includeInLayout))
            {
               _loc5_=_loc5_ + _loc11_;
               _loc7_=new FlexChildInfo();
               _loc7_.percent=_loc11_;
               _loc7_.min=_loc8_.minWidth;
               _loc7_.max=_loc8_.maxWidth;
               _loc7_.height=_loc13_;
               _loc7_.child=_loc8_;
               _loc6_.push(_loc7_);
            }
            else
            {
               _loc14_=_loc8_.getExplicitOrMeasuredWidth();
               if(_loc8_.scaleX == 1 && _loc8_.scaleY == 1)
               {
                  _loc8_.setActualSize(Math.floor(_loc14_),Math.floor(_loc13_));
               }
               else
               {
                  _loc8_.setActualSize(_loc14_,_loc13_);
               }
               if(_loc8_.includeInLayout)
               {
                  _loc4_=_loc4_ - _loc8_.width;
               }
            }
            _loc9_++;
         }
         return _loc4_;
      }

      public static function flexChildHeightsProportionally(param1:IChildList, param2:Number, param3:Number) : Number {
         var _loc7_:FlexChildInfo = null;
         var _loc8_:IUIComponent = null;
         var _loc9_:* = 0;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc4_:Number = param2;
         var _loc5_:Number = 0;
         var _loc6_:Array = [];
         var _loc10_:int = param1.numChildren;
         _loc9_=0;
         while(_loc9_ < _loc10_)
         {
            _loc8_=IUIComponent(param1.getChildAt(_loc9_));
            _loc11_=_loc8_.percentWidth;
            _loc12_=_loc8_.percentHeight;
            if(!isNaN(_loc11_) && (_loc8_.includeInLayout))
            {
               _loc13_=Math.max(_loc8_.minWidth,Math.min(_loc8_.maxWidth,_loc11_ >= 100?param3:param3 * _loc11_ / 100));
            }
            else
            {
               _loc13_=_loc8_.getExplicitOrMeasuredWidth();
            }
            if(!isNaN(_loc12_) && (_loc8_.includeInLayout))
            {
               _loc5_=_loc5_ + _loc12_;
               _loc7_=new FlexChildInfo();
               _loc7_.percent=_loc12_;
               _loc7_.min=_loc8_.minHeight;
               _loc7_.max=_loc8_.maxHeight;
               _loc7_.width=_loc13_;
               _loc7_.child=_loc8_;
               _loc6_.push(_loc7_);
            }
            else
            {
               _loc14_=_loc8_.getExplicitOrMeasuredHeight();
               if(_loc8_.scaleX == 1 && _loc8_.scaleY == 1)
               {
                  _loc8_.setActualSize(Math.floor(_loc13_),Math.floor(_loc14_));
               }
               else
               {
                  _loc8_.setActualSize(_loc13_,_loc14_);
               }
               if(_loc8_.includeInLayout)
               {
                  _loc4_=_loc4_ - _loc8_.height;
               }
            }
            _loc9_++;
         }
         return _loc4_;
      }

      public static function flexChildrenProportionally(param1:Number, param2:Number, param3:Number, param4:Array) : Number {
         var _loc6_:* = NaN;
         var _loc7_:* = false;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = 0;
         var _loc11_:FlexChildInfo = null;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc5_:int = param4.length;
         do
         {
            _loc6_=0;
            _loc7_=true;
            _loc8_=param2 - param1 * param3 / 100;
            if(_loc8_ > 0)
            {
               param2=param2 - _loc8_;
            }
            else
            {
               _loc8_=0;
            }
            _loc9_=param2 / param3;
            _loc10_=0;
            while(_loc10_ < _loc5_)
            {
               _loc11_=param4[_loc10_];
               _loc12_=_loc11_.percent * _loc9_;
               if(_loc12_ < _loc11_.min)
               {
                  _loc13_=_loc11_.min;
                  _loc11_.size=_loc13_;
                  param4[_loc10_]=param4[--_loc5_];
                  param4[_loc5_]=_loc11_;
                  param3=param3 - _loc11_.percent;
                  if(_loc8_ >= _loc13_)
                  {
                     _loc8_=_loc8_ - _loc13_;
                  }
                  else
                  {
                     param2=param2 - (_loc13_ - _loc8_);
                     _loc8_=0;
                  }
                  _loc7_=false;
                  break;
               }
               if(_loc12_ > _loc11_.max)
               {
                  _loc14_=_loc11_.max;
                  _loc11_.size=_loc14_;
                  param4[_loc10_]=param4[--_loc5_];
                  param4[_loc5_]=_loc11_;
                  param3=param3 - _loc11_.percent;
                  if(_loc8_ >= _loc14_)
                  {
                     _loc8_=_loc8_ - _loc14_;
                  }
                  else
                  {
                     param2=param2 - (_loc14_ - _loc8_);
                     _loc8_=0;
                  }
                  _loc7_=false;
                  break;
               }
               _loc11_.size=_loc12_;
               _loc6_=_loc6_ + _loc12_;
               _loc10_++;
            }
         }
         while(!_loc7_);
         return Math.max(0,Math.floor(param2 + _loc8_ - _loc6_));
      }

      public static function distributeExtraHeight(param1:IChildList, param2:Number) : void {
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc9_:IUIComponent = null;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc3_:int = param1.numChildren;
         var _loc4_:* = false;
         var _loc7_:Number = param2;
         var _loc8_:Number = 0;
         _loc5_=0;
         while(_loc5_ < _loc3_)
         {
            _loc9_=IUIComponent(param1.getChildAt(_loc5_));
            if(_loc9_.includeInLayout)
            {
               _loc10_=_loc9_.height;
               _loc6_=_loc9_.percentHeight;
               _loc8_=_loc8_ + _loc10_;
               if(!isNaN(_loc6_))
               {
                  _loc11_=Math.ceil(_loc6_ / 100 * param2);
                  if(_loc11_ > _loc10_)
                  {
                     _loc4_=true;
                  }
               }
            }
            _loc5_++;
         }
         return;
      }

      public static function distributeExtraWidth(param1:IChildList, param2:Number) : void {
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc9_:IUIComponent = null;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc3_:int = param1.numChildren;
         var _loc4_:* = false;
         var _loc7_:Number = param2;
         var _loc8_:Number = 0;
         _loc5_=0;
         while(_loc5_ < _loc3_)
         {
            _loc9_=IUIComponent(param1.getChildAt(_loc5_));
            if(_loc9_.includeInLayout)
            {
               _loc10_=_loc9_.width;
               _loc6_=_loc9_.percentWidth;
               _loc8_=_loc8_ + _loc10_;
               if(!isNaN(_loc6_))
               {
                  _loc11_=Math.ceil(_loc6_ / 100 * param2);
                  if(_loc11_ > _loc10_)
                  {
                     _loc4_=true;
                  }
               }
            }
            _loc5_++;
         }
         return;
      }
   }

}