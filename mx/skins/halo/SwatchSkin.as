package mx.skins.halo
{
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.collections.IList;
   import flash.display.Graphics;
   import mx.core.FlexVersion;

   use namespace mx_internal;

   public class SwatchSkin extends UIComponent
   {
      public function SwatchSkin() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var color:uint = 0;

      mx_internal var colorField:String = "color";

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         this.updateSkin(this.color);
         return;
      }

      mx_internal function updateGrid(param1:IList) : void {
         if(name == "swatchGrid")
         {
            graphics.clear();
            this.drawGrid(param1,this.colorField);
         }
         return;
      }

      mx_internal function updateSkin(param1:Number) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:uint = 0;
         var _loc10_:* = NaN;
         var _loc2_:Graphics = graphics;
         switch(name)
         {
            case "colorPickerSwatch":
               _loc3_=UIComponent(parent).width;
               _loc4_=UIComponent(parent).height;
               if(FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
               {
                  _loc3_=_loc3_ / Math.abs(UIComponent(parent).scaleX);
                  _loc4_=_loc4_ / Math.abs(UIComponent(parent).scaleY);
               }
               _loc2_.clear();
               this.drawSwatch(0,0,_loc3_,_loc4_,param1);
               break;
            case "swatchPreview":
               _loc5_=getStyle("previewWidth");
               _loc6_=getStyle("previewHeight");
               _loc2_.clear();
               this.drawSwatch(0,0,_loc5_,_loc6_,param1);
               this.drawBorder(0,0,_loc5_,_loc6_,10066329,16777215,1,1);
               break;
            case "swatchHighlight":
               _loc7_=getStyle("swatchWidth");
               _loc8_=getStyle("swatchHeight");
               _loc9_=getStyle("swatchHighlightColor");
               _loc10_=getStyle("swatchHighlightSize");
               _loc2_.clear();
               this.drawBorder(0,0,_loc7_,_loc8_,_loc9_,_loc9_,_loc10_,1);
               break;
         }
         return;
      }

      private function drawGrid(param1:IList, param2:String) : void {
         var _loc22_:* = NaN;
         var _loc23_:* = NaN;
         var _loc24_:* = NaN;
         var _loc3_:int = getStyle("columnCount");
         var _loc4_:Number = getStyle("horizontalGap");
         var _loc5_:Number = getStyle("previewWidth");
         var _loc6_:uint = getStyle("swatchGridBackgroundColor");
         var _loc7_:Number = getStyle("swatchGridBorderSize");
         var _loc8_:Number = getStyle("swatchHeight");
         var _loc9_:Number = getStyle("swatchWidth");
         var _loc10_:Number = getStyle("textFieldWidth");
         var _loc11_:Number = getStyle("verticalGap");
         var _loc12_:* = 1;
         var _loc13_:* = 3;
         var _loc14_:int = param1.length;
         if(_loc3_ > _loc14_)
         {
            _loc3_=_loc14_;
         }
         var _loc15_:Number = Math.ceil(_loc14_ / _loc3_);
         if(isNaN(_loc15_))
         {
            _loc15_=0;
         }
         var _loc16_:Number = _loc3_ * (_loc9_ - _loc12_) + _loc12_ + (_loc3_-1) * _loc4_ + 2 * _loc7_;
         var _loc17_:Number = _loc15_ * (_loc8_ - _loc12_) + _loc12_ + (_loc15_-1) * _loc11_ + 2 * _loc7_;
         var _loc18_:Number = _loc5_ + _loc10_ + _loc13_;
         if(_loc16_ < _loc18_)
         {
            _loc16_=_loc18_;
         }
         this.drawFill(0,0,_loc16_,_loc17_,_loc6_,100);
         setActualSize(_loc16_,_loc17_);
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         while(_loc21_ < _loc14_)
         {
            _loc22_=_loc7_ + _loc19_ * (_loc9_ + _loc4_ - _loc12_);
            _loc23_=_loc7_ + _loc20_ * (_loc8_ + _loc11_ - _loc12_);
            _loc24_=typeof param1.getItemAt(_loc21_) != "object"?Number(param1.getItemAt(_loc21_)):Number(param1.getItemAt(_loc21_)[this.colorField]);
            this.drawSwatch(_loc22_,_loc23_,_loc9_,_loc8_,_loc24_);
            if(_loc19_ < _loc3_-1)
            {
               _loc19_++;
            }
            else
            {
               _loc19_=0;
               _loc20_++;
            }
            _loc21_++;
         }
         return;
      }

      private function drawSwatch(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         var _loc6_:uint = getStyle("swatchBorderColor");
         var _loc7_:Number = getStyle("swatchBorderSize");
         if(_loc7_ == 0)
         {
            this.drawFill(param1,param2,param3,param4,param5,1);
         }
         else
         {
            if(_loc7_ < 0 || (isNaN(_loc7_)))
            {
               this.drawFill(param1,param2,param3,param4,_loc6_,1);
               this.drawFill(param1 + 1,param2 + 1,param3 - 2,param4 - 2,param5,1);
            }
            else
            {
               this.drawFill(param1,param2,param3,param4,_loc6_,1);
               this.drawFill(param1 + _loc7_,param2 + _loc7_,param3 - 2 * _loc7_,param4 - 2 * _loc7_,param5,1);
            }
         }
         return;
      }

      private function drawBorder(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void {
         this.drawFill(param1,param2,param7,param4,param5,param8);
         this.drawFill(param1,param2,param3,param7,param5,param8);
         this.drawFill(param1 + (param3 - param7),param2,param7,param4,param6,param8);
         this.drawFill(param1,param2 + (param4 - param7),param3,param7,param6,param8);
         return;
      }

      private function drawFill(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         var _loc7_:Graphics = graphics;
         _loc7_.moveTo(param1,param2);
         _loc7_.beginFill(param5,param6);
         _loc7_.lineTo(param1 + param3,param2);
         _loc7_.lineTo(param1 + param3,param4 + param2);
         _loc7_.lineTo(param1,param4 + param2);
         _loc7_.lineTo(param1,param2);
         _loc7_.endFill();
         return;
      }
   }

}