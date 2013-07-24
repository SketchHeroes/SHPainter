package mx.skins.halo
{
   import mx.skins.Border;
   import mx.core.mx_internal;
   import mx.utils.ColorUtil;
   import flash.display.GradientType;

   use namespace mx_internal;

   public class ScrollTrackSkin extends Border
   {
      public function ScrollTrackSkin() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function get measuredWidth() : Number {
         return 16;
      }

      override public function get measuredHeight() : Number {
         return 1;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:Array = getStyle("trackColors");
         styleManager.getColorNames(_loc3_);
         var _loc4_:uint = ColorUtil.adjustBrightness2(getStyle("borderColor"),-20);
         var _loc5_:uint = ColorUtil.adjustBrightness2(_loc4_,-30);
         graphics.clear();
         var _loc6_:Number = 1;
         if(name == "trackDisabledSkin")
         {
            _loc6_=0.2;
         }
         drawRoundRect(0,0,param1,param2,0,[_loc4_,_loc5_],_loc6_,verticalGradientMatrix(0,0,param1,param2),GradientType.LINEAR,null,
            {
               "x":1,
               "y":1,
               "w":param1 - 2,
               "h":param2 - 2,
               "r":0
            }
         );
         drawRoundRect(1,1,param1 - 2,param2 - 2,0,_loc3_,_loc6_,horizontalGradientMatrix(1,1,param1 / 3 * 2,param2 - 2));
         return;
      }
   }

}