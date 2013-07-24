package mx.skins.halo
{
   import mx.skins.ProgrammaticSkin;
   import mx.core.mx_internal;
   import flash.display.Graphics;

   use namespace mx_internal;

   public class ListDropIndicator extends ProgrammaticSkin
   {
      public function ListDropIndicator() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var direction:String = "horizontal";

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         _loc3_.lineStyle(2,2831164);
         if(this.direction == "horizontal")
         {
            _loc3_.moveTo(0,0);
            _loc3_.lineTo(param1,0);
         }
         else
         {
            _loc3_.moveTo(0,0);
            _loc3_.lineTo(0,param2);
         }
         return;
      }
   }

}