package mx.skins.halo
{
   import mx.skins.Border;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class SwatchPanelSkin extends Border
   {
      public function SwatchPanelSkin() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         super.updateDisplayList(param1,param2);
         if(name == "swatchPanelBorder")
         {
            _loc3_=getStyle("backgroundColor");
            _loc4_=getStyle("borderColor");
            _loc5_=getStyle("highlightColor");
            _loc6_=getStyle("shadowColor");
            _loc7_=0;
            _loc8_=0;
            graphics.clear();
            drawRoundRect(_loc7_,_loc8_,param1,param2,0,_loc4_,1);
            drawRoundRect(_loc7_ + 1,_loc8_ + 1,param1-1,param2-1,0,_loc6_,1);
            drawRoundRect(_loc7_ + 1,_loc8_ + 1,param1 - 2,param2 - 2,0,_loc5_,1);
            drawRoundRect(_loc7_ + 2,_loc8_ + 2,param1 - 4,param2 - 4,0,[_loc3_,_loc5_],1,verticalGradientMatrix(_loc7_ + 2,_loc8_ + 2,param1 - 4,param2 - 4));
         }
         return;
      }
   }

}