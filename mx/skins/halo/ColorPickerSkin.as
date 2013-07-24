package mx.skins.halo
{
   import mx.skins.Border;
   import mx.core.mx_internal;
   import flash.display.Graphics;

   use namespace mx_internal;

   public class ColorPickerSkin extends Border
   {
      public function ColorPickerSkin() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var borderShadowColor:uint = 10132381;

      private var borderHighlightColor:uint = 16711422;

      private var backgroundColor:uint = 15066855;

      private var borderSize:Number = 1;

      private var bevelSize:Number = 1;

      private var arrowWidth:Number = 7;

      private var arrowHeight:Number = 5;

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:uint = getStyle("iconColor");
         var _loc4_:Number = param1 - this.arrowWidth - this.bevelSize;
         var _loc5_:Number = param2 - this.arrowHeight - this.bevelSize;
         graphics.clear();
         if(name == "upSkin" || name == "overSkin")
         {
            this.drawFill(x,y,param1 + this.bevelSize,param2 + this.bevelSize,13421772,0);
            this.drawBorder(x,y,param1,param2,this.borderHighlightColor,this.borderShadowColor,this.bevelSize,1);
            this.drawBorder(x + this.bevelSize,y + this.bevelSize,param1 - this.bevelSize * 2,param2 - this.bevelSize * 2,this.backgroundColor,this.backgroundColor,this.borderSize,1);
            this.drawBorder(x + this.bevelSize + this.borderSize,y + this.bevelSize + this.borderSize,param1 - (this.bevelSize + this.borderSize) * 2,param2 - (this.bevelSize + this.borderSize) * 2,this.borderShadowColor,this.borderHighlightColor,this.bevelSize,1);
            this.drawFill(_loc4_,_loc5_,this.arrowWidth,this.arrowHeight,this.backgroundColor,1);
            this.drawArrow(_loc4_ + 1.5,_loc5_ + 1.5,this.arrowWidth - 3,this.arrowHeight - 3,_loc3_,1);
         }
         else
         {
            if(name == "downSkin")
            {
               this.drawFill(x,y,param1,param2,13421772,0);
               this.drawBorder(x,y,param1,param2,this.borderHighlightColor,13421772,this.bevelSize,1);
               this.drawBorder(x + this.bevelSize,y + this.bevelSize,param1 - 2 * this.bevelSize,param2 - 2 * this.bevelSize,this.backgroundColor,this.backgroundColor,this.borderSize,1);
               this.drawBorder(x + this.bevelSize + this.borderSize,y + this.bevelSize + this.borderSize,param1 - 2 * (this.bevelSize + this.borderSize),param2 - 2 * (this.bevelSize + this.borderSize),this.borderShadowColor,this.borderHighlightColor,this.bevelSize,1);
               this.drawFill(_loc4_,_loc5_,this.arrowWidth,this.arrowHeight,this.backgroundColor,1);
               this.drawArrow(_loc4_ + 1.5,_loc5_ + 1.5,this.arrowWidth - 3,this.arrowHeight - 3,_loc3_,1);
            }
            else
            {
               if(name == "disabledSkin")
               {
                  _loc3_=getStyle("disabledIconColor");
                  drawRoundRect(x,y,param1,param2,0,16777215,0.6);
                  this.drawFill(x,y,param1,param2,16777215,0.25);
                  this.drawBorder(x,y,param1,param2,this.borderHighlightColor,13421772,this.bevelSize,1);
                  this.drawBorder(x + this.bevelSize,y + this.bevelSize,param1 - this.bevelSize * 2,param2 - this.bevelSize * 2,this.backgroundColor,this.backgroundColor,this.borderSize,1);
                  this.drawBorder(x + this.bevelSize + this.borderSize,y + this.bevelSize + this.borderSize,param1 - 2 * (this.bevelSize + this.borderSize),param2 - 2 * (this.bevelSize + this.borderSize),this.borderShadowColor,this.borderHighlightColor,this.bevelSize,1);
                  this.drawFill(_loc4_,_loc5_,this.arrowWidth,this.arrowHeight,this.backgroundColor,1);
                  this.drawArrow(_loc4_ + 1.5,_loc5_ + 1.5,this.arrowWidth - 3,this.arrowHeight - 3,_loc3_,1);
               }
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

      private function drawArrow(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         var _loc7_:Graphics = graphics;
         _loc7_.moveTo(param1,param2);
         _loc7_.beginFill(param5,param6);
         _loc7_.lineTo(param1 + param3,param2);
         _loc7_.lineTo(param1 + param3 / 2,param4 + param2);
         _loc7_.lineTo(param1,param2);
         _loc7_.endFill();
         return;
      }
   }

}