package mx.skins.halo
{
   import mx.core.SpriteAsset;
   import mx.core.IFlexDisplayObject;
   import mx.core.mx_internal;
   import flash.display.Graphics;

   use namespace mx_internal;

   public class DefaultDragImage extends SpriteAsset implements IFlexDisplayObject
   {
      public function DefaultDragImage() {
         this.draw(10,10);
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function get measuredWidth() : Number {
         return 10;
      }

      override public function get measuredHeight() : Number {
         return 10;
      }

      override public function move(param1:Number, param2:Number) : void {
         this.x=param1;
         this.y=param2;
         return;
      }

      override public function setActualSize(param1:Number, param2:Number) : void {
         this.draw(param1,param2);
         return;
      }

      private function draw(param1:Number, param2:Number) : void {
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         _loc3_.beginFill(15658734);
         _loc3_.lineStyle(1,8433818);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
         return;
      }
   }

}