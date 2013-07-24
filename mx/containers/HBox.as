package mx.containers
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class HBox extends Box
   {
      public function HBox() {
         super();
         layoutObject.direction=BoxDirection.HORIZONTAL;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function set direction(param1:String) : void {
         return;
      }
   }

}