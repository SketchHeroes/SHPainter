package mx.skins.halo
{
   import mx.skins.ProgrammaticSkin;
   import mx.core.mx_internal;
   import flash.display.Graphics;

   use namespace mx_internal;

   public class BrokenImageBorderSkin extends ProgrammaticSkin
   {
      public function BrokenImageBorderSkin() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         _loc3_.lineStyle(1,getStyle("borderColor"));
         _loc3_.drawRect(0,0,param1,param2);
         return;
      }
   }

}